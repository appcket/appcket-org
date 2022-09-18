import { gql } from 'graphql-request';
import { UseQueryResult } from '@tanstack/react-query';

import { useApiQuery } from 'src/common/api';
import SearchTasksQueryResponse from 'src/common/models/responses/SearchTasksQueryResponse';
import GetTaskQueryResponse from 'src/common/models/responses/GetTaskQueryResponse';
// import UpdateTaskResponse from 'src/common/models/responses/UpdateTaskResponse';
// import CreateTaskResponse from 'src/common/models/responses/CreateTaskResponse';
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
      }
    }
    `,
    processData,
  );
};

export const useGetTask = (taskId: string): UseQueryResult<Task> => {
  const queryKey = ['getTask'];
  const processData = (data: GetTaskQueryResponse): Task => {
    return data.getTask;
  };

  return useApiQuery(
    queryKey,
    gql`
      {
        ${queryKey}(id: "${taskId}") {
          task_id
          name
          description
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
            firstName
            lastName
          }
        }
      }
    `,
    processData,
  );
};

// export const useUpdateTask = (): UseMutationResult => {
//   const mutationKey = 'updateTask';

//   const processData = (data: UpdateTaskResponse): Task => {
//     return data.updateTask;
//   };

//   return useApiMutation(
//     gql`
//       mutation ${mutationKey}($updateTaskInput: UpdateTaskInput!) {
//         updateTask(updateTaskInput: $updateTaskInput) {
//           name
//         }
//       }
//     `,
//     processData,
//   );
// };

// export const useCreateTask = (): UseMutationResult => {
//   const mutationKey = 'createTask';

//   const processData = (data: CreateTaskResponse): Task => {
//     return data.createTask;
//   };

//   return useApiMutation(
//     gql`
//       mutation ${mutationKey}($createTaskInput: CreateTaskInput!) {
//         createTask(createTaskInput: $createTaskInput) {
//           name
//         }
//       }
//     `,
//     processData,
//   );
// };
