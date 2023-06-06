import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';
import { Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

import { Team } from 'src/team/team.entity';
import { CreateTeamInput } from 'src/team/dtos/createTeam.input';
import { GetTeamService } from 'src/team/services/getTeam.service';
import { GetOrganizationService } from 'src/organization/services/getOrganization.service';
import { CreateChangeAuditChangeService } from 'src/changeAudit/services/createChangeAuditChange.service';
import { Resources } from 'src/common/enums/resources.enum';
import { ChangeAuditOperationTypes } from 'src/common/enums/changeAuditOperationTypes.enum';

@Injectable()
export class CreateTeamService {
  private readonly logger = new Logger(CreateTeamService.name);

  constructor(
    @InjectRepository(Team)
    private readonly teamRepository: EntityRepository<Team>,
    private getTeamService: GetTeamService,
    private getOrganizationService: GetOrganizationService,
    private createChangeAuditChangeService: CreateChangeAuditChangeService,
    private configService: ConfigService,
  ) {}

  public async createTeam(data: CreateTeamInput, userId: string): Promise<Team> {
    // validate userId is associated with data.organizationId in organization_user table
    await this.getOrganizationService.getOrganization(data.organizationId, userId);

    // validate data.userIds are associated with data.organizationId
    await this.getOrganizationService.getOrganizationUsers(data.organizationId, data.userIds);

    const newTeam = this.teamRepository.create({
      name: data.name,
      description: data.description,
      organization: data.organizationId,
      users: data.userIds,
    });

    await this.teamRepository.persist(newTeam).flush();

    const createdTeam = await this.getTeamService.getTeam(newTeam.id, userId);

    this.logger.log(`${Team.name} created successfully. id: ${createdTeam.id}`);

    const teamChangeAudit = {
      appId: this.configService.get('appId'),
      operationType: ChangeAuditOperationTypes.update,
      entity: {
        id: createdTeam.id.toString(),
        type: Resources.Team,
        data: {
          id: createdTeam.id,
          name: createdTeam.name,
          description: createdTeam.description,
          organizationId: createdTeam.organization.id,
          users: createdTeam.users.toArray().map((key) => ({
            id: key.id,
            username: key.username,
            email: key.email,
            firstName: key.firstName,
            lastName: key.lastName,
          })),
        },
      },
      user: {
        id: userId.toString(),
      },
      timestamp: new Date(),
    };
    this.createChangeAuditChangeService.createChange(teamChangeAudit);

    return createdTeam;
  }
}
