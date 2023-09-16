import { Field, InputType, PartialType } from '@nestjs/graphql';
import { IsOptional } from 'class-validator';

import { PaginatedSearchInput } from 'src/common/dtos/paginatedSearch.input';

@InputType()
export class SearchTasksInput extends PartialType(PaginatedSearchInput) {
  @Field(() => [String], { nullable: true })
  @IsOptional()
  projectIds: string[];
}
