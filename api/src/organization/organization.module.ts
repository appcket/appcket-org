import { Module } from '@nestjs/common';
import { MikroOrmModule } from '@mikro-orm/nestjs';

import { AuthorizationService } from 'src/common/services/authorization.service';
import { CommonModule } from 'src/common/common.module';
import { OrganizationResolver } from './organization.resolver';
import { Organization } from './organization.entity';
import { GetOrganizationService } from 'src/organization/services/getOrganization.service';
import { OrganizationUser } from 'src/organization/organizationUser.entity';

@Module({
  imports: [
    CommonModule,
    MikroOrmModule.forFeature({ entities: [Organization, OrganizationUser] }),
  ],
  providers: [AuthorizationService, GetOrganizationService, OrganizationResolver],
})
export class OrganizationModule {}
