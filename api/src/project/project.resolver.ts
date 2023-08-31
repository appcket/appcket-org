import 'reflect-metadata';
import { Args, Context, Field, InputType, Mutation, Query, Resolver } from '@nestjs/graphql';
import { Inject } from '@nestjs/common';
import { UseGuards } from '@nestjs/common';

import { ProjectDto } from 'src/project/dtos/project.dto';
import { UpdateProjectInput } from './dtos/updateProject.input';
import { CreateProjectInput } from './dtos/createProject.input';
import { Resources } from 'src/common/enums/resources.enum';
import { SortOrder } from 'src/common/enums/sortOrder.enum';
import { ProjectPermission } from 'src/common/enums/permissions.enum';
import { PermissionsGuard } from 'src/common/guards/permissions.guard';
import { Permissions } from 'src/common/decorators/permissions.decorator';
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
  @Field(() => SortOrder)
  updated_at: SortOrder;
}

@Resolver(() => ProjectDto)
export class ProjectResolver {
  constructor(
    @Inject(GetProjectService) private getProjectService: GetProjectService,
    @Inject(SearchProjectsService) private searchProjectsService: SearchProjectsService,
    @Inject(UpdateProjectService) private updateProjectService: UpdateProjectService,
    @Inject(CreateProjectService) private createProjectService: CreateProjectService,
  ) {}

  @Query(() => ProjectDto, { nullable: true })
  @Permissions(`${Resources.Project}#${ProjectPermission.read}`)
  @UseGuards(PermissionsGuard)
  async getProject(@Args('id') id: string, @Context() ctx) {
    return await this.getProjectService.getProject(id, ctx.user.id);
  }

  @Query(() => [ProjectDto])
  @Permissions(`${Resources.Project}#${ProjectPermission.read}`)
  @UseGuards(PermissionsGuard)
  async searchProjects(
    @Args('searchString', { nullable: true }) searchString: string,
    @Args('limit', { nullable: true }) limit: number,
    @Args('offset', { nullable: true }) offset: number,
    @Args('orderBy', { nullable: true }) orderBy: ProjectOrderByUpdatedAtInput,
    @Context() ctx,
  ) {
    return await this.searchProjectsService.searchProjects(
      searchString,
      limit,
      offset,
      ctx.user.id,
    );
  }

  @Mutation(() => ProjectDto)
  @Permissions(`${Resources.Project}#${ProjectPermission.update}`)
  @UseGuards(PermissionsGuard)
  async updateProject(
    @Args('updateProjectInput') updateProjectInput: UpdateProjectInput,
    @Context() ctx,
  ) {
    return await this.updateProjectService.updateProject(updateProjectInput, ctx.user.id);
  }

  @Mutation(() => ProjectDto)
  @Permissions(`${Resources.Project}#${ProjectPermission.create}`)
  @UseGuards(PermissionsGuard)
  async createProject(
    @Args('createProjectInput') createProjectInput: CreateProjectInput,
    @Context() ctx,
  ) {
    return await this.createProjectService.createProject(createProjectInput, ctx.user.id);
  }
}
