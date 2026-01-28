import { Global, Module } from '@nestjs/common';
import { EntityHistoryResolver } from 'src/entityHistory/entityHistory.resolver';
import { EntityHistoryService } from 'src/entityHistory/entityHistory.service';
import { UserService } from 'src/user/services/user.service';
import { MikroOrmModule } from '@mikro-orm/nestjs';
import { AuthorizationService } from 'src/common/services/authorization.service';
import { User } from 'src/user/user.entity';

@Global()
@Module({
  imports: [MikroOrmModule.forFeature({ entities: [User] })],
  exports: [AuthorizationService, EntityHistoryService, UserService],
  providers: [AuthorizationService, EntityHistoryResolver, EntityHistoryService, UserService],
})
export class EntityHistoryModule {}
