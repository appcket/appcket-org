import { Entity, PrimaryKey, Property } from '@mikro-orm/core';

@Entity({ schema: 'appcket' })
export class ChangeAuditOperationType {
  @PrimaryKey({ length: 50 })
  id!: string;

  @Property({ length: 50 })
  name?: string;
}
