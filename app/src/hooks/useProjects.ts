import { gql } from 'graphql-request';
import { useApiQuery, useApiMutation, callApi } from 'src/hooks/useApi';
import { queryOptions } from '@tanstack/react-query';
import { createServerFn } from '@tanstack/react-start';

export interface Project {
  id: string;
  name: string;
  description?: string;
  createdAt: string;
  updatedAt: string;
  organization: {
    id: string;
    name: string;
  };
  users: {
    id: string;
    email: string;
    username: string;
    firstName: string;
    lastName: string;
  }[];
}

export interface SearchProjectsPaginated {
  totalCount: number;
  pageInfo: {
    endCursor: string;
    startCursor: string;
    hasPreviousPage: boolean;
    hasNextPage: boolean;
  };
  edges: {
    node: Project;
  }[];
}

export interface SearchProjectsResponse {
  searchProjects: SearchProjectsPaginated;
}

export interface CreateProjectInput {
  name: string;
  description?: string;
  organizationId: string;
  userIds: string[];
}

export interface UpdateProjectInput {
  id: string;
  name: string;
  description?: string;
  organizationId: string;
  userIds: string[];
}

const GET_PROJECT_GQL = gql`
  query GetProject($id: String!) {
    getProject(id: $id) {
      id
      name
      description
      createdAt
      updatedAt
      organization {
        id
        name
      }
      users {
        id
        email
        username
        firstName
        lastName
      }
    }
  }
`;

export const useSearchProjects = (
  searchString: string,
  first: number,
  after: string | null,
  orderBy: string,
  placeholderData?: any,
) => {
  const queryKey = ['searchProjects', { searchString, first, after, orderBy }];

  return useApiQuery<SearchProjectsResponse, SearchProjectsPaginated>({
    queryKey,
    query: gql`
      {
        searchProjects(searchProjectsInput: {
          searchString: "${searchString}",
          first: ${first},
          after: ${after ? `"${after}"` : 'null'},
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
              description
              createdAt
              updatedAt
              organization {
                id
                name
              }
            }
          }
        }
      }
    `,
    select: (data) => {
      return data.searchProjects;
    },
    placeholderData,
  });
};

export const getProjectServer = createServerFn({ method: 'GET' })
  .inputValidator((projectId: string) => projectId)
  .handler(async ({ data: projectId }) => {
    const result = await callApi({
      data: {
        query: GET_PROJECT_GQL,
        variables: { id: projectId },
      },
    });
    return (result as any).getProject;
  });

export const projectQueryOptions = (projectId: string) =>
  queryOptions({
    queryKey: ['getProject', projectId],
    queryFn: () => getProjectServer({ data: projectId }),
  });

export const useGetProject = (projectId: string) => {
  const queryKey = ['getProject', projectId];

  return useApiQuery<any, Project>({
    queryKey,
    query: GET_PROJECT_GQL,
    variables: { id: projectId },
    select: (data) => data.getProject,
  });
};

export const createProjectAction = createServerFn({ method: 'POST' })
  .inputValidator((data: CreateProjectInput) => data)
  .handler(async ({ data }) => {
    const result = await callApi({
      data: {
        query: gql`
          mutation CreateProject($createProjectInput: CreateProjectInput!) {
            createProject(createProjectInput: $createProjectInput) {
              id
              name
            }
          }
        `,
        variables: { createProjectInput: data },
      },
    });
    return (result as any).createProject;
  });

export const updateProjectAction = createServerFn({ method: 'POST' })
  .inputValidator((data: UpdateProjectInput) => data)
  .handler(async ({ data }) => {
    const result = await callApi({
      data: {
        query: gql`
          mutation UpdateProject($updateProjectInput: UpdateProjectInput!) {
            updateProject(updateProjectInput: $updateProjectInput) {
              id
              name
            }
          }
        `,
        variables: { updateProjectInput: data },
      },
    });
    return (result as any).updateProject;
  });
