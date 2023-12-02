import { useParams } from 'react-router-dom';
import Grid from '@mui/material/Grid';
import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemText from '@mui/material/ListItemText';

import { useUserInfo } from 'src/common/api/user';
import Loading from 'src/common/components/Loading';
import Page from 'src/common/components/Page';
import PageHeader from 'src/common/components/PageHeader';
import { useGetTeam } from 'src/common/api/team';
import hasPermission from 'src/common/utils/hasPermission';
import { TeamPermission } from 'src/common/enums/permissions.enum';
import Resources from 'src/common/enums/resources.enum';
import Permission from 'src/common/models/Permission';
import EditButton from 'src/common/components/buttons/EditButton';
import { displayUser } from 'src/common/utils/general';
import EntityHistory from 'src/common/components/EntityHistory';

const Team = () => {
  const params = useParams();
  const teamId = params.teamId || '';
  const userInfo = useUserInfo();

  const updateTeamPermission = hasPermission(
    userInfo.data?.permissions as Permission[],
    Resources.Team,
    TeamPermission.update,
  );
  const readTeamHistoryPermission = hasPermission(
    userInfo.data?.permissions as Permission[],
    Resources.Team,
    TeamPermission.readHistory,
  );
  const { status, data, error, isFetching, isLoading } = useGetTeam(teamId);

  let teamComponent;
  let entityHistoryComponent;

  if (isLoading || isFetching) {
    teamComponent = <Loading />;
  } else if (status === 'error' && error instanceof Error) {
    teamComponent = <Typography paragraph>Error: {error.message}</Typography>;
  } else {
    teamComponent = <Typography paragraph>Unable to view Team</Typography>;

    let updateTeamButton = <EditButton variant="outlined" isDisabled={true} />;

    if (updateTeamPermission) {
      updateTeamButton = <EditButton variant="contained" isDisabled={false} linkTo="edit" />;
    }

    if (readTeamHistoryPermission) {
      entityHistoryComponent = <EntityHistory entityId={teamId} entityType={Resources.Team} />;
    }

    const usersComponent = (
      <div>
        <Typography variant="body1">
          Users: {data?.users.length === 0 ? 'No users associated with this team' : null}
        </Typography>
        <List>
          {data?.users.map((user) => (
            <ListItem key={user.id}>
              <ListItemText primary={displayUser(user)} />
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
          <Typography variant="body1">Description: {data?.description}</Typography>
          {usersComponent}
        </Grid>
        {entityHistoryComponent}
      </Paper>
    );
  }

  return (
    <Page title={`Team - ${data?.name}`}>
      <PageHeader title={data?.name} subTitle="Team details" />
      {teamComponent}
    </Page>
  );
};

export default Team;
