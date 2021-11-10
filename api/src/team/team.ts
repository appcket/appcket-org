import 'reflect-metadata';
import { ObjectType, Field, GraphQLISODateTime } from '@nestjs/graphql';

@ObjectType()
export class Team {
  @Field((type) => String)
  team_id: string;

  @Field()
  name: string;

  @Field((type) => String)
  organization_id: string | null;

  @Field((type) => GraphQLISODateTime)
  created_at: Date;

  @Field((type) => GraphQLISODateTime)
  updated_at: Date;
}
