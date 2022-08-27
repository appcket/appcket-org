import { find } from 'lodash';

import Permission from 'src/common/models/Permission';

const hasPermission = (userInfoPermissions: Permission[], resource: string, permission: string) => {
  return find(userInfoPermissions, { rsname: resource })?.scopes.includes(permission);
};

export default hasPermission;
