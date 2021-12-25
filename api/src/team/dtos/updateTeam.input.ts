import { InputType, Field } from '@nestjs/graphql';
import { IsString, IsNotEmpty, IsUUID, MaxLength } from 'class-validator';

@InputType()
export class UpdateTeamInput {
  @Field()
  @IsUUID()
  @IsNotEmpty()
  teamId: string;

  @Field()
  @IsString()
  @IsNotEmpty()
  @MaxLength(50)
  name: string;

  @Field()
  @IsUUID()
  organizationId: string;

  @Field(() => [String]) userIds?: string[];
}
