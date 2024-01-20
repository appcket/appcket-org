import { Entity, ManyToOne, OneToOne, Property } from '@mikro-orm/core';

import { BaseEntity } from 'src/common/entities/base.entity';
import { Project } from 'src/project/project.entity';
import { TaskStatusType } from 'src/taskStatusType/taskStatusType.entity';
import { User } from 'src/user/user.entity';

@Entity({ schema: 'appcket' })
export class Task extends BaseEntity {
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

  @Property({ length: 100 })
  name!: string;

  @Property({ columnType: 'text', length: 5000, nullable: true })
  description?: string;

  @OneToOne({
    entity: () => User,
    fieldName: 'assigned_to',
    updateRule: 'cascade',
    nullable: true,
  })
  assignedTo!: User;

  @ManyToOne({
    entity: () => TaskStatusType,
    updateRule: 'cascade',
    deleteRule: 'set null',
    nullable: true,
  })
  taskStatusType!: TaskStatusType;

  @ManyToOne({ entity: () => Project, updateRule: 'cascade' })
  project!: Project;
}
