import { Entity, ManyToOne, PrimaryKey, Property } from '@mikro-orm/core';
import { Organization } from './Organization';

@Entity({ schema: 'appcket' })
export class Team {
  @PrimaryKey({ columnType: 'uuid', defaultRaw: `gen_random_uuid()` })
  id!: string;

  @Property({ length: 50 })
  name!: string;

  @Property({ columnType: 'text', length: 500, nullable: true })
  description?: string;

  @ManyToOne({ entity: () => Organization, onUpdateIntegrity: 'cascade' })
  organization!: Organization;
}
