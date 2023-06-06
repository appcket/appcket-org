import { Module } from '@nestjs/common';
import { MikroOrmModule } from '@mikro-orm/nestjs';

import { AuthorizationService } from 'src/common/services/authorization.service';
import { ChangeAuditModule } from 'src/changeAudit/changeAudit.module';
import { CommonModule } from 'src/common/common.module';
import { CreateProjectService } from 'src/project/services/createProject.service';
import { GetOrganizationService } from 'src/organization/services/getOrganization.service';
import { GetProjectService } from 'src/project/services/getProject.service';
import { ProjectResolver } from './project.resolver';
import { SearchProjectsService } from 'src/project/services/searchProjects.service';
import { UpdateProjectService } from 'src/project/services/updateProject.service';
import { UserService } from 'src/user/services/user.service';
import { Project } from 'src/project/project.entity';
import { User } from 'src/user/user.entity';
import { Organization } from 'src/organization/organization.entity';
import { OrganizationUser } from 'src/organization/organizationUser.entity';

@Module({
  imports: [
    ChangeAuditModule,
    CommonModule,
    MikroOrmModule.forFeature({ entities: [Organization, OrganizationUser, Project, User] }),
  ],
  providers: [
    AuthorizationService,
    CreateProjectService,
    GetOrganizationService,
    GetProjectService,
    ProjectResolver,
    SearchProjectsService,
    UpdateProjectService,
    UserService,
  ],
})
export class ProjectModule {}
