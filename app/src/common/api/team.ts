import { gql } from 'graphql-request';
import { UseQueryResult } from 'react-query';

import { useApiQuery } from 'src/common/api';
import SearchTeamsQueryResponse from 'src/common/models/responses/SearchTeamsQueryResponse';
import TeamByIdQueryResponse from 'src/common/models/responses/TeamByIdQueryResponse';
import TeamGrid from 'src/common/models/TeamGrid';
import Team from 'src/common/models/Team';

export const useSearchTeams = (searchString: string): UseQueryResult<TeamGrid[]> => {
  const queryName = 'searchTeams';
  const processData = (data: SearchTeamsQueryResponse): Team[] => {
    return data.searchTeams;
  };

  return useApiQuery(
    queryName,
    gql`
      {
        ${queryName}(searchString: "${searchString}") {
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

export const useTeamById = (teamId: string): UseQueryResult<Team> => {
  const queryName = 'teamById';
  const processData = (data: TeamByIdQueryResponse): Team => {
    return data.teamById;
  };

  return useApiQuery(
    queryName,
    gql`
      {
        ${queryName}(id: "${teamId}") {
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
