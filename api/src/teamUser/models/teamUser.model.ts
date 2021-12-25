import 'reflect-metadata';
import { ObjectType, Field, GraphQLISODateTime } from '@nestjs/graphql';

@ObjectType()
export class TeamUser {
  @Field((type) => String)
  team_user_id: string;

  @Field()
  team_id: string;

  @Field()
  user_id: string;

  @Field((type) => GraphQLISODateTime)
  created_at: Date;

  @Field((type) => GraphQLISODateTime)
  updated_at: Date;
}
