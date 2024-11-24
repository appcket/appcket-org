import { Injectable } from '@nestjs/common';
import { EntityManager } from '@mikro-orm/postgresql';

import { Team } from 'src/team/team.entity';
import { GetOrganizationService } from 'src/organization/services/getOrganization.service';
import { IPaginated } from 'src/common/models/paginated.interface';
import { SearchTeamsInput } from 'src/team/dtos/searchTeams.input';

@Injectable()
export class SearchTeamsService {
  constructor(
    private getOrganizationService: GetOrganizationService,
    private readonly em: EntityManager,
  ) {}

  public async searchTeams(input: SearchTeamsInput, userId: string): Promise<IPaginated<Team>> {
    const userOrganizationIds = await this.getOrganizationService.getUserOrganizationIds(userId);
    const organizationWhere = { $in: userOrganizationIds };
    const where = input.searchString
      ? {
          name: { $like: `%${input.searchString}%` },
          deletedAt: null,
          organization: organizationWhere,
        }
      : {
          deletedAt: null,
          organization: organizationWhere,
        };

    const currentCursor = await this.em.findByCursor(Team, where, {
      populate: ['organization', 'createdBy', 'updatedBy', 'teamUsers'],
      first: input.first,
      after: input.after,
      orderBy: {
        [input.orderBy[0]?.fieldName]: input.orderBy[0]?.direction.toLocaleLowerCase(),
      },
    });

    const paginatedTeams: IPaginated<Team> = {
      totalCount: currentCursor.totalCount,
      pageInfo: {
        endCursor: currentCursor.endCursor,
        hasNextPage: currentCursor.hasNextPage,
        hasPreviousPage: currentCursor.hasPrevPage,
        startCursor: currentCursor.startCursor,
      },
      edges: [],
    };

    currentCursor.items.forEach((item) => {
      paginatedTeams.edges.push({
        node: item,
      });
    });

    return paginatedTeams;
  }
}
