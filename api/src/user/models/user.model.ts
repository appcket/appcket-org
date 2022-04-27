import 'reflect-metadata';
import { ObjectType, Field } from '@nestjs/graphql';
import { IsOptional } from 'class-validator';

import { Team } from 'src/team/models/team.model';
import { Permission } from 'src/permission/models/permission.model';
import { Organization } from 'src/organization/models/organization.model';

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

  @IsOptional()
  @Field({ nullable: true })
  lastName: string | null;

  @IsOptional()
  @Field({ nullable: true })
  jobTitle: string;

  @Field(() => [Team]) teams?: Team[];

  @Field(() => [Permission]) permissions?: Permission[];
  @Field(() => [Organization]) organizations?: Organization[];
}
