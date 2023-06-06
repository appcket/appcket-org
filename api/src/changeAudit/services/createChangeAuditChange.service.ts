import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';
import { Logger } from '@nestjs/common';

import CreateChangeAuditChange from 'src/changeAudit/types/createChangeAuditChange.type';
import { ChangeAuditChange } from 'src/changeAudit/entities/changeAuditChange.entity';
import { ChangeAuditEntity } from 'src/changeAudit/entities/changeAuditEntity.entity';
import { EntityChangesUtil } from 'src/common/utils/entityChanges.util';

@Injectable()
export class CreateChangeAuditChangeService {
  private readonly logger = new Logger(CreateChangeAuditChangeService.name);
  private entityChangesUtil = new EntityChangesUtil();

  constructor(
    @InjectRepository(ChangeAuditChange)
    private readonly changeAuditChangeRepository: EntityRepository<ChangeAuditChange>,
    @InjectRepository(ChangeAuditEntity)
    private readonly changeAuditEntityRepository: EntityRepository<ChangeAuditEntity>,
  ) {}

  private isObjectOrArray(data): boolean {
    return data && (data.constructor.name == 'Object' || data.constructor.name == 'Array');
  }

  public async createChange(data: CreateChangeAuditChange) {
    // get the most recent version of this entity
    const previousEntity = await this.changeAuditEntityRepository.findOne(
      {
        entityId: data.entity.id,
        appId: data.appId,
      },
      {
        orderBy: { createdAt: -1 },
      },
    );

    let diffResult = {
      changes: [],
      diffs: null,
    };

    if (previousEntity) {
      diffResult = this.entityChangesUtil.getEntityChanges(
        previousEntity.entity['data'],
        data.entity.data,
      );
    }

    // insert most recent version of this entity
    const entity = this.changeAuditEntityRepository.create({
      // external users pass in entity.id, but internally store this in the entityId column
      entityId: data.entity.id,
      appId: data.appId,
      userId: data.user.id,
      userEmail: data.user.email,
      userDisplayName: data.user.displayName,
      entity: JSON.stringify(data.entity),
      diff: diffResult.diffs,
    });

    await this.changeAuditEntityRepository.persistAndFlush(entity);

    // if changes are found from a previous version of this entity, then foreach diffResult.changes, insert a new record into change_audit_change
    if (diffResult.changes.length > 0) {
      diffResult.changes.forEach((change) => {
        const oldValue = this.isObjectOrArray(change.oldValue)
          ? JSON.stringify(change.oldValue)
          : change.oldValue;
        const newValue = this.isObjectOrArray(change.newValue)
          ? JSON.stringify(change.newValue)
          : change.newValue;

        const newChange = this.changeAuditChangeRepository.create({
          entityId: entity.entityId,
          changeAuditEntityId: entity.id,
          operationTypeId: data.operationType.toLowerCase(),
          userId: data.user.id,
          userEmail: data.user.email,
          userDisplayName: data.user.displayName,
          fieldName: change.fieldName,
          oldValue,
          newValue,
        });

        this.changeAuditChangeRepository.persist(newChange);
      });

      await this.changeAuditChangeRepository.flush();
    }
  }
}
