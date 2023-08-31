import 'reflect-metadata';
import { ObjectType, Field } from '@nestjs/graphql';

@ObjectType()
export class PermissionDto {
  @Field()
  rsid: string;

  @Field()
  rsname: string;

  @Field(() => [String], { nullable: true }) scopes?: string[];
}
