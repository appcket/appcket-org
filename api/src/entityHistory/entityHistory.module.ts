import { Global, Module } from '@nestjs/common';
import { EntityHistoryResolver } from 'src/entityHistory/entityHistory.resolver';
import { EntityHistoryService } from 'src/entityHistory/entityHistory.service';
import { UserService } from 'src/user/services/user.service';
import { GetChangeAuditEntityService } from 'src/changeAudit/services/getChangeAuditEntity.service';
import { GetChangeAuditChangeService } from 'src/changeAudit/services/getChangeAuditChange.service';
import { ChangeAuditEntity } from 'src/changeAudit/entities/changeAuditEntity.entity';
import { ChangeAuditChange } from 'src/changeAudit/entities/changeAuditChange.entity';
import { MikroOrmModule } from '@mikro-orm/nestjs';
import { AuthorizationService } from 'src/common/services/authorization.service';
import { User } from 'src/user/user.entity';

@Global()
@Module({
  imports: [MikroOrmModule.forFeature({ entities: [ChangeAuditChange, ChangeAuditEntity, User] })],
  exports: [
    AuthorizationService,
    EntityHistoryService,
    GetChangeAuditChangeService,
    GetChangeAuditEntityService,
    UserService,
  ],
  providers: [
    AuthorizationService,
    EntityHistoryResolver,
    EntityHistoryService,
    GetChangeAuditChangeService,
    GetChangeAuditEntityService,
    UserService,
  ],
})
export class EntityHistoryModule {}
