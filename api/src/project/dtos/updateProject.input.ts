import { InputType, Field } from '@nestjs/graphql';
import { IsString, IsNotEmpty, IsUUID, MaxLength, MinLength } from 'class-validator';

@InputType()
export class UpdateProjectInput {
  @Field()
  @IsUUID()
  @IsNotEmpty()
  projectId: string;

  @Field()
  @IsString()
  @IsNotEmpty()
  @MaxLength(50)
  @MinLength(1)
  name: string;

  @Field()
  @IsUUID()
  organizationId: string;

  @Field((type) => [String])
  userIds: string[];
}
