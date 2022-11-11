import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';

import { Project } from 'src/project/project.entity';
import { GetOrganizationService } from 'src/organization/services/getOrganization.service';

@Injectable()
export class SearchProjectsService {
  constructor(
    @InjectRepository(Project)
    private readonly projectRepository: EntityRepository<Project>,
    private getOrganizationService: GetOrganizationService,
  ) {}

  public async searchProjects(
    searchString: string,
    limit: number,
    offset: number,
    userId: string,
  ): Promise<Project[]> {
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

    const dbProjects = await this.projectRepository.find(where, {
      populate: ['organization'],
      limit,
      offset,
    });

    return dbProjects;
  }
}
