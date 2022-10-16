import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';

import { Team } from 'src/team/team.entity';

@Injectable()
export class SearchTeamsService {
  constructor(
    @InjectRepository(Team)
    private readonly teamRepository: EntityRepository<Team>,
  ) {}

  public async searchTeams(searchString: string, limit: number, offset: number): Promise<Team[]> {
    const where = searchString
      ? {
          name: { $like: `%${searchString}%` },
        }
      : {};

    const dbTeams = await this.teamRepository.find(where, {
      populate: ['organization', 'users'],
      limit,
      offset,
    });

    return dbTeams;
  }
}
