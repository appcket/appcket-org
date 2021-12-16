import React from 'react';
import { useParams } from 'react-router-dom';
import { useQuery } from 'react-query';
import Container from '@mui/material/Container';
import Button from '@mui/material/Button';
import Grid from '@mui/material/Grid';
import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemText from '@mui/material/ListItemText';

import Page from 'src/common/components/Page';
import { useTeamById } from 'src/common/api/team';
import hasPermission from 'src/common/utils/hasPermission';
import { TeamPermission } from 'src/common/enums/permissions.enum';
import Resources from 'src/common/enums/resources.enum';
import UserInfoQueryResponse from 'src/common/models/responses/UserInfoQueryResponse';
import Permission from 'src/common/models/Permission';

const Team = () => {
  let params = useParams();
  const userInfoQuery = useQuery<UserInfoQueryResponse>('userInfo');

  const readTeamPermission = hasPermission(
    userInfoQuery.data?.userInfo.permissions as Permission[],
    Resources.Team,
    TeamPermission.read,
  );
  const updateTeamPermission = hasPermission(
    userInfoQuery.data?.userInfo.permissions as Permission[],
    Resources.Team,
    TeamPermission.update,
  );
  const { status, data, error, isFetching } = useTeamById(params.teamId!);

  let teamComponent;

  if (status === 'loading' || isFetching) {
    teamComponent = <Typography paragraph>Loading...</Typography>;
  } else if (status === 'error' && error instanceof Error) {
    teamComponent = <Typography paragraph>Error: {error.message}</Typography>;
  } else {
    teamComponent = <Typography paragraph>Unable to view Team</Typography>;

    if (readTeamPermission) {
      let updateTeamButton = (
        <Button variant="outlined" disabled>
          Edit
        </Button>
      );

      if (updateTeamPermission) {
        updateTeamButton = <Button variant="contained">Edit</Button>;
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
        <div>
          <Typography variant="h4" gutterBottom>
            {data?.name}
          </Typography>

          <Paper elevation={1} sx={{ my: { xs: 3, md: 6 }, p: { xs: 2, md: 3 } }}>
            <Grid item xs={12} sm={6}>
              {updateTeamButton}
              <Typography variant="body1">Organization:</Typography>
              <Typography variant="body1" gutterBottom>
                {data?.organization.name}
              </Typography>
              {usersComponent}
            </Grid>
          </Paper>
        </div>
      );
    }
  }

  return (
    <Page title="Team">
      <Container maxWidth="lg">
        <div>{teamComponent}</div>
      </Container>
    </Page>
  );
};

export default Team;
