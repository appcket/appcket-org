import 'reflect-metadata';
import {
  Args,
  Context,
  Field,
  InputType,
  Mutation,
  Parent,
  Query,
  Resolver,
  ResolveField,
} from '@nestjs/graphql';
import { Inject } from '@nestjs/common';
import { UseGuards } from '@nestjs/common';
import { find, intersectionBy } from 'lodash';

import { Task } from './models/task.model';
import { SearchTasksInput } from 'src/task/dtos/searchTasks.input';
import { PrismaService } from 'src/common/services/prisma.service';
import { Resources } from 'src/common/enums/resources.enum';
import { SortOrder } from 'src/common/enums/sortOrder.enum';
import { TaskPermission } from 'src/common/enums/permissions.enum';
import { PermissionsGuard } from 'src/common/guards/permissions.guard';
import { Permissions } from 'src/common/decorators/permissions.decorator';
import { UserService } from 'src/user/services/user.service';
import { SearchTasksService } from 'src/task/services/searchTasks.service';

@InputType()
export class TaskCreateInput {
  @Field()
  name: string;
}

@InputType()
class TaskOrderByUpdatedAtInput {
  @Field((type) => SortOrder)
  updated_at: SortOrder;
}

@Resolver(() => Task)
export class TaskResolver {
  constructor(
    @Inject(PrismaService) private prismaService: PrismaService,
    @Inject(UserService) private userService: UserService,
    @Inject(SearchTasksService) private searchTasksService: SearchTasksService, // @Inject(GetTaskService) private getTaskService: GetTaskService, // @Inject(UpdateTaskService) private updateTaskService: UpdateTaskService, // @Inject(CreateTaskService) private createTaskService: CreateTaskService,
  ) {}

  @Query(() => [Task])
  @Permissions(`${Resources.Task}#${TaskPermission.read}`)
  @UseGuards(PermissionsGuard)
  async searchTasks(@Args('searchTasksInput') searchTasksInput: SearchTasksInput) {
    return await this.searchTasksService.searchTasks(searchTasksInput);
  }

  @ResolveField('assigned_to_user')
  async assigned_to_user(@Parent() task: Task, @Context() ctx) {
    const accountsUsers = await this.userService.getUsers(
      task.project.organization.organization_id,
      ctx.req.kauth.grant.access_token.token,
    );
    return find(accountsUsers, { user_id: task.assigned_to });
  }
}
