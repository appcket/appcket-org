import { Entity, ManyToOne, OneToOne } from '@mikro-orm/core';

import { BaseEntity } from 'src/common/entities/base.entity';
import { Team } from 'src/team/team.entity';
import { User } from 'src/user/user.entity';

@Entity({ schema: 'appcket' })
export class TeamUser extends BaseEntity {
  @OneToOne({
    entity: () => User,
    fieldName: 'created_by',
    updateRule: 'cascade',
    nullable: true,
  })
  createdBy!: User;

  @OneToOne({
    entity: () => User,
    fieldName: 'updated_by',
    updateRule: 'cascade',
    nullable: true,
  })
  updatedBy!: User;

  @OneToOne({
    entity: () => User,
    fieldName: 'deleted_by',
    updateRule: 'cascade',
    nullable: true,
  })
  deletedBy!: User;

  @ManyToOne({ entity: () => Team, updateRule: 'cascade' })
  team!: Team;

  @ManyToOne({ entity: () => User, updateRule: 'cascade' })
  user!: User;
}
