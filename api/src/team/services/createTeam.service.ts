import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';

import { Team } from 'src/team/team.entity';
import { CreateTeamInputDto } from 'src/team/dtos/createTeam.input';
import { User } from 'src/user/user.entity';

@Injectable()
export class CreateTeamService {
  constructor(
    @InjectRepository(Team)
    private readonly teamRepository: EntityRepository<Team>,
    @InjectRepository(User)
    private readonly userRepository: EntityRepository<User>,
  ) {}

  public async createTeam(data: CreateTeamInputDto, userId: string): Promise<Team> {
    const teamUsers = await this.userRepository.find({ $contains: data.userIds });
    const createdTeam = await this.teamRepository.create({
      name: data.name,
      organization: {
        id: data.organizationId,
      },
      users: teamUsers,
    });

    return createdTeam;
    /* const createdTeam = await this.prismaService.team.create({
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

    return createdTeam; */
  }
}
