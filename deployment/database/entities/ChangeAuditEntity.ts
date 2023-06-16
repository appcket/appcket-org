import { Entity, ManyToOne, PrimaryKey, Property, Index } from '@mikro-orm/core';
import { ChangeAuditApp } from './ChangeAuditApp';
import { ChangeAuditOperationType } from './ChangeAuditOperationType';

@Entity({ schema: 'appcket' })
@Index({ properties: ['entityId', 'appId'] })
export class ChangeAuditEntity {
  @PrimaryKey({ columnType: 'uuid', defaultRaw: `gen_random_uuid()` })
  id!: string;

  @Property()
  createdAt: Date = new Date();

  @Property({ length: 36 })
  entityId!: string;

  @ManyToOne({ entity: () => ChangeAuditApp, fieldName: 'app_id', onUpdateIntegrity: 'cascade' })
  appId!: ChangeAuditApp;

  @ManyToOne({ entity: () => ChangeAuditOperationType, onUpdateIntegrity: 'cascade' })
  operationType!: ChangeAuditOperationType;

  @Property({ length: 36 })
  userId!: string;

  @Property({ length: 100, nullable: true })
  userEmail?: string;

  @Property({ length: 100, nullable: true })
  userDisplayName?: string;

  @Property({ columnType: 'jsonb' })
  entity!: any;

  @Property({ columnType: 'jsonb', nullable: true })
  diff?: any;
}