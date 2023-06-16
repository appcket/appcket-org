import { useQuery } from '@tanstack/react-query';
import Typography from '@mui/material/Typography';
import { Link, NavLink } from 'react-router-dom';
import { DataGrid, GridRowsProp, GridColDef } from '@mui/x-data-grid';
import Button from '@mui/material/Button';
import Grid from '@mui/material/Unstable_Grid2/Grid2';
import { AddCircleOutlineOutlined } from '@mui/icons-material';

import Page from 'src/common/components/Page';
import PageHeader from 'src/common/components/PageHeader';
import { useSearchTeams } from 'src/common/api/team';
import hasPermission from 'src/common/utils/hasPermission';
import { TeamPermission } from 'src/common/enums/permissions.enum';
import Resources from 'src/common/enums/resources.enum';
import UserInfoResponse from 'src/common/models/responses/UserInfoResponse';
import Permission from 'src/common/models/Permission';
import Loading from 'src/common/components/Loading';

const ViewTeams = () => {
  // TODO: user input from Team name filter input field should drive table results
  const { status, data, error } = useSearchTeams('');

  const userInfoQuery = useQuery<UserInfoResponse>(['userInfo']);
  const createTeamPermission = hasPermission(
    userInfoQuery.data?.userInfo.permissions as Permission[],
    Resources.Team,
    TeamPermission.create,
  );

  let createTeamButton = (
    <Button variant="outlined" startIcon={<AddCircleOutlineOutlined />} disabled>
      Create Team
    </Button>
  );

  if (createTeamPermission) {
    createTeamButton = (
      <Button
        variant="contained"
        component={Link}
        to="create"
        startIcon={<AddCircleOutlineOutlined />}
      >
        Create Team
      </Button>
    );
  }

  let teamsComponent = <Typography paragraph>Unable to view Teams</Typography>;

  const columns: GridColDef[] = [
    {
      field: 'name',
      headerName: 'Name',
      flex: 0.25,
      renderCell: (cellValues) => {
        return <NavLink to={`/teams/${cellValues.row.id}`}>{cellValues.row.name}</NavLink>;
      },
    },
  ];

  if (status === 'loading') {
    teamsComponent = <Loading />;
  } else if (status === 'error' && error instanceof Error) {
    teamsComponent = <Typography paragraph>Error: {error.message}</Typography>;
  } else {
    const rows: GridRowsProp = data ? data : [];

    teamsComponent = (
      <DataGrid disableRowSelectionOnClick rows={rows} columns={columns} autoHeight={true} />
    );
  }

  return (
    <Page title="Teams">
      <PageHeader title="Teams" subTitle="Manage teams for an organization">
        <Grid container justifyContent="flex-end">
          <Grid>{createTeamButton}</Grid>
        </Grid>
      </PageHeader>

      {teamsComponent}
    </Page>
  );
};

export default ViewTeams;
