import PageInfo from 'src/common/models/responses/PageInfo';
import Project from 'src/common/models/Project';

export interface SearchProjectsPaginated extends Project {
  currentCount: number;
  previousCount: number;
  totalCount: number;
  pageInfo: PageInfo;
  edges: [
    {
      cursor: string;
      node: Project;
    },
  ];
}

export interface SearchProjectsResponse extends Project {
  searchProjects: SearchProjectsPaginated;
}
