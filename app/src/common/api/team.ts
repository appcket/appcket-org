import { gql } from 'graphql-request';
import { UseQueryResult } from 'react-query';

import { useApiQuery } from 'src/common/api';
import SearchTeamsQueryResponse from 'src/common/models/responses/SearchTeamsQueryResponse';
import TeamByIdQueryResponse from 'src/common/models/responses/TeamByIdQueryResponse';
import TeamGrid from 'src/common/models/TeamGrid';
import Team from 'src/common/models/Team';

export const useSearchTeams = (searchString: string): UseQueryResult<TeamGrid[]> => {
  const processData = async (data: SearchTeamsQueryResponse): Promise<Team[]> => {
    return data.searchTeams;
  };

  return useApiQuery(
    'searchTeams',
    gql`
      {
        searchTeams(searchString: "${searchString}") {
          team_id
          name
          created_at
          effective_at
        }
      }
    `,
    processData,
  );
};

export const useTeamById = (teamId: string): UseQueryResult<Team> => {
  const processData = async (data: TeamByIdQueryResponse): Promise<Team> => {
    return data.teamById;
  };

  return useApiQuery(
    'teamById',
    gql`
      {
        teamById(id: "${teamId}") {
          team_id
          name
          created_at
          effective_at
        }
      }
    `,
    processData,
  );
};
