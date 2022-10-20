import Project from 'src/common/models/Project';

export default interface SearchProjectsResponse extends Project {
  searchProjects: Project[];
}
