import React from 'react';
import { Container } from '@mui/material';
import Typography from '@mui/material/Typography';
import { useKeycloak } from '@react-keycloak/web';
import { useQuery } from 'react-query';
import { GraphQLClient, gql } from 'graphql-request';
import { get } from 'lodash';
import { useParams } from "react-router-dom";

import Page from 'src/components/Page';

const endpoint = get(process.env, 'REACT_APP_API_URL', 'https://api.appcket.org');

const Team = () => {
  let params = useParams();
  const { keycloak } = useKeycloak();
  const graphQLClient = new GraphQLClient(endpoint, {
    headers: {
      authorization: `Bearer ${keycloak.token}`,
    },
  });

  function useTeamById() {
    return useQuery('teamById', async () => {
      let data = await graphQLClient.request(
        gql`
          {
            teamById(id: "${params.teamId}") {
              team_id
              name
              created_at
              effective_at
            }
          }
        `,
      );

      return data.teamById;
    });
  }

  const { status, data, error } = useTeamById();

  let teamComponent;

  if (status === 'loading') {
    teamComponent = <Typography paragraph>Loading...</Typography>;
  } else if (status === 'error') {
    teamComponent = (
      // @ts-ignore
      <Typography paragraph>Error: {error.response.error}</Typography>
    );
  } else {
    teamComponent = (
      <div>
        <h1>{data.name}</h1>
      </div>
    );
  }

  return (
    <Page title="Team">
      <Container maxWidth="lg">
        <div>{teamComponent}</div>
      </Container>
    </Page>
  );
};

export default Team;
