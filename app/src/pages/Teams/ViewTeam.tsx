import { useParams } from 'react-router-dom';
import { useQuery } from '@tanstack/react-query';
import Grid from '@mui/material/Grid';
import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemText from '@mui/material/ListItemText';

import Page from 'src/common/components/Page';
import PageHeader from 'src/common/components/PageHeader';
import { useGetTeam } from 'src/common/api/team';
import hasPermission from 'src/common/utils/hasPermission';
import { TeamPermission } from 'src/common/enums/permissions.enum';
import Resources from 'src/common/enums/resources.enum';
import UserInfoQueryResponse from 'src/common/models/responses/UserInfoQueryResponse';
import Permission from 'src/common/models/Permission';
import EditButton from 'src/common/components/buttons/EditButton';

const Team = () => {
  const params = useParams();
  const teamId = params.teamId || '';
  const userInfoQuery = useQuery<UserInfoQueryResponse>(['userInfo']);

  const updateTeamPermission = hasPermission(
    userInfoQuery.data?.userInfo.permissions as Permission[],
    Resources.Team,
    TeamPermission.update,
  );
  const { status, data, error, isFetching } = useGetTeam(teamId!);

  let teamComponent;

  if (status === 'loading' || isFetching) {
    teamComponent = <Typography paragraph>Loading...</Typography>;
  } else if (status === 'error' && error instanceof Error) {
    teamComponent = <Typography paragraph>Error: {error.message}</Typography>;
  } else {
    teamComponent = <Typography paragraph>Unable to view Team</Typography>;

    let updateTeamButton = <EditButton variant="outlined" isDisabled={true} />;

    if (updateTeamPermission) {
      updateTeamButton = <EditButton variant="contained" isDisabled={false} linkTo="edit" />;
    }

    const usersComponent = (
      <div>
        <Typography variant="body1">Users:</Typography>
        <List>
          {data?.users.map((user) => (
            <ListItem key={user.user_id}>
              <ListItemText primary={user.firstName} />
            </ListItem>
          ))}
        </List>
      </div>
    );
    teamComponent = (
      <Paper elevation={1} sx={{ my: { xs: 3, md: 3 }, p: { xs: 2, md: 3 } }}>
        <Grid container justifyContent="flex-end">
          <Grid item>{updateTeamButton}</Grid>
        </Grid>
        <Grid item xs={12} sm={6}>
          <Typography variant="body1">Organization: {data?.organization.name}</Typography>
          {usersComponent}
        </Grid>
      </Paper>
    );
  }

  return (
    <Page title={`Team - ${data?.name}`}>
      <PageHeader title={data?.name} subTitle="Team details" />
      <div>{teamComponent}</div>
    </Page>
  );
};

export default Team;
