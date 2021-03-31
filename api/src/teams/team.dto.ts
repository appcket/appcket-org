import { FilterableField } from '@nestjs-query/query-graphql';
import { ObjectType, GraphQLISODateTime, Field } from '@nestjs/graphql';

@ObjectType('Team')
export class TeamDto {
  @FilterableField()
  team_id!: string;

  @FilterableField()
  name!: string;

  @FilterableField()
  organization_id!: string;

  @Field(() => GraphQLISODateTime)
  created_at!: Date;

  @Field(() => GraphQLISODateTime)
  effective_at!: Date;
}
