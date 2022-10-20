import Organization from 'src/common/models/Organization';
import User from 'src/common/models/User';

export default interface Project {
  id: string;
  name: string;
  description: string;
  organization: Organization;
  users: User[];
}
