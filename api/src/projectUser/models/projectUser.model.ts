import 'reflect-metadata';
import { ObjectType, Field, GraphQLISODateTime } from '@nestjs/graphql';

@ObjectType()
export class ProjectUser {
  @Field((type) => String)
  project_user_id: string;

  @Field()
  project_id: string;

  @Field()
  user_id: string;

  @Field((type) => GraphQLISODateTime)
  created_at: Date;

  @Field((type) => GraphQLISODateTime)
  updated_at: Date;
}
