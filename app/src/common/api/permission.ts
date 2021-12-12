import { gql } from 'graphql-request';
import { UseQueryResult } from 'react-query';

import { useApiQuery } from 'src/common/api';
import HasPermissionQueryResponse from 'src/common/models/responses/HasPermissionQueryResponse';

export const useHasPermission = (
  permissions: string[],
): UseQueryResult<HasPermissionQueryResponse> => {
  const queryName = 'hasPermission';
  const processData = (data: HasPermissionQueryResponse): boolean => {
    return data.hasPermission;
  };

  // permissions field ex: Organization#organization:create
  return useApiQuery(
    queryName,
    gql`
      {
        ${queryName}(permissions: ["${permissions}"])
      }
    `,
    processData,
  );
};
