import { Collection, Entity, ManyToMany, Property } from '@mikro-orm/core';
import { BaseEntity } from './Base';
import { User } from './User';
import { OrganizationUser } from './OrganizationUser';

@Entity({ schema: 'appcket' })
export class Organization extends BaseEntity{
  @Property({ length: 30 })
  name!: string;

  @ManyToMany({
    entity: () => User,
    pivotEntity: () => OrganizationUser,
    pivotTable: 'organization_user',
    inversedBy: 'organizations',
  })
  users = new Collection<User>(this);
}
