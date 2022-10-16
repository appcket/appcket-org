import { Entity, ManyToOne, OptionalProps, PrimaryKey, Property } from '@mikro-orm/core';
import { Team } from 'src/team/team.entity';

@Entity({ schema: 'appcket' })
export class TeamUser {
  @PrimaryKey({ columnType: 'uuid', defaultRaw: `gen_random_uuid()` })
  id!: string;

  @ManyToOne({ entity: () => Team, fieldName: 'team_id', onUpdateIntegrity: 'cascade' })
  teamId!: Team;

  @Property({ columnType: 'uuid' })
  userId!: string;
}
