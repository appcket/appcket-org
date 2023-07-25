export interface IEntityHistoryUser {
  id: string;
  displayName: string;
}

export interface IEntityHistoryChange {
  changedAt: string;
  fieldName: string;
  oldValue: string;
  newValue: string;
  changedBy: IEntityHistoryUser;
}

export interface IEntityHistory {
  id: string;
  createdAt: string;
  updatedAt: string;
  createdBy: IEntityHistoryUser;
  updatedBy: IEntityHistoryUser;
  changes?: IEntityHistoryChange[];
}
