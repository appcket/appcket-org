import { Module } from '@nestjs/common';
import { MikroOrmModule } from '@mikro-orm/nestjs';

import { AuthorizationService } from 'src/common/services/authorization.service';
import { CommonModule } from 'src/common/common.module';
import { PrismaService } from 'src/common/services/prisma.service';
import { SearchTasksService } from 'src/task/services/searchTasks.service';
import { GetTaskService } from 'src/task/services/getTask.service';
import { UpdateTaskService } from 'src/task/services/updateTask.service';
import { TaskResolver } from './task.resolver';
import { UserService } from 'src/user/services/user.service';
import { Task } from 'src/task/task.entity';
import { User } from 'src/user/user.entity';

@Module({
  imports: [CommonModule, MikroOrmModule.forFeature({ entities: [Task, User] })],
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
