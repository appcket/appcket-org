import { Injectable } from '@nestjs/common';
import { EntityManager } from '@mikro-orm/postgresql';

import { Project } from 'src/project/project.entity';
import { GetOrganizationService } from 'src/organization/services/getOrganization.service';
import { IPaginated } from 'src/common/models/paginated.interface';
import { PaginationService } from 'src/common/services/pagination.service';
import { SearchProjectsInput } from 'src/project/dtos/searchProjects.input';

@Injectable()
export class SearchProjectsService {
  constructor(
    private getOrganizationService: GetOrganizationService,
    private readonly em: EntityManager,
    private readonly paginationService: PaginationService,
  ) {}

  public async searchProjects(
    input: SearchProjectsInput,
    userId: string,
  ): Promise<IPaginated<Project>> {
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
      .createQueryBuilder(Project, 'p')
      .select('*')
      .leftJoinAndSelect('p.createdBy', 'cb', null, ['username', 'email', 'firstName', 'lastName'])
      .leftJoinAndSelect('p.organization', 'o')
      .where(where);

    return this.paginationService.queryBuilderPagination(
      'project',
      input.orderBy[0]?.fieldName,
      input.first,
      input.orderBy[0]?.direction,
      query,
      input.after,
    );
  }
}
