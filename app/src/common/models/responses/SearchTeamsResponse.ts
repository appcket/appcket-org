import Team from 'src/common/models/Team';
import { IEntityHistory } from 'src/common/models/EntityHistory';

export interface TeamsHistory extends Team {
  teams: Team[];
  history: IEntityHistory[];
  totalCount: number;
}

export interface SearchTeamsResponse extends Team {
  searchTeams: TeamsHistory;
}
