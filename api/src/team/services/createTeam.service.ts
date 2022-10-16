import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';
import { Logger } from '@nestjs/common';

import { Team } from 'src/team/team.entity';
import { CreateTeamInput } from 'src/team/dtos/createTeam.input';
import { GetTeamService } from 'src/team/services/getTeam.service';

@Injectable()
export class CreateTeamService {
  private readonly logger = new Logger(CreateTeamService.name);

  constructor(
    @InjectRepository(Team)
    private readonly teamRepository: EntityRepository<Team>,
    private getTeamService: GetTeamService,
  ) {}

  public async createTeam(data: CreateTeamInput, userId: string): Promise<Team> {
    // TODO: validate userId is associated with data.organizationId
    // TODO: validate data.userIds are associated with data.organizationId

    const newTeam = this.teamRepository.create({
      name: data.name,
      description: data.description,
      organization: data.organizationId,
      users: data.userIds,
    });

    await this.teamRepository.persist(newTeam).flush();

    const createdTeam = await this.getTeamService.getTeam(newTeam.id);

    this.logger.log(`${Team.name} created successfully. id: ${createdTeam.id}`);

    return createdTeam;
  }
}
