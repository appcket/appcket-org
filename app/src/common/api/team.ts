import { gql } from 'graphql-request';
import { UseMutationResult, UseQueryResult } from '@tanstack/react-query';

import { useApiMutation, useApiQuery } from 'src/common/api';
import { SearchTeamsResponse, TeamsHistory } from 'src/common/models/responses/SearchTeamsResponse';
import GetTeamResponse from 'src/common/models/responses/GetTeamResponse';
import UpdateTeamResponse from 'src/common/models/responses/UpdateTeamResponse';
import CreateTeamResponse from 'src/common/models/responses/CreateTeamResponse';
import Team from 'src/common/models/Team';

export const useSearchTeams = (searchString: string): UseQueryResult<TeamsHistory> => {
  const queryKey = ['searchTeams'];
  const processData = (data: SearchTeamsResponse): TeamsHistory => {
    return data.searchTeams;
  };

  return useApiQuery(
    queryKey,
    gql`
      {
        ${queryKey}(searchString: "${searchString}") {
          teams {
            id
            name
            organization {
              id
              name
            }
          }
          history {
            id
            createdAt
            createdBy {
              id
              displayName
            }
            updatedAt
            updatedBy {
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
