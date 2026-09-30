import { Entity, ManyToOne, Unique } from '@mikro-orm/decorators/legacy';

import { BaseEntity } from '@/common/entities/base.entity';
import { Project } from '@/project/project.entity';
import { User } from '@/user/user.entity';

@Entity({ schema: 'appcket', tableName: 'project_user' })
@Unique({ properties: ['project', 'user'] })
export class ProjectUser extends BaseEntity {
  @ManyToOne({
    entity: () => Project,
    fieldName: 'project_id',
    updateRule: 'cascade',
    deleteRule: 'cascade',
  })
  project!: Project;

  @ManyToOne({
    entity: () => User,
    fieldName: 'user_id',
    updateRule: 'cascade',
    deleteRule: 'cascade',
  })
  user!: User;
}
