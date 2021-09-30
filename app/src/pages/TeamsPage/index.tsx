import React from 'react';
import { Container } from '@material-ui/core';
import Typography from '@material-ui/core/Typography';
import { useKeycloak } from '@react-keycloak/web';
import { useQuery } from 'react-query';
import { GraphQLClient, gql } from 'graphql-request';
import { get } from 'lodash';

import { Team } from 'src/common/types/team.type';
import Page from 'src/components/Page';

const endpoint = get(
  process.env,
  'REACT_APP_API_URL',
  'https://api.appcket.org'
);

const TeamsPage = () => {
  const { keycloak } = useKeycloak();
  const graphQLClient = new GraphQLClient(endpoint, {
    headers: {
      authorization: `Bearer ${keycloak.token}`,
    },
  });

  function useTeams() {
    return useQuery('searchTeams', async () => {
      const data = await graphQLClient.request(
        gql`
          {
            searchTeams(searchString: "") {
              team_id
              name
              created_at
              effective_at
            }
          }
        `
      );

      return data;
    });
  }

  const { status, data, error } = useTeams();

  let teamsComponent;
  if (status === 'loading') {
    teamsComponent = <Typography paragraph>Loading...</Typography>;
  } else if (status === 'error') {
    // @ts-ignore
    teamsComponent = <Typography paragraph>Error: {error.message}</Typography>;
  } else {
    teamsComponent = (
      <ul>
        {data.searchTeams.map((teamNode: Team) => (
          <li key={teamNode.team_id}>{teamNode.name}</li>
        ))}
      </ul>
    );
  }

  return (
    <Page title="Teams">
      <Container maxWidth="lg">
        <h1>Teams</h1>
        <div>{teamsComponent}</div>
        {/* {!!keycloak.authenticated && (
          <textarea className="json-wrapper">{JSON.stringify(keycloak, undefined, 2)}</textarea>
        )} */}
      </Container>
    </Page>
  );
};

export default TeamsPage;
