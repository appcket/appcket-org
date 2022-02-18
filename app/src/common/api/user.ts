import { gql } from 'graphql-request';
import { UseQueryResult } from 'react-query';

import { useApiQuery } from 'src/common/api';
import User from 'src/common/models/User';
import SearchUsersQueryResponse from 'src/common/models/responses/user/SearchUsersQueryResponse';
import UserInfoQueryResponse from 'src/common/models/responses/user/UserInfoQueryResponse';

export const useUserInfo = (): UseQueryResult<User> => {
  const queryKey = 'userInfo';
  const processData = (data: UserInfoQueryResponse): User => {
    return data.userInfo;
  };

  return useApiQuery(
    queryKey,
    gql`
      {
        ${queryKey} {
          user_id
          username
          email
          firstName
          lastName
          jobTitle
          permissions {
            rsname
            scopes
          }
          organizations {
            organization_id
            name
          }
        }
      }
    `,
    processData,
  );
};

export const useSearchUsers = (organizationId: string): UseQueryResult<User[]> => {
  const queryKey = ['searchUsers', organizationId];
  const processData = (data: SearchUsersQueryResponse): User[] => {
    return data.searchUsers;
  };

  return useApiQuery(
    queryKey,
    gql`
      {
        ${queryKey[0]}(organizationId: "${organizationId}") {
          user_id
          username
          email
          firstName
          lastName
          jobTitle
        }
      }
    `,
    processData,
  );
};
