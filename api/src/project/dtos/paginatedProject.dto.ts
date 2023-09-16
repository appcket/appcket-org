import { ProjectDto } from 'src/project/dtos/project.dto';
import { ObjectType } from '@nestjs/graphql';
import { Paginated } from 'src/common/dtos/paginatedType.type';

@ObjectType()
export class PaginatedProjectDto extends Paginated(ProjectDto) {}
