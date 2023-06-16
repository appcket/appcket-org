import { Injectable } from '@nestjs/common';
import { EntityManager } from '@mikro-orm/core';
import { EntityRepository, wrap } from '@mikro-orm/core';
import { InjectRepository } from '@mikro-orm/nestjs';
import { Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

import { Project } from 'src/project/project.entity';
import { UpdateProjectInput } from 'src/project/dtos/updateProject.input';
import { GetProjectService } from 'src/project/services/getProject.service';
import { GetOrganizationService } from 'src/organization/services/getOrganization.service';
import { CreateChangeAuditChangeService } from 'src/changeAudit/services/createChangeAuditChange.service';
import { Resources } from 'src/common/enums/resources.enum';
import { ChangeAuditOperationTypes } from 'src/common/enums/changeAuditOperationTypes.enum';

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
  ) {}

  public async updateProject(data: UpdateProjectInput, userId: string): Promise<Project> {
    // validate userId is associated with data.organizationId in organization_user table
    await this.getOrganizationService.getOrganization(data.organizationId, userId);

    // validate data.userIds are associated with data.organizationId
    await this.getOrganizationService.getOrganizationUsers(data.organizationId, data.userIds);

    const project = await this.getProjectService.getProject(data.id, userId);

    wrap(project).assign({
      name: data.name,
      description: data.description,
      organization: data.organizationId,
      users: data.userIds,
    });
    await this.em.persist(project);

    const updatedProject = await this.getProjectService.getProject(data.id, userId);

    this.logger.log(`${Project.name} updated successfully. id: ${updatedProject.id}`);

    const projectChangeAudit = {
      appId: this.configService.get('appId'),
      operationType: ChangeAuditOperationTypes.update,
      entity: {
        id: data.id.toString(),
        type: Resources.Task,
        data: {
          id: updatedProject.id,
          name: updatedProject.name,
          description: updatedProject.description,
          organizationId: updatedProject.organization.id,
          users: updatedProject.users.toArray().map((key) => ({
            id: key.id,
            username: key.username,
            email: key.email,
            firstName: key.firstName,
            lastName: key.lastName,
          })),
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
