import { Collection } from '@mikro-orm/core';
import { Entity, OneToMany, PrimaryKey, Property } from '@mikro-orm/decorators/legacy';

import { OrganizationUser } from 'src/organization/organizationUser.entity';
import { ProjectUser } from 'src/project/projectUser.entity';
import { TeamUser } from 'src/team/teamUser.entity';
import { Organization } from 'src/organization/organization.entity';
import { Project } from 'src/project/project.entity';
import { Team } from 'src/team/team.entity';

@Entity({ schema: 'appcket', tableName: 'user' })
export class User {
  @PrimaryKey({ length: 36, type: 'varchar' })
  id!: string;

  @Property({ type: 'string' })
  email!: string;

  @Property({ type: 'string', fieldName: 'first_name' })
  firstName!: string;

  @Property({ type: 'string', fieldName: 'last_name' })
  lastName!: string;

  @Property({ type: 'string' })
  username!: string;

  @Property({ type: 'json', nullable: true })
  attributes?: any;

  @Property({ type: 'datetime', nullable: true, fieldName: 'last_synced_at' })
  lastSyncedAt?: Date;

  role?: string;

  permissions?: any[];

  @OneToMany({
    entity: () => OrganizationUser,
    mappedBy: 'user',
  })
  organizationUsers = new Collection<OrganizationUser>(this);

  @OneToMany({
    entity: () => ProjectUser,
    mappedBy: 'user',
  })
  projectUsers = new Collection<ProjectUser>(this);

  @OneToMany({
    entity: () => TeamUser,
    mappedBy: 'user',
  })
  teamUsers = new Collection<TeamUser>(this);

  /**
   * Convenience getter to access organizations directly without traversing pivot entities.
   * Returns an array of organizations this user belongs to.
   * Note: organizationUsers must be populated first.
   */
  get organizations(): any[] {
    return this.organizationUsers.toArray().map((ou) => ou.organization);
  }

  /**
   * Convenience getter to access projects directly without traversing pivot entities.
   * Returns an array of projects this user is assigned to.
   * Note: projectUsers must be populated first.
   */
  get projects(): any[] {
    return this.projectUsers.toArray().map((pu) => pu.project);
  }

  /**
   * Convenience getter to access teams directly without traversing pivot entities.
   * Returns an array of teams this user belongs to.
   * Note: teamUsers must be populated first.
   */
  get teams(): any[] {
    return this.teamUsers.toArray().map((tu) => tu.team);
  }
}
