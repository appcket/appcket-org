import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';
import { Logger } from '@nestjs/common';

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
  ) {}

  public async createProject(data: CreateProjectInput, userId: string): Promise<Project> {
    // TODO: validate userId is associated with data.organizationId
    // TODO: validate data.userIds are associated with data.organizationId

    const newProject = this.projectRepository.create({
      name: data.name,
      description: data.description,
      organization: data.organizationId,
      users: data.userIds,
    });

    await this.projectRepository.persist(newProject).flush();

    const createdProject = await this.getProjectService.getProject(newProject.id);

    this.logger.log(`${Project.name} created successfully. id: ${createdProject.id}`);

    return createdProject;
  }
}
