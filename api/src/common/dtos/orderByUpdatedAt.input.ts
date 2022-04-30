import { InputType, Field } from '@nestjs/graphql';

import { SortOrder } from 'src/common/enums/sortOrder.enum';

@InputType()
export class OrderByUpdatedAtInput {
  @Field((type) => SortOrder)
  updated_at: SortOrder;
}
