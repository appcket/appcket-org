import { InputType, Field } from '@nestjs/graphql';
import { IsString, MaxLength, MinLength, IsNumber, IsOptional } from 'class-validator';

import { OrderByUpdatedAtInput } from 'src/common/dtos/orderByUpdatedAt.input';

@InputType()
export class SearchTasksInput {
  @Field(() => String, { nullable: true }) // nullable = true needed for GraphQL optionality
  @IsOptional() // needed for auto-validation https://docs.nestjs.com/techniques/validation#auto-validation
  @IsString()
  @MaxLength(50)
  @MinLength(1)
  searchString: string;

  @Field((type) => [String], { nullable: true })
  @IsOptional()
  projectIds: string[];

  @Field(() => Number, { nullable: true })
  @IsOptional()
  @IsNumber()
  skip: number;

  @Field(() => Number, { nullable: true })
  @IsOptional()
  @IsNumber()
  take: number;

  @Field((type) => OrderByUpdatedAtInput, { nullable: true })
  @IsOptional()
  orderBy: OrderByUpdatedAtInput;
}
