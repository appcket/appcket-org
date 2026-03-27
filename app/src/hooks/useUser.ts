import { gql } from 'graphql-request';
import { useApiQuery } from 'src/hooks/useApi';
import { User } from 'src/lib/session';

interface UserInfoResponse {
  userInfo: User;
}

export const useUserInfo = () => {
  const queryKey = ['userInfo'];

  return useApiQuery<UserInfoResponse, User>({
    queryKey,
    query: gql`
      query GetUserInfo {
        userInfo {
          id
          username
          email
          firstName
          lastName
          role
          attributes {
            jobTitle
          }
          organizations {
            id
            name
          }
          permissions {
            rsid
            rsname
            scopes
          }
        }
      }
    `,
    select: (data) => data.userInfo,
    staleTime: Infinity,
    gcTime: Infinity,
  });
};

export const useSearchUsers = (organizationId?: string) => {
  const queryKey = ['searchUsers', organizationId];

  return useApiQuery<{ searchUsers: User[] }, User[]>({
    queryKey,
    query: gql`
      query SearchUsers {
        searchUsers(organizationId: "${organizationId}") {
          id
          username
          email
          firstName
          lastName
          attributes {
            jobTitle
          }
        }
      }
    `,
    select: (data) => data.searchUsers,
    staleTime: Infinity,
    gcTime: 300000,
  });
};
