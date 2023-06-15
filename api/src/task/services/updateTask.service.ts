import { Injectable } from '@nestjs/common';
import { EntityManager } from '@mikro-orm/core';
import { EntityRepository, wrap } from '@mikro-orm/core';
import { InjectRepository } from '@mikro-orm/nestjs';
import { Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

import { Task } from 'src/task/task.entity';
import { UpdateTaskInput } from 'src/task/dtos/updateTask.input';
import { GetTaskService } from 'src/task/services/getTask.service';
import { GetOrganizationService } from 'src/organization/services/getOrganization.service';
import { CreateChangeAuditChangeService } from 'src/changeAudit/services/createChangeAuditChange.service';
import { Resources } from 'src/common/enums/resources.enum';
import { ChangeAuditOperationTypes } from 'src/common/enums/changeAuditOperationTypes.enum';

@Injectable()
export class UpdateTaskService {
  private readonly logger = new Logger(UpdateTaskService.name);

  constructor(
    private readonly em: EntityManager,
    @InjectRepository(Task)
    private readonly taskRepository: EntityRepository<Task>,
    private getTaskService: GetTaskService,
    private getOrganizationService: GetOrganizationService,
    private createChangeAuditChangeService: CreateChangeAuditChangeService,
    private configService: ConfigService,
  ) {}

  public async updateTask(data: UpdateTaskInput, userId: string): Promise<Task> {
    // validate userId is associated with data.project.organization.id
    const task = await this.getTaskService.getTask(data.id, userId);

    // validate data.assignedTo is associated with data.project.organization.id
    await this.getOrganizationService.getOrganizationUsers(task.project.organization.id, [
      data.assignedTo,
    ]);

    wrap(task).assign({
      name: data.name,
      description: data.description,
      project: data.projectId,
      taskStatusType: data.taskStatusTypeId ? data.taskStatusTypeId : null,
      assignedTo: data.assignedTo ? data.assignedTo : null,
    });
    await this.em.persistAndFlush(task);

    const updatedTask = await this.getTaskService.getTask(data.id, userId);

    this.logger.log(`${Task.name} updated successfully. id: ${updatedTask.id}`);

    const taskChangeAudit = {
      appId: this.configService.get('appId'),
      operationType: ChangeAuditOperationTypes.update,
      entity: {
        id: data.id.toString(),
        type: Resources.Task,
        data: {
          id: updatedTask.id,
          name: updatedTask.name,
          description: updatedTask.description,
          assignedTo: {
            id: updatedTask.assignedTo.id,
            username: updatedTask.assignedTo.username,
            email: updatedTask.assignedTo.email,
            firstName: updatedTask.assignedTo.firstName,
            lastName: updatedTask.assignedTo.lastName,
          },
          taskStatusType: {
            id: updatedTask.taskStatusType.id,
            name: updatedTask.taskStatusType.name,
          },
          project: {
            id: updatedTask.project.id,
          },
        },
      },
      user: {
        id: userId.toString(),
      },
      timestamp: new Date(),
    };
    this.createChangeAuditChangeService.createChange(taskChangeAudit);

    return updatedTask;
  }
}
