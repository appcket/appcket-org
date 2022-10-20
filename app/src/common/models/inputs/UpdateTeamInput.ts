import CreateTeamInput from 'src/common/models/inputs/CreateTeamInput';

export default interface UpdateTeamInput extends CreateTeamInput {
  id: string;
}
