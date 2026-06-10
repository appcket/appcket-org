import { Global, Module } from '@nestjs/common';
import { MikroOrmModule } from '@mikro-orm/nestjs';
import { HttpModule } from '@nestjs/axios';

import { ClickHouseModule } from 'src/common/modules/clickhouse.module';
import { EntityHistoryResolver } from 'src/entityHistory/entityHistory.resolver';
import { EntityHistoryService } from 'src/entityHistory/entityHistory.service';
import { UserService } from 'src/user/services/user.service';
import { CommonService } from 'src/common/services/common.service';
import { AuthorizationService } from 'src/common/services/authorization.service';
import { User } from 'src/user/user.entity';

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
