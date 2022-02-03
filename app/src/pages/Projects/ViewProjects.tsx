import React from 'react';
import Typography from '@mui/material/Typography';
import { NavLink } from 'react-router-dom';
import { DataGrid, GridRowsProp, GridColDef } from '@mui/x-data-grid';

import Page from 'src/common/components/Page';
import { useSearchProjects } from 'src/common/api/project';

const ViewProjects = () => {
  // TODO: user input from Project name filter input field should drive table results
  const { status, data, error } = useSearchProjects('');

  let projectsComponent = <Typography paragraph>Unable to view Projects</Typography>;

  const columns: GridColDef[] = [
    {
      field: 'name',
      headerName: 'Name',
      width: 150,
      renderCell: (cellValues) => {
        return <NavLink to={`/projects/${cellValues.row.project_id}`}>{cellValues.row.name}</NavLink>;
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
    projectsComponent = <Typography paragraph>Loading...</Typography>;
  } else if (status === 'error' && error instanceof Error) {
    projectsComponent = <Typography paragraph>Error: {error.message}</Typography>;
  } else {
    // convert api data to mui grid-compatible data
    data?.forEach((project) => {
      project.id = project.project_id;
    });

    const rows: GridRowsProp = data!;

    projectsComponent = (
      <div style={{ height: 300, width: '100%' }}>
        <DataGrid disableSelectionOnClick={true} rows={rows} columns={columns} />
      </div>
    );
  }

  return (
    <Page title="Projects">
      <Typography variant="h4" gutterBottom>
        Projects
      </Typography>
      <div>{projectsComponent}</div>
    </Page>
  );
};

export default ViewProjects;
