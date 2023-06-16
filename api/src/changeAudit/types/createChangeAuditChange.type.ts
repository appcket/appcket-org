export default interface CreateChangeAuditChange {
  appId: string;
  operationType: string;
  entity: {
    id: string;
    type: string;
    data: any;
  };
  user: {
    id: string;
    email?: string;
    displayName?: string;
  };
  timestamp?: Date;
}
