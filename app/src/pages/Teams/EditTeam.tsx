import { useEffect } from 'react';
import { useForm } from 'react-hook-form';
import { useNavigate, useParams } from 'react-router-dom';
import Button from '@mui/material/Button';
import Grid from '@mui/material/Grid';
import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';
import { useSnackbar } from 'notistack';
import { get } from 'lodash';

import Page from 'src/common/components/Page';
import PageHeader from 'src/common/components/PageHeader';
import UpdateTeamMutationInput from 'src/common/models/inputs/UpdateTeamMutationInput';
import { useGetTeam, useUpdateTeam } from 'src/common/api/team';
import Team from 'src/common/models/Team';
import User from 'src/common/models/User';
import { FormTextField } from 'src/common/components/form/FormTextField';
import ResourceUsersGrid from 'src/common/components/ResourceUsersGrid';
import { useStore } from 'src/common/store';
import CancelButton from 'src/common/components/buttons/CancelButton';
import Loading from 'src/common/components/Loading';

const EditTeam = () => {
  const params = useParams();
  let teamId = '';
  if (params.teamId) {
    teamId = params.teamId;
  }
  const navigate = useNavigate();
  const { enqueueSnackbar } = useSnackbar();
  const {
    formState: { isValid },
    handleSubmit,
    reset,
    control,
  } = useForm<UpdateTeamMutationInput>({
    mode: 'all',
    defaultValues: {
      name: '',
    },
  });

  const getTeamQuery = useGetTeam(teamId);
  const updateTeam = useUpdateTeam();
  const resetSelectedUserIds = useStore((state) => state.resourceUsers.resetSelectedUserIds);
  const selectedUserIds = useStore((state) => state.resourceUsers.selectedUserIds);

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
      resourceUsers: {
        ...state.resourceUsers,
        selectedUserIds: initialSelectedItemIds(getTeamQuery?.data?.users as User[], 'user_id'),
      },
    }));
  }, [reset, getTeamQuery.data]);

  useEffect(() => {
    useStore.setState((state) => ({
      resourceUsers: {
        ...state.resourceUsers,
        initialSelectedUserIds: initialSelectedItemIds(
          getTeamQuery?.data?.users as User[],
          'user_id',
        ),
      },
    }));
  }, [getTeamQuery?.data?.users]);

  let editTeamComponent;

  if (getTeamQuery.status === 'loading' || getTeamQuery.isFetching) {
    editTeamComponent = <Loading />;
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
      <Paper elevation={1} sx={{ my: { xs: 3, md: 3 }, p: { xs: 2, md: 3 } }}>
        <Grid container justifyContent="flex-end">
          <Grid item>
            <CancelButton linkTo={`../${teamId}`} />
          </Grid>
        </Grid>
        <Typography variant="body1" sx={{ mb: 3 }}>
          Organization: {getTeamQuery.data.organization.name}
        </Typography>
        <Grid item xs={24} sm={12} sx={{ mb: 2 }}>
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
        </Grid>

        {/* instead of passing selectedUsers prop to child components, we use zustand to hold local state.
            In this case, it tracks initially selected users and user-selected users so the 
            parent component can have this data and send it back to the api onSubmit*/}
        <ResourceUsersGrid organizationId={getTeamQuery.data.organization.organization_id} />

        <Grid container justifyContent="flex-end" sx={{ mt: 8 }}>
          <Grid item>
            <Button
              onClick={() => {
                reset();
                resetSelectedUserIds();
              }}
              variant="outlined"
            >
              Reset
            </Button>
            <Button
              onClick={handleSubmit(onSubmit)}
              variant="contained"
              disabled={!isValid}
              sx={{ mx: 1 }}
            >
              Save
            </Button>
          </Grid>
        </Grid>
      </Paper>
    );
  }

  return (
    <Page title={`Edit Team - ${getTeamQuery.data?.name}`}>
      <PageHeader title={getTeamQuery.data?.name} subTitle="Edit team details" />
      <div>{editTeamComponent}</div>
    </Page>
  );
};

export default EditTeam;
