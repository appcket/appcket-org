import CreateProjectMutationInput from 'src/common/models/inputs/CreateProjectMutationInput';

export default interface UpdateProjectMutationInput extends CreateProjectMutationInput {
  projectId: string;
}
