import { Injectable } from '@nestjs/common';
import { FindOptions } from '@mikro-orm/core';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';
import { Logger } from '@nestjs/common';

import { ChangeAuditChange } from 'src/changeAudit/entities/changeAuditChange.entity';

@Injectable()
export class GetChangeAuditChangeService {
  private readonly logger = new Logger(GetChangeAuditChangeService.name);

  constructor(
    @InjectRepository(ChangeAuditChange)
    private readonly changeAuditChangeRepository: EntityRepository<ChangeAuditChange>,
  ) {}

  public async getChangeAuditChanges(
    changeAuditEntityIds: string[],
    entityType: string,
    findOptions: FindOptions<ChangeAuditChange>,
  ): Promise<ChangeAuditChange[]> {
    return await this.changeAuditChangeRepository.find(
      {
        changeAuditEntity: { $in: changeAuditEntityIds },
        entityType,
      },
      findOptions,
    );
  }
}
