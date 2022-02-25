import { Injectable } from '@nestjs/common';
import { findIndex } from 'lodash';

import { Team } from 'src/team/models/team.model';
import { CreateTeamInput } from 'src/team/dtos/createTeam.input';
import { PrismaService } from 'src/common/services/prisma.service';
import { GetTeamService } from 'src/team/services/getTeam.service';

@Injectable()
export class CreateTeamService {
  constructor(private prismaService: PrismaService, private getTeamService: GetTeamService) {}

  public async createTeam(data: CreateTeamInput, userId: string): Promise<Team> {
    const createdTeam = await this.prismaService.team.create({
      data: {
        name: data.name,
        // TODO: validate this user is associated with this organization
        // TODO: validate this team is associated with this organization
        organization_id: data.organizationId,
        updated_at: new Date(),
        updated_by: userId,
        created_by: userId,
      },
    });

    const teamUsersToDelete = await this.prismaService.team_user.findMany({
      where: {
        team_id: createdTeam.team_id,
        deleted_at: null,
        user_id: {
          notIn: data.userIds,
        },
      },
      select: {
        team_user_id: true,
      },
    });

    for (let teamUser of teamUsersToDelete) {
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

    let existingTeamUsers = await this.prismaService.team_user.findMany({
      where: {
        team_id: createdTeam.team_id,
        deleted_at: null,
        user_id: {
          in: data.userIds,
        },
      },
      select: {
        user_id: true,
      },
    });

    let teamUserIdsToCreate: string[] = [];

    data.userIds.forEach((inputDataUserId) => {
      const foundIndex = findIndex(existingTeamUsers, { user_id: inputDataUserId });
      if (foundIndex === -1) {
        // this inputData userId was not found in the database for this team so we need to create the record
        teamUserIdsToCreate.push(inputDataUserId);
      }
    });

    for (let teamUserId of teamUserIdsToCreate) {
      await this.prismaService.team_user.create({
        data: {
          team_id: createdTeam.team_id,
          user_id: teamUserId,
          created_by: userId,
        },
      });
    }

    return createdTeam;
  }
}
