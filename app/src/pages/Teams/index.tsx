import React from 'react';
import { Container } from '@mui/material';
import Typography from '@mui/material/Typography';
import { NavLink } from 'react-router-dom';
import { DataGrid, GridRowsProp, GridColDef } from '@mui/x-data-grid';

import Page from 'src/components/Page';
import TeamGrid from 'src/common/models/TeamGrid';
import { useSearchTeams } from 'src/common/api/team';

const Teams = () => {
  // TODO: user input from Team name filter input field should drive table results
  const { status, data, error } = useSearchTeams('');

  let teamsComponent;

  const columns: GridColDef[] = [
    {
      field: 'name',
      headerName: 'Name',
      width: 150,
      renderCell: (cellValues) => {
        return <NavLink to={`/teams/${cellValues.row.team_id}`}>{cellValues.row.name}</NavLink>;
      },
    },
    { field: 'updated_at', headerName: 'Updated', width: 150, type: 'dateTime' },
  ];

  if (status === 'loading') {
    teamsComponent = <Typography paragraph>Loading...</Typography>;
  } else if (status === 'error') {
    teamsComponent = (
      // @ts-ignore
      <Typography paragraph>Error: {error.response.error}</Typography>
    );
  } else {
    // convert api data to mui grid-compatible data
    data?.forEach((team: TeamGrid) => {
      team.id = team.team_id;
    });

    const rows: GridRowsProp = data!;

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
