import { Entity, Index, ManyToOne, PrimaryKey } from '@mikro-orm/core';
import { BaseEntity } from './Base';
import { Organization } from './Organization';
import { User } from './User';

@Entity({ schema: 'appcket' })
export class OrganizationUser extends BaseEntity {
  @PrimaryKey({ columnType: 'uuid', defaultRaw: `gen_random_uuid()` })
  id!: string;

  @ManyToOne({ entity: () => Organization, updateRule: 'cascade' })
  organization!: Organization;

  @ManyToOne({ entity: () => User, fieldName: 'user_id', updateRule: 'cascade' })
  user!: User;
}
