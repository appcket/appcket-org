import { Global, Module } from '@nestjs/common';
import { MikroOrmModule } from '@mikro-orm/nestjs';
import { HttpModule } from '@nestjs/axios';

import { ClickHouseModule } from '@/common/modules/clickhouse.module';
import { EntityHistoryResolver } from '@/entityHistory/entityHistory.resolver';
import { EntityHistoryService } from '@/entityHistory/entityHistory.service';
import { UserService } from '@/user/services/user.service';
import { CommonService } from '@/common/services/common.service';
import { AuthorizationService } from '@/common/services/authorization.service';
import { User } from '@/user/user.entity';

@Module({
  imports: [ClickHouseModule, HttpModule, MikroOrmModule.forFeature({ entities: [User] })],
  exports: [AuthorizationService, CommonService, EntityHistoryService, UserService],
  providers: [
    AuthorizationService,
    CommonService,
    EntityHistoryResolver,
    EntityHistoryService,
    UserService,
  ],
})
export class EntityHistoryModule {}
