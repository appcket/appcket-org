import { Collection } from '@mikro-orm/core';
import { Entity, OneToMany, Property } from '@mikro-orm/decorators/legacy';

import { OrganizationUser } from 'src/organization/organizationUser.entity';
import { BaseEntity } from 'src/common/entities/base.entity';
import { Project } from 'src/project/project.entity';
import { Team } from 'src/team/team.entity';

@Entity({ schema: 'appcket', tableName: 'organization' })
export class Organization extends BaseEntity {
  @Property({ length: 30, type: 'varchar' })
  name!: string;

  @OneToMany({
    entity: () => OrganizationUser,
    mappedBy: 'organization',
  })
  organizationUsers = new Collection<OrganizationUser>(this);

  @OneToMany({
    entity: () => Project,
    mappedBy: 'organization',
  })
  projects = new Collection<Project>(this);

  @OneToMany({
    entity: () => Team,
    mappedBy: 'organization',
  })
  teams = new Collection<Team>(this);
}
