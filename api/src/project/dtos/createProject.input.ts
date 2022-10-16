import { InputType, Field } from '@nestjs/graphql';
import { IsString, IsNotEmpty, IsOptional, IsUUID, MaxLength, MinLength, ValidateIf } from 'class-validator';

@InputType()
export class CreateProjectInput {
  @Field()
  @IsString()
  @IsNotEmpty()
  @MaxLength(50)
  @MinLength(1)
  name: string;

  @Field({ nullable: true })
  @IsOptional()
  @MaxLength(500)
  description: string;

  @Field()
  @IsUUID()
  organizationId: string;

  @Field((type) => [String])
  userIds: string[];
}
