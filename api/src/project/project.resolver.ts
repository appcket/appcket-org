import 'reflect-metadata';
import { Args, Context, Field, InputType, Mutation, Query, Resolver } from '@nestjs/graphql';
import { Inject } from '@nestjs/common';
import { UseGuards } from '@nestjs/common';

import { Project } from 'src/project/project.entity';
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
import { SearchProjectsService } from 'src/project/services/searchProjects.service';
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
    @Inject(SearchProjectsService) private searchProjectsService: SearchProjectsService,
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
  async searchProjects(
    @Args('searchString', { nullable: true }) searchString: string,
    @Args('limit', { nullable: true }) limit: number,
    @Args('offset', { nullable: true }) offset: number,
    @Args('orderBy', { nullable: true }) orderBy: ProjectOrderByUpdatedAtInput,
  ) {
    return await this.searchProjectsService.searchProjects(searchString, limit, offset);
  }

  @Mutation(() => Project)
  @Permissions(`${Resources.Project}#${ProjectPermission.update}`)
  @UseGuards(PermissionsGuard)
  async updateProject(
    @Args('updateProjectInput') updateProjectInput: UpdateProjectInput,
    @Context() ctx,
  ) {
    return await this.updateProjectService.updateProject(updateProjectInput, ctx.user.id);
  }

  @Mutation(() => Project)
  @Permissions(`${Resources.Project}#${ProjectPermission.create}`)
  @UseGuards(PermissionsGuard)
  async createProject(
    @Args('createProjectInput') createProjectInput: CreateProjectInput,
    @Context() ctx,
  ) {
    return await this.createProjectService.createProject(createProjectInput, ctx.user.id);
  }
}
