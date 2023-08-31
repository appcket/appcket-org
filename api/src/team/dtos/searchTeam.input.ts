import { InputType, PartialType } from '@nestjs/graphql';
import { PaginatedSearchInput } from 'src/common/dtos/paginatedSearch.input';

@InputType()
export class SearchTeamsInput extends PartialType(PaginatedSearchInput) {}
{
}
