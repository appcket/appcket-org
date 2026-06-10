import { Injectable } from '@nestjs/common';
import { EntityManager } from '@mikro-orm/core';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';
import { Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

import { Team } from 'src/team/team.entity';
import { TeamUser } from 'src/team/teamUser.entity';
import { CreateTeamInput } from 'src/team/dtos/createTeam.input';
import { GetTeamService } from 'src/team/services/getTeam.service';
import { GetOrganizationService } from 'src/organization/services/getOrganization.service';
import { Resources } from 'src/common/enums/resources.enum';
import { ChangeAuditOperationTypes } from 'src/common/enums/changeAuditOperationTypes.enum';
import { OutboxService } from 'src/common/services/outbox.service';

@Injectable()
export class CreateTeamService {
  private readonly logger = new Logger(CreateTeamService.name);

  constructor(
    private readonly em: EntityManager,
    @InjectRepository(Team)
    private readonly teamRepository: EntityRepository<Team>,
    private getTeamService: GetTeamService,
    private getOrganizationService: GetOrganizationService,
    private configService: ConfigService,
    private outboxService: OutboxService,
  ) {}

  public async createTeam(data: CreateTeamInput, userId: string): Promise<Team> {
    return this.em.transactional(async (em) => {
      // validate userId is associated with data.organizationId in organization_user table
      await this.getOrganizationService.getOrganization(data.organizationId, userId);

      // validate data.userIds are associated with data.organizationId
      await this.getOrganizationService.getOrganizationUsers(data.organizationId, data.userIds);

      const newTeam = em.create(Team, {
        name: data.name,
        description: data.description,
        organization: data.organizationId,
        createdBy: userId,
      });

      em.persist(newTeam);

      data.userIds.map((id) => {
        em.create(TeamUser, {
          team: newTeam,
          user: id,
        });
      });

      // Flush once to generate the ID if needed (though UUIDs are usually client-side or pre-generated)
      // but to ensure we can fetch the 'createdTeam' with relations for the payload.
      await em.flush();

      const createdTeam = await this.getTeamService.getTeam(newTeam.id, userId);

      this.logger.log(`${Team.name} created successfully. id: ${createdTeam.id}`);

      const teamEventPayload = {
        appId: this.configService.get('appId'),
        operationType: ChangeAuditOperationTypes.Create,
        entity: {
          id: createdTeam.id.toString(),
          type: Resources.Team,
          data: {
            id: createdTeam.id,
            name: createdTeam.name,
            description: createdTeam.description,
            organizationId: createdTeam.organization.id,
            users: createdTeam.teamUsers.toArray().map((teamUser) => {
              const u = teamUser.user as any;
              return {
                id: u.id,
                username: u.username,
                email: u.email,
                firstName: u.firstName,
                lastName: u.lastName,
              };
            }),
          },
        },
        user: {
          id: userId.toString(),
        },
        timestamp: new Date(),
      };

      await this.outboxService.create(teamEventPayload);

      return createdTeam;
    });
  }
}
