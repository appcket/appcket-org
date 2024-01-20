import { Collection, Entity, ManyToMany, OneToMany, PrimaryKey, Property } from '@mikro-orm/core';

import { Organization } from 'src/organization/organization.entity';
import { OrganizationUser } from 'src/organization/organizationUser.entity';

import { Permission } from 'src/permission/permission.model';
import { Project } from 'src/project/project.entity';
import { ProjectUser } from 'src/project/projectUser.entity';
import { Team } from 'src/team/team.entity';
import { TeamUser } from 'src/team/teamUser.entity';
import { UserAttribute } from 'src/user/userAttribute.entity';

@Entity({ schema: 'keycloak', tableName: 'user_entity' })
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

  @Property({ length: 255, persist: false })
  role: string;

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

  @OneToMany({ entity: () => UserAttribute, mappedBy: 'user' })
  attributes = new Collection<UserAttribute>(this);

  permissions?: Permission[];
}
