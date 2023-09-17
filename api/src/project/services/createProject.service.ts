import { Injectable } from '@nestjs/common';
import { EntityManager } from '@mikro-orm/core';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';
import { Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

import { GetOrganizationService } from 'src/organization/services/getOrganization.service';
import { Project } from 'src/project/project.entity';
import { ProjectUser } from 'src/project/projectUser.entity';
import { CreateProjectInput } from 'src/project/dtos/createProject.input';
import { GetProjectService } from 'src/project/services/getProject.service';
import { CreateChangeAuditChangeService } from 'src/changeAudit/services/createChangeAuditChange.service';
import { Resources } from 'src/common/enums/resources.enum';
import { ChangeAuditOperationTypes } from 'src/common/enums/changeAuditOperationTypes.enum';

@Injectable()
export class CreateProjectService {
  private readonly logger = new Logger(CreateProjectService.name);

  constructor(
    private readonly em: EntityManager,
    @InjectRepository(Project)
    private readonly projectRepository: EntityRepository<Project>,
    private getProjectService: GetProjectService,
    private getOrganizationService: GetOrganizationService,
    private createChangeAuditChangeService: CreateChangeAuditChangeService,
    private configService: ConfigService,
  ) {}

  public async createProject(data: CreateProjectInput, userId: string) {
    // validate userId is associated with data.organizationId in organization_user table
    await this.getOrganizationService.getOrganization(data.organizationId, userId);

    // validate data.userIds are associated with data.organizationId
    await this.getOrganizationService.getOrganizationUsers(data.organizationId, data.userIds);

    const newProject = this.projectRepository.create({
      name: data.name,
      description: data.description,
      organization: data.organizationId,
      createdBy: userId,
    });

    await this.em.persistAndFlush(newProject);

    data.userIds.map((userId) => {
      this.em.create(ProjectUser, {
        project: newProject.id,
        user: userId,
      });
    });

    const createdProject = await this.getProjectService.getProject(newProject.id, userId);

    this.logger.log(`${Project.name} created successfully. id: ${createdProject.id}`);

    const projectChangeAudit = {
      appId: this.configService.get('appId'),
      operationType: ChangeAuditOperationTypes.Create,
      entity: {
        id: createdProject.id.toString(),
        type: Resources.Project,
        data: {
          id: createdProject.id,
          name: createdProject.name,
          description: createdProject.description,
          organizationId: createdProject.organization.id,
          users: createdProject.projectUsers.toArray().map((projectUser) => ({
            id: projectUser.user.id,
            username: projectUser.user.username,
            email: projectUser.user.email,
            firstName: projectUser.user.firstName,
            lastName: projectUser.user.lastName,
          })),
        },
      },
      user: {
        id: userId.toString(),
      },
      timestamp: new Date(),
    };
    this.createChangeAuditChangeService.createChange(projectChangeAudit);

    return createdProject;
  }
}
