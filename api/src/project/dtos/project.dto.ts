import 'reflect-metadata';
import { ObjectType, Field } from '@nestjs/graphql';

import { OrganizationDto } from 'src/organization/organization.dto';
import { UserDto } from 'src/user/user.dto';

@ObjectType()
export class ProjectDto {
  @Field()
  id!: string;

  @Field()
  name!: string;

  @Field({ nullable: true })
  description: string;

  @Field(() => OrganizationDto)
  organization!: OrganizationDto;

  @Field(() => [UserDto])
  users: UserDto;
}
