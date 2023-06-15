import { Entity, PrimaryKey, Property } from '@mikro-orm/core';

@Entity({ schema: 'appcket' })
export class Organization {
  @PrimaryKey({ columnType: 'uuid', defaultRaw: `gen_random_uuid()` })
  id!: string;

  @Property({ length: 30 })
  name!: string;
}
