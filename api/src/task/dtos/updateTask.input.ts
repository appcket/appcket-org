import { InputType, Field } from '@nestjs/graphql';
import { IsNotEmpty, IsUUID } from 'class-validator';

import { CreateTaskInput } from 'src/task/dtos/createTask.input';

@InputType()
export class UpdateTaskInput extends CreateTaskInput {
  @Field()
  @IsUUID()
  @IsNotEmpty()
  id: string;
}
