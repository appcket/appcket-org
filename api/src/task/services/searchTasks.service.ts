import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';

import { Task } from 'src/task/task.entity';
import { SearchTasksInput } from 'src/task/dtos/searchTasks.input';

@Injectable()
export class SearchTasksService {
  constructor(
    @InjectRepository(Task)
    private readonly taskRepository: EntityRepository<Task>,
  ) {}

  public async searchTasks(input: SearchTasksInput): Promise<Task[]> {
    const where = input.searchString
      ? {
          name: { $like: `%${input.searchString}%` },
          project: { $in: input.projectIds },
        }
      : {};

    const dbTasks = await this.taskRepository.find(where, {
      populate: ['project', 'taskStatusType', 'assignedTo'],
      limit: input.limit,
      offset: input.offset,
    });

    return dbTasks;
  }
}
