import { Entity, ManyToOne, Property } from '@mikro-orm/core';
import { BaseEntity } from './Base';
import { Organization } from './Organization';

@Entity({ schema: 'appcket' })
export class Project extends BaseEntity {
  @Property({ length: 50 })
  name!: string;

  @Property({ columnType: 'text', length: 500, nullable: true })
  description?: string;

  @ManyToOne({ entity: () => Organization, onUpdateIntegrity: 'cascade' })
  organization!: Organization;
}
