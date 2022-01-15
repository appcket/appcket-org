import React, { useEffect } from 'react';
import { useForm } from 'react-hook-form';
import { useParams } from 'react-router-dom';
import Container from '@mui/material/Container';
import Button from '@mui/material/Button';
import Grid from '@mui/material/Grid';
import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';
import { useNavigate } from 'react-router-dom';
import { useSnackbar } from 'notistack';
import { get } from 'lodash';

import Page from 'src/common/components/Page';
import UpdateTeamMutationInput from 'src/common/models/inputs/UpdateTeamMutationInput';
import { useGetTeam, useUpdateTeam } from 'src/common/api/team';
import Team from 'src/common/models/Team';
import User from 'src/common/models/User';
import { FormTextField } from 'src/common/components/form/FormTextField';
import TeamUsersGrid from 'src/pages/Teams/TeamUsersGrid';
import { useStore } from 'src/common/store';

const EditTeam = () => {
  const params = useParams();
  const navigate = useNavigate();
  const { enqueueSnackbar } = useSnackbar();
  const {
    formState: { isValid },
    handleSubmit,
    reset,
    control,
  } = useForm<UpdateTeamMutationInput>({ mode: 'all' });

  const getTeamQuery = useGetTeam(params.teamId!);
  const updateTeam = useUpdateTeam();
  const resetSelectedUserIds = useStore((state) => state.teamUsers.resetSelectedUserIds);
  const selectedUserIds = useStore((state) => state.teamUsers.selectedUserIds);

  const initialSelectedItemIds: <T>(items: T[], key: string) => string[] = (
    items,
    key,
  ): string[] => {
    if (items) {
      return items.map((item) => get(item, key));
    }
    return [];
  };

  useEffect(() => {
    reset({ name: getTeamQuery?.data?.name ?? '' });
    useStore.setState((state) => ({
      teamUsers: {
        ...state.teamUsers,
        selectedUserIds: initialSelectedItemIds(getTeamQuery?.data?.users as User[], 'user_id'),
      },
    }));
  }, [reset, getTeamQuery.data]);

  useStore.setState((state) => ({
    teamUsers: {
      ...state.teamUsers,
      initialSelectedUserIds: initialSelectedItemIds(
        getTeamQuery?.data?.users as User[],
        'user_id',
      ),
    },
  }));

  let editTeamComponent;

  if (getTeamQuery.status === 'loading' || getTeamQuery.isFetching) {
    editTeamComponent = <Typography paragraph>Loading...</Typography>;
  } else if (getTeamQuery.status === 'error' && getTeamQuery.error instanceof Error) {
    editTeamComponent = <Typography paragraph>Error: {getTeamQuery.error.message}</Typography>;
  } else if (getTeamQuery.isSuccess) {
    editTeamComponent = <Typography paragraph>Unable to view Team</Typography>;

    const onSubmit = async (updateTeamInput: UpdateTeamMutationInput) => {
      updateTeamInput.organizationId = getTeamQuery.data.organization.organization_id;
      updateTeamInput.teamId = getTeamQuery.data.team_id;
      updateTeamInput.userIds = selectedUserIds;

      updateTeam.mutate(
        { updateTeamInput },
        {
          onSuccess: (data) => {
            const updatedTeam = data as Team;
            enqueueSnackbar(`Updated team successfully: ${updatedTeam.name}`, {
              variant: 'success',
            });
            navigate('/teams');
          },
        },
      );
    };

    editTeamComponent = (
      <div>
        <Typography variant="h4" gutterBottom>
          {getTeamQuery.data.name}
        </Typography>

        <Paper elevation={1} sx={{ my: { xs: 3, md: 6 }, p: { xs: 2, md: 3 } }}>
          <Grid item xs={24} sm={12}>
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
            <Typography variant="body1" gutterBottom>
              Organization: {getTeamQuery.data.organization.name}
            </Typography>

            {/* instead of passing props to child components, we use zustand to hold local state.
            In this case, it tracks initially selected users and user the selected users so the 
            parent component can have this data and send it back to the api onSubmit*/}
            <TeamUsersGrid />

            <Grid container justifyContent="flex-end">
              <Grid item>
                <Button onClick={handleSubmit(onSubmit)} variant="contained" disabled={!isValid}>
                  Save
                </Button>
                <Button
                  onClick={() => {
                    reset();
                    resetSelectedUserIds();
                  }}
                  variant="outlined"
                >
                  Reset
                </Button>
              </Grid>
            </Grid>
          </Grid>
        </Paper>
      </div>
    );
  }

  return (
    <Page title={`Edit Team - ${getTeamQuery.data?.name}`}>
      <Container maxWidth="lg">
        <div>{editTeamComponent}</div>
      </Container>
    </Page>
  );
};

export default EditTeam;
