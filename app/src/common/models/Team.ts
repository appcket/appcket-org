import Organization from 'src/common/models/Organization';
import User from 'src/common/models/User';

export default interface Team {
  team_id: string;
  name: string;
  created_at: Date;
  updated_at: Date;
  organization: Organization;
  users: User[];
}
