import { InputType, Field } from '@nestjs/graphql';
import { IsNotEmpty, IsUUID } from 'class-validator';

import { CreateTeamInput } from 'src/team/dtos/createTeam.input';

@InputType()
export class UpdateTeamInput extends CreateTeamInput {
  @Field()
  @IsUUID()
  @IsNotEmpty()
  id: string;
}
