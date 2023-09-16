import { InputType, Field } from '@nestjs/graphql';
import { IsString, MaxLength, MinLength, IsOptional } from 'class-validator';
import { QueryOrderEnum } from 'src/common/enums/queryOrder.enum';

@InputType()
export class OrderByInput<T> {
  @Field(() => String)
  @IsOptional()
  @IsString()
  @MaxLength(50)
  @MinLength(1)
  fieldName: keyof T;

  @Field(() => QueryOrderEnum)
  direction: QueryOrderEnum = QueryOrderEnum.ASC;
}
