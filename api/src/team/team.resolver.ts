import 'reflect-metadata';
import { Args, Context, Field, InputType, Mutation, Query, Resolver } from '@nestjs/graphql';
import { Inject } from '@nestjs/common';
import { UseGuards } from '@nestjs/common';

import { Team } from './team.entity';
import { UpdateTeamInput } from './dtos/updateTeam.input';
import { CreateTeamInput } from './dtos/createTeam.input';
import { Resources } from 'src/common/enums/resources.enum';
import { TeamPermission } from 'src/common/enums/permissions.enum';
import { SortOrder } from 'src/common/enums/sortOrder.enum';
import { PermissionsGuard } from 'src/common/guards/permissions.guard';
import { Permissions } from 'src/common/decorators/permissions.decorator';
import { GetTeamService } from 'src/team/services/getTeam.service';
import { UpdateTeamService } from 'src/team/services/updateTeam.service';
import { CreateTeamService } from 'src/team/services/createTeam.service';
import { SearchTeamsService } from 'src/team/services/searchTeams.service';

@InputType()
export class TeamCreateInput {
  @Field()
  name: string;
}

@InputType()
class TeamOrderByUpdatedAtInput {
  @Field(() => SortOrder)
  updated_at: SortOrder;
}

@Resolver(() => Team)
export class TeamResolver {
  constructor(
    @Inject(GetTeamService) private getTeamService: GetTeamService,
    @Inject(UpdateTeamService) private updateTeamService: UpdateTeamService,
    @Inject(CreateTeamService) private createTeamService: CreateTeamService,
    @Inject(SearchTeamsService) private searchTeamsService: SearchTeamsService,
  ) {}

  @Query(() => Team, { nullable: true })
  @Permissions(`${Resources.Team}#${TeamPermission.read}`)
  @UseGuards(PermissionsGuard)
  async getTeam(@Args('id') id: string, @Context() ctx) {
    return await this.getTeamService.getTeam(id, ctx.user.id);
  }

  @Query(() => [Team])
  @Permissions(`${Resources.Team}#${TeamPermission.read}`)
  @UseGuards(PermissionsGuard)
  async searchTeams(
    @Args('searchString', { nullable: true }) searchString: string,
    @Args('limit', { nullable: true }) limit: number,
    @Args('offset', { nullable: true }) offset: number,
    @Args('orderBy', { nullable: true }) orderBy: TeamOrderByUpdatedAtInput,
    @Context() ctx,
  ) {
    return await this.searchTeamsService.searchTeams(searchString, limit, offset, ctx.user.id);
  }

  @Mutation(() => Team)
  @Permissions(`${Resources.Team}#${TeamPermission.update}`)
  @UseGuards(PermissionsGuard)
  async updateTeam(@Args('updateTeamInput') updateTeamInput: UpdateTeamInput, @Context() ctx) {
    return await this.updateTeamService.updateTeam(updateTeamInput, ctx.user.id);
  }

  @Mutation(() => Team)
  @Permissions(`${Resources.Team}#${TeamPermission.create}`)
  @UseGuards(PermissionsGuard)
  async createTeam(@Args('createTeamInput') createTeamInput: CreateTeamInput, @Context() ctx) {
    return await this.createTeamService.createTeam(createTeamInput, ctx.user.id);
  }
}
