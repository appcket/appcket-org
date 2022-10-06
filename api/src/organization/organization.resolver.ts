import 'reflect-metadata';
import { Resolver, Query, Args } from '@nestjs/graphql';
import { Injectable } from '@nestjs/common';
import { UseGuards } from '@nestjs/common';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';

import { Organization } from './organization.entity';
import { OrganizationModel } from './organization.model';
import { Resources } from 'src/common/enums/resources.enum';
import { OrganizationPermission } from 'src/common/enums/permissions.enum';
import { PermissionsGuard } from 'src/common/guards/permissions.guard';
import { Permissions } from 'src/common/decorators/permissions.decorator';

@Injectable()
@Resolver(Organization)
export class OrganizationResolver {
  constructor(
    @InjectRepository(Organization)
    private readonly organizationRepository: EntityRepository<Organization>,
  ) {}

  @Query((returns) => Organization, { nullable: true })
  @Permissions(`${Resources.Organization}#${OrganizationPermission.read}`)
  @UseGuards(PermissionsGuard)
  async organizationById(@Args('id') id: string) {
    const organization = await this.organizationRepository.findOne(id, {
      populate: ['users'],
    });
    return organization;
  }
}
