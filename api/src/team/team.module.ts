import { Module } from '@nestjs/common';

import { AuthorizationService } from 'src/common/services/authorization.service';
import { PrismaService } from 'src/prisma.service';
import { CommonModule } from 'src/common/common.module';
import { TeamResolver } from './team.resolver';

@Module({
  imports: [CommonModule],
  providers: [AuthorizationService, PrismaService, TeamResolver],
})
export class TeamModule {}
