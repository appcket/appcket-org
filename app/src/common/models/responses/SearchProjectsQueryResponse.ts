import Project from '../Project';

export default interface SearchProjectsQueryResponse extends Project {
  searchProjects: Project[];
}
