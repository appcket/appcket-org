import { gql } from 'graphql-request';
import { UseMutationResult, UseQueryResult } from '@tanstack/react-query';

import { useApiMutation, useApiQuery } from 'src/common/api';
import {
  SearchTeamsResponse,
  SearchTeamsPaginated,
} from 'src/common/models/responses/SearchTeamsResponse';
import GetTeamResponse from 'src/common/models/responses/GetTeamResponse';
import UpdateTeamResponse from 'src/common/models/responses/UpdateTeamResponse';
import CreateTeamResponse from 'src/common/models/responses/CreateTeamResponse';
import Team from 'src/common/models/Team';

export const useSearchTeams = (
  searchString: string,
  first: number,
  after: string | null,
  orderBy: string,
): UseQueryResult<SearchTeamsPaginated> => {
  after = after ? `"${after}"` : null;
  let queryKeySearch = 'search:' + searchString;
  let queryKeyAfter = 'after:' + after;
  let queryKeyOrderBy = 'orderBy:' + orderBy;
  const queryKey = ['searchTeams', queryKeySearch, queryKeyAfter, queryKeyOrderBy];
  const processData = (data: SearchTeamsResponse): SearchTeamsPaginated => {
    return data.searchTeams;
  };

  return useApiQuery(
    queryKey,
    gql`
      {
        ${queryKey[0]}(searchTeamsInput: {
          searchString: "${searchString}",
          first: ${first},
          after: ${after},
          orderBy: ${orderBy}
        }) {
          currentCount
          previousCount
          totalCount
          pageInfo {
            endCursor
            startCursor
            hasPreviousPage
            hasNextPage
          }
          edges {
            cursor
            node {
              id
              name
              createdAt
              updatedAt
              organization {
                id
                name
              }
            }
          }
        }
      }
    `,
    processData,
  );
};

export const useGetTeam = (teamId: string): UseQueryResult<Team> => {
  const queryKey = ['getTeam'];
  const processData = (data: GetTeamResponse): Team => {
    return data.getTeam;
  };

  return useApiQuery(
    queryKey,
    gql`
      {
        ${queryKey}(id: "${teamId}") {
          id
          name
          description
          organization {
            id
            name
          }
          users {
            id
            email
            username
            firstName
            lastName
            attributes {
              id
              name
            }
          }
        }
      }
    `,
    processData,
  );
};

export const useUpdateTeam = (): UseMutationResult => {
  const mutationKey = 'updateTeam';

  const processData = (data: UpdateTeamResponse): Team => {
    return data.updateTeam;
  };

  return useApiMutation(
    gql`
      mutation ${mutationKey}($updateTeamInput: UpdateTeamInput!) {
        updateTeam(updateTeamInput: $updateTeamInput) {
          name
        }
      }
    `,
    processData,
  );
};

export const useCreateTeam = (): UseMutationResult => {
  const mutationKey = 'createTeam';

  const processData = (data: CreateTeamResponse): Team => {
    return data.createTeam;
  };

  return useApiMutation(
    gql`
      mutation ${mutationKey}($createTeamInput: CreateTeamInput!) {
        createTeam(createTeamInput: $createTeamInput) {
          name
        }
      }
    `,
    processData,
  );
};
