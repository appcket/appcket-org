import { Collection } from '@mikro-orm/core';
import { Entity, OneToMany, ManyToOne, Property } from '@mikro-orm/decorators/legacy';
import { BaseEntity } from 'src/common/entities/base.entity';
import { Organization } from 'src/organization/organization.entity';
import { TeamUser } from 'src/team/teamUser.entity';

@Entity({ schema: 'appcket', tableName: 'team' })
export class Team extends BaseEntity {
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
    entity: () => TeamUser,
    mappedBy: 'team',
  })
  teamUsers = new Collection<TeamUser>(this);
}
