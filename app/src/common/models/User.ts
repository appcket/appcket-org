import Permission from 'src/common/models/Permission';
import Organization from 'src/common/models/Organization';

export default interface User {
  id: string;
  username: string;
  email: string;
  firstName: string;
  lastName: string;
  role: string;
  permissions?: Permission[];
  organizations?: Organization[];
  attributes: [
    {
      name: string;
      value: string;
    },
  ];
}
