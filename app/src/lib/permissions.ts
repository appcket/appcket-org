import { redirect } from '@tanstack/react-router';
import { notifications } from '@mantine/notifications';
import * as m from 'src/paraglide/messages';

export interface Permission {
  rsname: string;
  scopes: string[];
}

/**
 * Checks if a user has a specific permission for a resource.
 */
export function hasPermission(
  permissions: Permission[] | undefined,
  resource: string,
  scope: string,
): boolean {
  if (!permissions) return false;

  const resourcePermission = permissions.find((p) => p.rsname === resource);
  if (!resourcePermission) return false;

  return resourcePermission.scopes.includes(scope);
}

/**
 * A reusable beforeLoad guard for TanStack Router.
 */
export const requirePermission = (resource: string, scope: string, fallback = '/') => {
  return ({ context }: { context: any }) => {
    const user = context?.session?.user;
    const isAuthorized = hasPermission(user?.permissions, resource, scope);

    if (!isAuthorized) {
      throw redirect({
        to: fallback as any,
        search: (prev: any) => ({
          ...prev,
          flash: 'unauthorized',
        }),
      });
    }
  };
};

export const TeamPermission = {
  read: 'team:read',
  update: 'team:update',
  delete: 'team:delete',
  create: 'team:create',
  readHistory: 'team:read:history',
};

export const ProjectPermission = {
  read: 'project:read',
  update: 'project:update',
  delete: 'project:delete',
  create: 'project:create',
  readHistory: 'project:read:history',
};

export const TaskPermission = {
  read: 'task:read',
  update: 'task:update',
  delete: 'task:delete',
  create: 'task:create',
  readHistory: 'task:read:history',
};
