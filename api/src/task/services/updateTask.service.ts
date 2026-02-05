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
import { Resources } from 'src/common/enums/resources.enum';
import { ChangeAuditOperationTypes } from 'src/common/enums/changeAuditOperationTypes.enum';
import { OutboxService } from 'src/common/services/outbox.service';

@Injectable()
export class UpdateTaskService {
  private readonly logger = new Logger(UpdateTaskService.name);

  constructor(
    private readonly em: EntityManager,
    @InjectRepository(Task)
    private readonly taskRepository: EntityRepository<Task>,
    private getTaskService: GetTaskService,
    private getOrganizationService: GetOrganizationService,
    private configService: ConfigService,
    private outboxService: OutboxService,
  ) {}

  public async updateTask(data: UpdateTaskInput, userId: string): Promise<Task> {
    return this.em.transactional(async (em) => {
      // validate userId is associated with data.project.organization.id
      const task = await this.getTaskService.getTask(data.id, userId);

      // validate data.assignedTo is associated with data.project.organization.id
      if (data.assignedTo) {
        await this.getOrganizationService.getOrganizationUsers(task.project.organization.id, [
          data.assignedTo,
        ]);
      }

      wrap(task).assign({
        name: data.name,
        description: data.description,
        project: data.projectId,
        taskStatusType: data.taskStatusTypeId ? data.taskStatusTypeId : null,
        assignedTo: data.assignedTo ? data.assignedTo : null,
      });
      em.persist(task);

      await em.flush();

      const updatedTask = await this.getTaskService.getTask(data.id, userId);

      this.logger.log(`${Task.name} updated successfully. id: ${updatedTask.id}`);

      const taskEventPayload = {
        appId: this.configService.get('appId'),
        operationType: ChangeAuditOperationTypes.Update,
        entity: {
          id: data.id.toString(),
          type: Resources.Task,
          data: {
            id: updatedTask.id,
            name: updatedTask.name,
            description: updatedTask.description,
            assignedTo: updatedTask.assignedTo
              ? {
                  id: updatedTask.assignedTo.id,
                  username: updatedTask.assignedTo.username,
                  email: updatedTask.assignedTo.email,
                  firstName: updatedTask.assignedTo.firstName,
                  lastName: updatedTask.assignedTo.lastName,
                }
              : null,
            taskStatusType: updatedTask.taskStatusType
              ? {
                  id: updatedTask.taskStatusType.id,
                  name: updatedTask.taskStatusType.name,
                }
              : null,
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

      await this.outboxService.create(taskEventPayload);

      return updatedTask;
    });
  }
}
