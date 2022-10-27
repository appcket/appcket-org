import Task from 'src/common/models/Task';
import TaskStatusType from 'src/common/models/TaskStatusType';

export default interface GetTaskResponse extends Task {
  getTask: Task;
  getTaskStatusTypes: TaskStatusType[];
}
