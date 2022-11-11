import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';

import { Team } from 'src/team/team.entity';
import { GetOrganizationService } from 'src/organization/services/getOrganization.service';

@Injectable()
export class SearchTeamsService {
  constructor(
    @InjectRepository(Team)
    private readonly teamRepository: EntityRepository<Team>,
    private getOrganizationService: GetOrganizationService,
  ) {}

  public async searchTeams(
    searchString: string,
    limit: number,
    offset: number,
    userId: string,
  ): Promise<Team[]> {
    const userOrganizationIds = await this.getOrganizationService.getUserOrganizationIds(userId);
    const organizationWhere = { $in: userOrganizationIds };
    const where = searchString
      ? {
          name: { $like: `%${searchString}%` },
          organization: organizationWhere,
        }
      : {
          organization: organizationWhere,
        };

    const dbTeams = await this.teamRepository.find(where, {
      populate: ['organization', 'users'],
      limit,
      offset,
    });

    return dbTeams;
  }
}
