import 'reflect-metadata';
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

@InputType()
export class TeamCreateInput {
  @Field()
  name: string;
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

    let createdBy = null;
    let updatedBy = null;

    if (team.createdBy) {
      createdBy = {
        id: team.createdBy.id,
        email: team.createdBy.email,
        username: team.createdBy.username,
        firstName: team.createdBy.firstName,
        lastName: team.createdBy.lastName,
      };
    }

    if (team.updatedBy) {
      updatedBy = {
        id: team.updatedBy.id,
        email: team.updatedBy.email,
        username: team.updatedBy.username,
        firstName: team.updatedBy.firstName,
        lastName: team.updatedBy.lastName,
      };
    }

    const teamDto: TeamDto = {
      id: team.id,
      createdAt: team.createdAt,
      createdBy,
      updatedAt: team.updatedAt,
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
        // attributes: teamUser.user.attributes,
        role: teamUser.user.role,
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
