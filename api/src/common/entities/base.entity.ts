import { ObjectType } from '@nestjs/graphql';
import { type Opt, type Ref } from '@mikro-orm/core';
import { Entity, ManyToOne, PrimaryKey, Property } from '@mikro-orm/decorators/legacy';

import { User } from 'src/user/user.entity';

@ObjectType()
@Entity({ abstract: true })
export abstract class BaseEntity {
  @PrimaryKey({ type: 'uuid', defaultRaw: `gen_random_uuid()` })
  id!: string & Opt;

  @Property({ onCreate: () => new Date() })
  createdAt: Date & Opt = new Date();

  @ManyToOne({
    entity: () => User,
    ref: true,
    fieldName: 'created_by',
    updateRule: 'cascade',
    nullable: true,
  })
  createdBy?: Ref<User> & Opt;

  @Property({ onUpdate: () => new Date() })
  updatedAt: Date & Opt = new Date();

  @ManyToOne({
    entity: () => User,
    ref: true,
    fieldName: 'updated_by',
    updateRule: 'cascade',
    nullable: true,
  })
  updatedBy?: Ref<User> & Opt;

  @Property({ nullable: true, type: 'datetime' })
  deletedAt?: Date & Opt;

  @ManyToOne({
    entity: () => User,
    ref: true,
    fieldName: 'deleted_by',
    updateRule: 'cascade',
    nullable: true,
  })
  deletedBy?: Ref<User> & Opt;
}
