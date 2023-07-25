export interface IChangeAuditEntityHistory {
  createdAt?: Date;
  updatedAt?: Date;
  createdBy?: string;
  updatedBy?: string;
  changes?: [
    {
      fieldName: string;
      oldValue?: string;
      newValue?: string;
      changedBy?: string;
    },
  ];
}
