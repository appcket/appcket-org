import Team from 'src/common/models/Team';

export default interface TeamResponse extends Team {
  team: Team;
}
