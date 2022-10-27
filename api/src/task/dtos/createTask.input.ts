import { InputType, Field } from '@nestjs/graphql';
import { IsString, IsNotEmpty, IsOptional, IsUUID, MaxLength, MinLength } from 'class-validator';

@InputType()
export class CreateTaskInput {
  @Field()
  @IsString()
  @IsNotEmpty()
  @MaxLength(100)
  @MinLength(1)
  name: string;

  @Field({ nullable: true })
  @IsOptional()
  @IsString()
  @MaxLength(5000)
  description: string;

  @Field()
  @IsString()
  @IsNotEmpty()
  taskStatusTypeId: string;

  @Field()
  @IsUUID()
  projectId: string;

  @Field()
  @IsUUID()
  assignedTo: string;
}
