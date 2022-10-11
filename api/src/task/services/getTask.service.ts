import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';

import { Task } from 'src/task/task.entity';

@Injectable()
export class GetTaskService {
  constructor(
    @InjectRepository(Task)
    private readonly taskRepository: EntityRepository<Task>,
  ) {}

  public async getTask(id: string): Promise<Task> {
    const task = await this.taskRepository.findOne(id, {
      populate: ['project', 'taskStatusType', 'assignedTo'],
    });
    return task;
  }
}
