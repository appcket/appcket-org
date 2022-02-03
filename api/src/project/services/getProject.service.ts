import { Injectable } from '@nestjs/common';

import { PrismaService } from 'src/common/services/prisma.service';
import { Project } from 'src/project/models/project.model';

@Injectable()
export class GetProjectService {
  constructor(private prismaService: PrismaService) {}

  public async getProject(id: string): Promise<Project> {
    return this.prismaService.project.findFirst({
      where: { project_id: id, deleted_at: null },
      include: {
        project_user: {
          where: {
            deleted_at: null,
          },
        },
        organization: true,
      },
    });
  }
}
