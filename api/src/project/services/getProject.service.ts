import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';

import { Project } from 'src/project/project.entity';
import { ProjectModel } from 'src/project/project.model';

@Injectable()
export class GetProjectService {
  constructor(
    @InjectRepository(Project)
    private readonly projectRepository: EntityRepository<Project>,
  ) {}

  public async getProject(id: string): Promise<ProjectModel> {
    const dbProject = await this.projectRepository.findOne(id, {
      populate: ['organization', 'users'],
    });

    return {
      id: dbProject.id,
      name: dbProject.name,
      description: dbProject.description,
      organization: {
        id: dbProject.organization.id,
        name: dbProject.organization.name,
      },
      users: dbProject.users.toJSON(),
    };
  }
}
