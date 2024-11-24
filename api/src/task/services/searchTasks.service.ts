import { Injectable } from '@nestjs/common';
import { EntityManager } from '@mikro-orm/postgresql';

import { Task } from 'src/task/task.entity';
import { SearchTasksInput } from 'src/task/dtos/searchTasks.input';
import { IPaginated } from 'src/common/models/paginated.interface';

@Injectable()
export class SearchTasksService {
  constructor(private readonly em: EntityManager) {}

  public async searchTasks(input: SearchTasksInput, userId: string): Promise<IPaginated<Task>> {
    const where = input.searchString
      ? {
          name: { $like: `%${input.searchString}%` },
          deletedAt: null,
          project: { $in: input.projectIds },
        }
      : {
          project: { $in: input.projectIds },
        };

    const currentCursor = await this.em.findByCursor(Task, where, {
      populate: ['project', 'createdBy', 'updatedBy', 'taskStatusType', 'assignedTo'],
      first: input.first,
      after: input.after,
      orderBy: {
        [input.orderBy[0]?.fieldName]: input.orderBy[0]?.direction.toLocaleLowerCase(),
      },
    });

    const paginatedTasks: IPaginated<Task> = {
      totalCount: currentCursor.totalCount,
      pageInfo: {
        endCursor: currentCursor.endCursor,
        hasNextPage: currentCursor.hasNextPage,
        hasPreviousPage: currentCursor.hasPrevPage,
        startCursor: currentCursor.startCursor,
      },
      edges: [],
    };

    currentCursor.items.forEach((item) => {
      paginatedTasks.edges.push({
        node: item,
      });
    });

    return paginatedTasks;
  }
}
