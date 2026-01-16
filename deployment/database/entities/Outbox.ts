import { Entity, PrimaryKey, Property } from '@mikro-orm/core';

@Entity({ schema: 'appcket' })
export class Outbox {
  @PrimaryKey({ columnType: 'integer', autoincrement: true })
  id!: number;

  @Property({ columnType: 'jsonb' })
  payload!: any;

  @Property({ onCreate: () => new Date(), defaultRaw: 'now()' })
  createdAt: Date = new Date();
}
