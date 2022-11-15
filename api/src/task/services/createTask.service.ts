import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';
import { Logger } from '@nestjs/common';

import { Task } from 'src/task/task.entity';
import { CreateTaskInput } from 'src/task/dtos/createTask.input';
import { GetTaskService } from 'src/task/services/getTask.service';
import { GetProjectService } from 'src/project/services/getProject.service';
import { GetOrganizationService } from 'src/organization/services/getOrganization.service';

@Injectable()
export class CreateTaskService {
  private readonly logger = new Logger(CreateTaskService.name);

  constructor(
    @InjectRepository(Task)
    private readonly taskRepository: EntityRepository<Task>,
    private getTaskService: GetTaskService,
    private getProjectService: GetProjectService,
    private getOrganizationService: GetOrganizationService,
  ) {}

  public async createTask(data: CreateTaskInput, userId: string): Promise<Task> {
    // validate userId is associated with data.projectId
    const taskProject = await this.getProjectService.getProject(data.projectId, userId);

    // validate data.assignedTo is associated with data.project.organization.id
    if (data.assignedTo) {
      await this.getOrganizationService.getOrganizationUsers(taskProject.organization.id, [data.assignedTo]);
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

    return createdTask;
  }
}
