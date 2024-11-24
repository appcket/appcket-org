import { Injectable } from '@nestjs/common';
import { EntityManager } from '@mikro-orm/postgresql';

import { Project } from 'src/project/project.entity';
import { GetOrganizationService } from 'src/organization/services/getOrganization.service';
import { IPaginated } from 'src/common/models/paginated.interface';
import { SearchProjectsInput } from 'src/project/dtos/searchProjects.input';

@Injectable()
export class SearchProjectsService {
  constructor(
    private getOrganizationService: GetOrganizationService,
    private readonly em: EntityManager,
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

    const currentCursor = await this.em.findByCursor(Project, where, {
      populate: ['organization', 'createdBy', 'updatedBy', 'projectUsers'],
      first: input.first,
      after: input.after,
      orderBy: {
        [input.orderBy[0]?.fieldName]: input.orderBy[0]?.direction.toLocaleLowerCase(),
      },
    });

    const paginatedProjects: IPaginated<Project> = {
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
      paginatedProjects.edges.push({
        node: item,
      });
    });

    return paginatedProjects;
  }
}
