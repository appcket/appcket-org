import React from 'react';
import { Container } from '@mui/material';
import Typography from '@mui/material/Typography';
import { useKeycloak } from '@react-keycloak/web';
import { useQuery } from 'react-query';
import { GraphQLClient, gql } from 'graphql-request';
import { get } from 'lodash';
import { NavLink } from 'react-router-dom';
import { DataGrid, GridRowsProp, GridColDef } from '@mui/x-data-grid';

import TeamGrid from 'src/common/models/TeamGrid';
import Page from 'src/components/Page';

const endpoint = get(process.env, 'REACT_APP_API_URL', 'https://api.appcket.org');

const Teams = () => {
  const { keycloak } = useKeycloak();
  const graphQLClient = new GraphQLClient(endpoint, {
    headers: {
      authorization: `Bearer ${keycloak.token}`,
    },
  });

  function useTeams() {
    return useQuery('searchTeams', async () => {
      let data = await graphQLClient.request(
        gql`
          {
            searchTeams(searchString: "") {
              team_id
              name
              created_at
              effective_at
            }
          }
        `,
      );

      // convert api data to mui grid-compatible data
      data.searchTeams.forEach((team: TeamGrid) => {
        team.id = team.team_id;
      });

      return data;
    });
  }

  const { status, data, error } = useTeams();

  let teamsComponent;

  const columns: GridColDef[] = [
    { field: 'name', headerName: 'Name', width: 150, renderCell: (cellValues) => {
      return <NavLink to={`/teams/${cellValues.row.team_id}`}>{cellValues.row.name}</NavLink>;
    } },
    { field: 'effective_at', headerName: 'Updated', width: 150, type: 'dateTime', },
  ];

  keycloak
    .updateToken(250)
    .then(function (refreshed) {
      if (refreshed) {
        console.log('Token was successfully refreshed');
      } else {
        console.log('Token is still valid');
      }
    })
    .catch(function () {
      console.log('Failed to refresh the token, or the session has expired');
    });

  if (status === 'loading') {
    teamsComponent = <Typography paragraph>Loading...</Typography>;
  } else if (status === 'error') {
    teamsComponent = (
      // @ts-ignore
      <Typography paragraph>Error: {error.response.error}</Typography>
    );
  } else {
    const rows: GridRowsProp = data.searchTeams;

    teamsComponent = (
      <div style={{ height: 300, width: '100%' }}>
        <DataGrid disableSelectionOnClick={true} rows={rows} columns={columns} />
      </div>
    );
  }

  return (
    <Page title="Teams">
      <Container maxWidth="lg">
        <h1>Teams</h1>
        <div>{teamsComponent}</div>
      </Container>
    </Page>
  );
};

export default Teams;
