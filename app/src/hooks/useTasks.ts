import { gql } from 'graphql-request';
import { useApiQuery, callApi } from 'src/hooks/useApi';
import { queryOptions } from '@tanstack/react-query';
import { createServerFn } from '@tanstack/react-start';

export interface Task {
  id: string;
  name: string;
  description?: string;
  createdAt: string;
  updatedAt: string;
  assignedTo?: {
    id: string;
    username: string;
    firstName: string;
    lastName: string;
  };
  taskStatusType: {
    id: string;
    name: string;
  };
  project: {
    id: string;
    name: string;
    users: {
      id: string;
      username: string;
      firstName: string;
      lastName: string;
    }[];
  };
}

export interface TaskStatusType {
  id: string;
  name: string;
}

export interface SearchTasksPaginated {
  totalCount: number;
  pageInfo: {
    endCursor: string;
    startCursor: string;
    hasPreviousPage: boolean;
    hasNextPage: boolean;
  };
  edges: {
    node: Task;
  }[];
}

export interface SearchTasksResponse {
  searchTasks: SearchTasksPaginated;
}

export interface CreateTaskInput {
  name: string;
  description?: string;
  projectId: string;
  taskStatusTypeId?: string;
  assignedTo?: string;
}

export interface UpdateTaskInput {
  id: string;
  name: string;
  description?: string;
  projectId: string;
  taskStatusTypeId?: string;
  assignedTo?: string;
}

const GET_TASK_GQL = gql`
  query GetTask($id: String!) {
    getTask(id: $id) {
      id
      name
      description
      createdAt
      updatedAt
      assignedTo {
        id
        username
        firstName
        lastName
      }
      taskStatusType {
        id
        name
      }
      project {
        id
        name
        users {
          id
          username
          firstName
          lastName
        }
      }
    }
  }
`;

export const useSearchTasks = (
  projectIds: string[],
  searchString: string,
  first: number,
  after: string | null,
  orderBy: { fieldName: string; innerFieldName?: string; direction: 'ASC' | 'DESC' }[],
  placeholderData?: any,
) => {
  const queryKey = ['searchTasks', { projectIds, searchString, first, after, orderBy }];

  return useApiQuery<SearchTasksResponse, SearchTasksPaginated>({
    queryKey,
    query: gql`
      query SearchTasks($input: SearchTasksInput!) {
        searchTasks(searchTasksInput: $input) {
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
              updatedAt
              assignedTo {
                id
                username
                firstName
                lastName
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
    variables: {
      input: {
        projectIds,
        searchString,
        first,
        after,
        orderBy,
      },
    },
    select: (data) => data.searchTasks,
    placeholderData,
  });
};

export const getTaskServer = createServerFn({ method: 'GET' })
  .inputValidator((taskId: string) => taskId)
  .handler(async ({ data: taskId }) => {
    const result = await callApi({
      data: {
        query: GET_TASK_GQL,
        variables: { id: taskId },
      },
    });
    return (result as any).getTask;
  });

export const taskQueryOptions = (taskId: string) =>
  queryOptions({
    queryKey: ['getTask', taskId],
    queryFn: () => getTaskServer({ data: taskId }),
  });

export const useGetTask = (taskId: string) => {
  const queryKey = ['getTask', taskId];

  return useApiQuery<any, Task>({
    queryKey,
    query: GET_TASK_GQL,
    variables: { id: taskId },
    select: (data) => data.getTask,
  });
};

export const useGetTaskStatusTypes = () => {
  return useApiQuery<{ getTaskStatusTypes: TaskStatusType[] }, TaskStatusType[]>({
    queryKey: ['getTaskStatusTypes'],
    query: gql`
      query GetTaskStatusTypes {
        getTaskStatusTypes {
          id
          name
        }
      }
    `,
    select: (data) => data.getTaskStatusTypes,
    staleTime: Infinity,
  });
};

export const createTaskAction = createServerFn({ method: 'POST' })
  .inputValidator((data: CreateTaskInput) => data)
  .handler(async ({ data }) => {
    const result = await callApi({
      data: {
        query: gql`
          mutation CreateTask($createTaskInput: CreateTaskInput!) {
            createTask(createTaskInput: $createTaskInput) {
              id
              name
            }
          }
        `,
        variables: { createTaskInput: data },
      },
    });
    return (result as any).createTask;
  });

export const updateTaskAction = createServerFn({ method: 'POST' })
  .inputValidator((data: UpdateTaskInput) => data)
  .handler(async ({ data }) => {
    const result = await callApi({
      data: {
        query: gql`
          mutation UpdateTask($updateTaskInput: UpdateTaskInput!) {
            updateTask(updateTaskInput: $updateTaskInput) {
              id
              name
            }
          }
        `,
        variables: { updateTaskInput: data },
      },
    });
    return (result as any).updateTask;
  });
