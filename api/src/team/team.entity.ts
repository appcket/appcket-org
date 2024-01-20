import { Collection, Entity, OneToMany, OneToOne, ManyToOne, Property } from '@mikro-orm/core';
import { BaseEntity } from 'src/common/entities/base.entity';
import { Organization } from 'src/organization/organization.entity';
import { TeamUser } from 'src/team/teamUser.entity';
import { User } from 'src/user/user.entity';

@Entity({ schema: 'appcket' })
export class Team extends BaseEntity {
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

  @Property({ length: 50 })
  name!: string;

  @Property({ columnType: 'text', length: 500, nullable: true })
  description?: string;

  @ManyToOne({
    entity: () => Organization,
    updateRule: 'cascade',
  })
  organization!: Organization;

  @OneToMany(() => TeamUser, (teamUser) => teamUser.team)
  teamUsers = new Collection<TeamUser>(this);
}
