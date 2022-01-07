import { gql } from 'graphql-request';
import { UseMutationResult, UseQueryResult } from 'react-query';

import { useApiMutation, useApiQuery } from 'src/common/api';
import SearchTeamsQueryResponse from 'src/common/models/responses/SearchTeamsQueryResponse';
import GetTeamQueryResponse from 'src/common/models/responses/GetTeamQueryResponse';
import TeamResponse from 'src/common/models/responses/TeamResponse';
import TeamGrid from 'src/common/models/TeamGrid';
import Team from 'src/common/models/Team';

export const useSearchTeams = (searchString: string): UseQueryResult<TeamGrid[]> => {
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

  const processData = (data: TeamResponse): Team => {
    return data.team;
  };

  return useApiMutation(
    gql`
      mutation ${mutationKey}($updateTeamInput: UpdateTeamInput!) {
        team(updateTeamInput: $updateTeamInput) {
          name
        }
      }
    `,
    processData,
  );
};
