import 'reflect-metadata';
import { ObjectType, Field } from '@nestjs/graphql';

import { OrganizationModel } from 'src/organization/organization.model';
import { UserModel } from 'src/user/user.model';

@ObjectType()
export class ProjectModel {
  @Field((type) => String)
  id: string;

  @Field()
  name: string;

  @Field()
  description?: string;

  @Field(() => OrganizationModel) organization?: OrganizationModel;

  @Field(() => [UserModel]) users?: UserModel[];
}
