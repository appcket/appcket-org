import { Module } from '@nestjs/common';
import { MikroOrmModule } from '@mikro-orm/nestjs';

import { AuthorizationService } from 'src/common/services/authorization.service';
import { CommonModule } from 'src/common/common.module';
import { ChangeAuditApp } from 'src/changeAudit/entities/changeAuditApp.entity';
import { ChangeAuditChange } from 'src/changeAudit/entities/changeAuditChange.entity';
import { ChangeAuditEntity } from 'src/changeAudit/entities/changeAuditEntity.entity';
import { CreateChangeAuditChangeService } from 'src/changeAudit/services/createChangeAuditChange.service';
import { GetChangeAuditEntityService } from 'src/changeAudit/services/getChangeAuditEntity.service';
import { GetChangeAuditChangeService } from 'src/changeAudit/services/getChangeAuditChange.service';

@Module({
  imports: [
    CommonModule,
    MikroOrmModule.forFeature({ entities: [ChangeAuditApp, ChangeAuditChange, ChangeAuditEntity] }),
  ],
  exports: [
    CreateChangeAuditChangeService,
    GetChangeAuditChangeService,
    GetChangeAuditEntityService,
  ],
  providers: [
    AuthorizationService,
    CreateChangeAuditChangeService,
    GetChangeAuditChangeService,
    GetChangeAuditEntityService,
  ],
})
export class ChangeAuditModule {}
