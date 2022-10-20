import CreateTaskInput from 'src/common/models/inputs/CreateTaskInput';

export default interface UpdateTaskInput extends CreateTaskInput {
  id: string;
}
