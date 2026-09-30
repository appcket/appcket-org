import { TaskDto } from '@/task/dtos/task.dto';
import { ObjectType } from '@nestjs/graphql';
import { Paginated } from '@/common/dtos/paginatedType.type';

@ObjectType()
export class PaginatedTaskDto extends Paginated(TaskDto) {}
