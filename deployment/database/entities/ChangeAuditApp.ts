import { Entity, ManyToOne, PrimaryKey, Property } from '@mikro-orm/core';
import { Organization } from './Organization';

@Entity({ schema: 'appcket' })
export class ChangeAuditApp {
  @PrimaryKey({ columnType: 'uuid', defaultRaw: `gen_random_uuid()` })
  id!: string;

  @Property({ length: 30 })
  name!: string;

  @ManyToOne({ entity: () => Organization, updateRule: 'cascade' })
  organization!: Organization;
}
