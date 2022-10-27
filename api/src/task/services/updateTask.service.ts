import { Injectable } from '@nestjs/common';
import { EntityRepository, wrap } from '@mikro-orm/core';
import { InjectRepository } from '@mikro-orm/nestjs';
import { Logger } from '@nestjs/common';

import { Task } from 'src/task/task.entity';
import { UpdateTaskInput } from 'src/task/dtos/updateTask.input';
import { GetTaskService } from 'src/task/services/getTask.service';

@Injectable()
export class UpdateTaskService {
  private readonly logger = new Logger(UpdateTaskService.name);

  constructor(
    @InjectRepository(Task)
    private readonly taskRepository: EntityRepository<Task>,
    private getTaskService: GetTaskService,
  ) {}

  public async updateTask(data: UpdateTaskInput, userId: string): Promise<Task> {
    const task = await this.getTaskService.getTask(data.id);

    wrap(task).assign({
      name: data.name,
      description: data.description,
      project: data.projectId,
      taskStatusType: data.taskStatusTypeId,
      assignedTo: data.assignedTo,
    });
    await this.taskRepository.persistAndFlush(task);

    const updatedTask = await this.getTaskService.getTask(data.id);

    this.logger.log(`${Task.name} updated successfully. id: ${updatedTask.id}`);

    return updatedTask;
  }
}
