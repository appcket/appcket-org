import Permission from 'src/common/models/Permission';

const hasPermission = (
  userInfoPermissions: Permission[] = [],
  resource: string,
  permission: string,
) => {
  const entry = userInfoPermissions.find((p) => p?.rsname === resource);
  return !!entry?.scopes?.includes(permission);
};

export default hasPermission;
