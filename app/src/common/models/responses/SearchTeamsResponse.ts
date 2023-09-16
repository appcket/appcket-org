import PageInfo from 'src/common/models/responses/PageInfo';
import Team from 'src/common/models/Team';

export interface SearchTeamsPaginated extends Team {
  currentCount: number;
  previousCount: number;
  totalCount: number;
  pageInfo: PageInfo;
  edges: [
    {
      cursor: string;
      node: Team;
    },
  ];
}

export interface SearchTeamsResponse extends Team {
  searchTeams: SearchTeamsPaginated;
}
