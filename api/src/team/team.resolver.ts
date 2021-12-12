import 'reflect-metadata';
import {
  Resolver,
  ResolveField,
  Parent,
  Query,
  Args,
  Context,
  InputType,
  Field,
  registerEnumType,
} from '@nestjs/graphql';
import { Inject } from '@nestjs/common';
import { UseGuards } from '@nestjs/common';
import { intersectionBy } from 'lodash';

import { Team } from './team';
import { PrismaService } from 'src/prisma.service';
import { Resources } from 'src/common/enums/resources.enum';
import { TeamPermission } from 'src/common/enums/permissions.enum';
import { PermissionsGuard } from 'src/common/guards/permissions.guard';
import { Permissions } from 'src/common/decorators/permissions.decorator';
import { UserService } from 'src/common/services/user.service';

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

enum SortOrder {
  asc = 'asc',
  desc = 'desc',
}

registerEnumType(SortOrder, {
  name: 'SortOrder',
});

@Resolver(Team)
export class TeamResolver {
  constructor(
    @Inject(PrismaService) private prismaService: PrismaService,
    @Inject(UserService) private userService: UserService,
  ) {}

  @Query((returns) => Team, { nullable: true })
  @Permissions(`${Resources.Team}#${TeamPermission.read}`)
  @UseGuards(PermissionsGuard)
  teamById(@Args('id') id: string) {
    return this.prismaService.team.findUnique({
      where: { team_id: id },
      include: {
        team_user: true,
        organization: true,
      },
    });
  }

  @Query((returns) => [Team])
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

  @ResolveField('users')
  async users(@Parent() team: Team, @Context() ctx) {
    const accountsUsers = await this.userService.getUsers(ctx.req.kauth.grant.access_token.token);
    return intersectionBy(accountsUsers, team.team_user, 'user_id');
  }
}
