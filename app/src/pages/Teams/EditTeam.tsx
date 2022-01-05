import React, { useEffect } from 'react';
import { useForm } from 'react-hook-form';
import { useParams } from 'react-router-dom';
import Container from '@mui/material/Container';
import Button from '@mui/material/Button';
import Grid from '@mui/material/Grid';
import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemText from '@mui/material/ListItemText';
import { useNavigate } from 'react-router-dom';

import Page from 'src/common/components/Page';
import UpdateTeamMutationInput from 'src/common/models/inputs/UpdateTeamMutationInput';
import { useGetTeam, useUpdateTeam } from 'src/common/api/team';
import { FormTextField } from 'src/common/components/form/FormTextField';

const EditTeam = () => {
  const params = useParams();
  const getTeamsQuery = useGetTeam(params.teamId!);
  const updateTeam = useUpdateTeam();
  let navigate = useNavigate();

  const {
    formState: { isValid },
    handleSubmit,
    reset,
    control,
  } = useForm<UpdateTeamMutationInput>({ mode: 'all' });

  const onSubmit = async (updateTeamInput: UpdateTeamMutationInput) => {
    if (getTeamsQuery.isSuccess) {
      updateTeamInput.organizationId = getTeamsQuery.data.organization.organization_id;
      updateTeamInput.teamId = getTeamsQuery.data.team_id;
      updateTeamInput.userIds = [
        '4379775d-7629-4dca-9dd0-8781329569b1',
        'cd88e2db-00bb-474f-91d2-2096e10f86a1',
      ];

      updateTeam.mutate({ updateTeamInput }, { onSuccess: (data) => navigate('/teams') });
    }
  };

  useEffect(() => {
    reset({ name: getTeamsQuery?.data?.name ?? '' });
  }, [reset, getTeamsQuery.data]);

  let editTeamComponent;

  if (getTeamsQuery.status === 'loading' || getTeamsQuery.isFetching) {
    editTeamComponent = <Typography paragraph>Loading...</Typography>;
  } else if (getTeamsQuery.status === 'error' && getTeamsQuery.error instanceof Error) {
    editTeamComponent = <Typography paragraph>Error: {getTeamsQuery.error.message}</Typography>;
  } else if (getTeamsQuery.isSuccess) {
    editTeamComponent = <Typography paragraph>Unable to view Team</Typography>;

    const usersComponent = (
      <div>
        <Typography variant="body1">Users:</Typography>
        <List>
          {getTeamsQuery.data.users.map((user) => (
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
          {getTeamsQuery.data.name}
        </Typography>

        <FormTextField
          name="name"
          control={control}
          label="Team Name"
          rules={{
            required: { value: true, message: 'This field is required' },
            maxLength: { value: 50, message: 'This field must be less than 50 characters' },
            minLength: { value: 1, message: 'This field must be more than 1 character' },
          }}
        />

        <Button onClick={handleSubmit(onSubmit)} variant="contained" disabled={!isValid}>
          Save
        </Button>
        <Button onClick={() => reset()} variant="outlined">
          Reset
        </Button>

        <Paper elevation={1} sx={{ my: { xs: 3, md: 6 }, p: { xs: 2, md: 3 } }}>
          <Grid item xs={12} sm={6}>
            <Typography variant="body1">Organization:</Typography>
            <Typography variant="body1" gutterBottom>
              {getTeamsQuery.data.organization.name}
            </Typography>
            {usersComponent}
          </Grid>
        </Paper>
      </div>
    );
  }

  return (
    <Page title={`Edit Team - ${getTeamsQuery.data?.name}`}>
      <Container maxWidth="lg">
        <div>{editTeamComponent}</div>
      </Container>
    </Page>
  );
};

export default EditTeam;
