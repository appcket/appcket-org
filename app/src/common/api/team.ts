import { gql } from 'graphql-request';

import { useApiQuery } from 'src/common/api';
import SearchTeamsQueryResponse from 'src/common/models/responses/SearchTeamsQueryResponse';
import TeamByIdQueryResponse from 'src/common/models/responses/TeamByIdQueryResponse';

export const useSearchTeams = (searchString: string) => {
  const processData = async (data: SearchTeamsQueryResponse) => {
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

export const useTeamById = (teamId: string) => {
  const processData = async (data: TeamByIdQueryResponse) => {
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
