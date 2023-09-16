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

  @Property({ length: 100 })
  name!: string;

  @Property({ columnType: 'text', length: 5000, nullable: true })
  description?: string;

  @OneToOne({
    entity: () => User,
    fieldName: 'assigned_to',
    onUpdateIntegrity: 'cascade',
    nullable: true,
  })
  assignedTo!: User;

  @ManyToOne({
    entity: () => TaskStatusType,
    onUpdateIntegrity: 'cascade',
    onDelete: 'set null',
    nullable: true,
  })
  taskStatusType!: TaskStatusType;

  @ManyToOne({ entity: () => Project, onUpdateIntegrity: 'cascade' })
  project!: Project;
}
