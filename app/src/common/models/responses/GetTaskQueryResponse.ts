import Task from '../Task';

export default interface GetTaskQueryResponse extends Task {
  getTask: Task;
}
