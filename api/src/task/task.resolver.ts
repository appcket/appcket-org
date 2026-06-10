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
import { UserDto } from 'src/user/user.dto';

@InputType()
export class TaskCreateInput {
  @Field()
  name!: string;
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

    const createdBy = task.createdBy
      ? {
          id: task.createdBy.id,
          email: (task.createdBy as UserDto).email,
          username: (task.createdBy as UserDto).username,
          firstName: (task.createdBy as UserDto).firstName,
          lastName: (task.createdBy as UserDto).lastName,
          attributes: (task.createdBy as UserDto).attributes,
        }
      : undefined;

    const updatedBy = task.updatedBy
      ? {
          id: task.updatedBy.id,
          email: (task.updatedBy as any).email,
          username: (task.updatedBy as any).preferred_username || (task.updatedBy as any).username,
          firstName: (task.updatedBy as any).firstName,
          lastName: (task.updatedBy as any).lastName,
          attributes: (task.updatedBy as any).attributes,
        }
      : undefined;

    const taskDto: TaskDto = {
      id: task.id,
      createdAt: task.createdAt!,
      createdBy,
      updatedAt: task.updatedAt!,
      updatedBy,
      name: task.name,
      description: task.description,
      taskStatusType: task.taskStatusType
        ? {
            id: task.taskStatusType.id,
            name: task.taskStatusType.name,
          }
        : (null as unknown as any),
      assignedTo: task.assignedTo
        ? {
            id: task.assignedTo.id,
            email: task.assignedTo.email,
            username: task.assignedTo.username,
            firstName: task.assignedTo.firstName,
            lastName: task.assignedTo.lastName,
            attributes: task.assignedTo.attributes,
          }
        : undefined,
      project: {
        id: task.project.id,
        name: task.project.name,
        createdAt: task.project.createdAt!,
        updatedAt: task.project.updatedAt!,
        users: task.project.projectUsers.toArray().map((projectUser) => {
          const u = projectUser.user as any;
          return {
            id: u.id,
            createdAt: projectUser.createdAt,
            createdBy: projectUser.createdBy ? { id: (projectUser.createdBy as any).id } : null,
            updatedAt: projectUser.updatedAt,
            updatedBy: projectUser.updatedBy ? { id: (projectUser.updatedBy as any).id } : null,
            username: u.username,
            email: u.email,
            firstName: u.firstName,
            lastName: u.lastName,
            attributes: u.attributes,
          };
        }),
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
