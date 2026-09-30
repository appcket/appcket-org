import { Field, ObjectType } from '@nestjs/graphql';

import { BaseDto } from '@/common/dtos/base.dto';
import { OrganizationDto } from '@/organization/organization.dto';
import { UserDto } from '@/user/user.dto';

@ObjectType()
export class TeamDto extends BaseDto {
  @Field()
  name!: string;

  @Field({ nullable: true })
  description?: string;

  @Field(() => OrganizationDto)
  organization!: OrganizationDto;

  @Field(() => [UserDto])
  users!: UserDto[];
}
