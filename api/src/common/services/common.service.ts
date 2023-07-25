import { Injectable, NotFoundException } from '@nestjs/common';
import { sortBy } from 'lodash';

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
    return sortBy(collection, [sortyByProp]);
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
