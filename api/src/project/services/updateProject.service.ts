import { Injectable } from '@nestjs/common';
import { EntityRepository, wrap } from '@mikro-orm/core';
import { InjectRepository } from '@mikro-orm/nestjs';
import { Logger } from '@nestjs/common';

import { Project } from 'src/project/project.entity';
import { UpdateProjectInput } from 'src/project/dtos/updateProject.input';
import { GetProjectService } from 'src/project/services/getProject.service';

@Injectable()
export class UpdateProjectService {
  private readonly logger = new Logger(UpdateProjectService.name);

  constructor(
    @InjectRepository(Project)
    private readonly projectRepository: EntityRepository<Project>,
    private getProjectService: GetProjectService,
  ) {}

  public async updateProject(data: UpdateProjectInput, userId: string): Promise<Project> {
    const project = await this.getProjectService.getProject(data.id);

    wrap(project).assign({
      name: data.name,
      description: data.description,
      organization: data.organizationId,
      users: data.userIds,
    });
    await this.projectRepository.persist(project);

    const updatedProject = await this.getProjectService.getProject(data.id);

    this.logger.log(`${Project.name} updated successfully. id: ${updatedProject.id}`);

    return updatedProject;
  }
}
