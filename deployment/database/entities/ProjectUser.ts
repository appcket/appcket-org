import { Entity, ManyToOne, OptionalProps, PrimaryKey, Property } from '@mikro-orm/core';
import { Project } from './Project';

@Entity({ schema: 'appcket' })
export class ProjectUser {
  @PrimaryKey({ columnType: 'uuid', defaultRaw: `gen_random_uuid()` })
  id!: string;

  @ManyToOne({ entity: () => Project, fieldName: 'project_id', onUpdateIntegrity: 'cascade' })
  projectId!: Project;

  @Property({ length: 36 })
  userId!: string;
}
