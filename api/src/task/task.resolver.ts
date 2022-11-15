import 'reflect-metadata';
import { Args, Context, Field, InputType, Mutation, Query, Resolver } from '@nestjs/graphql';
import { Inject } from '@nestjs/common';
import { UseGuards } from '@nestjs/common';

import { Task } from './task.entity';
import { SearchTasksInput } from 'src/task/dtos/searchTasks.input';
import { CreateTaskInput } from 'src/task/dtos/createTask.input';
import { UpdateTaskInput } from 'src/task/dtos/updateTask.input';
import { Resources } from 'src/common/enums/resources.enum';
import { TaskPermission } from 'src/common/enums/permissions.enum';
import { PermissionsGuard } from 'src/common/guards/permissions.guard';
import { Permissions } from 'src/common/decorators/permissions.decorator';
import { SearchTasksService } from 'src/task/services/searchTasks.service';
import { GetTaskService } from 'src/task/services/getTask.service';
import { CreateTaskService } from 'src/task/services/createTask.service';
import { UpdateTaskService } from 'src/task/services/updateTask.service';

@InputType()
export class TaskCreateInput {
  @Field()
  name: string;
}

@Resolver(() => Task)
export class TaskResolver {
  constructor(
    @Inject(SearchTasksService) private searchTasksService: SearchTasksService,
    @Inject(GetTaskService) private getTaskService: GetTaskService,
    @Inject(UpdateTaskService) private updateTaskService: UpdateTaskService,
    @Inject(CreateTaskService) private createTaskService: CreateTaskService,
  ) {}

  @Query(() => [Task])
  @Permissions(`${Resources.Task}#${TaskPermission.read}`)
  @UseGuards(PermissionsGuard)
  async searchTasks(@Args('searchTasksInput') searchTasksInput: SearchTasksInput) {
    return await this.searchTasksService.searchTasks(searchTasksInput);
  }

  @Query(() => Task, { nullable: true })
  @Permissions(`${Resources.Task}#${TaskPermission.read}`)
  @UseGuards(PermissionsGuard)
  async getTask(@Args('id') id: string, @Context() ctx) {
    return await this.getTaskService.getTask(id, ctx.user.id);
  }

  @Mutation(() => Task)
  @Permissions(`${Resources.Task}#${TaskPermission.create}`)
  @UseGuards(PermissionsGuard)
  async createTask(@Args('createTaskInput') createTaskInput: CreateTaskInput, @Context() ctx) {
    return await this.createTaskService.createTask(createTaskInput, ctx.user.id);
  }

  @Mutation(() => Task)
  @Permissions(`${Resources.Task}#${TaskPermission.update}`)
  @UseGuards(PermissionsGuard)
  async updateTask(@Args('updateTaskInput') updateTaskInput: UpdateTaskInput, @Context() ctx) {
    return await this.updateTaskService.updateTask(updateTaskInput, ctx.user.id);
  }
}
