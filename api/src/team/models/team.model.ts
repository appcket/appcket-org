import 'reflect-metadata';
import { ObjectType, Field, GraphQLISODateTime } from '@nestjs/graphql';

import { Organization } from 'src/organization/models/organization.model';
import { User } from 'src/user/models/user.model';
import { TeamUser } from 'src/teamUser/models/teamUser.model';

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
