import { Injectable, Inject } from '@nestjs/common';
import { Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { ClickHouseClient } from '@clickhouse/client';

import { EntityHistory } from 'src/entityHistory/entityHistory.entity';
import { ChangeAuditOperationTypes } from 'src/common/enums/changeAuditOperationTypes.enum';
import { UserService } from 'src/user/services/user.service';
import { CommonService } from 'src/common/services/common.service';
import { CLICKHOUSE_CLIENT } from 'src/common/modules/clickhouse.module';
import { EntityChangesUtil } from 'src/common/utils/entityChanges.util';

@Injectable()
export class EntityHistoryService {
  private readonly logger = new Logger(EntityHistoryService.name);
  private entityChangesUtil = new EntityChangesUtil();

  constructor(
    @Inject(CLICKHOUSE_CLIENT)
    private readonly clickhouse: ClickHouseClient,
    private userService: UserService,
    private configService: ConfigService,
    private commonService: CommonService,
  ) {}

  public async getEntitiesHistory(
    entityIds: string[],
    includeChanges: boolean,
    userId: string,
  ): Promise<EntityHistory[]> {
    // High-level summary from ClickHouse
    // We want Min(committed_at) as createdAt and Max(committed_at) as updatedAt for each ID

    if (entityIds.length === 0) return [];

    const query = `
      SELECT 
        entity_id, 
        min(committed_at) as created_at, 
        max(committed_at) as updated_at,
        argMin(user_id, committed_at) as created_by_id,
        argMax(user_id, committed_at) as updated_by_id
      FROM appcket.outbox_events_history
      WHERE entity_id IN ({ids: Array(String)})
      GROUP BY entity_id
    `;

    const resultSet = await this.clickhouse.query({
      query,
      query_params: { ids: entityIds },
      format: 'JSONEachRow',
    });

    const rows = await resultSet.json<any>();

    // Fetch all involved users for display names
    const userIds = new Set<string>();
    rows.forEach((row) => {
      if (row.created_by_id) userIds.add(row.created_by_id);
      if (row.updated_by_id) userIds.add(row.updated_by_id);
    });

    const users = await this.userService.getUsersByIds(Array.from(userIds));

    return rows.map((row) => {
      const createdUser = users.find((u) => u.id === row.created_by_id);
      const updatedUser = users.find((u) => u.id === row.updated_by_id);

      return {
        id: row.entity_id,
        createdAt: new Date(row.created_at),
        updatedAt: new Date(row.updated_at),
        createdBy: {
          id: row.created_by_id,
          displayName: this.commonService.getUserDisplayName(createdUser),
        },
        updatedBy: {
          id: row.updated_by_id,
          displayName: this.commonService.getUserDisplayName(updatedUser),
        },
        changes: [], // Not populating changes for the list view
      };
    });
  }

  public async getEntityHistory(
    entityId: string,
    entityType: string,
    orderBy,
    userId: string,
  ): Promise<EntityHistory> {
    const entityHistory = new EntityHistory();
    entityHistory.id = entityId;

    // Fetch all events for this entity from ClickHouse, sorted by time
    const query = `
      SELECT *
      FROM appcket.outbox_events_history
      WHERE entity_id = {entityId: String} AND entity_type = {entityType: String}
      ORDER BY committed_at ASC
    `;

    const resultSet = await this.clickhouse.query({
      query,
      query_params: {
        entityId,
        entityType: entityType.charAt(0).toUpperCase() + entityType.slice(1), // Ensure proper casing (e.g. 'Task') if needed, or rely on caller
      },
      format: 'JSONEachRow',
    });

    const events = await resultSet.json<any>();

    if (events.length === 0) {
      return entityHistory;
    }

    // 1. Populate Header Metadata (Created/Updated)
    const firstEvent = events[0];
    const lastEvent = events[events.length - 1];

    // Fetch users for header
    const headerUserIds = [firstEvent.user_id, lastEvent.user_id].filter(Boolean);
    const headerUsers = await this.userService.getUsersByIds(headerUserIds);
    const createdByUser = headerUsers.find((u) => u.id === firstEvent.user_id);
    const updatedByUser = headerUsers.find((u) => u.id === lastEvent.user_id);

    entityHistory.createdAt = new Date(firstEvent.committed_at);
    entityHistory.createdBy = {
      id: firstEvent.user_id,
      displayName: this.commonService.getUserDisplayName(createdByUser),
    };

    entityHistory.updatedAt = new Date(lastEvent.committed_at);
    entityHistory.updatedBy = {
      id: lastEvent.user_id,
      displayName: this.commonService.getUserDisplayName(updatedByUser),
    };

    // 2. Compute Diffs (Changes)
    // We will collect all user IDs found in changes to fetch them in bulk
    const changeUserIds = new Set<string>();
    const historyChanges = [];

    for (let i = 0; i < events.length; i++) {
      const currentEvent = events[i];
      const payload = JSON.parse(currentEvent.payload);
      const currentData = payload.entity.data;

      changeUserIds.add(currentEvent.user_id);

      if (i === 0) {
        // Initial Create - everything is "new"
        // We can optionally show this as a big "set everything" change, or skip it.
        // The old logic seemed to create an initial change record.
        // Let's create a "fake" previous empty state to generate the diff.
        const diffResult = this.entityChangesUtil.getEntityChanges({}, currentData);
        if (diffResult.changes.length > 0) {
          diffResult.changes.forEach((c) => {
            historyChanges.push({
              changedAt: new Date(currentEvent.committed_at),
              userId: currentEvent.user_id,
              fieldName: c.fieldName,
              oldValue: c.oldValue,
              newValue: c.newValue,
            });
          });
        }
      } else {
        // Compare with previous
        const previousEvent = events[i - 1];
        const previousPayload = JSON.parse(previousEvent.payload);
        const previousData = previousPayload.entity.data;

        const diffResult = this.entityChangesUtil.getEntityChanges(previousData, currentData);

        if (diffResult.changes.length > 0) {
          diffResult.changes.forEach((c) => {
            historyChanges.push({
              changedAt: new Date(currentEvent.committed_at),
              userId: currentEvent.user_id,
              fieldName: c.fieldName,
              oldValue: JSON.stringify(c.oldValue), // Ensure strings for display
              newValue: JSON.stringify(c.newValue),
            });
          });
        }
      }
    }

    // Bulk fetch users for the changes
    const changeUsers = await this.userService.getUsersByIds(Array.from(changeUserIds));

    // Map to final structure
    entityHistory.changes = historyChanges.map((c) => {
      const user = changeUsers.find((u) => u.id === c.userId);
      return {
        changedAt: c.changedAt,
        fieldName: c.fieldName,
        oldValue: typeof c.oldValue === 'string' ? c.oldValue : JSON.stringify(c.oldValue),
        newValue: typeof c.newValue === 'string' ? c.newValue : JSON.stringify(c.newValue),
        changedBy: {
          id: c.userId,
          displayName: this.commonService.getUserDisplayName(user),
        },
      };
    });

    // Sort changes DESC (newest first)
    entityHistory.changes.sort((a, b) => b.changedAt.getTime() - a.changedAt.getTime());

    return entityHistory;
  }
}
