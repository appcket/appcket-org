import Task from 'src/common/models/Task';

export default interface GetTaskResponse extends Task {
  getTask: Task;
}
