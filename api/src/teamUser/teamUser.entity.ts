import { Entity, ManyToOne, PrimaryKey } from '@mikro-orm/core';
import { Team } from 'src/team/team.entity';
import { User } from 'src/user/user.entity';

@Entity({ schema: 'appcket' })
export class TeamUser {
  @PrimaryKey({ columnType: 'uuid', defaultRaw: `gen_random_uuid()` })
  id!: string;

  @ManyToOne({
    entity: () => Team,
    onUpdateIntegrity: 'cascade',
  })
  team!: Team;

  @ManyToOne({ entity: () => User, onUpdateIntegrity: 'cascade' })
  user!: User;
}
