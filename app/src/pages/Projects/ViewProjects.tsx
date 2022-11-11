import { useQuery } from '@tanstack/react-query';
import Typography from '@mui/material/Typography';
import { Link, NavLink } from 'react-router-dom';
import { DataGrid, GridRowsProp, GridColDef } from '@mui/x-data-grid';
import Button from '@mui/material/Button';
import Grid from '@mui/material/Grid';

import AddCircleOutlineOutlinedIcon from '@mui/icons-material/AddCircleOutlineOutlined';
import Page from 'src/common/components/Page';
import PageHeader from 'src/common/components/PageHeader';
import { useSearchProjects } from 'src/common/api/project';
import hasPermission from 'src/common/utils/hasPermission';
import { ProjectPermission } from 'src/common/enums/permissions.enum';
import Resources from 'src/common/enums/resources.enum';
import UserInfoResponse from 'src/common/models/responses/UserInfoResponse';
import Permission from 'src/common/models/Permission';
import Loading from 'src/common/components/Loading';

const ViewProjects = () => {
  // TODO: user input from Project name filter input field should drive table results
  const { status, data, error } = useSearchProjects('');
  const userInfoQuery = useQuery<UserInfoResponse>(['userInfo']);
  const createProjectPermission = hasPermission(
    userInfoQuery.data?.userInfo.permissions as Permission[],
    Resources.Project,
    ProjectPermission.create,
  );

  let createProjectButton = (
    <Button variant="outlined" startIcon={<AddCircleOutlineOutlinedIcon />} disabled>
      Create Project
    </Button>
  );

  if (createProjectPermission) {
    createProjectButton = (
      <Button
        variant="contained"
        component={Link}
        to="create"
        startIcon={<AddCircleOutlineOutlinedIcon />}
      >
        Create Project
      </Button>
    );
  }

  let projectsComponent = <Typography paragraph>Unable to view Projects</Typography>;

  const columns: GridColDef[] = [
    {
      field: 'name',
      headerName: 'Name',
      flex: 0.25,
      renderCell: (cellValues) => {
        return <NavLink to={`/projects/${cellValues.row.id}`}>{cellValues.row.name}</NavLink>;
      },
    },
    {
      field: 'organization',
      headerName: 'Organization',
      flex: 0.75,
      renderCell: (cellValues) => cellValues.row.organization.name,
    },
  ];

  if (status === 'loading') {
    projectsComponent = <Loading />;
  } else if (status === 'error' && error instanceof Error) {
    projectsComponent = <Typography paragraph>Error: {error.message}</Typography>;
  } else {
    const rows: GridRowsProp = data ? data : [];

    projectsComponent = (
      <DataGrid disableSelectionOnClick={true} rows={rows} columns={columns} autoHeight={true} />
    );
  }

  return (
    <Page title="Projects">
      <PageHeader title="Projects" subTitle="Manage projects for an organization">
        <Grid container justifyContent="flex-end">
          <Grid>{createProjectButton}</Grid>
        </Grid>
      </PageHeader>
      {projectsComponent}
    </Page>
  );
};

export default ViewProjects;
