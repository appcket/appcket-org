import { Entity, Index, ManyToOne, PrimaryKey, Property } from '@mikro-orm/core';
import { BaseEntity } from './Base';
import { Organization } from './Organization';

@Entity({ schema: 'appcket' })
export class OrganizationUser extends BaseEntity {
  @Index({ name: 'organization_user_id_idx' })
  @PrimaryKey({ columnType: 'uuid', defaultRaw: `gen_random_uuid()` })
  id!: string;

  @ManyToOne({ entity: () => Organization, onUpdateIntegrity: 'cascade' })
  organization!: Organization;

  @Property({ length: 36 })
  userId!: string;
}
