export enum OrganizationPermission {
  create = 'organization:create',
  read = 'organization:read',
  readHistory = 'organization:read:history',
  update = 'organization:update',
  delete = 'organization:delete',
}

export enum ProjectPermission {
  create = 'project:create',
  read = 'project:read',
  readHistory = 'project:read:history',
  update = 'project:update',
  delete = 'project:delete',
}

export enum TeamPermission {
  create = 'team:create',
  read = 'team:read',
  readHistory = 'team:read:history',
  update = 'team:update',
  delete = 'team:delete',
}

export enum TaskPermission {
  create = 'task:create',
  read = 'task:read',
  readHistory = 'task:read:history',
  update = 'task:update',
  delete = 'task:delete',
}
