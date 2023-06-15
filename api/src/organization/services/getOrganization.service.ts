import { BadRequestException, Logger, Injectable } from '@nestjs/common';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';

import { Organization } from 'src/organization/organization.entity';
import { OrganizationUser } from 'src/organization/organizationUser.entity';

@Injectable()
export class GetOrganizationService {
  private readonly logger = new Logger(GetOrganizationService.name);

  constructor(
    @InjectRepository(Organization)
    private readonly organizationRepository: EntityRepository<Organization>,
    @InjectRepository(OrganizationUser)
    private readonly organizationUserRepository: EntityRepository<OrganizationUser>,
  ) {}

  public async getOrganization(id: string, userId: string): Promise<Organization> {
    // fail if the requesting userId is not associated with the organizationId
    await this.organizationUserRepository.findOneOrFail({
      organization: id,
      user: userId,
    });

    const organization = await this.organizationRepository.findOneOrFail(id, {
      populate: ['users', 'users.attributes', 'projects', 'teams'],
    });

    return organization;
  }

  public async getUserOrganizationIds(userId: string) {
    const userOrganizationIds = (await this.organizationUserRepository.find({ user: userId })).map(
      (entity) => entity.organization,
    );

    return userOrganizationIds;
  }

  public async getOrganizationUsers(id: string, userIds: string[]) {
    const organizationUsers = await this.organizationUserRepository.find(
      { organization: id, user: { $in: userIds } },
      {
        populate: ['user'],
        fields: ['user'],
      },
    );

    const organizationUserIds = [];
    organizationUsers.forEach((organizationUser) => {
      organizationUserIds.push(organizationUser.user.id);
    });

    const notAssociatedUserIds = userIds.filter((userId) => !organizationUserIds.includes(userId));

    if (organizationUsers.length !== userIds.length) {
      const errorMessage = `userId(s): ${notAssociatedUserIds.toString()} not associated with organizationId: ${id}`;
      this.logger.log(errorMessage);

      throw new BadRequestException(errorMessage);
    }

    return organizationUsers;
  }
}
