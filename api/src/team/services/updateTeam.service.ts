import { Injectable } from '@nestjs/common';
import { EntityManager } from '@mikro-orm/core';
import { EntityRepository, wrap } from '@mikro-orm/core';
import { InjectRepository } from '@mikro-orm/nestjs';
import { Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

import { Team } from 'src/team/team.entity';
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
    @InjectRepository(Team)
    private readonly teamRepository: EntityRepository<Team>,
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

    wrap(team).assign({
      name: data.name,
      description: data.description,
      organization: data.organizationId,
      users: data.userIds,
    });
    await this.em.persist(team);

    const updatedTeam = await this.getTeamService.getTeam(data.id, userId);

    this.logger.log(`${Team.name} updated successfully. id: ${updatedTeam.id}`);

    // sort here so change audit diff process doesn't generate a change based on a different order of users
    const sortedUsers = this.commonService.sortCollection(
      updatedTeam.users.toArray().map((key) => ({
        id: key.id,
        username: key.username,
        email: key.email,
        firstName: key.firstName,
        lastName: key.lastName,
      })),
      'id',
    );

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
