import { Entity, ManyToOne, OneToOne } from '@mikro-orm/core';
import { BaseEntity } from 'src/common/entities/base.entity';
import { Project } from 'src/project/project.entity';
import { User } from 'src/user/user.entity';

@Entity({ schema: 'appcket' })
export class ProjectUser extends BaseEntity {
  @OneToOne({
    entity: () => User,
    fieldName: 'created_by',
    updateRule: 'cascade',
    nullable: true,
  })
  createdBy!: User;

  @OneToOne({
    entity: () => User,
    fieldName: 'updated_by',
    updateRule: 'cascade',
    nullable: true,
  })
  updatedBy!: User;

  @OneToOne({
    entity: () => User,
    fieldName: 'deleted_by',
    updateRule: 'cascade',
    nullable: true,
  })
  deletedBy!: User;

  @ManyToOne({ entity: () => Project, updateRule: 'cascade' })
  project!: Project;

  @ManyToOne({ entity: () => User, updateRule: 'cascade' })
  user!: User;
}
