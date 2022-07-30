import { useAuth } from "react-oidc-context";
import { UseMutationResult, useMutation, useQuery } from '@tanstack/react-query';
import { GraphQLClient } from 'graphql-request';
import { get } from 'lodash';
import { useSnackbar } from 'notistack';

const endpoint = get(process.env, 'REACT_APP_API_URL', 'https://api.appcket.org');

// @ts-ignore
export const useApiQuery = (queryKey: string[], query: string, processData?) => {
  const auth = useAuth();
  return useQuery(
    queryKey,
    async () => {
      const graphQLClient = new GraphQLClient(endpoint, {
        headers: {
          authorization: `Bearer ${auth.user?.access_token}`,
        },
      });

      let data = await graphQLClient.request(query);

      return data;
    },
    {
      select: processData,
    },
  );
};

// @ts-ignore
export const useApiMutation = (mutation: string, processData?): UseMutationResult<unknown> => {
  const auth = useAuth();
  const { enqueueSnackbar } = useSnackbar();
  return useMutation(async (inputVars) => {
    const graphQLClient = new GraphQLClient(endpoint, {
      headers: {
        authorization: `Bearer ${auth.user?.access_token}`,
      },
    });

    try {
      const data = await graphQLClient.request(mutation, inputVars);
      return processData(data);
    } catch (error) {
      // @ts-ignore
      enqueueSnackbar(error.response.errors[0].extensions.response.message[0], {
        variant: 'error',
      });
    }
  });
};
