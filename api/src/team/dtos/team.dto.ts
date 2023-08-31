import { Field, GraphQLISODateTime, ObjectType } from '@nestjs/graphql';

import { OrganizationDto } from 'src/organization/organization.dto';
import { UserDto } from 'src/user/user.dto';

@ObjectType()
export class TeamDto {
  @Field()
  id!: string;

  @Field(() => GraphQLISODateTime)
  createdAt: Date = new Date();

  @Field(() => UserDto, { nullable: true })
  createdBy?: UserDto;

  @Field(() => GraphQLISODateTime)
  updatedAt: Date = new Date();

  @Field(() => UserDto, { nullable: true })
  updatedBy?: UserDto;

  @Field(() => GraphQLISODateTime, { nullable: true })
  deletedAt?: Date;

  @Field(() => UserDto, { nullable: true })
  deletedBy?: UserDto;

  @Field()
  name!: string;

  @Field({ nullable: true })
  description?: string;

  @Field(() => OrganizationDto)
  organization!: OrganizationDto;

  @Field(() => [UserDto])
  users: UserDto[];
}
