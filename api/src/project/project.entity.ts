import 'reflect-metadata';
import { Collection, Entity, OneToMany, ManyToOne, OneToOne, Property } from '@mikro-orm/core';

import { BaseEntity } from 'src/common/entities/base.entity';
import { Organization } from 'src/organization/organization.entity';
import { ProjectUser } from 'src/project/projectUser.entity';
import { User } from 'src/user/user.entity';

@Entity({ schema: 'appcket' })
export class Project extends BaseEntity {
  @OneToOne({
    entity: () => User,
    fieldName: 'created_by',
    onUpdateIntegrity: 'cascade',
    nullable: true,
  })
  createdBy!: User;

  @OneToOne({
    entity: () => User,
    fieldName: 'updated_by',
    onUpdateIntegrity: 'cascade',
    nullable: true,
  })
  updatedBy!: User;

  @OneToOne({
    entity: () => User,
    fieldName: 'deleted_by',
    onUpdateIntegrity: 'cascade',
    nullable: true,
  })
  deletedBy!: User;

  @Property({ length: 50 })
  name!: string;

  @Property({ columnType: 'text', length: 500, nullable: true })
  description: string;

  @ManyToOne({
    entity: () => Organization,
    onUpdateIntegrity: 'cascade',
  })
  organization!: Organization;

  @OneToMany(() => ProjectUser, (projectUser) => projectUser.project)
  projectUsers = new Collection<ProjectUser>(this);
}
