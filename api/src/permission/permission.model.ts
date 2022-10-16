import 'reflect-metadata';
import { ObjectType, Field } from '@nestjs/graphql';

@ObjectType()
export class Permission {
  @Field()
  rsid: string;

  @Field()
  rsname: string;

  @Field(() => [String], { nullable: true }) scopes?: String[];
}
