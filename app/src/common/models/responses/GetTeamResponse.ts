import Team from 'src/common/models/Team';

export default interface GetTeamResponse extends Team {
  getTeam: Team;
}
