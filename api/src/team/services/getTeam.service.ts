import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';

import { CommonService } from 'src/common/services/common.service';
import { Team } from 'src/team/team.entity';
import { GetOrganizationService } from 'src/organization/services/getOrganization.service';

@Injectable()
export class GetTeamService {
  constructor(
    @InjectRepository(Team)
    private readonly teamRepository: EntityRepository<Team>,
    private commonService: CommonService,
    private getOrganizationService: GetOrganizationService,
  ) {}

  public async getTeam(id: string, userId: string): Promise<Team> {
    const userOrganizationIds = await this.getOrganizationService.getUserOrganizationIds(userId);
    const organizationWhere = { $in: userOrganizationIds };
    const team = await this.teamRepository.findOneOrFail(
      { id, organization: organizationWhere },
      {
        populate: ['organization.id', 'organization.name', 'users'],
      },
    );

    return team;
  }
}
