import { InputType, Field } from '@nestjs/graphql';
import { IsString, IsNotEmpty, IsOptional, IsUUID, MaxLength, MinLength } from 'class-validator';

@InputType()
export class CreateTeamInput {
  @Field()
  @IsString()
  @IsNotEmpty()
  @MaxLength(50)
  @MinLength(1)
  name: string;

  @Field({ nullable: true })
  @IsOptional()
  @IsString()
  @MaxLength(500)
  description: string;

  @Field()
  @IsUUID()
  organizationId: string;

  @Field((type) => [String])
  userIds: string[];
}
