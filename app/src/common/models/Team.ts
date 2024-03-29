import Organization from 'src/common/models/Organization';
import User from 'src/common/models/User';

export default interface Team {
  id: string;
  name: string;
  createdAt: string;
  updatedAt: string;
  description: string;
  organization: Organization;
  users: User[];
}
