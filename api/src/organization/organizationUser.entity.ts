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
    onUpdateIntegrity: 'cascade',
  })
  organization!: Organization;

  @ManyToOne()
  user!: User;
}
