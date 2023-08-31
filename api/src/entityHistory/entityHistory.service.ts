import { Injectable } from '@nestjs/common';
import { Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

import { EntityHistory } from 'src/entityHistory/entityHistory.entity';
import { ChangeAuditOperationTypes } from 'src/common/enums/changeAuditOperationTypes.enum';
import { GetChangeAuditEntityService } from 'src/changeAudit/services/getChangeAuditEntity.service';
import { GetChangeAuditChangeService } from 'src/changeAudit/services/getChangeAuditChange.service';
import { UserService } from 'src/user/services/user.service';
import { CommonService } from 'src/common/services/common.service';

@Injectable()
export class EntityHistoryService {
  private readonly logger = new Logger(EntityHistoryService.name);

  constructor(
    private getChangeAuditEntityService: GetChangeAuditEntityService,
    private getChangeAuditChangeService: GetChangeAuditChangeService,
    private userService: UserService,
    private configService: ConfigService,
    private commonService: CommonService,
  ) {}

  public async getEntitiesHistory(
    entityIds: string[],
    includeChanges: boolean,
    userId: string,
  ): Promise<EntityHistory[]> {
    const appId = this.configService.get('appId');
    const entitiesHistory: EntityHistory[] = [];

    // get id: createdAt, updatedAt, createdBy, updatedBy for each entityId
    const entities = await this.getChangeAuditEntityService.getChangeAuditEntities(
      appId,
      entityIds,
    );

    const userIds = entities.map((emtity) => emtity.userId);
    const users = await this.userService.getUsersByIds(userIds);

    // group entities by entityId
    /*
    [
      {
        entityId: 'fsdafsda',
        createdAt: '',
        updatedAt: '',
        createdBy: {},
        updatedBy: {},
      }
    ]
    */

    entities.map((entity) => {
      const foundUser = users.find((user) => entity.userId === user.id);
      const displayName = this.commonService.getUserDisplayName(foundUser);
      const entityHistoryItem = entitiesHistory.find(({ id }) => id === entity.entityId);
      if (!entityHistoryItem) {
        if (entity.operationType.id === ChangeAuditOperationTypes.Create) {
          entitiesHistory.push({
            id: entity.entityId,
            createdAt: entity.createdAt,
            createdBy: {
              id: entity.userId,
              displayName,
            },
            updatedAt: null,
            updatedBy: null,
          });
        } else {
          entitiesHistory.push({
            id: entity.entityId,
            createdAt: null,
            createdBy: null,
            updatedAt: entity.createdAt,
            updatedBy: {
              id: entity.userId,
              displayName,
            },
          });
        }
      } else {
        if (entity.operationType.id === ChangeAuditOperationTypes.Update) {
          entityHistoryItem.updatedAt = entity.createdAt;
          entityHistoryItem.updatedBy = {
            id: entity.userId,
            displayName,
          };
        }
      }
    });

    return entitiesHistory;
  }

  public async getEntityHistory(entityId: string, orderBy, userId: string): Promise<EntityHistory> {
    const appId = this.configService.get('appId');
    const entityHistory = new EntityHistory();
    entityHistory.id = entityId;

    // get the oldest version of this entity
    const oldestEntity = await this.getChangeAuditEntityService.getChangeAuditEntity(
      appId,
      entityId,
      ChangeAuditOperationTypes.Create,
      {
        orderBy: { createdAt: 1 },
      },
    );

    // get the most recent version of this entity
    const newestEntity = await this.getChangeAuditEntityService.getChangeAuditEntity(
      appId,
      entityId,
      ChangeAuditOperationTypes.Update,
      {
        orderBy: { createdAt: -1 },
      },
    );

    if (oldestEntity !== null) {
      this.logger.log(
        `Retrieved entity for createdAt successfully. app_id: ${appId} entity_id: ${entityId}`,
      );

      if (oldestEntity.userId) {
        const user = await this.userService.getUser(oldestEntity.userId);
        entityHistory.createdBy.id = oldestEntity.userId;
        entityHistory.createdBy.displayName = this.commonService.getUserDisplayName(user);
      }

      entityHistory.createdAt = oldestEntity.createdAt;
    }

    if (newestEntity !== null) {
      this.logger.log(
        `Retrieved entity for updatedAt successfully. app_id: ${appId} entity_id: ${entityId}`,
      );

      if (newestEntity.userId) {
        const user = await this.userService.getUser(newestEntity.userId);
        entityHistory.updatedBy.id = newestEntity.userId;
        entityHistory.updatedBy.displayName = this.commonService.getUserDisplayName(user);
      }

      entityHistory.updatedAt = newestEntity.createdAt;
    }

    // get all versions of this entity
    const allEntityVersions =
      await this.getChangeAuditEntityService.getAllChangeAuditEntityVersions(appId, entityId, {
        orderBy: { createdAt: -1 },
      });

    const entityIds = allEntityVersions.map((ent) => ent.id);

    // get all changes for this entity
    const changes = await this.getChangeAuditChangeService.getChangeAuditChanges(entityIds, {
      orderBy: { createdAt: -1 },
    });

    const changeUserIds = changes.map((change) => change.userId);
    const changeUsers = await this.userService.getUsersByIds(changeUserIds);

    entityHistory.changes = changes.map((change) => {
      const foundUser = changeUsers.find((user) => change.userId === user.id);
      const displayName = this.commonService.getUserDisplayName(foundUser);
      return {
        changedAt: change.createdAt,
        fieldName: change.fieldName,
        oldValue: change.oldValue,
        newValue: change.newValue,
        changedBy: {
          id: change.userId,
          displayName,
        },
      };
    });

    return entityHistory;
  }
}
