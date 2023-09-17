import 'reflect-metadata';
import { Args, Context, Field, InputType, Query, Resolver } from '@nestjs/graphql';
import { Inject } from '@nestjs/common';
import { UseGuards } from '@nestjs/common';

import { EntityHistory } from 'src/entityHistory/entityHistory.entity';
import { EntityHistoryService } from 'src/entityHistory/entityHistory.service';
import { SortOrder } from 'src/common/enums/sortOrder.enum';
import { Resources } from 'src/common/enums/resources.enum';
import { TeamPermission } from 'src/common/enums/permissions.enum';
import { PermissionsGuard } from 'src/common/guards/permissions.guard';
import { Permissions } from 'src/common/decorators/permissions.decorator';

@InputType()
class OrderByInput2 {
  @Field(() => String)
  fieldName: string;

  @Field(() => SortOrder)
  direction: SortOrder;
}

@Resolver(() => EntityHistory)
export class EntityHistoryResolver {
  constructor(@Inject(EntityHistoryService) private entityHistoryService: EntityHistoryService) {}

  @Query(() => EntityHistory, { nullable: true })
  @Permissions(`${Resources.Team}#${TeamPermission.readHistory}`)
  @UseGuards(PermissionsGuard)
  async getEntityHistory(
    @Args('id') id: string,
    @Args('type') type: string,
    @Args('orderBy', { nullable: true }) orderBy: OrderByInput2,
    @Context() ctx,
  ) {
    return await this.entityHistoryService.getEntityHistory(
      id,
      type,
      orderBy ? orderBy : null,
      ctx.user.id,
    );
  }
}
