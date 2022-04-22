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
import { PrismaService } from 'src/common/services/prisma.service';
import { Resources } from 'src/common/enums/resources.enum';
import { SortOrder } from 'src/common/enums/sortOrder.enum';
import { TaskPermission } from 'src/common/enums/permissions.enum';
import { PermissionsGuard } from 'src/common/guards/permissions.guard';
import { Permissions } from 'src/common/decorators/permissions.decorator';
import { UserService } from 'src/user/services/user.service';

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
  ) {}

  @Query(() => [Task])
  @Permissions(`${Resources.Task}#${TaskPermission.read}`)
  @UseGuards(PermissionsGuard)
  searchTasks(
    @Args('searchString', { nullable: true }) searchString: string,
    @Args('skip', { nullable: true }) skip: number,
    @Args('take', { nullable: true }) take: number,
    @Args('orderBy', { nullable: true }) orderBy: TaskOrderByUpdatedAtInput,
  ) {
    const or = searchString
      ? {
          OR: [{ name: { contains: searchString } }],
        }
      : {};

    // TODO: move to searchTasks.service
    const tasks = this.prismaService.task.findMany({
      where: {
        deleted_at: null,
        ...or,
      },
      include: {
        project: true,
        task_status_type: true
      },
      take: take || undefined,
      skip: skip || undefined,
      orderBy: orderBy || undefined,
    });
    return tasks;
  }

  @ResolveField('assigned_to_user')
  async assigned_to_user(@Parent() task: Task, @Context() ctx) {
    const accountsUsers = await this.userService.getUsers(
      // task.project.organization.organization_id,
      '4cb17fd4-9292-4e20-bfa7-809d1a62fcc8',
      ctx.req.kauth.grant.access_token.token,
    );
    return find(accountsUsers, { 'user_id': task.assigned_to });
  }
}
