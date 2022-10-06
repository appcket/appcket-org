import { Entity, ManyToOne, PrimaryKey, Property } from '@mikro-orm/core';
import { Project } from './Project';
import { TaskStatusType } from './TaskStatusType';

@Entity({ schema: 'appcket' })
export class Task {
  @PrimaryKey({ columnType: 'uuid', defaultRaw: `gen_random_uuid()` })
  id!: string;

  @Property({ length: 100 })
  name!: string;

  @Property({ columnType: 'text', length: 500, nullable: true })
  description?: string;

  @Property({ length: 36 })
  assignedTo?: string;

  @ManyToOne({ entity: () => TaskStatusType, fieldName: 'task_status_type_id', onUpdateIntegrity: 'cascade', onDelete: 'set null', nullable: true })
  taskStatusTypeId?: TaskStatusType;

  @ManyToOne({ entity: () => Project, fieldName: 'project_id', onUpdateIntegrity: 'cascade' })
  projectId!: Project;
}
