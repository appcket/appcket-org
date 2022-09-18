import { Module } from '@nestjs/common';

import { AuthorizationService } from 'src/common/services/authorization.service';
import { CommonModule } from 'src/common/common.module';
import { PrismaService } from 'src/common/services/prisma.service';
import { SearchTasksService } from 'src/task/services/searchTasks.service';
import { GetTaskService } from 'src/task/services/getTask.service';
import { UpdateTaskService } from 'src/task/services/updateTask.service';
import { TaskResolver } from './task.resolver';
import { UserService } from 'src/user/services/user.service';

@Module({
  imports: [CommonModule],
  providers: [
    AuthorizationService,
    PrismaService,
    GetTaskService,
    SearchTasksService,
    UpdateTaskService,
    TaskResolver,
    UserService,
  ],
})
export class TaskModule {}
