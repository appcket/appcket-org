import Project from 'src/common/models/Project';

export default interface GetProjectResponse extends Project {
  getProject: Project;
}
