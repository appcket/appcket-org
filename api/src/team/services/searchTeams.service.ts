import { Injectable } from '@nestjs/common';
import { EntityManager } from '@mikro-orm/postgresql';

import { Team } from 'src/team/team.entity';
import { GetOrganizationService } from 'src/organization/services/getOrganization.service';
import { IPaginated } from 'src/common/models/paginated.interface';
import { PaginationService } from 'src/common/services/pagination.service';
import { SearchTeamsInput } from 'src/team/dtos/searchTeams.input';

@Injectable()
export class SearchTeamsService {
  constructor(
    private getOrganizationService: GetOrganizationService,
    private readonly em: EntityManager,
    private readonly paginationService: PaginationService,
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

    const query = this.em
      .createQueryBuilder(Team, 't')
      .select('*')
      .leftJoinAndSelect('t.createdBy', 'cb', null, ['username', 'email', 'firstName', 'lastName'])
      .leftJoinAndSelect('t.organization', 'o')
      .where(where);

    return this.paginationService.queryBuilderPagination(
      'team',
      input.orderBy[0]?.fieldName,
      input.first,
      input.orderBy[0]?.direction,
      query,
      input.after,
    );
  }
}
