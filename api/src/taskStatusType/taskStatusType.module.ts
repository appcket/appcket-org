import { Module } from '@nestjs/common';
import { MikroOrmModule } from '@mikro-orm/nestjs';
import { HttpModule } from '@nestjs/axios';

import { AuthorizationService } from 'src/common/services/authorization.service';
import { CommonService } from 'src/common/services/common.service';
import { GetTaskStatusTypesService } from 'src/taskStatusType/getTaskStatusTypes.service';
import { TaskStatusTypeResolver } from 'src/taskStatusType/taskStatusType.resolver';
import { TaskStatusType } from 'src/taskStatusType/taskStatusType.entity';
import { User } from 'src/user/user.entity';
import { UserService } from 'src/user/services/user.service';

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
