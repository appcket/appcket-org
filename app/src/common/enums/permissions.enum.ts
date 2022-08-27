export enum OrganizationPermission {
  create = `organization:create`,
  read = 'organization:read',
  update = 'organization:update',
  delete = 'organization:delete',
}

export enum ProjectPermission {
  create = `project:create`,
  read = 'project:read',
  update = 'project:update',
  delete = 'project:delete',
}

export enum TeamPermission {
  create = 'team:create',
  read = 'team:read',
  update = 'team:update',
  delete = 'team:delete',
}

export enum TaskPermission {
  create = 'task:create',
  read = 'task:read',
  update = 'task:update',
  delete = 'task:delete',
}
