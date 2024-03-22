import { Injectable } from '@nestjs/common';
import { EntityManager } from '@mikro-orm/core';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';
import { Logger } from '@nestjs/common';

import { CreateChangeAuditChange } from 'src/changeAudit/types/createChangeAuditChange.type';
import { ChangeAuditChange } from 'src/changeAudit/entities/changeAuditChange.entity';
import { ChangeAuditEntity } from 'src/changeAudit/entities/changeAuditEntity.entity';
import { EntityChangesUtil } from 'src/changeAudit/utils/entityChanges.util';
import { ChangeAuditOperationTypes } from 'src/common/enums/changeAuditOperationTypes.enum';

@Injectable()
export class CreateChangeAuditChangeService {
  private readonly logger = new Logger(CreateChangeAuditChangeService.name);
  private entityChangesUtil = new EntityChangesUtil();

  constructor(
    private readonly em: EntityManager,
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
        appId: data.appId,
        entityId: data.entity.id,
        entityType: data.entity.type,
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

    // this entity has no changes (user just sent in the same object as before), so do not need to save anything
    if (
      diffResult.changes.length === 0 &&
      diffResult.diffs?.length === 0 &&
      data.operationType === ChangeAuditOperationTypes.Update
    ) {
      return;
    }

    // insert most recent version of this entity
    const entity = this.changeAuditEntityRepository.create({
      // external users pass in entity.id, but internally store this in the entityId column
      entityId: data.entity.id,
      entityType: data.entity.type,
      appId: data.appId,
      operationType: data.operationType.toLowerCase(),
      userId: data.user.id,
      userEmail: data.user.email,
      userDisplayName: data.user.displayName,
      entity: data.entity,
      diff: diffResult.diffs,
    });

    await this.em.persistAndFlush(entity);

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
          entityType: entity.entityType,
          changeAuditEntity: entity.id,
          userId: data.user.id,
          userEmail: data.user.email,
          userDisplayName: data.user.displayName,
          fieldName: change.fieldName,
          oldValue,
          newValue,
        });

        this.em.persist(newChange);
      });
    } else {
      // if no changes found for this entity, then insert an initial baseline change for the newly created entity
      const newChange = this.changeAuditChangeRepository.create({
        entityId: entity.entityId,
        entityType: entity.entityType,
        changeAuditEntity: entity.id,
        userId: data.user.id,
        userEmail: data.user.email,
        userDisplayName: data.user.displayName,
        fieldName: null,
        oldValue: null,
        newValue: JSON.stringify(entity.entity['data']),
      });

      this.em.persist(newChange);
    }
    await this.em.flush();
  }
}
