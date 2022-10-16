import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';

import { CommonService } from 'src/common/services/common.service';
import { Organization } from 'src/organization/organization.entity';

@Injectable()
export class GetOrganizationService {
  private readonly entityType = 'Organization';

  constructor(
    @InjectRepository(Organization)
    private readonly organizationRepository: EntityRepository<Organization>,
    private commonService: CommonService,
  ) {}

  public async getOrganization(id: string): Promise<Organization> {
    const organization = await this.organizationRepository.findOneOrFail(id, {
      populate: ['users', 'users.attributes', 'projects', 'teams'],
    });

    return organization;
  }
}
