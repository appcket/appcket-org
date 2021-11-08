import Team from '../Team';

export default interface SearchTeamsQueryResponse extends Team {
  searchTeams: Team[];
}
