import { Injectable } from '@nestjs/common';

import { PrismaService } from 'src/common/services/prisma.service';
import { Task } from 'src/task/models/task.model';

@Injectable()
export class GetTaskService {
  constructor(private prismaService: PrismaService) {}

  public async getTask(id: string): Promise<Task> {
    return this.prismaService.task.findFirst({
      where: { task_id: id, deleted_at: null },
      include: {
        project: {
          include: {
            organization: true,
          },
        },
        task_status_type: true,
      },
    });
  }
}
