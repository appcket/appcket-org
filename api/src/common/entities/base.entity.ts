import { Field, ObjectType, GraphQLISODateTime } from '@nestjs/graphql';
import { PrimaryKey, Property } from '@mikro-orm/core';

@ObjectType()
export abstract class BaseEntity {
  @Field()
  @PrimaryKey({ columnType: 'uuid', defaultRaw: `gen_random_uuid()` })
  id!: string;

  @Field(() => GraphQLISODateTime)
  @Property()
  createdAt: Date = new Date();

  @Field(() => GraphQLISODateTime)
  @Property({ onUpdate: () => new Date() })
  updatedAt: Date = new Date();

  @Field(() => GraphQLISODateTime, { nullable: true })
  @Property({ nullable: true })
  deletedAt?: Date;
}
