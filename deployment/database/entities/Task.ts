import { Entity, ManyToOne, Property } from '@mikro-orm/core';
import { BaseEntity } from './Base';
import { Project } from './Project';
import { TaskStatusType } from './TaskStatusType';
import { User } from './User';

@Entity({ schema: 'appcket' })
export class Task extends BaseEntity {
  @Property({ length: 100 })
  name!: string;

  @Property({ columnType: 'text', length: 500, nullable: true })
  description?: string;

  @ManyToOne({ entity: () => User, fieldName: 'assigned_to', updateRule: 'cascade', nullable: true })
  assignedTo?: User;

  @ManyToOne({ entity: () => TaskStatusType, fieldName: 'task_status_type_id', updateRule: 'cascade', nullable: true })
  taskStatusTypeId!: TaskStatusType;

  @ManyToOne({ entity: () => Project, fieldName: 'project_id', updateRule: 'cascade' })
  projectId!: Project;
}
