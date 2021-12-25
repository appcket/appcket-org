import { Module } from '@nestjs/common';

import { AuthorizationService } from 'src/common/services/authorization.service';
import { PrismaService } from 'src/common/services/prisma.service';
import { CommonModule } from 'src/common/common.module';
import { TeamResolver } from './team.resolver';
import { UserService } from 'src/user/services/user.service';
import { UpdateTeamService } from 'src/team/services/updateTeam.service';
import { GetTeamService } from 'src/team/services/getTeam.service';

@Module({
  imports: [CommonModule],
  providers: [
    AuthorizationService,
    PrismaService,
    TeamResolver,
    GetTeamService,
    UpdateTeamService,
    UserService,
  ],
})
export class TeamModule {}
