import { Entity, ManyToOne, PrimaryKey, Property } from '@mikro-orm/core';
import { Project } from 'src/project/project.entity';

@Entity({ schema: 'appcket' })
export class ProjectUser {
  @PrimaryKey({ columnType: 'uuid', defaultRaw: `gen_random_uuid()` })
  id!: string;

  @ManyToOne({ entity: () => Project, fieldName: 'project_id', onUpdateIntegrity: 'cascade' })
  projectId!: Project;

  @Property({ columnType: 'uuid' })
  userId!: string;
}
