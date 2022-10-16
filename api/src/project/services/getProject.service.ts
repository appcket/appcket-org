import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';

import { CommonService } from 'src/common/services/common.service';
import { Project } from 'src/project/project.entity';

@Injectable()
export class GetProjectService {
  private readonly entityType = 'Project';

  constructor(
    @InjectRepository(Project)
    private readonly projectRepository: EntityRepository<Project>,
    private commonService: CommonService,
  ) {}

  public async getProject(id: string): Promise<Project> {
    const project = await this.projectRepository.findOneOrFail(id, {
      populate: ['organization', 'users', 'users.attributes'],
    });

    return project;
  }
}
