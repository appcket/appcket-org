import { Injectable } from '@nestjs/common';
import { EntityManager } from '@mikro-orm/core';
import { EntityRepository } from '@mikro-orm/core';
import { InjectRepository } from '@mikro-orm/nestjs';
import { Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

import { Team } from 'src/team/team.entity';
import { TeamUser } from 'src/team/teamUser.entity';
import { UpdateTeamInput } from 'src/team/dtos/updateTeam.input';
import { GetTeamService } from 'src/team/services/getTeam.service';
import { GetOrganizationService } from 'src/organization/services/getOrganization.service';
import { CreateChangeAuditChangeService } from 'src/changeAudit/services/createChangeAuditChange.service';
import { Resources } from 'src/common/enums/resources.enum';
import { ChangeAuditOperationTypes } from 'src/common/enums/changeAuditOperationTypes.enum';
import { CommonService } from 'src/common/services/common.service';

@Injectable()
export class UpdateTeamService {
  private readonly logger = new Logger(UpdateTeamService.name);

  constructor(
    private readonly em: EntityManager,
    @InjectRepository(TeamUser)
    private readonly teamUserRepository: EntityRepository<TeamUser>,
    private getTeamService: GetTeamService,
    private getOrganizationService: GetOrganizationService,
    private createChangeAuditChangeService: CreateChangeAuditChangeService,
    private configService: ConfigService,
    private commonService: CommonService,
  ) {}

  public async updateTeam(data: UpdateTeamInput, userId: string): Promise<Team> {
    // validate userId is associated with data.organizationId in organization_user table
    await this.getOrganizationService.getOrganization(data.organizationId, userId);

    // validate data.userIds are associated with data.organizationId
    await this.getOrganizationService.getOrganizationUsers(data.organizationId, data.userIds);

    const team = await this.getTeamService.getTeam(data.id, userId);

    let teamUsersUpdated = [];

    teamUsersUpdated = data.userIds.map((id) => {
      return {
        user: id,
        team: team.id,
      };
    });

    // if teamUsersUpdated item is not found in the existing team.teamUsers, insert
    teamUsersUpdated.forEach((teamUserUpdated) => {
      if (!team.teamUsers.toArray().find((teamUser) => teamUser.user.id == teamUserUpdated.user)) {
        this.em.create(TeamUser, {
          user: teamUserUpdated.user,
          team: team.id,
          createdAt: new Date(),
          createdBy: userId,
        });
      }
    });

    // if existing team.teamUser record is not found in teamUsersUpdated, soft delete
    team.teamUsers.getItems().forEach((teamUser) => {
      if (!teamUsersUpdated.find((teamUserUpdated) => teamUserUpdated.user == teamUser.user.id)) {
        const newTeamUser = this.em.assign(teamUser, {
          deletedAt: new Date(),
          deletedBy: userId,
        });
        this.em.persist(newTeamUser);
      }
    });

    await this.em.flush();

    this.em.assign(team, {
      updatedAt: new Date(),
      name: data.name,
      description: data.description,
      organization: data.organizationId,
      updatedBy: userId,
    });

    await this.em.persistAndFlush(team);

    const updatedTeam = await this.getTeamService.getTeam(data.id, userId);

    this.logger.log(`${Team.name} updated successfully. id: ${updatedTeam.id}`);

    // sort here so change audit diff process doesn't generate a change based on a different order of users
    const usersToSort = [];
    updatedTeam.teamUsers.toArray().forEach((teamUser) => {
      if (teamUser.deletedAt === null || teamUser.deletedAt === undefined) {
        usersToSort.push({
          id: teamUser.user.id,
          username: teamUser.user.username,
          email: teamUser.user.email,
          firstName: teamUser.user.firstName,
          lastName: teamUser.user.lastName,
        });
      }
    });
    const sortedUsers = this.commonService.sortCollection(usersToSort, 'id');

    const teamChangeAudit = {
      appId: this.configService.get('appId'),
      operationType: ChangeAuditOperationTypes.Update,
      entity: {
        id: data.id.toString(),
        type: Resources.Team,
        data: {
          id: updatedTeam.id,
          name: updatedTeam.name,
          description: updatedTeam.description,
          organizationId: updatedTeam.organization.id,
          users: sortedUsers,
        },
      },
      user: {
        id: userId.toString(),
      },
      timestamp: new Date(),
    };
    this.createChangeAuditChangeService.createChange(teamChangeAudit);

    return updatedTeam;
  }
}
