import { Field, GraphQLISODateTime, ObjectType } from '@nestjs/graphql';

import { UserDto } from 'src/user/user.dto';

@ObjectType()
export abstract class BaseDto {
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
}
