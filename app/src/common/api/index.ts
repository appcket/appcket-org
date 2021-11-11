import { useKeycloak } from '@react-keycloak/web';
import { useQuery } from 'react-query';
import { GraphQLClient } from 'graphql-request';
import { get } from 'lodash';

const endpoint = get(process.env, 'REACT_APP_API_URL', 'https://api.appcket.org');

// @ts-ignore
export const useApiQuery = (queryName: string, query: string, select?) => {
  const { keycloak } = useKeycloak();
  return useQuery(
    queryName,
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
      select,
    },
  );
};

export const useApiMutation = (mutation: string) => {
  // TODO: add mutation operation
};
