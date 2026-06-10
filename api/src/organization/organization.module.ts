import { Module } from '@nestjs/common';
import { MikroOrmModule } from '@mikro-orm/nestjs';
import { HttpModule } from '@nestjs/axios';

import { AuthorizationService } from 'src/common/services/authorization.service';
import { Organization } from 'src/organization/organization.entity';
import { OrganizationUser } from 'src/organization/organizationUser.entity';
import { GetOrganizationService } from 'src/organization/services/getOrganization.service';
import { OrganizationResolver } from 'src/organization/organization.resolver';

@Module({
  imports: [HttpModule, MikroOrmModule.forFeature({ entities: [Organization, OrganizationUser] })],
  providers: [AuthorizationService, GetOrganizationService, OrganizationResolver],
  exports: [GetOrganizationService],
})
export class OrganizationModule {}
