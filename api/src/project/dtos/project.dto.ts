import { ObjectType, Field } from '@nestjs/graphql';

import { BaseDto } from 'src/common/dtos/base.dto';
import { OrganizationDto } from 'src/organization/organization.dto';
import { UserDto } from 'src/user/user.dto';

@ObjectType()
export class ProjectDto extends BaseDto {
  @Field()
  name!: string;

  @Field({ nullable: true })
  description?: string;

  @Field(() => OrganizationDto)
  organization?: OrganizationDto;

  @Field(() => [UserDto])
  users?: UserDto[];
}
