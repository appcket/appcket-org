import Task from 'src/common/models/Task';

export default interface SearchTasksResponse extends Task {
  searchTasks: Task[];
}
