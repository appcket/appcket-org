import { Entity, ManyToOne, PrimaryKey, Property } from '@mikro-orm/core';
import { ChangeAuditEntity } from 'src/changeAudit/entities/changeAuditEntity.entity';

@Entity({ schema: 'appcket' })
export class ChangeAuditChange {
  @PrimaryKey({ columnType: 'uuid', defaultRaw: `gen_random_uuid()` })
  id!: string;

  @Property()
  createdAt: Date = new Date();

  @ManyToOne({
    entity: () => ChangeAuditEntity,
    onUpdateIntegrity: 'cascade',
  })
  changeAuditEntity!: ChangeAuditEntity;

  @Property({ length: 36 })
  entityId!: string;

  @Property({ length: 50 })
  entityType!: string;

  @Property({ length: 36 })
  userId!: string;

  @Property({ length: 100, nullable: true })
  userEmail?: string;

  @Property({ length: 100, nullable: true })
  userDisplayName?: string;

  @Property({ length: 200, nullable: true })
  fieldName?: string;

  @Property({ columnType: 'text', nullable: true })
  oldValue!: string;

  @Property({ columnType: 'text', nullable: true })
  newValue!: string;
}
