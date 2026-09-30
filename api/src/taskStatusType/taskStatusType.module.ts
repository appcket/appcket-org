import { Module } from '@nestjs/common';
import { MikroOrmModule } from '@mikro-orm/nestjs';
import { HttpModule } from '@nestjs/axios';

import { AuthorizationService } from '@/common/services/authorization.service';
import { CommonService } from '@/common/services/common.service';
import { GetTaskStatusTypesService } from '@/taskStatusType/getTaskStatusTypes.service';
import { TaskStatusTypeResolver } from '@/taskStatusType/taskStatusType.resolver';
import { TaskStatusType } from '@/taskStatusType/taskStatusType.entity';
import { User } from '@/user/user.entity';
import { UserService } from '@/user/services/user.service';

@Module({
  imports: [HttpModule, MikroOrmModule.forFeature({ entities: [TaskStatusType, User] })],
  providers: [
    AuthorizationService,
    CommonService,
    GetTaskStatusTypesService,
    TaskStatusTypeResolver,
    UserService,
  ],
})
export class TaskStatusTypeModule {}
