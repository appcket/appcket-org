import { useAuth } from 'react-oidc-context';
import { useMutation, useQuery } from '@tanstack/react-query';
import { GraphQLClient, Variables } from 'graphql-request';
import { useSnackbar } from 'notistack';

const endpoint = import.meta.env?.VITE_API_URL ?? 'https://api.appcket.org';

export const useApiQuery = <T, U>(
  queryKey: string[],
  query: string,
  processData?: (data: T) => U,
  staleTime = 0,
  gcTime = 300000,
) => {
  const auth = useAuth();
  return useQuery({
    queryKey,
    staleTime,
    gcTime,
    queryFn: async () => {
      const graphQLClient = new GraphQLClient(endpoint, {
        headers: {
          authorization: `Bearer ${auth.user?.access_token}`,
        },
      });

      const data = await (<T>graphQLClient.request(query));

      return data;
    },
    select: processData,
  });
};

export const useApiMutation = <T, U>(mutation: string, processData?: (data: T) => U) => {
  const auth = useAuth();
  const { enqueueSnackbar } = useSnackbar();

  return useMutation({
    mutationFn: async (inputVars: Variables) => {
      const graphQLClient = new GraphQLClient(endpoint, {
        headers: {
          authorization: `Bearer ${auth.user?.access_token}`,
        },
      });

      try {
        const data = await graphQLClient.request(mutation, inputVars);
        if (processData) return processData(<T>data);
      } catch (error) {
        const message = JSON.stringify(error, undefined, 2);

        enqueueSnackbar(message, {
          variant: 'error',
        });
      }
    },
  });
};
