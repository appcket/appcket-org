import { Injectable } from '@nestjs/common';
import { EntityManager } from '@mikro-orm/core';
import { EntityRepository } from '@mikro-orm/core';
import { InjectRepository } from '@mikro-orm/nestjs';
import { Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

import { Project } from 'src/project/project.entity';
import { ProjectUser } from 'src/project/projectUser.entity';
import { UpdateProjectInput } from 'src/project/dtos/updateProject.input';
import { GetProjectService } from 'src/project/services/getProject.service';
import { GetOrganizationService } from 'src/organization/services/getOrganization.service';
import { CreateChangeAuditChangeService } from 'src/changeAudit/services/createChangeAuditChange.service';
import { Resources } from 'src/common/enums/resources.enum';
import { ChangeAuditOperationTypes } from 'src/common/enums/changeAuditOperationTypes.enum';
import { CommonService } from 'src/common/services/common.service';

@Injectable()
export class UpdateProjectService {
  private readonly logger = new Logger(UpdateProjectService.name);

  constructor(
    private readonly em: EntityManager,
    @InjectRepository(Project)
    private readonly projectRepository: EntityRepository<Project>,
    private getProjectService: GetProjectService,
    private getOrganizationService: GetOrganizationService,
    private createChangeAuditChangeService: CreateChangeAuditChangeService,
    private configService: ConfigService,
    private commonService: CommonService,
  ) {}

  public async updateProject(data: UpdateProjectInput, userId: string): Promise<Project> {
    // validate userId is associated with data.organizationId in organization_user table
    await this.getOrganizationService.getOrganization(data.organizationId, userId);

    // validate data.userIds are associated with data.organizationId
    await this.getOrganizationService.getOrganizationUsers(data.organizationId, data.userIds);

    const project = await this.getProjectService.getProject(data.id, userId);

    let projectUsersUpdated = [];

    projectUsersUpdated = data.userIds.map((id) => {
      return {
        user: id,
        project: project.id,
      };
    });

    // if projectUsersUpdated item is not found in the existing project.projectUsers, insert
    projectUsersUpdated.forEach((projectUserUpdated) => {
      if (
        !project.projectUsers
          .toArray()
          .find((projectUser) => projectUser.user.id == projectUserUpdated.user)
      ) {
        this.em.create(ProjectUser, {
          user: projectUserUpdated.user,
          project: project.id,
          createdAt: new Date(),
          createdBy: userId,
        });
      }
    });

    // if existing project.projectUser record is not found in projectUsersUpdated, soft delete
    project.projectUsers.getItems().forEach((projectUser) => {
      if (
        !projectUsersUpdated.find(
          (projectUserUpdated) => projectUserUpdated.user == projectUser.user.id,
        )
      ) {
        const newProjectUser = this.em.assign(projectUser, {
          deletedAt: new Date(),
          deletedBy: userId,
        });
        this.em.persist(newProjectUser);
      }
    });

    await this.em.flush();

    this.em.assign(project, {
      updatedAt: new Date(),
      name: data.name,
      description: data.description,
      organization: data.organizationId,
      updatedBy: userId,
    });

    await this.em.persistAndFlush(project);

    const updatedProject = await this.getProjectService.getProject(data.id, userId);

    this.logger.log(`${Project.name} updated successfully. id: ${updatedProject.id}`);

    // sort here so change audit diff process doesn't generate a change based on a different order of users
    const usersToSort = [];
    updatedProject.projectUsers.toArray().forEach((projectUser) => {
      if (projectUser.deletedAt === null || projectUser.deletedAt === undefined) {
        usersToSort.push({
          id: projectUser.user.id,
          username: projectUser.user.username,
          email: projectUser.user.email,
          firstName: projectUser.user.firstName,
          lastName: projectUser.user.lastName,
        });
      }
    });
    const sortedUsers = this.commonService.sortCollection(usersToSort, 'id');

    const projectChangeAudit = {
      appId: this.configService.get('appId'),
      operationType: ChangeAuditOperationTypes.Update,
      entity: {
        id: data.id.toString(),
        type: Resources.Project,
        data: {
          id: updatedProject.id,
          name: updatedProject.name,
          description: updatedProject.description,
          organizationId: updatedProject.organization.id,
          users: sortedUsers,
        },
      },
      user: {
        id: userId.toString(),
      },
      timestamp: new Date(),
    };
    this.createChangeAuditChangeService.createChange(projectChangeAudit);

    return updatedProject;
  }
}
