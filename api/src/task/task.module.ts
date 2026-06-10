import { Module } from '@nestjs/common';
import { MikroOrmModule } from '@mikro-orm/nestjs';

import { AuthorizationService } from 'src/common/services/authorization.service';
import { CommonModule } from 'src/common/modules/common.module';
import { SearchTasksService } from 'src/task/services/searchTasks.service';
import { GetOrganizationService } from 'src/organization/services/getOrganization.service';
import { GetProjectService } from 'src/project/services/getProject.service';
import { GetTaskService } from 'src/task/services/getTask.service';
import { CreateTaskService } from 'src/task/services/createTask.service';
import { UpdateTaskService } from 'src/task/services/updateTask.service';
import { TaskResolver } from './task.resolver';
import { UserService } from 'src/user/services/user.service';
import { Task } from 'src/task/task.entity';
import { User } from 'src/user/user.entity';
import { Project } from 'src/project/project.entity';
import { Organization } from 'src/organization/organization.entity';
import { OrganizationUser } from 'src/organization/organizationUser.entity';
import { OutboxService } from 'src/common/services/outbox.service';

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
