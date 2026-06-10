import { Args, Context, Field, InputType, Mutation, Query, Resolver } from '@nestjs/graphql';
import { Inject } from '@nestjs/common';
import { UseGuards } from '@nestjs/common';

import { ProjectDto } from 'src/project/dtos/project.dto';
import { UpdateProjectInput } from './dtos/updateProject.input';
import { CreateProjectInput } from './dtos/createProject.input';
import { Resources } from 'src/common/enums/resources.enum';
import { ProjectPermission } from 'src/common/enums/permissions.enum';
import { PermissionsGuard } from 'src/common/guards/permissions.guard';
import { Permissions } from 'src/common/decorators/permissions.decorator';
import { GetProjectService } from 'src/project/services/getProject.service';
import { SearchProjectsService } from 'src/project/services/searchProjects.service';
import { UpdateProjectService } from 'src/project/services/updateProject.service';
import { CreateProjectService } from 'src/project/services/createProject.service';
import { PaginatedProjectDto } from 'src/project/dtos/paginatedProject.dto';
import { SearchProjectsInput } from 'src/project/dtos/searchProjects.input';
import { User } from 'src/user/user.entity';

@InputType()
export class ProjectCreateInput {
  @Field()
  name!: string;
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
    const project = await this.getProjectService.getProject(id, ctx.user.id);

    const createdBy = project.createdBy
      ? {
          id: project.createdBy.id,
          email: (project.createdBy as any).email,
          username:
            (project.createdBy as any).preferred_username || (project.createdBy as any).username,
          firstName: (project.createdBy as any).firstName,
          lastName: (project.createdBy as any).lastName,
          attributes: (project.createdBy as any).attributes,
        }
      : undefined;

    const updatedBy = project.updatedBy
      ? {
          id: project.updatedBy.id,
          email: (project.updatedBy as any).email,
          username:
            (project.updatedBy as any).preferred_username || (project.updatedBy as any).username,
          firstName: (project.updatedBy as any).firstName,
          lastName: (project.updatedBy as any).lastName,
          attributes: (project.updatedBy as any).attributes,
        }
      : undefined;

    const ProjectDto: ProjectDto = {
      id: project.id,
      createdAt: project.createdAt!,
      createdBy,
      updatedAt: project.updatedAt!,
      updatedBy,
      name: project.name,
      description: project.description,
      organization: {
        id: project.organization.id,
        name: (project.organization as any).name,
      },
      users: project.projectUsers.toArray().map((projectUser) => {
        const user = projectUser.user as any;

        return {
          id: user.id,
          createdAt: projectUser.createdAt,
          createdBy: projectUser.createdBy,
          updatedAt: projectUser.updatedAt,
          updatedBy: projectUser.updatedBy,
          username: user.username,
          email: user.email,
          firstName: user.firstName,
          lastName: user.lastName,
          attributes: user.attributes,
          role: user.role,
        };
      }),
    };

    return ProjectDto;
  }

  @Query(() => PaginatedProjectDto)
  @Permissions(`${Resources.Project}#${ProjectPermission.read}`)
  @UseGuards(PermissionsGuard)
  async searchProjects(
    @Args('searchProjectsInput') searchProjectsInput: SearchProjectsInput,
    @Context() ctx,
  ) {
    const results = await this.searchProjectsService.searchProjects(
      searchProjectsInput,
      ctx.user.id,
    );

    return results;
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
