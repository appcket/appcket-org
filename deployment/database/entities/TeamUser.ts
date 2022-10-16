import { Entity, ManyToOne, PrimaryKey, Property } from '@mikro-orm/core';
import { Team } from './Team';

@Entity({ schema: 'appcket' })
export class TeamUser {
  @PrimaryKey({ columnType: 'uuid', defaultRaw: `gen_random_uuid()` })
  id!: string;

  @ManyToOne({ entity: () => Team, fieldName: 'team_id', onUpdateIntegrity: 'cascade' })
  teamId!: Team;

  @Property({ length: 36 })
  userId!: string;
}
