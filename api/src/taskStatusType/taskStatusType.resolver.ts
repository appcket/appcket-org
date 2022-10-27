import 'reflect-metadata';
import { Query, Resolver } from '@nestjs/graphql';
import { Inject } from '@nestjs/common';

import { TaskStatusType } from 'src/taskStatusType/taskStatusType.entity';
import { GetTaskStatusTypesService } from 'src/taskStatusType/getTaskStatusTypes.service';

@Resolver(() => TaskStatusType)
export class TaskStatusTypeResolver {
  constructor(
    @Inject(GetTaskStatusTypesService) private getTaskStatusTypesService: GetTaskStatusTypesService,
  ) {}

  @Query(() => [TaskStatusType])
  async getTaskStatusTypes() {
    return await this.getTaskStatusTypesService.getAll();
  }
}
