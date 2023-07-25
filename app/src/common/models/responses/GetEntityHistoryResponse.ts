import EntityHistory from 'src/common/models/EntityHistory';

export default interface GetEntityHistoryResponse extends EntityHistory {
  getEntityHistory: EntityHistory;
}
