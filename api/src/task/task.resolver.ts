import 'reflect-metadata';
import { Args, Context, Field, InputType, Mutation, Query, Resolver } from '@nestjs/graphql';
import { Inject } from '@nestjs/common';
import { UseGuards } from '@nestjs/common';

import { TaskDto } from 'src/task/dtos/task.dto';
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
import { PaginatedTaskDto } from 'src/task/dtos/paginatedTask.dto';

@InputType()
export class TaskCreateInput {
  @Field()
  name: string;
}

@Resolver(() => TaskDto)
export class TaskResolver {
  constructor(
    @Inject(SearchTasksService) private searchTasksService: SearchTasksService,
    @Inject(GetTaskService) private getTaskService: GetTaskService,
    @Inject(UpdateTaskService) private updateTaskService: UpdateTaskService,
    @Inject(CreateTaskService) private createTaskService: CreateTaskService,
  ) {}

  @Query(() => PaginatedTaskDto)
  @Permissions(`${Resources.Task}#${TaskPermission.read}`)
  @UseGuards(PermissionsGuard)
  async searchTasks(@Args('searchTasksInput') searchTasksInput: SearchTasksInput, @Context() ctx) {
    const results = await this.searchTasksService.searchTasks(searchTasksInput, ctx.user.id);

    return results;
  }

  @Query(() => TaskDto, { nullable: true })
  @Permissions(`${Resources.Task}#${TaskPermission.read}`)
  @UseGuards(PermissionsGuard)
  async getTask(@Args('id') id: string, @Context() ctx) {
    const task = await this.getTaskService.getTask(id, ctx.user.id);

    let createdBy = null;
    let updatedBy = null;

    if (task.createdBy) {
      createdBy = {
        id: task.createdBy.id,
        email: task.createdBy.email,
        username: task.createdBy.username,
        firstName: task.createdBy.firstName,
        lastName: task.createdBy.lastName,
      };
    }

    if (task.updatedBy) {
      updatedBy = {
        id: task.updatedBy.id,
        email: task.updatedBy.email,
        username: task.updatedBy.username,
        firstName: task.updatedBy.firstName,
        lastName: task.updatedBy.lastName,
      };
    }

    const taskDto: TaskDto = {
      id: task.id,
      createdAt: task.createdAt,
      createdBy,
      updatedAt: task.updatedAt,
      updatedBy,
      name: task.name,
      description: task.description,
      taskStatusType: {
        id: task.taskStatusType.id,
        name: task.taskStatusType.name,
      },
      assignedTo: {
        id: task.assignedTo.id,
        email: task.assignedTo.email,
        username: task.assignedTo.username,
        firstName: task.assignedTo.firstName,
        lastName: task.assignedTo.lastName,
      },
      project: {
        id: task.project.id,
        name: task.project.name,
        createdAt: task.project.createdAt,
        updatedAt: task.project.updatedAt,
        users: task.project.projectUsers.toArray().map((projectUser) => ({
          id: projectUser.user.id,
          createdAt: projectUser.createdAt,
          createdBy: projectUser.createdBy,
          updatedAt: projectUser.updatedAt,
          updatedBy: projectUser.updatedBy,
          username: projectUser.user.username,
          email: projectUser.user.email,
          firstName: projectUser.user.firstName,
          lastName: projectUser.user.lastName,
        })),
      },
    };

    return taskDto;
  }

  @Mutation(() => TaskDto)
  @Permissions(`${Resources.Task}#${TaskPermission.create}`)
  @UseGuards(PermissionsGuard)
  async createTask(@Args('createTaskInput') createTaskInput: CreateTaskInput, @Context() ctx) {
    return await this.createTaskService.createTask(createTaskInput, ctx.user.id);
  }

  @Mutation(() => TaskDto)
  @Permissions(`${Resources.Task}#${TaskPermission.update}`)
  @UseGuards(PermissionsGuard)
  async updateTask(@Args('updateTaskInput') updateTaskInput: UpdateTaskInput, @Context() ctx) {
    return await this.updateTaskService.updateTask(updateTaskInput, ctx.user.id);
  }
}
