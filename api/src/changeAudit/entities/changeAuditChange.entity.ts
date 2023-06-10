import { Entity, ManyToOne, PrimaryKey, Property } from '@mikro-orm/core';
import { ChangeAuditEntity } from 'src/changeAudit/entities/changeAuditEntity.entity';
import { ChangeAuditOperationType } from 'src/changeAudit/entities/changeAuditOperationType.entity';

@Entity({ schema: 'appcket' })
export class ChangeAuditChange {
  @PrimaryKey({ columnType: 'uuid', defaultRaw: `gen_random_uuid()` })
  id!: string;

  @Property()
  createdAt: Date = new Date();

  @ManyToOne({
    entity: () => ChangeAuditEntity,
    fieldName: 'change_audit_entity_id',
    onUpdateIntegrity: 'cascade',
  })
  changeAuditEntityId!: ChangeAuditEntity;

  @Property({ length: 36 })
  entityId!: string;

  @ManyToOne({
    entity: () => ChangeAuditOperationType,
    fieldName: 'operation_type_id',
    onUpdateIntegrity: 'cascade',
  })
  operationTypeId!: ChangeAuditOperationType;

  @Property({ length: 36 })
  userId!: string;

  @Property({ length: 100, nullable: true })
  userEmail?: string;

  @Property({ length: 100, nullable: true })
  userDisplayName?: string;

  @Property({ length: 200 })
  fieldName!: string;

  @Property({ columnType: 'text', nullable: true })
  oldValue!: string;

  @Property({ columnType: 'text', nullable: true })
  newValue!: string;
}