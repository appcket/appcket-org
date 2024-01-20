import { Entity, ManyToOne, Property } from '@mikro-orm/core';
import { BaseEntity } from './Base';
import { Project } from './Project';

@Entity({ schema: 'appcket' })
export class ProjectUser extends BaseEntity {
  @ManyToOne({ entity: () => Project, fieldName: 'project_id', updateRule: 'cascade' })
  projectId!: Project;

  @Property({ length: 36 })
  userId!: string;
}
