import { Injectable } from '@nestjs/common';
import { EntityRepository, wrap } from '@mikro-orm/core';
import { InjectRepository } from '@mikro-orm/nestjs';
import { Logger } from '@nestjs/common';

import { Team } from 'src/team/team.entity';
import { UpdateTeamInput } from 'src/team/dtos/updateTeam.input';
import { GetTeamService } from 'src/team/services/getTeam.service';

@Injectable()
export class UpdateTeamService {
  private readonly logger = new Logger(UpdateTeamService.name);

  constructor(
    @InjectRepository(Team)
    private readonly teamRepository: EntityRepository<Team>,
    private getTeamService: GetTeamService,
  ) {}

  public async updateTeam(data: UpdateTeamInput, userId: string): Promise<Team> {
    const team = await this.getTeamService.getTeam(data.id);

    wrap(team).assign(data);
    await this.teamRepository.persist(team);

    const updatedTeam = await this.getTeamService.getTeam(data.id);

    this.logger.log(`${Team.name} updated successfully. id: ${updatedTeam.id}`);

    return updatedTeam;
  }
}
