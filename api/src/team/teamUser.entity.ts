import { Entity, ManyToOne, Unique } from '@mikro-orm/decorators/legacy';

import { BaseEntity } from '@/common/entities/base.entity';
import { Team } from '@/team/team.entity';
import { User } from '@/user/user.entity';

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
