import 'reflect-metadata';
import { ObjectType, Field, GraphQLISODateTime } from '@nestjs/graphql';

import { Organization } from 'src/organization/models/organization.model';
import { User } from 'src/user/models/user.model';
import { ProjectUser } from 'src/projectUser/models/projectUser.model';

@ObjectType()
export class Project {
  @Field((type) => String)
  project_id: string;

  @Field()
  name: string;

  @Field((type) => GraphQLISODateTime)
  created_at: Date;

  @Field((type) => GraphQLISODateTime)
  updated_at: Date;

  @Field()
  organization?: Organization;

  @Field(() => [User]) users?: User[];

  @Field(() => [ProjectUser]) project_user?: ProjectUser[];
}
