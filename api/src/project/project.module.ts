import { Module } from '@nestjs/common';

import { AuthorizationService } from 'src/common/services/authorization.service';
import { PrismaService } from 'src/common/services/prisma.service';
import { CommonModule } from 'src/common/common.module';
import { ProjectResolver } from './project.resolver';
import { UserService } from 'src/user/services/user.service';
import { UpdateProjectService } from 'src/project/services/updateProject.service';
import { GetProjectService } from 'src/project/services/getProject.service';

@Module({
  imports: [CommonModule],
  providers: [
    AuthorizationService,
    PrismaService,
    ProjectResolver,
    GetProjectService,
    UpdateProjectService,
    UserService,
  ],
})
export class ProjectModule {}
