import { Module } from '@nestjs/common';
import { MikroOrmModule } from '@mikro-orm/nestjs';

import { AuthorizationService } from 'src/common/services/authorization.service';
import { CommonModule } from 'src/common/common.module';
import { ChangeAuditModule } from 'src/changeAudit/changeAudit.module';
import { TeamResolver } from 'src/team/team.resolver';
import { UserService } from 'src/user/services/user.service';
import { UpdateTeamService } from 'src/team/services/updateTeam.service';
import { GetOrganizationService } from 'src/organization/services/getOrganization.service';
import { GetTeamService } from 'src/team/services/getTeam.service';
import { CreateTeamService } from 'src/team/services/createTeam.service';
import { SearchTeamsService } from 'src/team/services/searchTeams.service';
import { Team } from 'src/team/team.entity';
import { TeamUser } from 'src/team/teamUser.entity';
import { User } from 'src/user/user.entity';
import { Organization } from 'src/organization/organization.entity';
import { OrganizationUser } from 'src/organization/organizationUser.entity';

@Module({
  imports: [
    ChangeAuditModule,
    CommonModule,
    MikroOrmModule.forFeature({ entities: [Organization, OrganizationUser, Team, User, TeamUser] }),
  ],
  providers: [
    AuthorizationService,
    CreateTeamService,
    GetOrganizationService,
    GetTeamService,
    SearchTeamsService,
    TeamResolver,
    UpdateTeamService,
    UserService,
  ],
})
export class TeamModule {}
