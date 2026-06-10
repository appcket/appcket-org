import { Collection } from '@mikro-orm/core';
import { Entity, ManyToOne, OneToMany, Property } from '@mikro-orm/decorators/legacy';

import { BaseEntity } from 'src/common/entities/base.entity';
import { Organization } from 'src/organization/organization.entity';
import { ProjectUser } from 'src/project/projectUser.entity';

@Entity({ schema: 'appcket', tableName: 'project' })
export class Project extends BaseEntity {
  @Property({ length: 50, type: 'varchar' })
  name!: string;

  @Property({ type: 'text', nullable: true })
  description?: string;

  @ManyToOne({
    entity: () => Organization,
    fieldName: 'organization_id',
    updateRule: 'cascade',
    deleteRule: 'cascade',
  })
  organization!: Organization;

  @OneToMany({
    entity: () => ProjectUser,
    mappedBy: 'project',
  })
  projectUsers = new Collection<ProjectUser>(this);
}
