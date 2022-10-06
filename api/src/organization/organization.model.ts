import 'reflect-metadata';
import { ObjectType, Field } from '@nestjs/graphql';

import { UserModel } from 'src/user/user.model';

@ObjectType()
export class OrganizationModel {
  @Field((type) => String)
  id: string;

  @Field()
  name: string;

  @Field(() => [UserModel]) users?: UserModel[];
}
