import { ObjectType, Field } from '@nestjs/graphql';
import { Entity, ManyToOne, PrimaryKey, Property } from '@mikro-orm/core';

import { User } from 'src/user/user.entity';

@ObjectType()
@Entity({ schema: 'keycloak', tableName: 'user_attribute' })
export class UserAttribute {
  @Field()
  @PrimaryKey({ length: 36 })
  id!: string;

  @Field()
  @Property({ length: 255 })
  name!: string;

  @Field()
  @Property({ length: 255 })
  value!: string;

  @ManyToOne({
    entity: () => User,
    onUpdateIntegrity: 'cascade',
  })
  user!: User;
}
