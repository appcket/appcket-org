import { TeamDto } from 'src/team/dtos/team.dto';
import { ObjectType } from '@nestjs/graphql';
import { Paginated } from 'src/common/dtos/paginatedType.type';

@ObjectType()
export class PaginatedTeamDto extends Paginated(TeamDto) {}
