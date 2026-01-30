import { Entity, ManyToOne } from '@mikro-orm/core';
import { BaseEntity } from './Base';
import { Team } from './Team';
import { User } from './User';

@Entity({ schema: 'appcket' })
export class TeamUser extends BaseEntity {
  @ManyToOne({ entity: () => Team, fieldName: 'team_id', updateRule: 'cascade' })
  team!: Team;

  @ManyToOne({ entity: () => User, fieldName: 'user_id', updateRule: 'cascade' })
  user!: User;
}
