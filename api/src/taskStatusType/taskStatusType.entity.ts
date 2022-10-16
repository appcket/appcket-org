import { ObjectType, Field } from '@nestjs/graphql';
import { Entity, PrimaryKey, Property } from '@mikro-orm/core';

@ObjectType()
@Entity({ schema: 'appcket' })
export class TaskStatusType {
  @Field()
  @PrimaryKey({ length: 50 })
  id!: string;

  @Field()
  @Property({ length: 50 })
  name!: string;
}
