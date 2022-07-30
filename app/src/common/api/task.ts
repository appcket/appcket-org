import { gql } from 'graphql-request';
import { UseQueryResult } from '@tanstack/react-query';

import { useApiQuery } from 'src/common/api';
import SearchTasksQueryResponse from 'src/common/models/responses/SearchTasksQueryResponse';
import Task from 'src/common/models/Task';

export const useSearchTasks = (projectIds: string[]): UseQueryResult<Task[]> => {
  const queryKey = ['searchTasks'];
  const processData = (data: SearchTasksQueryResponse): Task[] => {
    return data.searchTasks;
  };

  return useApiQuery(
    queryKey,
    gql`
    {
      ${queryKey}(searchTasksInput: {projectIds: ["${projectIds}"]}) {
        task_id
        name
        created_at
        updated_at
        task_status_type_id
        project {
          project_id
          name
        }
        task_status_type {
          task_status_type_id
          name
        }
        assigned_to_user {
          user_id
          username
        }
      }
    }
    `,
    processData,
  );
};

