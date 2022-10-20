import Task from 'src/common/models/Task';

export default interface UpdateTaskResponse extends Task {
  updateTask: Task;
}
