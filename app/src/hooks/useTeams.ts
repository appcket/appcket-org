import { gql } from 'graphql-request';
import { useApiQuery, useApiMutation, callApi } from 'src/hooks/useApi';
import { queryOptions } from '@tanstack/react-query';
import { createServerFn } from '@tanstack/react-start';

export interface UpdateTeamInput {
  id: string;
  name: string;
  description: string;
  organizationId: string;
  userIds: string[];
}

export interface CreateTeamInput {
  name: string;
  description: string;
  organizationId: string;
  userIds: string[];
}

export interface Team {
  id: string;
  name: string;
  description?: string;
  createdAt: string;
  updatedAt: string;
  organization: {
    id: string;
    name: string;
  };
}

export interface SearchTeamsPaginated {
  totalCount: number;
  pageInfo: {
    endCursor: string;
    startCursor: string;
    hasPreviousPage: boolean;
    hasNextPage: boolean;
  };
  edges: {
    node: Team;
  }[];
}

export interface SearchTeamsResponse {
  searchTeams: SearchTeamsPaginated;
}

const GET_TEAM_GQL = gql`
  query GetTeam($id: String!) {
    getTeam(id: $id) {
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
          jobTitle
        }
      }
    }
  }
`;

export const useSearchTeams = (
  searchString: string,
  first: number,
  after: string | null,
  orderBy: string,
  placeholderData?: any,
) => {
  const queryKeySearch = 'search:' + searchString;
  const queryKeyAfter = 'after:' + after;
  const queryKeyOrderBy = 'orderBy:' + orderBy;
  const queryKey = ['searchTeams', queryKeySearch, queryKeyAfter, queryKeyOrderBy];

  return useApiQuery<SearchTeamsResponse, SearchTeamsPaginated>({
    queryKey,
    query: gql`
      {
        searchTeams(searchTeamsInput: {
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
    select: (data) => data.searchTeams,
    placeholderData,
  });
};

export const useGetTeam = (teamId: string) => {
  const queryKey = ['getTeam', teamId];

  return useApiQuery<any, Team & { users: any[] }>({
    queryKey,
    query: GET_TEAM_GQL,
    variables: { id: teamId },
    select: (data) => data.getTeam,
  });
};

export const getTeamServer = createServerFn({ method: 'GET' })
  .inputValidator((teamId: string) => teamId)
  .handler(async ({ data: teamId }) => {
    const result = await callApi({
      data: {
        query: GET_TEAM_GQL,
        variables: { id: teamId },
      },
    });
    return (result as any).getTeam;
  });

export const teamQueryOptions = (teamId: string) =>
  queryOptions({
    queryKey: ['getTeam', teamId],
    queryFn: () => getTeamServer({ data: teamId }),
  });

export const createTeamAction = createServerFn({ method: 'POST' })
  .inputValidator((data: CreateTeamInput) => data)
  .handler(async ({ data }) => {
    const result = await callApi({
      data: {
        query: gql`
          mutation CreateTeam($createTeamInput: CreateTeamInput!) {
            createTeam(createTeamInput: $createTeamInput) {
              id
              name
            }
          }
        `,
        variables: {
          createTeamInput: data,
        },
      },
    });
    return (result as any).createTeam;
  });

export const updateTeamAction = createServerFn({ method: 'POST' })
  .inputValidator((data: UpdateTeamInput) => data)
  .handler(async ({ data }) => {
    const result = await callApi({
      data: {
        query: gql`
          mutation UpdateTeam($updateTeamInput: UpdateTeamInput!) {
            updateTeam(updateTeamInput: $updateTeamInput) {
              id
              name
            }
          }
        `,
        variables: {
          updateTeamInput: data,
        },
      },
    });
    return (result as any).updateTeam;
  });

export const useUpdateTeam = () => {
  const mutationKey = 'updateTeam';

  const processData = (data: any): Team => {
    return data.updateTeam;
  };

  return useApiMutation<any, Team>(
    gql`
      mutation UpdateTeam($updateTeamInput: UpdateTeamInput!) {
        updateTeam(updateTeamInput: $updateTeamInput) {
          id
          name
        }
      }
    `,
    processData,
  );
};

export const useCreateTeam = () => {
  const mutationKey = 'createTeam';

  const processData = (data: any): Team => {
    return data.createTeam;
  };

  return useApiMutation<any, Team>(
    gql`
      mutation CreateTeam($createTeamInput: CreateTeamInput!) {
        createTeam(createTeamInput: $createTeamInput) {
          id
          name
        }
      }
    `,
    processData,
  );
};
