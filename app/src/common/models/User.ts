import Permission from 'src/common/models/Permission';
import Organization from 'src/common/models/Organization';

export default interface User {
  id?: string;
  user_id: string;
  username: string;
  email: string;
  firstName: string;
  jobTitle: string;
  permissions: Permission[];
  organizations: Organization[];
}
