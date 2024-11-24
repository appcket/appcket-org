import { gql } from 'graphql-request';

import { useApiMutation, useApiQuery } from 'src/common/api';
import GetTaskResponse from 'src/common/models/responses/GetTaskResponse';
import UpdateTaskResponse from 'src/common/models/responses/UpdateTaskResponse';
import CreateTaskResponse from 'src/common/models/responses/CreateTaskResponse';
import Task from 'src/common/models/Task';
import {
  SearchTasksResponse,
  SearchTasksPaginated,
} from 'src/common/models/responses/SearchTasksResponse';

export const useSearchTasks = (
  projectIds: string[],
  searchString: string,
  first: number,
  after: string | null,
  orderBy: string,
) => {
  after = after ? `"${after}"` : null;
  let queryKeyProjectIds = 'projectIds:' + projectIds;
  let queryKeySearch = 'search:' + searchString;
  let queryKeyAfter = 'after:' + after;
  let queryKeyOrderBy = 'orderBy:' + orderBy;
  const queryKey = [
    'searchTasks',
    queryKeyProjectIds,
    queryKeySearch,
    queryKeyAfter,
    queryKeyOrderBy,
  ];
  const processData = (data: SearchTasksResponse): SearchTasksPaginated => {
    return data.searchTasks;
  };

  return useApiQuery(
    queryKey,
    gql`
      {
        ${queryKey[0]}(searchTasksInput: {
          projectIds: ["${projectIds}"],
          searchString: "${searchString}",
          first: ${first},
          after: ${after},
          orderBy: ${orderBy}
        }) {
          totalCount
          pageInfo {
            endCursor
            startCursor
            hasPreviousPage
            hasNextPage
          }
          edges {
            node {
              id
              name
              createdAt
              createdBy {
                id
                username
                email
                firstName
                lastName
              }
              updatedAt
              updatedBy {
                id
                username
                email
                firstName
                lastName
        }
        assignedTo {
          username
          email
          firstName
          lastName
        }
        project {
          id
          name
        }
        taskStatusType {
          id
          name
        }
      }
    }
        }
      }
    `,
    processData,
  );
};

export const useGetTask = (taskId: string) => {
  const queryKey = ['getTask'];
  const processData = (data: GetTaskResponse) => {
    return data;
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
        getTaskStatusTypes {
          id
          name
        }
      }
    `,
    processData,
  );
};

export const useUpdateTask = () => {
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
          taskStatusType {
            id
            name
          }
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

export const useCreateTask = () => {
  const mutationKey = 'createTask';

  const processData = (data: CreateTaskResponse): Task => {
    return data.createTask;
  };

  return useApiMutation(
    gql`
      mutation ${mutationKey}($createTaskInput: CreateTaskInput!) {
        createTask(createTaskInput: $createTaskInput) {
          id
          name
        }
      }
    `,
    processData,
  );
};
