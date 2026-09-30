import { Query, Resolver } from '@nestjs/graphql';
import { Inject } from '@nestjs/common';

import { TaskStatusType } from '@/taskStatusType/taskStatusType.entity';
import { GetTaskStatusTypesService } from '@/taskStatusType/getTaskStatusTypes.service';

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
