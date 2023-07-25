import { Field, ObjectType } from '@nestjs/graphql';
import { EntityHistory } from 'src/entityHistory/entityHistory.entity';
import { Team } from 'src/team/team.entity';

@ObjectType()
export class SearchTeam {
  @Field(() => [Team])
  teams: Team[];

  @Field(() => [EntityHistory])
  history: EntityHistory[];

  @Field(() => Number)
  totalCount: number;
}
