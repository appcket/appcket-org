import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';
import { Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

import { Task } from 'src/task/task.entity';
import { CreateTaskInput } from 'src/task/dtos/createTask.input';
import { GetTaskService } from 'src/task/services/getTask.service';
import { GetProjectService } from 'src/project/services/getProject.service';
import { GetOrganizationService } from 'src/organization/services/getOrganization.service';
import { CreateChangeAuditChangeService } from 'src/changeAudit/services/createChangeAuditChange.service';
import { Resources } from 'src/common/enums/resources.enum';
import { ChangeAuditOperationTypes } from 'src/common/enums/changeAuditOperationTypes.enum';

@Injectable()
export class CreateTaskService {
  private readonly logger = new Logger(CreateTaskService.name);

  constructor(
    @InjectRepository(Task)
    private readonly taskRepository: EntityRepository<Task>,
    private getTaskService: GetTaskService,
    private getProjectService: GetProjectService,
    private getOrganizationService: GetOrganizationService,
    private createChangeAuditChangeService: CreateChangeAuditChangeService,
    private configService: ConfigService,
  ) {}

  public async createTask(data: CreateTaskInput, userId: string): Promise<Task> {
    // validate userId is associated with data.projectId
    const taskProject = await this.getProjectService.getProject(data.projectId, userId);

    // validate data.assignedTo is associated with data.project.organization.id
    if (data.assignedTo) {
      await this.getOrganizationService.getOrganizationUsers(taskProject.organization.id, [
        data.assignedTo,
      ]);
    }

    const newTask = this.taskRepository.create({
      name: data.name,
      description: data.description,
      project: data.projectId,
      taskStatusType: data.taskStatusTypeId ? data.taskStatusTypeId : null,
      assignedTo: data.assignedTo ? data.assignedTo : null,
    });

    await this.taskRepository.persist(newTask).flush();

    const createdTask = await this.getTaskService.getTask(newTask.id, userId);

    this.logger.log(`${Task.name} created successfully. id: ${createdTask.id}`);

    const taskChangeAudit = {
      appId: this.configService.get('appId'),
      operationType: ChangeAuditOperationTypes.update,
      entity: {
        id: createdTask.id.toString(),
        type: Resources.Task,
        data: {
          id: createdTask.id,
          name: createdTask.name,
          description: createdTask.description,
          assignedTo: {
            id: createdTask.assignedTo.id,
            username: createdTask.assignedTo.username,
            email: createdTask.assignedTo.email,
            firstName: createdTask.assignedTo.firstName,
            lastName: createdTask.assignedTo.lastName,
          },
          taskStatusType: {
            id: createdTask.taskStatusType.id,
            name: createdTask.taskStatusType.name,
          },
          project: {
            id: createdTask.project.id,
          },
        },
      },
      user: {
        id: userId.toString(),
      },
      timestamp: new Date(),
    };
    this.createChangeAuditChangeService.createChange(taskChangeAudit);

    return createdTask;
  }
}
