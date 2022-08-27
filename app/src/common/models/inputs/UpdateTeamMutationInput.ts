import CreateTeamMutationInput from 'src/common/models/inputs/CreateTeamMutationInput';

export default interface UpdateTeamMutationInput extends CreateTeamMutationInput {
  teamId: string;
}
