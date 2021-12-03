import 'reflect-metadata';
import { ObjectType, Field, GraphQLISODateTime } from '@nestjs/graphql';

import { Organization } from 'src/organization/organization';

@ObjectType()
export class Team {
  @Field((type) => String)
  team_id: string;

  @Field()
  name: string;

  @Field()
  organization: Organization;

  @Field((type) => GraphQLISODateTime)
  created_at: Date;

  @Field((type) => GraphQLISODateTime)
  updated_at: Date;
}
