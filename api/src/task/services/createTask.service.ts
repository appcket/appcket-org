import { Injectable } from '@nestjs/common';
import { EntityManager } from '@mikro-orm/core';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';
import { Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

import { Task } from 'src/task/task.entity';
import { CreateTaskInput } from 'src/task/dtos/createTask.input';
import { GetTaskService } from 'src/task/services/getTask.service';
import { GetProjectService } from 'src/project/services/getProject.service';
import { GetOrganizationService } from 'src/organization/services/getOrganization.service';
import { Resources } from 'src/common/enums/resources.enum';
import { ChangeAuditOperationTypes } from 'src/common/enums/changeAuditOperationTypes.enum';
import { OutboxService } from 'src/common/services/outbox.service';

@Injectable()
export class CreateTaskService {
  private readonly logger = new Logger(CreateTaskService.name);

  constructor(
    private readonly em: EntityManager,
    @InjectRepository(Task)
    private readonly taskRepository: EntityRepository<Task>,
    private getTaskService: GetTaskService,
    private getProjectService: GetProjectService,
    private getOrganizationService: GetOrganizationService,
    private configService: ConfigService,
    private outboxService: OutboxService,
  ) {}

  public async createTask(data: CreateTaskInput, userId: string): Promise<Task> {
    return this.em.transactional(async (em) => {
      // validate userId is associated with data.projectId
      const taskProject = await this.getProjectService.getProject(data.projectId, userId);

      // validate data.assignedTo is associated with data.project.organization.id
      if (data.assignedTo) {
        await this.getOrganizationService.getOrganizationUsers(taskProject.organization.id, [
          data.assignedTo,
        ]);
      }

      const newTask = em.create(Task, {
        name: data.name,
        description: data.description,
        project: taskProject,
        taskStatusType: data.taskStatusTypeId ? data.taskStatusTypeId : null,
        assignedTo: data.assignedTo ? data.assignedTo : null,
      });

      em.persist(newTask);

      await em.flush();

      const createdTask = await this.getTaskService.getTask(newTask.id, userId);

      this.logger.log(`${Task.name} created successfully. id: ${createdTask.id}`);

      const taskEventPayload = {
        appId: this.configService.get('appId'),
        operationType: ChangeAuditOperationTypes.Create,
        entity: {
          id: createdTask.id.toString(),
          type: Resources.Task,
          data: {
            id: createdTask.id,
            name: createdTask.name,
            description: createdTask.description,
            assignedTo: createdTask.assignedTo
              ? {
                  id: createdTask.assignedTo.id,
                  username: createdTask.assignedTo.username,
                  email: createdTask.assignedTo.email,
                  firstName: createdTask.assignedTo.firstName,
                  lastName: createdTask.assignedTo.lastName,
                }
              : null,
            taskStatusType: createdTask.taskStatusType
              ? {
                  id: createdTask.taskStatusType.id,
                  name: createdTask.taskStatusType.name,
                }
              : null,
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

      await this.outboxService.create(taskEventPayload);

      return createdTask;
    });
  }
}
