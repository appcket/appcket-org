import { useEffect } from 'react';
import { useForm } from 'react-hook-form';
import Button from '@mui/material/Button';
import Grid from '@mui/material/Grid';
import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';
import { useNavigate } from 'react-router-dom';
import { useSnackbar } from 'notistack';
import { get } from 'lodash';

import { useUserInfo } from 'src/common/api/user';
import Page from 'src/common/components/Page';
import PageHeader from 'src/common/components/PageHeader';
import CreateTeamInput from 'src/common/models/inputs/CreateTeamInput';
import { useCreateTeam } from 'src/common/api/team';
import Team from 'src/common/models/Team';
import User from 'src/common/models/User';
import { FormTextField } from 'src/common/components/form/FormTextField';
import FormSelectMenu from 'src/common/components/form/FormSelectMenu';
import ResourceUsersGrid from 'src/common/components/ResourceUsersGrid';
import { useStore } from 'src/common/store';
import UserInfoResponse from 'src/common/models/responses/UserInfoResponse';
import CancelButton from 'src/common/components/buttons/CancelButton';
import Loading from 'src/common/components/Loading';

const CreateTeam = () => {
  const navigate = useNavigate();
  const { enqueueSnackbar } = useSnackbar();
  const {
    watch,
    formState: { isValid },
    handleSubmit,
    reset,
    control,
  } = useForm<CreateTeamInput>({
    mode: 'all',
    defaultValues: {
      name: '',
      description: '',
      organizationId: '',
    },
  });

  const watchOrganizationId = watch('organizationId', '');
  const createTeam = useCreateTeam();
  const resetSelectedUserIds = useStore((state) => state.resourceUsers.resetSelectedUserIds);
  const selectedUserIds = useStore((state) => state.resourceUsers.selectedUserIds);
  const userInfo = useUserInfo();

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
    reset({ name: '', description: '', organizationId: '' });
    useStore.setState((state) => ({
      resourceUsers: {
        ...state.resourceUsers,
        selectedUserIds: initialSelectedItemIds([] as User[], 'user_id'),
      },
    }));
  }, [reset]);

  const onSubmit = async (createTeamInput: CreateTeamInput) => {
    createTeamInput.userIds = selectedUserIds;

    createTeam.mutate(
      { createTeamInput },
      {
        onSuccess: (data) => {
          const createdTeam = data as Team;
          enqueueSnackbar(`Team created: ${createdTeam.name}`, {
            variant: 'success',
          });
          navigate('/teams');
        },
      },
    );
  };

  let organizationSelectMenu;
  let organizationUsersGrid;

  if (userInfo.isLoading || userInfo.isFetching) {
    organizationSelectMenu = <Loading />;
    organizationUsersGrid = <Loading />;
  } else if (userInfo.status === 'error' && userInfo.error instanceof Error) {
    organizationSelectMenu = <Typography paragraph>Error: {userInfo.error.message}</Typography>;
  } else if (userInfo.isSuccess) {
    const options = userInfo.data.organizations?.map((organization) => {
      return { id: organization.id, label: organization.name };
    });
    organizationSelectMenu = (
      <FormSelectMenu
        name="organizationId"
        className="mb-4"
        control={control}
        label="Organization"
        options={options}
        rules={{
          required: { value: true, message: 'This field is required' },
        }}
      />
    );

    organizationUsersGrid = (
      <ResourceUsersGrid resourceType="Team" organizationId={watchOrganizationId} />
    );
  }

  const createTeamComponent = (
    <Paper elevation={1} sx={{ my: { xs: 3, md: 3 }, p: { xs: 2, md: 3 } }}>
      <Grid item xs={24} sm={12} sx={{ mb: 2 }}>
        {organizationSelectMenu}

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

      <FormTextField
        name="description"
        control={control}
        label="Description"
        multiline
        rows={3}
        rules={{
          maxLength: { value: 500, message: 'This field must be less than 500 characters' },
        }}
      />

      {watchOrganizationId && organizationUsersGrid}

      <Grid container justifyContent="flex-end" sx={{ mt: 3 }}>
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

  return (
    <Page title="New Team">
      <PageHeader title="New Team" subTitle="Create a new team for an organization">
        <Grid container justifyContent="flex-end">
          <Grid>
            <CancelButton linkTo="../" />
          </Grid>
        </Grid>
      </PageHeader>
      <div>{createTeamComponent}</div>
    </Page>
  );
};

export default CreateTeam;
