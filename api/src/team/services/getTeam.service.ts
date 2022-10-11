import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';

import { Team } from 'src/team/team.entity';

@Injectable()
export class GetTeamService {
  constructor(
    @InjectRepository(Team)
    private readonly teamRepository: EntityRepository<Team>,
  ) {}

  public async getTeam(id: string): Promise<Team> {
    const team = await this.teamRepository.findOne(id, {
      populate: ['organization', 'users'],
    });
    return team;
  }
}
