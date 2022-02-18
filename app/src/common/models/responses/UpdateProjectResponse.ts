import Project from 'src/common/models/Project';

export default interface UpdateProjectResponse extends Project {
  updateProject: Project;
}
