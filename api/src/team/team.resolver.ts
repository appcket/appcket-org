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

import { Team } from './team';
import { PrismaService } from 'src/prisma.service';
import { resources } from 'src/common/enums/resources.enum';
import { TeamPermission } from 'src/common/enums/permissions.enum';
import { PermissionsGuard } from 'src/common/guards/permissions.guard';
import { Permissions } from 'src/common/decorators/permissions.decorator';

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
  constructor(@Inject(PrismaService) private prismaService: PrismaService) {}

  @Query((returns) => Team, { nullable: true })
  @Permissions(`${resources.Team}#${TeamPermission.read}`)
  @UseGuards(PermissionsGuard)
  teamById(@Args('id') id: string) {
    return this.prismaService.team.findUnique({
      where: { team_id: id },
    });
  }

  @Query((returns) => [Team])
  @Permissions(`${resources.Team}#${TeamPermission.read}`)
  @UseGuards(PermissionsGuard)
  searchTeams(
    @Args('searchString', { nullable: true }) searchString: string,
    @Args('skip', { nullable: true }) skip: number,
    @Args('take', { nullable: true }) take: number,
    @Args('orderBy', { nullable: true }) orderBy: TeamOrderByUpdatedAtInput,
    @Context() ctx
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

  @ResolveField('organization')
  async organization(@Parent() team: Team) {
    return this.prismaService.team.findUnique({ where: { team_id: team.team_id } }).organization();
  }
}
