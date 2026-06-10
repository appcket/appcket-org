import { Injectable } from '@nestjs/common';
import { EntityManager } from '@mikro-orm/core';
import { EntityRepository } from '@mikro-orm/core';
import { InjectRepository } from '@mikro-orm/nestjs';
import { Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

import { Project } from 'src/project/project.entity';
import { ProjectUser } from 'src/project/projectUser.entity';
import { User } from 'src/user/user.entity';
import { UpdateProjectInput } from 'src/project/dtos/updateProject.input';
import { GetProjectService } from 'src/project/services/getProject.service';
import { GetOrganizationService } from 'src/organization/services/getOrganization.service';
import { Resources } from 'src/common/enums/resources.enum';
import { ChangeAuditOperationTypes } from 'src/common/enums/changeAuditOperationTypes.enum';
import { CommonService } from 'src/common/services/common.service';
import { OutboxService } from 'src/common/services/outbox.service';

@Injectable()
export class UpdateProjectService {
  private readonly logger = new Logger(UpdateProjectService.name);

  constructor(
    private readonly em: EntityManager,
    @InjectRepository(Project)
    private readonly projectRepository: EntityRepository<Project>,
    private getProjectService: GetProjectService,
    private getOrganizationService: GetOrganizationService,
    private configService: ConfigService,
    private commonService: CommonService,
    private outboxService: OutboxService,
  ) {}

  public async updateProject(data: UpdateProjectInput, userId: string): Promise<Project> {
    return this.em.transactional(async (em) => {
      // validate userId is associated with data.organizationId in organization_user table
      await this.getOrganizationService.getOrganization(data.organizationId, userId);

      // validate data.userIds are associated with data.organizationId
      await this.getOrganizationService.getOrganizationUsers(data.organizationId, data.userIds);

      const project = await this.getProjectService.getProject(data.id, userId);

      const projectUsersUpdated = data.userIds.map((id) => {
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
            .find((projectUser) => {
              const u = projectUser.user as any;
              const projectUserId = u.id || u;
              return projectUserId === projectUserUpdated.user;
            })
        ) {
          em.create(ProjectUser, {
            user: projectUserUpdated.user,
            project: project.id,
            createdAt: new Date(),
            createdBy: userId,
          });
        }
      });

      // if existing project.projectUser record is not found in projectUsersUpdated, soft delete
      project.projectUsers.getItems().forEach((projectUser) => {
        const u = projectUser.user as any;
        const existingUserId = u.id || u;

        if (
          !projectUsersUpdated.find(
            (projectUserUpdated) => projectUserUpdated.user === existingUserId,
          )
        ) {
          const newProjectUser = em.assign(projectUser, {
            deletedAt: new Date(),
            deletedBy: userId,
          });
          em.persist(newProjectUser);
        }
      });

      em.assign(project, {
        updatedAt: new Date(),
        name: data.name,
        description: data.description,
        organization: data.organizationId,
        updatedBy: userId,
      });

      em.persist(project);

      await em.flush();

      const updatedProject = await this.getProjectService.getProject(data.id, userId);

      this.logger.log(`${Project.name} updated successfully. id: ${updatedProject.id}`);

      // sort here so change audit diff process doesn't generate a change based on a different order of users
      const usersToSort: Array<{
        id: string;
        username: string;
        email: string;
        firstName: string;
        lastName: string;
      }> = [];
      updatedProject.projectUsers.toArray().forEach((projectUser) => {
        if (projectUser.deletedAt === null || projectUser.deletedAt === undefined) {
          const user = projectUser.user as any;

          if (typeof user !== 'string') {
            usersToSort.push({
              id: user.id,
              username: user.username,
              email: user.email,
              firstName: user.firstName,
              lastName: user.lastName,
            });
          }
        }
      });
      const sortedUsers = this.commonService.sortCollection(usersToSort, 'id');

      const projectEventPayload = {
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
      
      await this.outboxService.create(projectEventPayload);

      return updatedProject;
    });
  }
}
