import { Entity, ManyToOne, Property } from '@mikro-orm/decorators/legacy';

import { BaseEntity } from 'src/common/entities/base.entity';
import { Project } from 'src/project/project.entity';
import { TaskStatusType } from 'src/taskStatusType/taskStatusType.entity';
import { User } from 'src/user/user.entity';

@Entity({ schema: 'appcket', tableName: 'task' })
export class Task extends BaseEntity {
  @Property({ length: 100, type: 'varchar' })
  name!: string;

  @Property({ type: 'text', nullable: true })
  description?: string;

  @ManyToOne({
    entity: () => User,
    fieldName: 'assigned_to',
    updateRule: 'cascade',
    deleteRule: 'set null',
    nullable: true,
  })
  assignedTo?: User | null;

  @ManyToOne({
    entity: () => TaskStatusType,
    fieldName: 'task_status_type_id',
    updateRule: 'cascade',
    deleteRule: 'set null',
    nullable: true,
  })
  taskStatusType?: TaskStatusType | null;

  @ManyToOne({
    entity: () => Project,
    fieldName: 'project_id',
    updateRule: 'cascade',
    deleteRule: 'cascade',
  })
  project!: Project;
}
