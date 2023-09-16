import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';

import { GetOrganizationService } from 'src/organization/services/getOrganization.service';
import { Project } from 'src/project/project.entity';

@Injectable()
export class GetProjectService {
  constructor(
    @InjectRepository(Project)
    private readonly projectRepository: EntityRepository<Project>,
    private getOrganizationService: GetOrganizationService,
  ) {}

  public async getProject(id: string, userId: string): Promise<Project> {
    const userOrganizationIds = await this.getOrganizationService.getUserOrganizationIds(userId);
    const organizationWhere = { $in: userOrganizationIds };

    const project = await this.projectRepository.findOneOrFail(
      { id, deletedAt: null, organization: organizationWhere },
      {
        populate: [
          'createdBy',
          'updatedBy',
          'organization.id',
          'organization.name',
          'projectUsers.user',
          'projectUsers.user.attributes',
        ],
        populateWhere: { projectUsers: { deletedAt: null } },
      },
    );

    return project;
  }
}
