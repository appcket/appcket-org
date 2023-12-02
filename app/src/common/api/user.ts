import { gql } from 'graphql-request';

import { useApiQuery } from 'src/common/api';
import User from 'src/common/models/User';
import SearchUsersResponse from 'src/common/models/responses/SearchUsersResponse';
import UserInfoResponse from 'src/common/models/responses/UserInfoResponse';

export const useUserInfo = () => {
  const queryKey = ['userInfo'];
  const processData = (data: UserInfoResponse): User => {
    return data.userInfo;
  };

  return useApiQuery(
    queryKey,
    gql`
      {
        ${queryKey} {
          id
          username
          email
          firstName
          lastName
          role
          attributes {
            name
            value
          }
          permissions {
            rsname
            scopes
          }
          organizations {
            id
            name
          }
        }
      }
    `,
    processData,
    Infinity,
    Infinity,
  );
};

export const useSearchUsers = (organizationId: string) => {
  const queryKey = ['searchUsers', organizationId];
  const processData = (data: SearchUsersResponse): User[] => {
    return data.searchUsers;
  };

  return useApiQuery(
    queryKey,
    gql`
      {
        ${queryKey[0]}(organizationId: "${organizationId}") {
          id
          username
          email
          firstName
          lastName
          attributes {
            name
            value
          }
        }
      }
    `,
    processData,
  );
};
