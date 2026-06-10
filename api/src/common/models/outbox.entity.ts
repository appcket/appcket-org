import { Entity, PrimaryKey, Property } from '@mikro-orm/decorators/legacy';
import { type Opt } from '@mikro-orm/core';

@Entity({ schema: 'appcket', tableName: 'outbox' })
export class Outbox {
  @PrimaryKey({ type: 'uuid', defaultRaw: `gen_random_uuid()` })
  id!: string & Opt;

  @Property({ type: 'json' })
  payload!: any;

  @Property({ type: 'uuid', nullable: true, fieldName: 'correlation_id' })
  correlationId?: string;

  @Property({ onCreate: () => new Date(), defaultRaw: 'now()', fieldName: 'created_at' })
  createdAt: Date & Opt = new Date();
}
