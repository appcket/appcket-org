import { Entity, ManyToOne, Unique } from '@mikro-orm/decorators/legacy';

import { BaseEntity } from 'src/common/entities/base.entity';
import { Team } from 'src/team/team.entity';
import { User } from 'src/user/user.entity';

@Entity({ schema: 'appcket', tableName: 'team_user' })
@Unique({ properties: ['team', 'user'] })
export class TeamUser extends BaseEntity {
  @ManyToOne({
    entity: () => Team,
    fieldName: 'team_id',
    updateRule: 'cascade',
    deleteRule: 'cascade',
  })
  team!: Team;

  @ManyToOne({
    entity: () => User,
    fieldName: 'user_id',
    updateRule: 'cascade',
    deleteRule: 'cascade',
  })
  user!: User;
}
