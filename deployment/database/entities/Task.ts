import { Entity, ManyToOne, Property } from '@mikro-orm/core';
import { BaseEntity } from './Base';
import { Project } from './Project';
import { TaskStatusType } from './TaskStatusType';

@Entity({ schema: 'appcket' })
export class Task extends BaseEntity {
  @Property({ length: 100 })
  name!: string;

  @Property({ columnType: 'text', length: 500, nullable: true })
  description?: string;

  @Property({ length: 36, nullable: true })
  assignedTo?: string;

  @ManyToOne({ entity: () => TaskStatusType, fieldName: 'task_status_type_id', updateRule: 'cascade', nullable: true })
  taskStatusTypeId!: TaskStatusType;

  @ManyToOne({ entity: () => Project, fieldName: 'project_id', updateRule: 'cascade' })
  projectId!: Project;
}
