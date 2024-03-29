import 'reflect-metadata';
import { Context, Resolver, Query, Args } from '@nestjs/graphql';
import { Inject } from '@nestjs/common';
import { UseGuards } from '@nestjs/common';

import { OrganizationDto } from 'src/organization/organization.dto';
import { Resources } from 'src/common/enums/resources.enum';
import { OrganizationPermission } from 'src/common/enums/permissions.enum';
import { PermissionsGuard } from 'src/common/guards/permissions.guard';
import { Permissions } from 'src/common/decorators/permissions.decorator';
import { GetOrganizationService } from 'src/organization/services/getOrganization.service';

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
