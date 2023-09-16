import { Injectable } from '@nestjs/common';
import { EntityManager } from '@mikro-orm/postgresql';

import { Task } from 'src/task/task.entity';
import { SearchTasksInput } from 'src/task/dtos/searchTasks.input';
import { IPaginated } from 'src/common/models/paginated.interface';
import { PaginationService } from 'src/common/services/pagination.service';

@Injectable()
export class SearchTasksService {
  constructor(
    private readonly em: EntityManager,
    private readonly paginationService: PaginationService,
  ) {}

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

    const query = this.em
      .createQueryBuilder(Task, 't')
      .select(['*'])
      .leftJoinAndSelect('t.createdBy', 'cb', null, ['username', 'email', 'firstName', 'lastName'])
      .leftJoinAndSelect('t.project', 'p')
      .leftJoinAndSelect('t.taskStatusType', 'tst')
      .leftJoinAndSelect('t.assignedTo', 'at', null, ['username', 'email', 'firstName', 'lastName'])
      .where(where);

    const test = await this.paginationService.queryBuilderPagination(
      'team',
      input.orderBy[0]?.fieldName,
      input.first,
      input.orderBy[0]?.direction,
      query,
      input.after,
    );

    return test;
  }
}
