import { Module } from '@nestjs/common';
import { MikroOrmModule } from '@mikro-orm/nestjs';

import { AuthorizationService } from 'src/common/services/authorization.service';
import { PrismaService } from 'src/common/services/prisma.service';
import { CommonModule } from 'src/common/common.module';
import { OrganizationResolver } from './organization.resolver';
import { Organization } from './organization.entity';

@Module({
  imports: [CommonModule, MikroOrmModule.forFeature({ entities: [Organization] })],
  providers: [AuthorizationService, PrismaService, OrganizationResolver],
})
export class OrganizationModule {}
