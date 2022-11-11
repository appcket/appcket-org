import { Injectable } from '@nestjs/common';
import { EntityRepository, wrap } from '@mikro-orm/core';
import { InjectRepository } from '@mikro-orm/nestjs';
import { Logger } from '@nestjs/common';

import { Team } from 'src/team/team.entity';
import { UpdateTeamInput } from 'src/team/dtos/updateTeam.input';
import { GetTeamService } from 'src/team/services/getTeam.service';
import { GetOrganizationService } from 'src/organization/services/getOrganization.service';

@Injectable()
export class UpdateTeamService {
  private readonly logger = new Logger(UpdateTeamService.name);

  constructor(
    @InjectRepository(Team)
    private readonly teamRepository: EntityRepository<Team>,
    private getTeamService: GetTeamService,
    private getOrganizationService: GetOrganizationService,
  ) {}

  public async updateTeam(data: UpdateTeamInput, userId: string): Promise<Team> {
    // validate userId is associated with data.organizationId in organization_user table
    await this.getOrganizationService.getOrganization(data.organizationId, userId);

    // validate data.userIds are associated with data.organizationId
    await this.getOrganizationService.getOrganizationUsers(data.organizationId, data.userIds);

    const team = await this.getTeamService.getTeam(data.id, userId);

    wrap(team).assign({
      name: data.name,
      description: data.description,
      organization: data.organizationId,
      users: data.userIds,
    });
    await this.teamRepository.persist(team);

    const updatedTeam = await this.getTeamService.getTeam(data.id, userId);

    this.logger.log(`${Team.name} updated successfully. id: ${updatedTeam.id}`);

    return updatedTeam;
  }
}
