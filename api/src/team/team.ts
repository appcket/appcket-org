import 'reflect-metadata';
import { ObjectType, Field, GraphQLISODateTime } from '@nestjs/graphql';

import { Organization } from 'src/organization/organization';
import { User } from 'src/user/user';
import { TeamUser } from 'src/teamUser/teamUser';

@ObjectType()
export class Team {
  @Field((type) => String)
  team_id: string;

  @Field()
  name: string;

  @Field((type) => GraphQLISODateTime)
  created_at: Date;

  @Field((type) => GraphQLISODateTime)
  updated_at: Date;

  @Field()
  organization?: Organization;

  @Field(() => [User]) users?: User[];

  @Field(() => [TeamUser]) team_user?: TeamUser[];
}
