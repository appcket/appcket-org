import { Collection, Entity, ManyToMany, OneToMany, PrimaryKey, Property } from '@mikro-orm/core';

import { Organization } from './Organization';
import { OrganizationUser } from './OrganizationUser';
import { Project } from './Project';
import { ProjectUser } from './ProjectUser';
import { Team } from './Team';
import { TeamUser } from './TeamUser';

@Entity({ schema: 'appcket' })
export class User {
  @PrimaryKey({ length: 36 })
  id: string;

  @Property({ length: 255 })
  email: string;

  @Property({ length: 255 })
  firstName: string;

  @Property({ length: 255 })
  lastName: string;

  @Property({ length: 255 })
  username: string;

  @Property({ columnType: 'jsonb', nullable: true })
  attributes?: any;

  @Property({ nullable: true })
  lastSyncedAt?: Date;

  @ManyToMany({
    entity: () => Organization,
    pivotEntity: () => OrganizationUser,
    pivotTable: 'appcket.organization_user',
    mappedBy: 'users',
  })
  organizations = new Collection<Organization>(this);

  @OneToMany(() => ProjectUser, (projectUser) => projectUser.user)
  projects = new Collection<Project>(this);

  @OneToMany(() => TeamUser, (teamUser) => teamUser.user)
  teams = new Collection<Team>(this);
}
