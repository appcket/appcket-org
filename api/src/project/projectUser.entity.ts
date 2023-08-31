import { Entity, ManyToOne } from '@mikro-orm/core';
import { BaseEntity } from 'src/common/entities/base.entity';
import { Project } from 'src/project/project.entity';
import { User } from 'src/user/user.entity';

@Entity({ schema: 'appcket' })
export class ProjectUser extends BaseEntity {
  @ManyToOne({ entity: () => Project, onUpdateIntegrity: 'cascade' })
  project!: Project;

  @ManyToOne({ entity: () => User, onUpdateIntegrity: 'cascade' })
  user!: User;
}
