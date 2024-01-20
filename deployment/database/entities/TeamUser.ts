import { Entity, ManyToOne, Property } from '@mikro-orm/core';
import { BaseEntity } from './Base';
import { Team } from './Team';

@Entity({ schema: 'appcket' })
export class TeamUser extends BaseEntity {
  @ManyToOne({ entity: () => Team, fieldName: 'team_id', updateRule: 'cascade' })
  teamId!: Team;

  @Property({ length: 36 })
  userId!: string;
}
