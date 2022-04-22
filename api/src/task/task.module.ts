import { Module } from '@nestjs/common';

import { AuthorizationService } from 'src/common/services/authorization.service';
import { CommonModule } from 'src/common/common.module';
// import { CreateTaskService } from 'src/task/services/createTask.service';
// import { GetTaskService } from 'src/task/services/getTask.service';
import { PrismaService } from 'src/common/services/prisma.service';
// import { SearchTaskService } from 'src/task/services/searchTask.service';
import { TaskResolver } from './task.resolver';
// import { UpdateTaskService } from 'src/task/services/updateTask.service';
import { UserService } from 'src/user/services/user.service';

@Module({
  imports: [CommonModule],
  providers: [
    AuthorizationService,
    // CreateTaskService,
    // GetTaskService,
    PrismaService,
    // SearchTaskService,
    TaskResolver,
    // UpdateTaskService,
    UserService,
  ],
})
export class TaskModule {}
