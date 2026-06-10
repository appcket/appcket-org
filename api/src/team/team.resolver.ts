import { Args, Context, Field, InputType, Mutation, Query, Resolver } from '@nestjs/graphql';
import { Inject } from '@nestjs/common';
import { UseGuards } from '@nestjs/common';

import { Team } from 'src/team/team.entity';
import { TeamDto } from 'src/team/dtos/team.dto';
import { UpdateTeamInput } from 'src/team/dtos/updateTeam.input';
import { CreateTeamInput } from 'src/team/dtos/createTeam.input';
import { Resources } from 'src/common/enums/resources.enum';
import { TeamPermission } from 'src/common/enums/permissions.enum';
import { PermissionsGuard } from 'src/common/guards/permissions.guard';
import { Permissions } from 'src/common/decorators/permissions.decorator';
import { GetTeamService } from 'src/team/services/getTeam.service';
import { UpdateTeamService } from 'src/team/services/updateTeam.service';
import { CreateTeamService } from 'src/team/services/createTeam.service';
import { SearchTeamsService } from 'src/team/services/searchTeams.service';
import { EntityHistoryService } from 'src/entityHistory/entityHistory.service';
import { PaginatedTeamDto } from 'src/team/dtos/paginatedTeam.dto';
import { SearchTeamsInput } from 'src/team/dtos/searchTeams.input';
import { User } from 'src/user/user.entity';

@InputType()
export class TeamCreateInput {
  @Field()
  name!: string;
}

@Resolver(() => Team)
export class TeamResolver {
  constructor(
    @Inject(GetTeamService) private getTeamService: GetTeamService,
    @Inject(UpdateTeamService) private updateTeamService: UpdateTeamService,
    @Inject(CreateTeamService) private createTeamService: CreateTeamService,
    @Inject(SearchTeamsService) private searchTeamsService: SearchTeamsService,
    @Inject(EntityHistoryService) private entityHistoryService: EntityHistoryService,
  ) {}

  @Query(() => TeamDto, { nullable: true })
  @Permissions(`${Resources.Team}#${TeamPermission.read}`)
  @UseGuards(PermissionsGuard)
  async getTeam(@Args('id') id: string, @Context() ctx) {
    const team = await this.getTeamService.getTeam(id, ctx.user.id);

    const createdBy = team.createdBy
      ? {
          id: team.createdBy.id,
          email: (team.createdBy as any).email,
          username: (team.createdBy as any).preferred_username || (team.createdBy as any).username,
          firstName: (team.createdBy as any).firstName,
          lastName: (team.createdBy as any).lastName,
          attributes: (team.createdBy as any).attributes,
        }
      : undefined;

    const updatedBy = team.updatedBy
      ? {
          id: team.updatedBy.id,
          email: (team.updatedBy as any).email,
          username: (team.updatedBy as any).preferred_username || (team.updatedBy as any).username,
          firstName: (team.updatedBy as any).firstName,
          lastName: (team.updatedBy as any).lastName,
          attributes: (team.updatedBy as any).attributes,
        }
      : undefined;

    const teamDto: TeamDto = {
      id: team.id,
      createdAt: team.createdAt!,
      createdBy,
      updatedAt: team.updatedAt!,
      updatedBy,
      name: team.name,
      description: team.description,
      organization: {
        id: team.organization.id,
        name: team.organization.name,
      },
      users: team.teamUsers.toArray().map((teamUser) => ({
        id: teamUser.user.id,
        createdAt: teamUser.createdAt,
        createdBy: teamUser.createdBy,
        updatedAt: teamUser.updatedAt,
        updatedBy: teamUser.updatedBy,
        username: teamUser.user.username,
        email: teamUser.user.email,
        firstName: teamUser.user.firstName,
        lastName: teamUser.user.lastName,
        attributes: teamUser.user['attributes'],
        role: (teamUser.user as any).role,
      })),
    };

    return teamDto;
  }

  @Query(() => PaginatedTeamDto)
  @Permissions(`${Resources.Team}#${TeamPermission.read}`)
  @UseGuards(PermissionsGuard)
  async searchTeams(@Args('searchTeamsInput') searchTeamsInput: SearchTeamsInput, @Context() ctx) {
    const results = await this.searchTeamsService.searchTeams(searchTeamsInput, ctx.user.id);

    return results;
  }

  @Mutation(() => TeamDto)
  @Permissions(`${Resources.Team}#${TeamPermission.update}`)
  @UseGuards(PermissionsGuard)
  async updateTeam(@Args('updateTeamInput') updateTeamInput: UpdateTeamInput, @Context() ctx) {
    return await this.updateTeamService.updateTeam(updateTeamInput, ctx.user.id);
  }

  @Mutation(() => TeamDto)
  @Permissions(`${Resources.Team}#${TeamPermission.create}`)
  @UseGuards(PermissionsGuard)
  async createTeam(@Args('createTeamInput') createTeamInput: CreateTeamInput, @Context() ctx) {
    return await this.createTeamService.createTeam(createTeamInput, ctx.user.id);
  }
}
