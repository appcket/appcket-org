import { Field, ObjectType } from '@nestjs/graphql';

import { OrganizationDto } from '@/organization/organization.dto';
import { PermissionDto } from '@/permission/permission.dto';
import { TeamDto } from '@/team/dtos/team.dto';
import { ProjectDto } from '@/project/dtos/project.dto';

@ObjectType()
export class UserAttributesDto {
  @Field({ nullable: true })
  id?: string;

  @Field({ nullable: true })
  name?: string;

  @Field({ nullable: true })
  jobTitle?: string;
}

@ObjectType()
export class UserDto {
  @Field()
  id!: string;

  @Field({ nullable: true })
  email?: string;

  @Field({ nullable: true })
  firstName?: string;

  @Field({ nullable: true })
  lastName?: string;

  @Field({ nullable: true })
  username?: string;

  @Field({ nullable: true })
  role?: string;

  @Field(() => UserAttributesDto, { nullable: true })
  attributes?: UserAttributesDto;

  @Field(() => [PermissionDto], { nullable: true })
  permissions?: PermissionDto[];

  @Field(() => [OrganizationDto], { nullable: true })
  organizations?: OrganizationDto[];

  @Field(() => [TeamDto])
  team?: TeamDto[];

  @Field(() => [ProjectDto])
  project?: ProjectDto[];
}
