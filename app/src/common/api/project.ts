import { gql } from 'graphql-request';
import { UseMutationResult, UseQueryResult } from '@tanstack/react-query';

import { useApiMutation, useApiQuery } from 'src/common/api';
import SearchProjectsResponse from 'src/common/models/responses/SearchProjectsResponse';
import GetProjectResponse from 'src/common/models/responses/GetProjectResponse';
import UpdateProjectResponse from 'src/common/models/responses/UpdateProjectResponse';
import CreateProjectResponse from 'src/common/models/responses/CreateProjectResponse';
import Project from 'src/common/models/Project';

export const useSearchProjects = (searchString: string): UseQueryResult<Project[]> => {
  const queryKey = ['searchProjects'];
  const processData = (data: SearchProjectsResponse): Project[] => {
    return data.searchProjects;
  };

  return useApiQuery(
    queryKey,
    gql`
      {
        ${queryKey}(searchString: "${searchString}") {
          id
          name
          organization {
            id
            name
          }
        }
      }
    `,
    processData,
  );
};

export const useGetProject = (projectId: string): UseQueryResult<Project> => {
  const queryKey = ['getProject'];
  const processData = (data: GetProjectResponse): Project => {
    return data.getProject;
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
      }
    `,
    processData,
  );
};

export const useUpdateProject = (): UseMutationResult => {
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

export const useCreateProject = (): UseMutationResult => {
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
