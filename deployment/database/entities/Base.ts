import { Entity, PrimaryKey, Property } from '@mikro-orm/core';

@Entity()
export abstract class BaseEntity {
  @PrimaryKey({ columnType: 'uuid', defaultRaw: `gen_random_uuid()` })
  id!: string;

  @Property({ onCreate: () => new Date() })
  createdAt: Date = new Date();

  @Property({ length: 36, nullable: true })
  createdBy?: string;

  @Property({ onUpdate: () => new Date() })
  updatedAt: Date = new Date();

  @Property({ length: 36, nullable: true })
  updatedBy?: string;

  @Property({ nullable: true })
  deletedAt?: Date;

  @Property({ length: 36, nullable: true })
  deletedBy?: string;
}