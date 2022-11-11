import { Entity, Index, ManyToOne, PrimaryKey } from '@mikro-orm/core';
import { Organization } from './organization.entity';
import { User } from 'src/user/user.entity';

@Entity({ schema: 'appcket' })
export class OrganizationUser {
  @Index({ name: 'organization_user_id_idx' })
  @PrimaryKey({ columnType: 'uuid', defaultRaw: `gen_random_uuid()` })
  id!: string;

  @ManyToOne({
    entity: () => Organization,
    fieldName: 'organization_id',
    onUpdateIntegrity: 'cascade',
  })
  organizationId!: Organization;

  @ManyToOne({ entity: () => User, fieldName: 'user_id', onUpdateIntegrity: 'cascade' })
  userId!: User;
}
