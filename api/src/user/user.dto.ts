import { Field, ObjectType } from '@nestjs/graphql';

import { OrganizationDto } from 'src/organization/organization.dto';
import { PermissionDto } from 'src/permission/permission.dto';
import { UserAttributeDto } from 'src/user/userAttribute.dto';
import { TeamDto } from 'src/team/dtos/team.dto';
import { ProjectDto } from 'src/project/dtos/project.dto';

@ObjectType()
export class UserDto {
  @Field()
  id!: string;

  @Field()
  email: string;

  @Field()
  firstName: string;

  @Field({ nullable: true })
  lastName: string;

  @Field()
  username: string;

  @Field({ nullable: true })
  role?: string;

  @Field(() => [UserAttributeDto], { nullable: true })
  attributes?: UserAttributeDto[];

  @Field(() => [PermissionDto])
  permissions?: PermissionDto[];

  @Field(() => [OrganizationDto], { nullable: true })
  organizations?: OrganizationDto[];

  @Field(() => [TeamDto])
  team?: TeamDto[];

  @Field(() => [ProjectDto])
  project?: ProjectDto[];
}
