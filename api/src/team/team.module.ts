import { Module } from '@nestjs/common';
import { MikroOrmModule } from '@mikro-orm/nestjs';

import { AuthorizationService } from 'src/common/services/authorization.service';
import { CommonModule } from 'src/common/common.module';
import { TeamResolver } from './team.resolver';
import { UserService } from 'src/user/services/user.service';
import { UpdateTeamService } from 'src/team/services/updateTeam.service';
import { GetTeamService } from 'src/team/services/getTeam.service';
import { CreateTeamService } from 'src/team/services/createTeam.service';
import { SearchTeamsService } from 'src/team/services/searchTeams.service';
import { Team } from 'src/team/team.entity';
import { User } from 'src/user/user.entity';

@Module({
  imports: [CommonModule, MikroOrmModule.forFeature({ entities: [Team, User] })],
  providers: [
    AuthorizationService,
    CreateTeamService,
    GetTeamService,
    SearchTeamsService,
    TeamResolver,
    UpdateTeamService,
    UserService,
  ],
})
export class TeamModule {}
