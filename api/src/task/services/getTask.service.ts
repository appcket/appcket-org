import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';

import { GetOrganizationService } from 'src/organization/services/getOrganization.service';
import { Task } from 'src/task/task.entity';

@Injectable()
export class GetTaskService {
  constructor(
    @InjectRepository(Task)
    private readonly taskRepository: EntityRepository<Task>,
    private getOrganizationService: GetOrganizationService,
  ) {}

  public async getTask(id: string, userId: string): Promise<Task> {
    const task = await this.taskRepository.findOneOrFail(
      { id, deletedAt: null },
      {
        populate: [
          'project',
          'project.projectUsers.user',
          'taskStatusType',
          'project.organization.id',
        ],
        populateWhere: { project: { projectUsers: { deletedAt: null } } },
      },
    );

    // validate userId is associated with task.project.organization.id
    await this.getOrganizationService.getOrganization(task.project.organization.id, userId);

    return task;
  }
}
