import { Injectable } from '@nestjs/common';
import { findIndex } from 'lodash';

import { Team } from 'src/team/team.entity';
import { UpdateTeamInputDto } from 'src/team/dtos/updateTeam.input';
import { PrismaService } from 'src/common/services/prisma.service';
import { GetTeamService } from 'src/team/services/getTeam.service';

@Injectable()
export class UpdateTeamService {
  constructor(private prismaService: PrismaService, private getTeamService: GetTeamService) {}

  public async updateTeam(data: UpdateTeamInputDto, userId: string): Promise<Team> {
    await this.prismaService.team.update({
      where: {
        team_id: data.teamId,
      },
      data: {
        name: data.name,
        // TODO: validate this user is associated with this organization
        // TODO: validate this team is associated with this organization
        organization_id: data.organizationId,
        updated_at: new Date(),
        updated_by: userId,
      },
    });

    const teamUsersToDelete = await this.prismaService.team_user.findMany({
      where: {
        team_id: data.teamId,
        deleted_at: null,
        user_id: {
          notIn: data.userIds,
        },
      },
      select: {
        team_user_id: true,
      },
    });

    for (const teamUser of teamUsersToDelete) {
      await this.prismaService.team_user.update({
        where: {
          team_user_id: teamUser.team_user_id,
        },
        data: {
          deleted_at: new Date(),
          deleted_by: userId,
        },
      });
    }

    const existingTeamUsers = await this.prismaService.team_user.findMany({
      where: {
        team_id: data.teamId,
        deleted_at: null,
        user_id: {
          in: data.userIds,
        },
      },
      select: {
        user_id: true,
      },
    });

    const teamUserIdsToCreate: string[] = [];

    data.userIds.forEach((inputDataUserId) => {
      const foundIndex = findIndex(existingTeamUsers, { user_id: inputDataUserId });
      if (foundIndex === -1) {
        // this inputData userId was not found in the database for this team so we need to create the record
        teamUserIdsToCreate.push(inputDataUserId);
      }
    });

    for (const teamUserId of teamUserIdsToCreate) {
      await this.prismaService.team_user.create({
        data: {
          team_id: data.teamId,
          user_id: teamUserId,
          created_by: userId,
        },
      });
    }

    const updatedTeam = await this.getTeamService.getTeam(data.teamId);

    return updatedTeam;
  }
}
