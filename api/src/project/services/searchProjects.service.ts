import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';

import { Project } from 'src/project/project.entity';
import { ProjectModel } from 'src/project/project.model';

@Injectable()
export class SearchProjectsService {
  constructor(
    @InjectRepository(Project)
    private readonly projectRepository: EntityRepository<Project>,
  ) {}

  public async searchProjects(
    searchString: string,
    limit: number,
    offset: number,
  ): Promise<Project[]> {
    const where = searchString
      ? {
          name: { $like: `%${searchString}%` },
        }
      : {};

    const dbProjects = await this.projectRepository.find(where, {
      populate: ['organization'],
      limit,
      offset,
    });

    return dbProjects;
  }
}
