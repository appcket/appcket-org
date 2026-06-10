import { createServerFn } from '@tanstack/react-start';
import { GraphQLClient, Variables } from 'graphql-request';
import { QueryKey, useMutation, useQuery } from '@tanstack/react-query';

import { getKeycloakToken } from 'src/lib/auth-tokens';

const endpoint = `${import.meta.env.VITE_API_URL || 'https://api.appcket.test'}`;

/**
 * Server-side executor for GraphQL requests.
 */
export const callApi = createServerFn({ method: 'POST' })
  .inputValidator((d: { query: string; variables?: Variables }) => d)
  .handler(async ({ data }) => {
    const token = await getKeycloakToken();
    if (!token) throw new Error('Unauthorized');

    const client = new GraphQLClient(endpoint, {
      headers: {
        authorization: `Bearer ${token}`,
        'X-Correlation-ID': crypto.randomUUID(),
      },
    });

    return client.request(data.query, data.variables);
  });

interface ApiQueryOptions<T, U> {
  queryKey: QueryKey;
  query: string;
  variables?: Variables;
  select?: (data: T) => U;
  staleTime?: number;
  gcTime?: number;
  placeholderData?: any;
  enabled?: boolean;
}

/**
 * Hook to query the GraphQL API using an options object.
 */
export const useApiQuery = <T, U>({
  queryKey,
  query,
  variables,
  select,
  staleTime = 0,
  gcTime = 300000,
  placeholderData,
  enabled = true,
}: ApiQueryOptions<T, U>) => {
  return useQuery({
    queryKey,
    staleTime,
    gcTime,
    enabled,
    queryFn: async () => {
      try {
        const data = await callApi({ data: { query, variables } });
        return data as T;
      } catch (error) {
        console.error(`useApiQuery Error [${queryKey.join(', ')}]:`, error);
        throw error;
      }
    },
    select,
    placeholderData,
  });
};

/**
 * Hook to execute mutations against the GraphQL API.
 */
export const useApiMutation = <T, U>(mutation: string, processData?: (data: T) => U) => {
  return useMutation({
    mutationFn: async (variables: Variables) => {
      const data = await callApi({ data: { query: mutation, variables } });
      if (processData) return processData(data as T);
      return data as U;
    },
  });
};
