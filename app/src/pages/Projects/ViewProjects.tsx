import React from 'react';
import { useQuery } from '@tanstack/react-query';
import Typography from '@mui/material/Typography';
import { Link, NavLink } from 'react-router-dom';
import { DataGrid, GridRowsProp, GridColDef } from '@mui/x-data-grid';
import Button from '@mui/material/Button';
import Grid from '@mui/material/Grid';

import Page from 'src/common/components/Page';
import { useSearchProjects } from 'src/common/api/project';
import hasPermission from 'src/common/utils/hasPermission';
import { ProjectPermission } from 'src/common/enums/permissions.enum';
import Resources from 'src/common/enums/resources.enum';
import UserInfoQueryResponse from 'src/common/models/responses/user/UserInfoQueryResponse';
import Permission from 'src/common/models/Permission';

const ViewProjects = () => {
  // TODO: user input from Project name filter input field should drive table results
  const { status, data, error } = useSearchProjects('');
  const userInfoQuery = useQuery<UserInfoQueryResponse>(['userInfo']);
  const createProjectPermission = hasPermission(
    userInfoQuery.data?.userInfo.permissions as Permission[],
    Resources.Project,
    ProjectPermission.create,
  );

  let createProjectButton = (
    <Button variant="outlined" disabled>
      Create
    </Button>
  );

  if (createProjectPermission) {
    createProjectButton = (
      <Button variant="contained" component={Link} to="create">
        Create
      </Button>
    );
  }

  let projectsComponent = <Typography paragraph>Unable to view Projects</Typography>;

  const columns: GridColDef[] = [
    {
      field: 'name',
      headerName: 'Name',
      width: 150,
      renderCell: (cellValues) => {
        return (
          <NavLink to={`/projects/${cellValues.row.project_id}`}>{cellValues.row.name}</NavLink>
        );
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
      <Grid container justifyContent="flex-end">
        <Grid item>{createProjectButton}</Grid>
      </Grid>
      <div>{projectsComponent}</div>
    </Page>
  );
};

export default ViewProjects;
