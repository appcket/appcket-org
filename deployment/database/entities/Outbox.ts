import { Entity, PrimaryKey, Property } from '@mikro-orm/core';

@Entity({ schema: 'appcket' })
export class Outbox {
  @PrimaryKey({ columnType: 'uuid', defaultRaw: `gen_random_uuid()` })
  id!: string;

  @Property({ columnType: 'jsonb' })
  payload!: any;

  @Property({ columnType: 'uuid', nullable: true })
  correlationId?: string;

  @Property({ onCreate: () => new Date(), defaultRaw: 'now()' })
  createdAt: Date = new Date();
}
