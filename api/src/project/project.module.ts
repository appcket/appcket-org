import { Module } from '@nestjs/common';
import { MikroOrmModule } from '@mikro-orm/nestjs';

import { AuthorizationService } from 'src/common/services/authorization.service';
import { CommonModule } from 'src/common/common.module';
import { CreateProjectService } from 'src/project/services/createProject.service';
import { GetProjectService } from 'src/project/services/getProject.service';
import { PrismaService } from 'src/common/services/prisma.service';
import { ProjectResolver } from './project.resolver';
import { SearchProjectsService } from 'src/project/services/searchProjects.service';
import { UpdateProjectService } from 'src/project/services/updateProject.service';
import { UserService } from 'src/user/services/user.service';
import { Project } from 'src/project/project.entity';
import { User } from 'src/user/user.entity';

@Module({
  imports: [CommonModule, MikroOrmModule.forFeature({ entities: [Project, User] })],
  providers: [
    AuthorizationService,
    CreateProjectService,
    GetProjectService,
    PrismaService,
    ProjectResolver,
    SearchProjectsService,
    UpdateProjectService,
    UserService,
  ],
})
export class ProjectModule {}
