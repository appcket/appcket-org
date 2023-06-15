import { Entity, ManyToOne, PrimaryKey } from '@mikro-orm/core';
import { Project } from 'src/project/project.entity';
import { User } from 'src/user/user.entity';

@Entity({ schema: 'appcket' })
export class ProjectUser {
  @PrimaryKey({ columnType: 'uuid', defaultRaw: `gen_random_uuid()` })
  id!: string;

  @ManyToOne({ entity: () => Project, onUpdateIntegrity: 'cascade' })
  project!: Project;

  @ManyToOne({ entity: () => User, onUpdateIntegrity: 'cascade' })
  user!: User;
}
