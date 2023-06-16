import 'reflect-metadata';
import { ObjectType, Field } from '@nestjs/graphql';
import { Collection, Entity, ManyToMany, ManyToOne, PrimaryKey, Property } from '@mikro-orm/core';

import { Organization } from 'src/organization/organization.entity';
import { ProjectUser } from 'src/projectUser/projectUser.entity';
import { User } from 'src/user/user.entity';

@ObjectType()
@Entity({ schema: 'appcket' })
export class Project {
  @Field()
  @PrimaryKey({ columnType: 'uuid', defaultRaw: `gen_random_uuid()` })
  id!: string;

  @Field()
  @Property({ length: 50 })
  name!: string;

  @Field({ nullable: true })
  @Property({ columnType: 'text', length: 500, nullable: true })
  description: string;

  @Field(() => Organization)
  @ManyToOne({
    entity: () => Organization,
    onUpdateIntegrity: 'cascade',
  })
  organization!: Organization;

  @Field(() => [User])
  @ManyToMany({
    entity: () => User,
    pivotEntity: () => ProjectUser,
    pivotTable: 'project_user',
    inversedBy: 'projects',
  })
  users = new Collection<User>(this);
}
