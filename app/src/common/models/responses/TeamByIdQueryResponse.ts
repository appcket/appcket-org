import Team from '../Team';

export default interface TeamByIdQueryResponse extends Team {
  teamById: Team;
}
