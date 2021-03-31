import { Field, GraphQLISODateTime, ObjectType } from '@nestjs/graphql';

@ObjectType()
export class Team {
  @Field((type) => String)
  team_id: string;

  @Field({ nullable: false })
  name: string;

  @Field({ nullable: false })
  organization_id: string;

  @Field((type) => GraphQLISODateTime, { nullable: false })
  created_at: Date;

  @Field((type) => GraphQLISODateTime, { nullable: false })
  effective_at: Date;
}
