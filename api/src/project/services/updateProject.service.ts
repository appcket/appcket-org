import { Injectable } from '@nestjs/common';
import { EntityRepository, wrap } from '@mikro-orm/core';
import { InjectRepository } from '@mikro-orm/nestjs';
import { Logger } from '@nestjs/common';

import { Project } from 'src/project/project.entity';
import { UpdateProjectInput } from 'src/project/dtos/updateProject.input';
import { GetProjectService } from 'src/project/services/getProject.service';
import { GetOrganizationService } from 'src/organization/services/getOrganization.service';

@Injectable()
export class UpdateProjectService {
  private readonly logger = new Logger(UpdateProjectService.name);

  constructor(
    @InjectRepository(Project)
    private readonly projectRepository: EntityRepository<Project>,
    private getProjectService: GetProjectService,
    private getOrganizationService: GetOrganizationService,
  ) {}

  public async updateProject(data: UpdateProjectInput, userId: string): Promise<Project> {
    // validate userId is associated with data.organizationId in organization_user table
    await this.getOrganizationService.getOrganization(data.organizationId, userId);

    // validate data.userIds are associated with data.organizationId
    await this.getOrganizationService.getOrganizationUsers(data.organizationId, data.userIds);

    const project = await this.getProjectService.getProject(data.id, userId);

    wrap(project).assign({
      name: data.name,
      description: data.description,
      organization: data.organizationId,
      users: data.userIds,
    });
    await this.projectRepository.persist(project);

    const updatedProject = await this.getProjectService.getProject(data.id, userId);

    this.logger.log(`${Project.name} updated successfully. id: ${updatedProject.id}`);

    return updatedProject;
  }
}
