import { Context, Resolver, Query, Args, ResolveField, Parent } from '@nestjs/graphql';
import { Inject } from '@nestjs/common';
import { UseGuards } from '@nestjs/common';

import { OrganizationDto } from '@/organization/organization.dto';
import { Resources } from '@/common/enums/resources.enum';
import { OrganizationPermission } from '@/common/enums/permissions.enum';
import { PermissionsGuard } from '@/common/guards/permissions.guard';
import { Permissions } from '@/common/decorators/permissions.decorator';
import { GetOrganizationService } from '@/organization/services/getOrganization.service';

@Resolver(OrganizationDto)
export class OrganizationResolver {
  constructor(
    @Inject(GetOrganizationService) private getOrganizationService: GetOrganizationService,
  ) {}

  @Query(() => OrganizationDto, { nullable: true })
  @Permissions(`${Resources.Organization}#${OrganizationPermission.read}`)
  @UseGuards(PermissionsGuard)
  async getOrganization(@Args('id') id: string, @Context() ctx) {
    return await this.getOrganizationService.getOrganization(id, ctx.user.id);
  }
}
