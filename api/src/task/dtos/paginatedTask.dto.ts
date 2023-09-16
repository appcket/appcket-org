import { TaskDto } from 'src/task/dtos/task.dto';
import { ObjectType } from '@nestjs/graphql';
import { Paginated } from 'src/common/dtos/paginatedType.type';

@ObjectType()
export class PaginatedTaskDto extends Paginated(TaskDto) {}
