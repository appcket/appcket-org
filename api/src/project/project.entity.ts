import 'reflect-metadata';
import { ObjectType, Field } from '@nestjs/graphql';
import { Collection, Entity, ManyToMany, ManyToOne, Property } from '@mikro-orm/core';

import { BaseEntity } from 'src/common/entities/base.entity';
import { Organization } from 'src/organization/organization.entity';
import { ProjectUser } from 'src/project/projectUser.entity';
import { User } from 'src/user/user.entity';

@ObjectType()
@Entity({ schema: 'appcket' })
export class Project extends BaseEntity {
  @Field()
  @Property({ length: 50 })
  name!: string;

  @Property({ columnType: 'text', length: 500, nullable: true })
  description: string;

  @ManyToOne({
    entity: () => Organization,
    onUpdateIntegrity: 'cascade',
  })
  organization!: Organization;

  @ManyToMany({
    entity: () => User,
    pivotEntity: () => ProjectUser,
    pivotTable: 'project_user',
    inversedBy: 'projects',
  })
  users = new Collection<User>(this);
}
