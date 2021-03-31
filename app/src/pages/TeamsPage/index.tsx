import React from 'react';
import { Container } from '@material-ui/core';
import Typography from '@material-ui/core/Typography';
import { useKeycloak } from '@react-keycloak/web';
import { useQuery } from 'react-query';
import { GraphQLClient, gql } from 'graphql-request';
import { get } from 'lodash';

import { TeamNode } from 'src/common/types/team.type';
import Page from 'src/components/Page';

const endpoint = get(process.env, 'REACT_APP_API_URL', 'https://api.appcket.com');

const TeamsPage = () => {
  const { keycloak } = useKeycloak();
  const graphQLClient = new GraphQLClient(endpoint, {
    headers: {
      authorization: `Bearer ${keycloak.token}`,
    },
  });

  function useTeams() {
    return useQuery('teams', async () => {
      const data = await graphQLClient.request(
        gql`
          {
            teams {
              pageInfo {
                hasNextPage
                hasPreviousPage
                startCursor
                endCursor
              }
              edges {
                node {
                  team_id
                  name
                  created_at
                  effective_at
                }
                cursor
              }
            }
          }
        `,
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
        {data.teams.edges.map((teamNode: TeamNode) => {
          return <li key={teamNode.node.team_id}>{teamNode.node.name}</li>;
        })}
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
