import { Module } from '@nestjs/common';

import { AuthorizationService } from 'src/common/services/authorization.service';
import { CommonModule } from 'src/common/common.module';
import { CreateProjectService } from 'src/project/services/createProject.service';
import { GetProjectService } from 'src/project/services/getProject.service';
import { PrismaService } from 'src/common/services/prisma.service';
import { ProjectResolver } from './project.resolver';
import { UpdateProjectService } from 'src/project/services/updateProject.service';
import { UserService } from 'src/user/services/user.service';

@Module({
  imports: [CommonModule],
  providers: [
    AuthorizationService,
    CreateProjectService,
    GetProjectService,
    PrismaService,
    ProjectResolver,
    UpdateProjectService,
    UserService,
  ],
})
export class ProjectModule {}
