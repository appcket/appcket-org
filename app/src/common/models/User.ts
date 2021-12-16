import Permission from 'src/common/models/Permission';

export default interface User {
  user_id: string;
  username: string;
  email: string;
  firstName: string;
  jobTitle: string;
  permissions: Permission[]
}
