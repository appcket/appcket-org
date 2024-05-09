import { ObjectType, Field } from '@nestjs/graphql';

@ObjectType()
export class UserAttributeDto {
  @Field()
  id!: string;

  @Field()
  name?: string;

  @Field()
  value?: string;
}
