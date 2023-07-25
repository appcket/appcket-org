import { gql } from 'graphql-request';
import { UseQueryResult } from '@tanstack/react-query';

import { useApiQuery } from 'src/common/api';
import GetEntityHistoryResponse from 'src/common/models/responses/GetEntityHistoryResponse';
import { IEntityHistory } from 'src/common/models/EntityHistory';

export const useGetEntityHistory = (entityHistoryId: string): UseQueryResult<IEntityHistory> => {
  const queryKey = ['getEntityHistory', entityHistoryId];
  const processData = (data: GetEntityHistoryResponse): IEntityHistory => {
    return data.getEntityHistory;
  };

  return useApiQuery(
    queryKey,
    gql`
      {
        ${queryKey[0]}(id: "${entityHistoryId}") {
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
