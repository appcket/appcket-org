import { Module } from '@nestjs/common';
import { MikroOrmModule } from '@mikro-orm/nestjs';

import { AuthorizationService } from '@/common/services/authorization.service';
import { CommonModule } from '@/common/modules/common.module';
import { CreateProjectService } from '@/project/services/createProject.service';
import { GetOrganizationService } from '@/organization/services/getOrganization.service';
import { GetProjectService } from '@/project/services/getProject.service';
import { ProjectResolver } from './project.resolver';
import { SearchProjectsService } from '@/project/services/searchProjects.service';
import { UpdateProjectService } from '@/project/services/updateProject.service';
import { UserService } from '@/user/services/user.service';
import { Project } from '@/project/project.entity';
import { User } from '@/user/user.entity';
import { Organization } from '@/organization/organization.entity';
import { OrganizationUser } from '@/organization/organizationUser.entity';
import { OutboxService } from '@/common/services/outbox.service';

@Module({
  imports: [
    CommonModule,
    MikroOrmModule.forFeature({ entities: [Organization, OrganizationUser, Project, User] }),
  ],
  providers: [
    AuthorizationService,
    CreateProjectService,
    GetOrganizationService,
    GetProjectService,
    OutboxService,
    ProjectResolver,
    SearchProjectsService,
    UpdateProjectService,
    UserService,
  ],
})
export class ProjectModule {}
