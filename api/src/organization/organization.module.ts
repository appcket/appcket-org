import { Module } from '@nestjs/common';

import { AuthorizationService } from 'src/common/services/authorization.service';
import { PrismaService } from 'src/common/services/prisma.service';
import { CommonModule } from 'src/common/common.module';
import { OrganizationResolver } from './organization.resolver';

@Module({
  imports: [CommonModule],
  providers: [AuthorizationService, PrismaService, OrganizationResolver],
})
export class OrganizationModule {}
