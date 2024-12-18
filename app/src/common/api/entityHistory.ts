import { gql } from 'graphql-request';

import { useApiQuery } from 'src/common/api';
import Resources from 'src/common/enums/Resources';
import GetEntityHistoryResponse from 'src/common/models/responses/GetEntityHistoryResponse';
import { IEntityHistory } from 'src/common/models/EntityHistory';

export const useGetEntityHistory = (entityHistoryId: string, entityType: Resources) => {
  const queryKey = ['getEntityHistory', entityHistoryId, 'type', entityType];
  const processData = (data: GetEntityHistoryResponse): IEntityHistory => {
    return data.getEntityHistory;
  };

  return useApiQuery(
    queryKey,
    gql`
      {
        ${queryKey[0]}(id: "${entityHistoryId}", type: "${entityType}") {
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
    processData,
  );
};
