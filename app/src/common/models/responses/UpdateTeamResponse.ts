import Team from 'src/common/models/Team';

export default interface UpdateTeamResponse extends Team {
  updateTeam: Team;
}
