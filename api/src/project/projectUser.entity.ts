import { Entity, ManyToOne, OneToOne } from '@mikro-orm/core';
import { BaseEntity } from 'src/common/entities/base.entity';
import { Project } from 'src/project/project.entity';
import { User } from 'src/user/user.entity';

@Entity({ schema: 'appcket' })
export class ProjectUser extends BaseEntity {
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

  @ManyToOne({ entity: () => Project, onUpdateIntegrity: 'cascade' })
  project!: Project;

  @ManyToOne({ entity: () => User, onUpdateIntegrity: 'cascade' })
  user!: User;
}
