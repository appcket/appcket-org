import { Module } from '@nestjs/common';
import { MikroOrmModule } from '@mikro-orm/nestjs';

import { AuthorizationService } from 'src/common/services/authorization.service';
import { CommonModule } from 'src/common/common.module';
import { ChangeAuditApp } from 'src/changeAudit/entities/changeAuditApp.entity';
import { ChangeAuditChange } from 'src/changeAudit/entities/changeAuditChange.entity';
import { ChangeAuditEntity } from 'src/changeAudit/entities/changeAuditEntity.entity';
import { CreateChangeAuditChangeService } from 'src/changeAudit/services/createChangeAuditChange.service';

@Module({
  imports: [
    CommonModule,
    MikroOrmModule.forFeature({ entities: [ChangeAuditApp, ChangeAuditChange, ChangeAuditEntity] }),
  ],
  exports: [CreateChangeAuditChangeService],
  providers: [AuthorizationService, CreateChangeAuditChangeService],
})
export class ChangeAuditModule {}
