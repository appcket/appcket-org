import { IEntityHistory } from 'src/common/models/EntityHistory';

export default interface GetEntityHistoryResponse extends IEntityHistory {
  getEntityHistory: IEntityHistory;
}
