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
    {
      field: 'updated_at',
      headerName: 'Updated',
      width: 250,
      type: 'dateTime',
      valueGetter: ({ value }) =>
        value &&
        new Intl.DateTimeFormat('en-US', {
          weekday: 'short',
          year: 'numeric',
          month: 'short',
          day: '2-digit',
          hour: '2-digit',
          minute: '2-digit',
          second: '2-digit',
          hour12: true,
        }).format(new Date(value)),
    },
  ];

  if (status === 'loading') {
    teamsComponent = <Typography paragraph>Loading...</Typography>;
  } else if (status === 'error' && error instanceof Error) {
    teamsComponent = <Typography paragraph>Error: {error.message}</Typography>;
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
      <Typography variant="h4" gutterBottom>
          Teams
        </Typography>
        <div>{teamsComponent}</div>
      </Container>
    </Page>
  );
};

export default Teams;
