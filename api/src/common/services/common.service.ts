import { Injectable, NotFoundException } from '@nestjs/common';

@Injectable()
export class CommonService {
  public checkEntityExists<T>(entityType: string, entityId: string, entity: T): void {
    if (!entity) {
      throw new NotFoundException(`${entityType} was not found with id: ${entityId}`);
    }
  }
}
