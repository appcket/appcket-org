import { Entity, ManyToOne } from '@mikro-orm/core';
import { BaseEntity } from './Base';
import { Project } from './Project';
import { User } from './User';

@Entity({ schema: 'appcket' })
export class ProjectUser extends BaseEntity {
  @ManyToOne({ entity: () => Project, fieldName: 'project_id', updateRule: 'cascade' })
  project!: Project;

  @ManyToOne({ entity: () => User, fieldName: 'user_id', updateRule: 'cascade' })
  user!: User;
}
