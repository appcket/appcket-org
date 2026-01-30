import { Entity, PrimaryKey, Property, ManyToOne } from '@mikro-orm/core';

@Entity({ abstract: true })
export abstract class BaseEntity {
  @PrimaryKey({ columnType: 'uuid', defaultRaw: `gen_random_uuid()` })
  id!: string;

  @Property({ onCreate: () => new Date() })
  createdAt: Date = new Date();

  @ManyToOne({ entity: 'User', fieldName: 'created_by', updateRule: 'cascade', nullable: true })
  createdBy?: any;

  @Property({ onUpdate: () => new Date() })
  updatedAt: Date = new Date();

  @ManyToOne({ entity: 'User', fieldName: 'updated_by', updateRule: 'cascade', nullable: true })
  updatedBy?: any;

  @Property({ nullable: true })
  deletedAt?: Date;

  @ManyToOne({ entity: 'User', fieldName: 'deleted_by', updateRule: 'cascade', nullable: true })
  deletedBy?: any;
}