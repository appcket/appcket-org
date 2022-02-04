import Project from 'src/common/models/Project';

export default interface ProjectResponse extends Project {
  updateProject: Project;
}
