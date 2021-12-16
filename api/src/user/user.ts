import 'reflect-metadata';
import { ObjectType, Field } from '@nestjs/graphql';

import { Team } from 'src/team/team';
import { Permission } from './permission';

@ObjectType()
export class User {
  @Field((type) => String)
  user_id: string;

  @Field()
  username: string;

  @Field()
  email: string;

  @Field()
  firstName: string;

  @Field()
  jobTitle: string | null;

  @Field(() => [Team]) teams?: Team[];

  @Field(() => [Permission]) permissions?: Permission[];
}
