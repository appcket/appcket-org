import Project from 'src/common/models/Project';
import TaskStatusType from 'src/common/models/TaskStatusType';

export default interface GetProjectResponse extends Project {
  getProject: Project;
  getTaskStatusTypes: TaskStatusType[];
}
