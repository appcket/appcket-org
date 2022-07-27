import Project from 'src/common/models/Project';
import User from 'src/common/models/User';
import TaskStatusType from 'src/common/models/TaskStatusType';

export default interface Task {
  id?: string;
  task_id: string;
  name: string;
  created_at: Date;
  updated_at: Date;
  project: Project;
  task_status_type: TaskStatusType;
  assigned_to_user: User;
}
