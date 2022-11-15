import Task from 'src/common/models/Task';

export default interface CreateTaskResponse extends Task {
  createTask: Task;
}
