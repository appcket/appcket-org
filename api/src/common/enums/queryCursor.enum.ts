import { registerEnumType } from '@nestjs/graphql';
import { BaseEntity } from 'src/common/entities/base.entity';

export enum QueryCursorEnum {
  DATE = 'DATE',
  ALPHA = 'ALPHA',
}

registerEnumType(QueryCursorEnum, {
  name: 'QueryCursor',
});

export const getQueryCursor = (cursor: QueryCursorEnum): keyof BaseEntity =>
  cursor === QueryCursorEnum.ALPHA ? 'id' : 'createdAt';
