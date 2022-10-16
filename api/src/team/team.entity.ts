import { ObjectType, Field } from '@nestjs/graphql';
import { Collection, Entity, ManyToMany, ManyToOne, PrimaryKey, Property } from '@mikro-orm/core';

import { Organization } from 'src/organization/organization.entity';
import { TeamUser } from 'src/teamUser/teamUser.entity';
import { User } from 'src/user/user.entity';

@ObjectType()
@Entity({ schema: 'appcket' })
export class Team {
  @Field()
  @PrimaryKey({ columnType: 'uuid', defaultRaw: `gen_random_uuid()` })
  id!: string;

  @Field()
  @Property({ length: 50 })
  name!: string;

  @Field()
  @Property({ columnType: 'text', length: 500, nullable: true })
  description?: string;

  @Field(() => Organization)
  @ManyToOne({
    entity: () => Organization,
    fieldName: 'organization_id',
    onUpdateIntegrity: 'cascade',
  })
  organization!: Organization;

  @Field(() => [User])
  @ManyToMany({
    entity: () => User,
    pivotEntity: () => TeamUser,
    pivotTable: 'team_user',
  })
  users = new Collection<User>(this);
}
