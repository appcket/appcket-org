import { ProjectDto } from '@/project/dtos/project.dto';
import { ObjectType } from '@nestjs/graphql';
import { Paginated } from '@/common/dtos/paginatedType.type';

@ObjectType()
export class PaginatedProjectDto extends Paginated(ProjectDto) {}
