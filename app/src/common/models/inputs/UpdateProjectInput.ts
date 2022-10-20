import CreateProjectInput from 'src/common/models/inputs/CreateProjectInput';

export default interface UpdateProjectInput extends CreateProjectInput {
  id: string;
}
