import { gql } from 'graphql-request';
import { UseQueryResult } from 'react-query';

import { useApiQuery } from 'src/common/api';
import User from 'src/common/models/User';
import UserInfoQueryResponse from 'src/common/models/responses/UserInfoQueryResponse';

interface SearchUsersQueryResponse extends User {
  searchUsers: User[];
}

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
        }
      }
    `,
    processData,
  );
};

export const useSearchUsers = (): UseQueryResult<User[]> => {
  const queryKey = 'searchUsers';
  const processData = (data: SearchUsersQueryResponse): User[] => {
    return data.searchUsers;
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
        }
      }
    `,
    processData,
  );
};
