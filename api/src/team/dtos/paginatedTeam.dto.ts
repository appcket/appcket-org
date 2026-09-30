import { TeamDto } from '@/team/dtos/team.dto';
import { ObjectType } from '@nestjs/graphql';
import { Paginated } from '@/common/dtos/paginatedType.type';

@ObjectType()
export class PaginatedTeamDto extends Paginated(TeamDto) {}
