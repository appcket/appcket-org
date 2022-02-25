import { Injectable } from '@nestjs/common';
import { findIndex } from 'lodash';

import { Project } from 'src/project/models/project.model';
import { CreateProjectInput } from 'src/project/dtos/createProject.input';
import { PrismaService } from 'src/common/services/prisma.service';
import { GetProjectService } from 'src/project/services/getProject.service';

@Injectable()
export class CreateProjectService {
  constructor(private prismaService: PrismaService, private getProjectService: GetProjectService) {}

  public async createProject(data: CreateProjectInput, userId: string): Promise<Project> {
    const createdProject = await this.prismaService.project.create({
      data: {
        name: data.name,
        // TODO: validate this user is associated with this organization
        // TODO: validate this project is associated with this organization
        organization_id: data.organizationId,
        updated_at: new Date(),
        updated_by: userId,
        created_by: userId,
      },
    });

    const projectUsersToDelete = await this.prismaService.project_user.findMany({
      where: {
        project_id: createdProject.project_id,
        deleted_at: null,
        user_id: {
          notIn: data.userIds,
        },
      },
      select: {
        project_user_id: true,
      },
    });

    for (let projectUser of projectUsersToDelete) {
      await this.prismaService.project_user.update({
        where: {
          project_user_id: projectUser.project_user_id,
        },
        data: {
          deleted_at: new Date(),
          deleted_by: userId,
        },
      });
    }

    let existingProjectUsers = await this.prismaService.project_user.findMany({
      where: {
        project_id: createdProject.project_id,
        deleted_at: null,
        user_id: {
          in: data.userIds,
        },
      },
      select: {
        user_id: true,
      },
    });

    let projectUserIdsToCreate: string[] = [];

    data.userIds.forEach((inputDataUserId) => {
      const foundIndex = findIndex(existingProjectUsers, { user_id: inputDataUserId });
      if (foundIndex === -1) {
        // this inputData userId was not found in the database for this project so we need to create the record
        projectUserIdsToCreate.push(inputDataUserId);
      }
    });

    for (let projectUserId of projectUserIdsToCreate) {
      await this.prismaService.project_user.create({
        data: {
          project_id: createdProject.project_id,
          user_id: projectUserId,
          created_by: userId,
        },
      });
    }

    return createdProject;
  }
}
