import 'reflect-metadata';
import { ObjectType, Field } from '@nestjs/graphql';
import { Collection, Entity, ManyToMany, OneToMany, PrimaryKey, Property } from '@mikro-orm/core';

import { OrganizationUser } from 'src/organization/organizationUser.entity';
import { User } from 'src/user/user.entity';
import { Project } from 'src/project/project.entity';
import { Team } from 'src/team/team.entity';

@ObjectType()
@Entity({ schema: 'appcket' })
export class Organization {
  @Field()
  @PrimaryKey({ columnType: 'uuid', defaultRaw: `gen_random_uuid()` })
  id!: string;

  @Field()
  @Property({ length: 30 })
  name!: string;

  @Field(() => [Project])
  @OneToMany({ entity: () => Project, mappedBy: 'organization' })
  projects = new Collection<Project>(this);

  @Field(() => [Team])
  @OneToMany({ entity: () => Team, mappedBy: 'organization' })
  teams = new Collection<Team>(this);

  @Field(() => [User])
  @ManyToMany({
    entity: () => User,
    pivotEntity: () => OrganizationUser,
    pivotTable: 'organization_user',
  })
  users = new Collection<User>(this);
}
