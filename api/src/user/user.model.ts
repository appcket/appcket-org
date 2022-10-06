import 'reflect-metadata';
import { ObjectType, Field } from '@nestjs/graphql';
import { IsOptional } from 'class-validator';

import { TeamModel } from 'src/team/team.model';
import { ProjectModel } from 'src/project/project.model';
import { Permission } from 'src/permission/models/permission.model';
import { Organization } from 'src/organization/organization.entity';

@ObjectType()
export class UserModel {
  @Field((type) => String)
  id: string;

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
  jobTitle?: string;

  @Field(() => [TeamModel]) teams?: TeamModel[];
  @Field(() => [ProjectModel]) projects?: ProjectModel[];

  @Field(() => [Permission]) permissions?: Permission[];
  @Field(() => [Organization]) organizations?: Organization[];
}
