import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';
import { Logger } from '@nestjs/common';

import { GetOrganizationService } from 'src/organization/services/getOrganization.service';
import { Project } from 'src/project/project.entity';
import { CreateProjectInput } from 'src/project/dtos/createProject.input';
import { GetProjectService } from 'src/project/services/getProject.service';

@Injectable()
export class CreateProjectService {
  private readonly logger = new Logger(CreateProjectService.name);

  constructor(
    @InjectRepository(Project)
    private readonly projectRepository: EntityRepository<Project>,
    private getProjectService: GetProjectService,
    private getOrganizationService: GetOrganizationService,
  ) {}

  public async createProject(data: CreateProjectInput, userId: string) {
    // validate userId is associated with data.organizationId in organization_user table
    await this.getOrganizationService.getOrganization(data.organizationId, userId);

    // validate data.userIds are associated with data.organizationId
    await this.getOrganizationService.getOrganizationUsers(data.organizationId, data.userIds);

    const newProject = this.projectRepository.create({
      name: data.name,
      description: data.description,
      organization: data.organizationId,
      users: data.userIds,
    });

    await this.projectRepository.persist(newProject).flush();

    const createdProject = await this.getProjectService.getProject(newProject.id, userId);

    this.logger.log(`${Project.name} created successfully. id: ${createdProject.id}`);

    return createdProject;
  }
}
