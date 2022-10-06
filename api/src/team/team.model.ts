import 'reflect-metadata';
import { ObjectType, Field } from '@nestjs/graphql';

import { Organization } from 'src/organization/models/organization.model';
import { UserModel } from 'src/user/user.model';

@ObjectType()
export class TeamModel {
  @Field((type) => String)
  id: string;

  @Field()
  name: string;

  @Field()
  organization?: Organization;

  @Field(() => [UserModel]) users?: UserModel[];
}
