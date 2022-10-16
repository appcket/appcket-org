import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';

import { CommonService } from 'src/common/services/common.service';
import { Task } from 'src/task/task.entity';

@Injectable()
export class GetTaskService {
  private readonly entityType = 'Task';

  constructor(
    @InjectRepository(Task)
    private readonly taskRepository: EntityRepository<Task>,
    private commonService: CommonService,
  ) {}

  public async getTask(id: string): Promise<Task> {
    const task = await this.taskRepository.findOneOrFail(id, {
      populate: ['project', 'taskStatusType', 'assignedTo'],
    });

    return task;
  }
}
