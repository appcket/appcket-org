import 'reflect-metadata';
import { Collection, Entity, ManyToMany, OneToMany, Property } from '@mikro-orm/core';

import { BaseEntity } from 'src/common/entities/base.entity';
import { OrganizationUser } from 'src/organization/organizationUser.entity';
import { User } from 'src/user/user.entity';
import { Project } from 'src/project/project.entity';
import { Team } from 'src/team/team.entity';

@Entity({ schema: 'appcket' })
export class Organization extends BaseEntity {
  @Property({ length: 30 })
  name!: string;

  @OneToMany({ entity: () => Project, mappedBy: 'organization' })
  projects = new Collection<Project>(this);

  @OneToMany({ entity: () => Team, mappedBy: 'organization' })
  teams = new Collection<Team>(this);

  @ManyToMany({
    entity: () => User,
    pivotEntity: () => OrganizationUser,
    pivotTable: 'organization_user',
    inversedBy: 'organizations',
  })
  users = new Collection<User>(this);
}
