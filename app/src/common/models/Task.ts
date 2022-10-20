import Project from 'src/common/models/Project';
import User from 'src/common/models/User';
import TaskStatusType from 'src/common/models/TaskStatusType';

export default interface Task {
  id: string;
  name: string;
  description: string;
  project: Project;
  taskStatusType: TaskStatusType;
  assignedTo: User;
}
