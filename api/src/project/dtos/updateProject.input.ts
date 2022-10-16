import { InputType, Field } from '@nestjs/graphql';
import { IsNotEmpty, IsUUID } from 'class-validator';

import { CreateProjectInput } from 'src/project/dtos/createProject.input';

@InputType()
export class UpdateProjectInput extends CreateProjectInput {
  @Field()
  @IsUUID()
  @IsNotEmpty()
  id: string;
}
