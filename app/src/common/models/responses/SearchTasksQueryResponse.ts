import Task from 'src/common/models/Task';

export default interface SearchTasksQueryResponse extends Task {
  searchTasks: Task[];
}
