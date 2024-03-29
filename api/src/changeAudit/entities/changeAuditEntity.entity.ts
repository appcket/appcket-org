import { Entity, ManyToOne, PrimaryKey, Property, Index } from '@mikro-orm/core';
import { ChangeAuditApp } from 'src/changeAudit/entities/changeAuditApp.entity';
import { ChangeAuditOperationType } from 'src/changeAudit/entities/changeAuditOperationType.entity';

@Entity({ schema: 'appcket' })
@Index({ properties: ['entityId', 'appId'] })
export class ChangeAuditEntity {
  @PrimaryKey({ columnType: 'uuid', defaultRaw: `gen_random_uuid()` })
  id!: string;

  @Property()
  createdAt: Date = new Date();

  @Property({ length: 36 })
  entityId!: string;

  @Property({ length: 50 })
  entityType?: string;

  @ManyToOne({ entity: () => ChangeAuditApp, fieldName: 'app_id', updateRule: 'cascade' })
  appId?: ChangeAuditApp;

  @ManyToOne({
    entity: () => ChangeAuditOperationType,
    updateRule: 'cascade',
  })
  operationType!: ChangeAuditOperationType;

  @Property({ length: 36 })
  userId!: string;

  @Property({ length: 100, nullable: true })
  userEmail?: string;

  @Property({ length: 100, nullable: true })
  userDisplayName?: string;

  @Property({ columnType: 'jsonb' })
  entity?: any;

  @Property({ columnType: 'jsonb', nullable: true })
  diff?: any;
}
