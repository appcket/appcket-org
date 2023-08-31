import { Injectable } from '@nestjs/common';
import { EntityManager } from '@mikro-orm/postgresql';

import { Team } from 'src/team/team.entity';
import { GetOrganizationService } from 'src/organization/services/getOrganization.service';
import { IPaginated } from 'src/common/models/paginated.interface';
import { PaginationService } from 'src/common/services/pagination.service';
import { SearchTeamsInput } from 'src/team/dtos/searchTeam.input';

@Injectable()
export class SearchTeamsService {
  constructor(
    private getOrganizationService: GetOrganizationService,
    private readonly em: EntityManager,
    private readonly paginationService: PaginationService,
  ) {}

  public async searchTeams(
    searchTeamsInput: SearchTeamsInput,
    userId: string,
  ): Promise<IPaginated<Team>> {
    const userOrganizationIds = await this.getOrganizationService.getUserOrganizationIds(userId);
    const organizationWhere = { $in: userOrganizationIds };
    const where = searchTeamsInput.searchString
      ? {
          name: { $like: `%${searchTeamsInput.searchString}%` },
          deletedAt: null,
          organization: organizationWhere,
        }
      : {
          deletedAt: null,
          organization: organizationWhere,
        };

    const query = this.em
      .createQueryBuilder(Team, 't')
      .select('*')
      // TODO: also populate team.createdBy and team.updatedBy with User entity values
      .leftJoinAndSelect('t.organization', 'o')
      .where(where);

    return this.paginationService.queryBuilderPagination(
      'team',
      'name',
      searchTeamsInput.first,
      searchTeamsInput.orderBy[0]?.orderDirection,
      query,
      searchTeamsInput.after,
    );
  }
}
