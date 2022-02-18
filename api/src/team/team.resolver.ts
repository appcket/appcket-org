import 'reflect-metadata';
import {
  Args,
  Context,
  Field,
  InputType,
  Mutation,
  Parent,
  Query,
  Resolver,
  ResolveField,
} from '@nestjs/graphql';
import { Inject } from '@nestjs/common';
import { UseGuards } from '@nestjs/common';
import { intersectionBy } from 'lodash';

import { Team } from './models/team.model';
import { UpdateTeamInput } from './dtos/updateTeam.input';
import { PrismaService } from 'src/common/services/prisma.service';
import { Resources } from 'src/common/enums/resources.enum';
import { TeamPermission } from 'src/common/enums/permissions.enum';
import { SortOrder } from 'src/common/enums/sortOrder.enum';
import { PermissionsGuard } from 'src/common/guards/permissions.guard';
import { Permissions } from 'src/common/decorators/permissions.decorator';
import { UserService } from 'src/user/services/user.service';
import { GetTeamService } from 'src/team/services/getTeam.service';
import { UpdateTeamService } from 'src/team/services/updateTeam.service';

@InputType()
export class TeamCreateInput {
  @Field()
  name: string;
}

@InputType()
class TeamOrderByUpdatedAtInput {
  @Field((type) => SortOrder)
  updated_at: SortOrder;
}

@Resolver(() => Team)
export class TeamResolver {
  constructor(
    @Inject(PrismaService) private prismaService: PrismaService,
    @Inject(UserService) private userService: UserService,
    @Inject(GetTeamService) private getTeamService: GetTeamService,
    @Inject(UpdateTeamService) private updateTeamService: UpdateTeamService,
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
  searchTeams(
    @Args('searchString', { nullable: true }) searchString: string,
    @Args('skip', { nullable: true }) skip: number,
    @Args('take', { nullable: true }) take: number,
    @Args('orderBy', { nullable: true }) orderBy: TeamOrderByUpdatedAtInput,
  ) {
    const or = searchString
      ? {
          OR: [{ name: { contains: searchString } }],
        }
      : {};

    // TODO: move to searchTeams.service
    return this.prismaService.team.findMany({
      where: {
        deleted_at: null,
        ...or,
      },
      take: take || undefined,
      skip: skip || undefined,
      orderBy: orderBy || undefined,
    });
  }

  @Mutation(() => Team)
  @Permissions(`${Resources.Team}#${TeamPermission.update}`)
  @UseGuards(PermissionsGuard)
  async updateTeam(@Args('updateTeamInput') updateTeamInput: UpdateTeamInput, @Context() ctx) {
    return await this.updateTeamService.updateTeam(updateTeamInput, ctx.user.id);
  }

  @ResolveField('users')
  async users(@Parent() team: Team, @Context() ctx) {
    const accountsUsers = await this.userService.getUsers(
      team.organization.organization_id,
      ctx.req.kauth.grant.access_token.token,
    );
    return intersectionBy(accountsUsers, team.team_user, 'user_id');
  }
}
