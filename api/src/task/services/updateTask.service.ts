import { Injectable } from '@nestjs/common';

import { Task } from 'src/task/task.entity';
import { UpdateTaskInput } from 'src/task/dtos/updateTask.input';
import { PrismaService } from 'src/common/services/prisma.service';
import { GetTaskService } from 'src/task/services/getTask.service';

@Injectable()
export class UpdateTaskService {
  constructor(private prismaService: PrismaService, private getTaskService: GetTaskService) {}

  public async updateTask(data: UpdateTaskInput, userId: string): Promise<Task> {
    await this.prismaService.task.update({
      where: {
        task_id: data.taskId,
      },
      data: {
        name: data.name,
        description: data.description,
        task_status_type_id: data.taskStatusTypeId,
        project_id: data.projectId,
        updated_at: new Date(),
        updated_by: userId,
        assigned_to: data.assignedTo,
      },
    });

    const updatedTask = await this.getTaskService.getTask(data.taskId);

    return updatedTask;
  }
}
