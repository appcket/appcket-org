import { Injectable } from '@nestjs/common';
import { EntityManager } from '@mikro-orm/postgresql';

import { Project } from 'src/project/project.entity';
import { GetOrganizationService } from 'src/organization/services/getOrganization.service';
import { IPaginated } from 'src/common/models/paginated.interface';
import { SearchProjectsInput } from 'src/project/dtos/searchProjects.input';
import { Organization } from 'src/organization/organization.entity';

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
    const organizationIds = userOrganizationIds.map((org: any) => org.id || org);
    const organizationWhere = { $in: organizationIds };
    const searchString = input.searchString?.toLowerCase();
    const where = searchString
      ? {
          name: { $ilike: `%${searchString}%` },
          deletedAt: null,
          organization: organizationWhere,
        }
      : {
          deletedAt: null,
          organization: organizationWhere,
        };

    const orderField = input.orderBy?.[0]?.fieldName || 'createdAt';
    const orderDirection = input.orderBy?.[0]?.direction?.toLowerCase() || 'desc';

    const currentCursor = await this.em.findByCursor(Project, {
      where,
      populate: ['organization', 'createdBy', 'updatedBy', 'projectUsers'],
      first: input.first,
      after: input.after,
      orderBy: {
        [orderField]: orderDirection,
      },
    });

    const paginatedProjects: IPaginated<Project> = {
      totalCount: currentCursor.totalCount,
      pageInfo: {
        endCursor: currentCursor.endCursor ?? '',
        hasNextPage: currentCursor.hasNextPage,
        hasPreviousPage: currentCursor.hasPrevPage,
        startCursor: currentCursor.startCursor ?? '',
      },
      edges: [],
    };

    currentCursor.items.forEach((item) => {
      paginatedProjects.edges.push({
        node: {
          ...item,
          organization: item.organization
            ? {
                id: item.organization.id,
                name: (item.organization as Organization).name,
              }
            : undefined,
        } as any,
      });
    });

    return paginatedProjects;
  }
}
