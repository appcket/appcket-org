import 'reflect-metadata';
import { ObjectType, Field } from '@nestjs/graphql';
import { Collection, Entity, ManyToMany, PrimaryKey, Property } from '@mikro-orm/core';

import { OrganizationUser } from 'src/organization/organizationUser.entity';
import { User } from 'src/user/user.entity';

@ObjectType()
@Entity({ schema: 'appcket' })
export class Organization {
  @Field()
  @PrimaryKey({ columnType: 'uuid', defaultRaw: `gen_random_uuid()` })
  id!: string;

  @Field()
  @Property({ length: 30 })
  name!: string;

  @Field(() => [User])
  @ManyToMany({
    entity: () => User,
    pivotEntity: () => OrganizationUser,
    pivotTable: 'organization_user',
  })
  users = new Collection<User>(this);
}
