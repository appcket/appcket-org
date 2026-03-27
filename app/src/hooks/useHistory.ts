import { gql } from 'graphql-request';
import { useApiQuery } from 'src/hooks/useApi';

export enum Resources {
  Organization = 'Organization',
  Team = 'Team',
  Project = 'Project',
  Task = 'Task',
}

export interface IEntityHistoryChange {
  changedAt: string;
  fieldName: string | null;
  oldValue: string | null;
  newValue: string | null;
  changedBy: {
    id: string;
    displayName: string;
  };
}

export interface IEntityHistory {
  id: string;
  createdAt: string;
  updatedAt: string;
  createdBy: {
    id: string;
    displayName: string;
  } | null;
  updatedBy: {
    id: string;
    displayName: string;
  } | null;
  changes: IEntityHistoryChange[];
}

export interface GetEntityHistoryResponse {
  getEntityHistory: IEntityHistory;
}

export const useGetEntityHistory = (entityId: string, entityType: Resources) => {
  const queryKey = ['getEntityHistory', entityId, 'type', entityType];

  return useApiQuery<GetEntityHistoryResponse, IEntityHistory>({
    queryKey,
    query: gql`
      {
        getEntityHistory(id: "${entityId}", type: "${entityType}") {
          id
          createdAt
          updatedAt
          createdBy {
            id
            displayName
          }
          updatedBy {
            id
            displayName
          }
          changes {
            changedAt
            fieldName
            oldValue
            newValue
            changedBy {
              id
              displayName
            }
          }
        }
      }
    `,
    select: (data) => data.getEntityHistory,
  });
};
