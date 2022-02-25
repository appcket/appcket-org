import { gql } from 'graphql-request';
import { UseMutationResult, UseQueryResult } from 'react-query';

import { useApiMutation, useApiQuery } from 'src/common/api';
import SearchTeamsQueryResponse from 'src/common/models/responses/SearchTeamsQueryResponse';
import GetTeamQueryResponse from 'src/common/models/responses/GetTeamQueryResponse';
import UpdateTeamResponse from 'src/common/models/responses/UpdateTeamResponse';
import CreateTeamResponse from 'src/common/models/responses/CreateTeamResponse';
import Team from 'src/common/models/Team';

export const useSearchTeams = (searchString: string): UseQueryResult<Team[]> => {
  const queryKey = 'searchTeams';
  const processData = (data: SearchTeamsQueryResponse): Team[] => {
    return data.searchTeams;
  };

  return useApiQuery(
    queryKey,
    gql`
      {
        ${queryKey}(searchString: "${searchString}") {
          team_id
          name
          created_at
          updated_at
        }
      }
    `,
    processData,
  );
};

export const useGetTeam = (teamId: string): UseQueryResult<Team> => {
  const queryKey = 'getTeam';
  const processData = (data: GetTeamQueryResponse): Team => {
    return data.getTeam;
  };

  return useApiQuery(
    queryKey,
    gql`
      {
        ${queryKey}(id: "${teamId}") {
          team_id
          name
          created_at
          updated_at
          organization {
            organization_id
            name
          }
          users {
            user_id
            username
            firstName
            lastName
            jobTitle
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
