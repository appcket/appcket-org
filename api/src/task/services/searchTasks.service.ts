import { Injectable } from '@nestjs/common';

import { PrismaService } from 'src/common/services/prisma.service';
import { SearchTasksInput } from 'src/task/dtos/searchTasks.input';

@Injectable()
export class SearchTasksService {
  constructor(private prismaService: PrismaService) {}

  public async searchTasks(input: SearchTasksInput) {
    const or = input.searchString
      ? {
          OR: [{ name: { contains: input.searchString } }],
        }
      : {};

    return this.prismaService.task.findMany({
      where: {
        deleted_at: null,
        ...or,
        project_id: {
          in: input.projectIds,
        },
      },
      include: {
        project: {
          include: {
            organization: true,
          },
        },
        task_status_type: true,
      },
      take: input.take || undefined,
      skip: input.skip || undefined,
      orderBy: input.orderBy || undefined,
    });
  }
}
