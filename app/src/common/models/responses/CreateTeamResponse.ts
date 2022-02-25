import Team from 'src/common/models/Team';

export default interface CreateTeamResponse extends Team {
  createTeam: Team;
}
