import { Injectable } from '@nestjs/common';
import { EntityRepository, wrap } from '@mikro-orm/core';
import { InjectRepository } from '@mikro-orm/nestjs';
import { Logger } from '@nestjs/common';

import { Task } from 'src/task/task.entity';
import { UpdateTaskInput } from 'src/task/dtos/updateTask.input';
import { GetTaskService } from 'src/task/services/getTask.service';
import { GetOrganizationService } from 'src/organization/services/getOrganization.service';

@Injectable()
export class UpdateTaskService {
  private readonly logger = new Logger(UpdateTaskService.name);

  constructor(
    @InjectRepository(Task)
    private readonly taskRepository: EntityRepository<Task>,
    private getTaskService: GetTaskService,
    private getOrganizationService: GetOrganizationService,
  ) {}

  public async updateTask(data: UpdateTaskInput, userId: string): Promise<Task> {
    // validate userId is associated with data.project.organization.id
    const task = await this.getTaskService.getTask(data.id, userId);

    // validate data.assignedTo is associated with data.project.organization.id
    await this.getOrganizationService.getOrganizationUsers(task.project.organization.id, [data.assignedTo]);

    wrap(task).assign({
      name: data.name,
      description: data.description,
      project: data.projectId,
      taskStatusType: data.taskStatusTypeId ? data.taskStatusTypeId : null,
      assignedTo: data.assignedTo ? data.assignedTo : null,
    });
    await this.taskRepository.persistAndFlush(task);

    const updatedTask = await this.getTaskService.getTask(data.id, userId);

    this.logger.log(`${Task.name} updated successfully. id: ${updatedTask.id}`);

    return updatedTask;
  }
}
