import { gql } from 'graphql-request';
import { UseMutationResult, UseQueryResult } from 'react-query';

import { useApiMutation, useApiQuery } from 'src/common/api';
import SearchProjectsQueryResponse from 'src/common/models/responses/SearchProjectsQueryResponse';
import GetProjectQueryResponse from 'src/common/models/responses/GetProjectQueryResponse';
import ProjectResponse from 'src/common/models/responses/ProjectResponse';
import Project from 'src/common/models/Project';

export const useSearchProjects = (searchString: string): UseQueryResult<Project[]> => {
  const queryKey = 'searchProjects';
  const processData = (data: SearchProjectsQueryResponse): Project[] => {
    return data.searchProjects;
  };

  return useApiQuery(
    queryKey,
    gql`
      {
        ${queryKey}(searchString: "${searchString}") {
          project_id
          name
          created_at
          updated_at
        }
      }
    `,
    processData,
  );
};

export const useGetProject = (projectId: string): UseQueryResult<Project> => {
  const queryKey = 'getProject';
  const processData = (data: GetProjectQueryResponse): Project => {
    return data.getProject;
  };

  return useApiQuery(
    queryKey,
    gql`
      {
        ${queryKey}(id: "${projectId}") {
          project_id
          name
          created_at
          updated_at
          organization {
            organization_id
            name
          }
          users {
            user_id
            username
            firstName
            lastName
            jobTitle
          }
        }
      }
    `,
    processData,
  );
};

export const useUpdateProject = (): UseMutationResult => {
  const mutationKey = 'updateProject';

  const processData = (data: ProjectResponse): Project => {
    return data.project;
  };

  return useApiMutation(
    gql`
      mutation ${mutationKey}($updateProjectInput: UpdateProjectInput!) {
        project(updateProjectInput: $updateProjectInput) {
          name
        }
      }
    `,
    processData,
  );
};
