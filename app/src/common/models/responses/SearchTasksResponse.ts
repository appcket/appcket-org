import PageInfo from 'src/common/models/responses/PageInfo';
import Task from 'src/common/models/Task';

export interface SearchTasksPaginated extends Task {
  currentCount: number;
  previousCount: number;
  totalCount: number;
  pageInfo: PageInfo;
  edges: [
    {
      cursor: string;
      node: Task;
    },
  ];
}

export interface SearchTasksResponse extends Task {
  searchTasks: SearchTasksPaginated;
}
