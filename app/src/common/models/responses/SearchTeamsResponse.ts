import Team from 'src/common/models/Team';

export default interface SearchTeamsResponse extends Team {
  searchTeams: Team[];
}
