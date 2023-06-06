import { diff } from 'json-diff-ts';

export class EntityChangesUtil {
  public getEntityChanges(entity1, entity2) {
    let entityDiffs = null;
    const changes = [];

    if (entity1) {
      entityDiffs = diff(entity1, entity2);
    }

    try {
      // if changes are found from a previous version of this entity, then foreach entityDiffs[0].changes, insert a new record into change_audit_change
      if (entityDiffs.length > 0) {
        entityDiffs.forEach((change) => {
          // build a list of changes for this diff
          if (change.changes && change.changes.length > 0) {
            changes.push({
              fieldName: change.key,
              oldValue: entity1[change.key],
              newValue: entity2[change.key],
            });
          } else {
            changes.push({
              fieldName: change.key,
              oldValue: change.oldValue,
              newValue: change.value,
            });
          }
        });
      }

      return {
        changes,
        diffs: entityDiffs,
      };
    } catch (error) {
      throw new Error(error);
    }
  }
}
