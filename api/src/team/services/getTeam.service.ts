import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';

import { Team } from 'src/team/team.entity';
import { GetOrganizationService } from 'src/organization/services/getOrganization.service';

@Injectable()
export class GetTeamService {
  constructor(
    @InjectRepository(Team)
    private readonly teamRepository: EntityRepository<Team>,
    private getOrganizationService: GetOrganizationService,
  ) {}

  public async getTeam(id: string, userId: string): Promise<Team> {
    const userOrganizationIds = await this.getOrganizationService.getUserOrganizationIds(userId);
    const organizationIds = userOrganizationIds.map((org: any) => org.id || org);
    const organizationWhere = { $in: organizationIds };

    const team = await this.teamRepository.findOneOrFail(
      { id, deletedAt: null, organization: organizationWhere },
      {
        populate: [
          'createdBy',
          'updatedBy',
          'organization.id',
          'organization.name',
          'teamUsers.user',
          'teamUsers.user.attributes',
        ],
        populateWhere: { teamUsers: { deletedAt: null } },
      },
    );

    return team;
  }
}
