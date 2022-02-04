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
import { intersectionBy } from 'lodash';

import { Project } from './models/project.model';
import { UpdateProjectInput } from './dtos/updateProject.input';
import { CreateProjectInput } from './dtos/createProject.input';
import { PrismaService } from 'src/common/services/prisma.service';
import { Resources } from 'src/common/enums/resources.enum';
import { SortOrder } from 'src/common/enums/sortOrder.enum';
import { ProjectPermission } from 'src/common/enums/permissions.enum';
import { PermissionsGuard } from 'src/common/guards/permissions.guard';
import { Permissions } from 'src/common/decorators/permissions.decorator';
import { UserService } from 'src/user/services/user.service';
import { GetProjectService } from 'src/project/services/getProject.service';
import { UpdateProjectService } from 'src/project/services/updateProject.service';
import { CreateProjectService } from 'src/project/services/createProject.service';

@InputType()
export class ProjectCreateInput {
  @Field()
  name: string;
}

@InputType()
class ProjectOrderByUpdatedAtInput {
  @Field((type) => SortOrder)
  updated_at: SortOrder;
}

@Resolver(() => Project)
export class ProjectResolver {
  constructor(
    @Inject(PrismaService) private prismaService: PrismaService,
    @Inject(UserService) private userService: UserService,
    @Inject(GetProjectService) private getProjectService: GetProjectService,
    @Inject(UpdateProjectService) private updateProjectService: UpdateProjectService,
    @Inject(CreateProjectService) private createProjectService: CreateProjectService,
  ) {}

  @Query(() => Project, { nullable: true })
  @Permissions(`${Resources.Project}#${ProjectPermission.read}`)
  @UseGuards(PermissionsGuard)
  async getProject(@Args('id') id: string) {
    return await this.getProjectService.getProject(id);
  }

  @Query(() => [Project])
  @Permissions(`${Resources.Project}#${ProjectPermission.read}`)
  @UseGuards(PermissionsGuard)
  searchProjects(
    @Args('searchString', { nullable: true }) searchString: string,
    @Args('skip', { nullable: true }) skip: number,
    @Args('take', { nullable: true }) take: number,
    @Args('orderBy', { nullable: true }) orderBy: ProjectOrderByUpdatedAtInput,
  ) {
    const or = searchString
      ? {
          OR: [{ name: { contains: searchString } }],
        }
      : {};

    // TODO: move to searchProjects.service
    return this.prismaService.project.findMany({
      where: {
        deleted_at: null,
        ...or,
      },
      take: take || undefined,
      skip: skip || undefined,
      orderBy: orderBy || undefined,
    });
  }

  @Mutation(() => Project)
  @Permissions(`${Resources.Project}#${ProjectPermission.update}`)
  @UseGuards(PermissionsGuard)
  async updateProject(@Args('updateProjectInput') updateProjectInput: UpdateProjectInput, @Context() ctx) {
    return await this.updateProjectService.updateProject(updateProjectInput, ctx.user.id);
  }

  @Mutation(() => Project)
  @Permissions(`${Resources.Project}#${ProjectPermission.create}`)
  @UseGuards(PermissionsGuard)
  async createProject(@Args('createProjectInput') createProjectInput: CreateProjectInput, @Context() ctx) {
    return await this.createProjectService.createProject(createProjectInput, ctx.user.id);
  }

  @ResolveField('users')
  async users(@Parent() project: Project, @Context() ctx) {
    const accountsUsers = await this.userService.getUsers(ctx.req.kauth.grant.access_token.token);
    return intersectionBy(accountsUsers, project.project_user, 'user_id');
  }
}
