import { Entity, ManyToOne, OptionalProps, PrimaryKey, Property } from '@mikro-orm/core';
import { Organization } from './Organization';

@Entity({ schema: 'appcket' })
export class Project {
  @PrimaryKey({ columnType: 'uuid', defaultRaw: `gen_random_uuid()` })
  id!: string;

  @Property({ length: 50 })
  name!: string;

  @Property({ columnType: 'text', length: 500, nullable: true })
  description?: string;

  @ManyToOne({ entity: () => Organization, fieldName: 'organization_id', onUpdateIntegrity: 'cascade' })
  organizationId!: Organization;
}
