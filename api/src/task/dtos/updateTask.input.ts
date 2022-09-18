import { InputType, Field } from '@nestjs/graphql';
import { IsString, IsNotEmpty, IsUUID, MaxLength, MinLength } from 'class-validator';

@InputType()
export class UpdateTaskInput {
  @Field()
  @IsUUID()
  @IsNotEmpty()
  taskId: string;

  @Field()
  @IsUUID()
  @IsNotEmpty()
  taskStatusTypeId: string;

  @Field()
  @IsString()
  @IsNotEmpty()
  @MaxLength(100)
  @MinLength(1)
  name: string;

  @Field()
  @IsString()
  @IsNotEmpty()
  @MaxLength(1000)
  description: string;

  @Field()
  @IsUUID()
  projectId: string;

  @Field()
  @IsUUID()
  assignedTo: string;
}
