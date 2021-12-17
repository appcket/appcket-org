import React from 'react';
import { useForm } from 'react-hook-form';
import { useParams } from 'react-router-dom';
import Box from '@mui/material/Box';
import Container from '@mui/material/Container';
import Button from '@mui/material/Button';
import Grid from '@mui/material/Grid';
import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemText from '@mui/material/ListItemText';
import TextField from '@mui/material/TextField';

import Page from 'src/common/components/Page';
import Team from 'src/common/models/Team';
import { useTeamById } from 'src/common/api/team';

const EditTeam = () => {
  const params = useParams();
  const {
    register,
    handleSubmit,
    watch,
    formState: { errors },
  } = useForm<Team>();
  const onSubmit = (data: unknown) => console.log(data);
  const { status, data, error, isFetching } = useTeamById(params.teamId!);

  let editTeamComponent;

  if (status === 'loading' || isFetching) {
    editTeamComponent = <Typography paragraph>Loading...</Typography>;
  } else if (status === 'error' && error instanceof Error) {
    editTeamComponent = <Typography paragraph>Error: {error.message}</Typography>;
  } else {
    editTeamComponent = <Typography paragraph>Unable to view Team</Typography>;

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
    editTeamComponent = (
      <div>
        <Typography variant="h4" gutterBottom>
          {data?.name}
        </Typography>

        <Paper elevation={1} sx={{ my: { xs: 3, md: 6 }, p: { xs: 2, md: 3 } }}>
          <Grid item xs={12} sm={6}>
            <Typography variant="body1">Organization:</Typography>
            <Typography variant="body1" gutterBottom>
              {data?.organization.name}
            </Typography>
            {usersComponent}
          </Grid>

          <Box component="form" noValidate onSubmit={handleSubmit(onSubmit)} sx={{ mt: 3 }}>
            <Grid container spacing={2}>
              <Grid item xs={12} sm={6}>
                <TextField
                  required
                  fullWidth
                  id="name"
                  label="Team Name"
                  defaultValue={data?.name}
                  {...register('name')}
                  autoFocus
                />
              </Grid>
            </Grid>
            <Button type="submit" fullWidth variant="contained" sx={{ mt: 3, mb: 2 }}>
              Save
            </Button>
          </Box>
        </Paper>
      </div>
    );
  }

  return (
    <Page title={`Edit Team - ${data?.name}`}>
      <Container maxWidth="lg">
        <div>{editTeamComponent}</div>
      </Container>
    </Page>
  );
};

export default EditTeam;
