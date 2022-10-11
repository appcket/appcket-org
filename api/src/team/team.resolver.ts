import 'reflect-metadata';
import { Args, Context, Field, InputType, Mutation, Query, Resolver } from '@nestjs/graphql';
import { Inject } from '@nestjs/common';
import { UseGuards } from '@nestjs/common';

import { Team } from './team.entity';
import { UpdateTeamInputDto } from './dtos/updateTeam.input';
import { CreateTeamInputDto } from './dtos/createTeam.input';
import { PrismaService } from 'src/common/services/prisma.service';
import { Resources } from 'src/common/enums/resources.enum';
import { TeamPermission } from 'src/common/enums/permissions.enum';
import { SortOrder } from 'src/common/enums/sortOrder.enum';
import { PermissionsGuard } from 'src/common/guards/permissions.guard';
import { Permissions } from 'src/common/decorators/permissions.decorator';
import { UserService } from 'src/user/services/user.service';
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
    @Inject(PrismaService) private prismaService: PrismaService,
    @Inject(UserService) private userService: UserService,
    @Inject(GetTeamService) private getTeamService: GetTeamService,
    @Inject(UpdateTeamService) private updateTeamService: UpdateTeamService,
    @Inject(CreateTeamService) private createTeamService: CreateTeamService,
    @Inject(SearchTeamsService) private searchTeamsService: SearchTeamsService,
  ) {}

  @Query(() => Team, { nullable: true })
  @Permissions(`${Resources.Team}#${TeamPermission.read}`)
  @UseGuards(PermissionsGuard)
  async getTeam(@Args('id') id: string) {
    return await this.getTeamService.getTeam(id);
  }

  @Query(() => [Team])
  @Permissions(`${Resources.Team}#${TeamPermission.read}`)
  @UseGuards(PermissionsGuard)
  async searchTeams(
    @Args('searchString', { nullable: true }) searchString: string,
    @Args('limit', { nullable: true }) limit: number,
    @Args('offset', { nullable: true }) offset: number,
    @Args('orderBy', { nullable: true }) orderBy: TeamOrderByUpdatedAtInput,
  ) {
    return await this.searchTeamsService.searchTeams(searchString, limit, offset);
  }

  @Mutation(() => Team)
  @Permissions(`${Resources.Team}#${TeamPermission.update}`)
  @UseGuards(PermissionsGuard)
  async updateTeam(@Args('updateTeamInput') updateTeamInput: UpdateTeamInputDto, @Context() ctx) {
    return await this.updateTeamService.updateTeam(updateTeamInput, ctx.user.id);
  }

  @Mutation(() => Team)
  @Permissions(`${Resources.Team}#${TeamPermission.create}`)
  @UseGuards(PermissionsGuard)
  async createTeam(@Args('createTeamInput') createTeamInput: CreateTeamInputDto, @Context() ctx) {
    return await this.createTeamService.createTeam(createTeamInput, ctx.user.id);
  }
}
