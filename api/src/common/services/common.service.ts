import { Injectable, NotFoundException } from '@nestjs/common';

import { User } from 'src/user/user.entity';

@Injectable()
export class CommonService {
  public checkEntityExists<T>(entityType: string, entityId: string, entity: T): void {
    if (!entity) {
      throw new NotFoundException(`${entityType} was not found with id: ${entityId}`);
    }
  }

  /**
   * Sorts a collection of objects by the given prop.
   *
   * @param collection the unsorted array of objects.
   * @param sortByProp the property within the each object used to sort the objects by.
   * @returns the original collection but sorted.
   */
  public sortCollection<T>(collection: T[], sortyByProp: string): T[] {
    // Use native Array.sortReturn a new array.
    if (!Array.isArray(collection)) {
      return collection;
    }

    const getValue = (obj: any, path: string): any => {
      if (obj == null || !path) return undefined;
      return path.split('.').reduce((o: any, key: string) => (o != null ? o[key] : undefined), obj);
    };

    return [...collection].sort((a: any, b: any) => {
      const av = getValue(a, sortyByProp);
      const bv = getValue(b, sortyByProp);

      // Treat null/undefined as greater so they appear at the end
      if (av == null && bv == null) return 0;
      if (av == null) return 1;
      if (bv == null) return -1;

      // Date objects
      if (av instanceof Date && bv instanceof Date) return av.getTime() - bv.getTime();

      // Numbers
      if (typeof av === 'number' && typeof bv === 'number') return av - bv;

      // Booleans
      if (typeof av === 'boolean' && typeof bv === 'boolean') return av === bv ? 0 : av ? 1 : -1;

      // Fallback to string comparison
      const aStr = String(av);
      const bStr = String(bv);

      return aStr.localeCompare(bStr);
    });
  }

  public getUserDisplayName(user: User | undefined): string {
    if (user) {
      if (user.firstName && user.lastName) {
        return `${user.firstName} ${user.lastName}`;
      }

      if (user.firstName) {
        return `${user.firstName}`;
      }

      return user.username;
    }

    return '';
  }
}
