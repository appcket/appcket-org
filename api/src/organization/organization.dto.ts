import 'reflect-metadata';
import { ObjectType, Field } from '@nestjs/graphql';

import { UserDto } from 'src/user/user.dto';
import { ProjectDto } from 'src/project/dtos/project.dto';
import { TeamDto } from 'src/team/dtos/team.dto';

@ObjectType()
export class OrganizationDto {
  @Field()
  id!: string;

  @Field()
  name!: string;

  @Field(() => [ProjectDto], { nullable: true })
  projects?: ProjectDto[];

  @Field(() => [TeamDto], { nullable: true })
  teams?: TeamDto[];

  @Field(() => [UserDto], { nullable: true })
  users?: UserDto[];
}
