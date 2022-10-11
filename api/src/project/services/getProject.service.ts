import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';

import { Project } from 'src/project/project.entity';

@Injectable()
export class GetProjectService {
  constructor(
    @InjectRepository(Project)
    private readonly projectRepository: EntityRepository<Project>,
  ) {}

  public async getProject(id: string): Promise<Project> {
    const dbProject = await this.projectRepository.findOne(id, {
      populate: ['organization', 'users', 'users.attributes'],
    });

    return dbProject;
  }
}
