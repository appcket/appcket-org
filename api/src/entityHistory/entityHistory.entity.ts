import { Field, ObjectType, GraphQLISODateTime } from '@nestjs/graphql';
import { Property } from '@mikro-orm/decorators/legacy';

@ObjectType()
class EntityHistoryUser {
  @Field(() => String, { nullable: true })
  @Property({ nullable: true, persist: false })
  id?: string | null = null;

  @Field(() => String, { nullable: true })
  @Property({ nullable: true, persist: false })
  displayName?: string | null = null;
}

@ObjectType()
class EntityHistoryChange {
  @Field(() => GraphQLISODateTime, { nullable: true })
  @Property({ nullable: true, persist: false })
  changedAt?: Date | null = null;

  @Field(() => String, { nullable: true })
  @Property({ nullable: true, persist: false })
  fieldName?: string | null = null;

  @Field(() => String, { nullable: true })
  @Property({ nullable: true, persist: false })
  oldValue?: string | null = null;

  @Field(() => String, { nullable: true })
  @Property({ nullable: true, persist: false })
  newValue?: string | null = null;

  @Field(() => EntityHistoryUser, { nullable: true })
  @Property({ nullable: true, persist: false })
  changedBy?: EntityHistoryUser = {};
}

@ObjectType()
export class EntityHistory {
  @Field(() => String)
  @Property({ persist: false })
  id!: string;

  @Field(() => GraphQLISODateTime, { nullable: true })
  @Property({ nullable: true, persist: false })
  createdAt?: Date | null = null;

  @Field(() => GraphQLISODateTime, { nullable: true })
  @Property({ nullable: true, persist: false })
  updatedAt?: Date | null = null;

  @Field(() => EntityHistoryUser, { nullable: true })
  @Property({ nullable: true, persist: false })
  createdBy?: EntityHistoryUser = {};

  @Field(() => EntityHistoryUser, { nullable: true })
  @Property({ nullable: true, persist: false })
  updatedBy?: EntityHistoryUser = {};

  @Field(() => [EntityHistoryChange], { nullable: true })
  @Property({ nullable: true, persist: false })
  changes?: EntityHistoryChange[] = [];
}
