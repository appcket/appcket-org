import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';
import { Logger } from '@nestjs/common';

import { Task } from 'src/task/task.entity';
import { CreateTaskInput } from 'src/task/dtos/createTask.input';
import { GetTaskService } from 'src/task/services/getTask.service';

@Injectable()
export class CreateTaskService {
  private readonly logger = new Logger(CreateTaskService.name);

  constructor(
    @InjectRepository(Task)
    private readonly taskRepository: EntityRepository<Task>,
    private getTaskService: GetTaskService,
  ) {}

  public async createTask(data: CreateTaskInput, userId: string): Promise<Task> {
    // TODO: validate userId is associated with data.organizationId
    // TODO: validate data.userIds are associated with data.organizationId

    const newTask = this.taskRepository.create({
      name: data.name,
      taskStatusType: data.taskStatusTypeId,
      description: data.description,
      project: data.projectId,
      assignedTo: data.assignedTo,
    });

    await this.taskRepository.persist(newTask).flush();

    const createdTask = await this.getTaskService.getTask(newTask.id);

    this.logger.log(`${Task.name} created successfully. id: ${createdTask.id}`);

    return createdTask;
  }
}
