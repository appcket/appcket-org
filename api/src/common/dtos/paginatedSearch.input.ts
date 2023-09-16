import { InputType, Field } from '@nestjs/graphql';
import { IsString, Max, MaxLength, Min, MinLength, IsNumber, IsOptional } from 'class-validator';
import { OrderByInput } from 'src/common/dtos/orderBy.input';

@InputType()
export class PaginatedSearchInput<T> {
  @Field(() => String, { nullable: true }) // nullable = true needed for GraphQL optionality
  @IsOptional() // needed for auto-validation https://docs.nestjs.com/techniques/validation#auto-validation
  @IsString()
  @MaxLength(50)
  searchString: string;

  @Field(() => Number, { nullable: true })
  @IsOptional()
  @IsNumber()
  @Min(1)
  @Max(100)
  first: number;

  @Field(() => String, { nullable: true })
  @IsOptional()
  @IsString()
  @MaxLength(50)
  @MinLength(1)
  after: string;

  @Field(() => [OrderByInput], { nullable: true })
  @IsOptional()
  orderBy: OrderByInput<T>[];
}
