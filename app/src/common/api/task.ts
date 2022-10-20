import { gql } from 'graphql-request';
import { UseMutationResult, UseQueryResult } from '@tanstack/react-query';

import { useApiMutation, useApiQuery } from 'src/common/api';
import SearchTasksResponse from 'src/common/models/responses/SearchTasksResponse';
import GetTaskResponse from 'src/common/models/responses/GetTaskResponse';
import UpdateTaskResponse from 'src/common/models/responses/UpdateTaskResponse';
// import CreateTaskResponse from 'src/common/models/responses/CreateTaskResponse';
import Task from 'src/common/models/Task';

export const useSearchTasks = (projectIds: string[]): UseQueryResult<Task[]> => {
  const queryKey = ['searchTasks'];
  const processData = (data: SearchTasksResponse): Task[] => {
    return data.searchTasks;
  };

  return useApiQuery(
    queryKey,
    gql`
    {
      ${queryKey}(searchTasksInput: {projectIds: ["${projectIds}"]}) {
        id
        name
        taskStatusType {
          id
          name
        }
        project {
          id
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
  const processData = (data: GetTaskResponse): Task => {
    return data.getTask;
  };

  return useApiQuery(
    queryKey,
    gql`
      {
        ${queryKey}(id: "${taskId}") {
          id
          name
          description
          taskStatusType {
            id
            name
          }
          project {
            id
            name
            users {
              id
              firstName
              lastName
            }
          }
          assignedTo {
            id
            email
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

export const useUpdateTask = (): UseMutationResult => {
  const mutationKey = 'updateTask';

  const processData = (data: UpdateTaskResponse): Task => {
    return data.updateTask;
  };

  return useApiMutation(
    gql`
      mutation ${mutationKey}($updateTaskInput: UpdateTaskInput!) {
        updateTask(updateTaskInput: $updateTaskInput) {
          id
          name
          project {
            id
            name
          }
          assignedTo {
            id
            email
            firstName
            lastName
          }
        }
      }
    `,
    processData,
  );
};

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
