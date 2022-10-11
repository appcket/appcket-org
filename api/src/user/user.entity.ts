import { ObjectType, Field } from '@nestjs/graphql';
import { Collection, Entity, ManyToMany, OneToMany, PrimaryKey, Property } from '@mikro-orm/core';

import { Organization } from 'src/organization/organization.entity';
import { OrganizationUser } from 'src/organization/organizationUser.entity';

import { Permission } from 'src/permission/models/permission.model';
import { Project } from 'src/project/project.entity';
import { ProjectUser } from 'src/projectUser/projectUser.entity';
import { Team } from 'src/team/team.entity';
import { TeamUser } from 'src/teamUser/teamUser.entity';
import { UserAttribute } from 'src/user/userAttribute.entity';

@ObjectType()
@Entity({ schema: 'keycloak', tableName: 'user_entity' })
export class User {
  @Field()
  @PrimaryKey({ columnType: 'uuid' })
  id: string;

  @Field()
  @Property({ length: 255 })
  email: string;

  @Field()
  @Property({ length: 255 })
  firstName: string;

  @Field({ nullable: true })
  @Property({ length: 255 })
  lastName: string;

  @Field()
  @Property({ length: 255 })
  username: string;

  @Field(() => [Organization])
  @ManyToMany({
    entity: () => Organization,
    pivotEntity: () => OrganizationUser,
    pivotTable: 'appcket.organization_user',
  })
  organizations = new Collection<Organization>(this);

  @Field(() => [Project])
  @ManyToMany({
    entity: () => Project,
    pivotEntity: () => ProjectUser,
    pivotTable: 'appcket.project_user',
  })
  projects = new Collection<Project>(this);

  @Field(() => [Team])
  @ManyToMany({
    entity: () => Team,
    pivotEntity: () => TeamUser,
    pivotTable: 'appcket.team_user',
  })
  teams = new Collection<Team>(this);

  @Field(() => [UserAttribute])
  @OneToMany({ entity: () => UserAttribute, mappedBy: 'user' })
  attributes = new Collection<UserAttribute>(this);

  @Field(() => [Permission])
  permissions?: Permission[];
}
