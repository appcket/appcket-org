import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';

import { CommonService } from 'src/common/services/common.service';
import { Team } from 'src/team/team.entity';

@Injectable()
export class GetTeamService {
  private readonly entityType = 'Team';
  constructor(
    @InjectRepository(Team)
    private readonly teamRepository: EntityRepository<Team>,
    private commonService: CommonService,
  ) {}

  public async getTeam(id: string): Promise<Team> {
    const team = await this.teamRepository.findOneOrFail(id, {
      populate: ['organization', 'users'],
    });

    return team;
  }
}
