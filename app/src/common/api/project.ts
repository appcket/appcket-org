import { gql } from 'graphql-request';

import { useApiMutation, useApiQuery } from 'src/common/api';
import {
  SearchProjectsResponse,
  SearchProjectsPaginated,
} from 'src/common/models/responses/SearchProjectsResponse';
import GetProjectResponse from 'src/common/models/responses/GetProjectResponse';
import UpdateProjectResponse from 'src/common/models/responses/UpdateProjectResponse';
import CreateProjectResponse from 'src/common/models/responses/CreateProjectResponse';
import Project from 'src/common/models/Project';

export const useSearchProjects = (
  searchString: string,
  first: number,
  after: string | null,
  orderBy: string,
) => {
  after = after ? `"${after}"` : null;
  let queryKeySearch = 'search:' + searchString;
  let queryKeyAfter = 'after:' + after;
  let queryKeyOrderBy = 'orderBy:' + orderBy;
  const queryKey = ['searchProjects', queryKeySearch, queryKeyAfter, queryKeyOrderBy];
  const processData = (data: SearchProjectsResponse): SearchProjectsPaginated => {
    return data.searchProjects;
  };

  return useApiQuery(
    queryKey,
    gql`
      {
        ${queryKey[0]}(searchProjectsInput: {
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
    processData,
  );
};

export const useGetProject = (projectId: string) => {
  const queryKey = ['getProject'];
  const processData = (data: GetProjectResponse): GetProjectResponse => {
    return data;
  };

  return useApiQuery(
    queryKey,
    gql`
      {
        ${queryKey}(id: "${projectId}") {
          id
          name
          description
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
            attributes {
              name
              value
            }
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

export const useUpdateProject = () => {
  const mutationKey = 'updateProject';

  const processData = (data: UpdateProjectResponse): Project => {
    return data.updateProject;
  };

  return useApiMutation(
    gql`
      mutation ${mutationKey}($updateProjectInput: UpdateProjectInput!) {
        updateProject(updateProjectInput: $updateProjectInput) {
          name
        }
      }
    `,
    processData,
  );
};

export const useCreateProject = () => {
  const mutationKey = 'createProject';

  const processData = (data: CreateProjectResponse): Project => {
    return data.createProject;
  };

  return useApiMutation(
    gql`
      mutation ${mutationKey}($createProjectInput: CreateProjectInput!) {
        createProject(createProjectInput: $createProjectInput) {
          name
        }
      }
    `,
    processData,
  );
};
