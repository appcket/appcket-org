import { gql } from 'graphql-request';
import { UseQueryResult } from 'react-query';

import { useApiQuery } from 'src/common/api';
import UserInfoQueryResponse from 'src/common/models/responses/UserInfoQueryResponse';
import User from 'src/common/models/User';

export const useUserInfo = (): UseQueryResult<User> => {
  const queryName = 'userInfo';
  const processData = (data: UserInfoQueryResponse): User => {
    return data.userInfo;
  };

  return useApiQuery(
    queryName,
    gql`
      {
        ${queryName} {
          user_id
          username
          email
          firstName
          jobTitle
        }
      }
    `,
    processData,
  );
};
