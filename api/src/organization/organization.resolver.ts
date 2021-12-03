import 'reflect-metadata';
import { Resolver, Query, Args, Context, InputType, Field } from '@nestjs/graphql';
import { Inject } from '@nestjs/common';
import { UseGuards } from '@nestjs/common';

import { Organization } from './organization';
import { PrismaService } from 'src/prisma.service';
import { resources } from 'src/common/enums/resources.enum';
import { OrganizationPermission } from 'src/common/enums/permissions.enum';
import { PermissionsGuard } from 'src/common/guards/permissions.guard';
import { Permissions } from 'src/common/decorators/permissions.decorator';

@Resolver(Organization)
export class OrganizationResolver {
  constructor(@Inject(PrismaService) private prismaService: PrismaService) {}

  @Query((returns) => Organization, { nullable: true })
  @Permissions(`${resources.Organization}#${OrganizationPermission.read}`)
  @UseGuards(PermissionsGuard)
  organizationById(@Args('id') id: string) {
    return this.prismaService.organization.findUnique({
      where: { organization_id: id },
    });
  }
}
