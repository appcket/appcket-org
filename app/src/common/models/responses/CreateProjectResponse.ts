import Project from 'src/common/models/Project';

export default interface CreateProjectResponse extends Project {
  createProject: Project;
}
