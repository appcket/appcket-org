import React from 'react';
import Typography from '@mui/material/Typography';
import { NavLink } from 'react-router-dom';
import { DataGrid, GridRowsProp, GridColDef } from '@mui/x-data-grid';

import Page from 'src/common/components/Page';
import { useSearchTeams } from 'src/common/api/team';

const ViewTeams = () => {
  // TODO: user input from Team name filter input field should drive table results
  const { status, data, error } = useSearchTeams('');

  let teamsComponent = <Typography paragraph>Unable to view Teams</Typography>;

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
    data?.forEach((team) => {
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
      <Typography variant="h4" gutterBottom>
        Teams
      </Typography>
      <div>{teamsComponent}</div>
    </Page>
  );
};

export default ViewTeams;
