import { useKeycloak } from '@react-keycloak/web';
import { UseMutationResult, useMutation, useQuery, UseQueryResult } from 'react-query';
import { GraphQLClient } from 'graphql-request';
import { get } from 'lodash';

const endpoint = get(process.env, 'REACT_APP_API_URL', 'https://api.appcket.org');

// @ts-ignore
export const useApiQuery = (queryKey: string, query: string, processData?) => {
  const { keycloak } = useKeycloak();
  return useQuery(
    queryKey,
    async () => {
      const graphQLClient = new GraphQLClient(endpoint, {
        headers: {
          authorization: `Bearer ${keycloak.token}`,
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
  const { keycloak } = useKeycloak();
  return useMutation(async (inputVars) => {
    const graphQLClient = new GraphQLClient(endpoint, {
      headers: {
        authorization: `Bearer ${keycloak.token}`,
      },
    });

    let data = await graphQLClient.request(mutation, inputVars);

    return processData(data);
  });
};
