import { Entity, Index, ManyToOne, OptionalProps, PrimaryKey, Property } from '@mikro-orm/core';
import { Organization } from './Organization';

@Entity({ schema: 'appcket' })
export class OrganizationUser {
  @Index({ name: 'organization_user_id_idx' })
  @PrimaryKey({ columnType: 'uuid', defaultRaw: `gen_random_uuid()` })
  id!: string;

  @ManyToOne({ entity: () => Organization, fieldName: 'organization_id', onUpdateIntegrity: 'cascade' })
  organizationId!: Organization;

  @Property({ length: 36 })
  userId!: string;
}
