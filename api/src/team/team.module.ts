import { Module } from '@nestjs/common';
import { MikroOrmModule } from '@mikro-orm/nestjs';

import { EntityHistoryService } from '@/entityHistory/entityHistory.service';
import { AuthorizationService } from '@/common/services/authorization.service';
import { CommonModule } from '@/common/modules/common.module';
import { TeamResolver } from '@/team/team.resolver';
import { UserService } from '@/user/services/user.service';
import { UpdateTeamService } from '@/team/services/updateTeam.service';
import { GetOrganizationService } from '@/organization/services/getOrganization.service';
import { GetTeamService } from '@/team/services/getTeam.service';
import { CreateTeamService } from '@/team/services/createTeam.service';
import { SearchTeamsService } from '@/team/services/searchTeams.service';
import { Team } from '@/team/team.entity';
import { TeamUser } from '@/team/teamUser.entity';
import { User } from '@/user/user.entity';
import { Organization } from '@/organization/organization.entity';
import { OrganizationUser } from '@/organization/organizationUser.entity';
import { Outbox } from '@/common/models/outbox.entity';
import { OutboxService } from '@/common/services/outbox.service';

@Module({
  imports: [
    CommonModule,
    MikroOrmModule.forFeature({
      entities: [Organization, OrganizationUser, Team, User, TeamUser, Outbox],
    }),
  ],
  providers: [
    AuthorizationService,
    CreateTeamService,
    EntityHistoryService,
    GetOrganizationService,
    GetTeamService,
    OutboxService,
    SearchTeamsService,
    TeamResolver,
    UpdateTeamService,
    UserService,
  ],
})
export class TeamModule {}
