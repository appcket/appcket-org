import { Module } from '@nestjs/common';
import { MikroOrmModule } from '@mikro-orm/nestjs';

import { GetTaskStatusTypesService } from 'src/taskStatusType/getTaskStatusTypes.service';
import { TaskStatusTypeResolver } from 'src/taskStatusType/taskStatusType.resolver';
import { TaskStatusType } from 'src/taskStatusType/taskStatusType.entity';

@Module({
  imports: [MikroOrmModule.forFeature({ entities: [TaskStatusType] })],
  providers: [GetTaskStatusTypesService, TaskStatusTypeResolver],
})
export class TaskStatusTypeModule {}
