import { Module } from '@nestjs/common';
import { MikroOrmModule } from '@mikro-orm/nestjs';
import { HttpModule } from '@nestjs/axios';

import { AuthorizationService } from '@/common/services/authorization.service';
import { Organization } from '@/organization/organization.entity';
import { OrganizationUser } from '@/organization/organizationUser.entity';
import { GetOrganizationService } from '@/organization/services/getOrganization.service';
import { OrganizationResolver } from '@/organization/organization.resolver';

@Module({
  imports: [HttpModule, MikroOrmModule.forFeature({ entities: [Organization, OrganizationUser] })],
  providers: [AuthorizationService, GetOrganizationService, OrganizationResolver],
  exports: [GetOrganizationService],
})
export class OrganizationModule {}
