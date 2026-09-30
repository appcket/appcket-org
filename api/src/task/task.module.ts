import { Module } from '@nestjs/common';
import { MikroOrmModule } from '@mikro-orm/nestjs';

import { AuthorizationService } from '@/common/services/authorization.service';
import { CommonModule } from '@/common/modules/common.module';
import { SearchTasksService } from '@/task/services/searchTasks.service';
import { GetOrganizationService } from '@/organization/services/getOrganization.service';
import { GetProjectService } from '@/project/services/getProject.service';
import { GetTaskService } from '@/task/services/getTask.service';
import { CreateTaskService } from '@/task/services/createTask.service';
import { UpdateTaskService } from '@/task/services/updateTask.service';
import { TaskResolver } from './task.resolver';
import { UserService } from '@/user/services/user.service';
import { Task } from '@/task/task.entity';
import { User } from '@/user/user.entity';
import { Project } from '@/project/project.entity';
import { Organization } from '@/organization/organization.entity';
import { OrganizationUser } from '@/organization/organizationUser.entity';
import { OutboxService } from '@/common/services/outbox.service';

@Module({
  imports: [
    CommonModule,
    MikroOrmModule.forFeature({ entities: [Organization, OrganizationUser, Project, Task, User] }),
  ],
  providers: [
    AuthorizationService,
    GetOrganizationService,
    GetProjectService,
    GetTaskService,
    CreateTaskService,
    OutboxService,
    SearchTasksService,
    UpdateTaskService,
    TaskResolver,
    UserService,
  ],
})
export class TaskModule {}
