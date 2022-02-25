import React, { useEffect } from 'react';
import { useQuery } from 'react-query';
import { useForm } from 'react-hook-form';
import Button from '@mui/material/Button';
import Grid from '@mui/material/Grid';
import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';
import { useNavigate } from 'react-router-dom';
import { useSnackbar } from 'notistack';
import { get } from 'lodash';

import Page from 'src/common/components/Page';
import CreateTeamMutationInput from 'src/common/models/inputs/CreateTeamMutationInput';
import { useCreateTeam } from 'src/common/api/team';
import Team from 'src/common/models/Team';
import Organization from 'src/common/models/Organization';
import User from 'src/common/models/User';
import { FormTextField } from 'src/common/components/form/FormTextField';
import FormSelectMenu from 'src/common/components/form/FormSelectMenu';
import ResourceUsersGrid from 'src/common/components/ResourceUsersGrid';
import { useStore } from 'src/common/store';
import UserInfoQueryResponse from 'src/common/models/responses/user/UserInfoQueryResponse';
import { resourcesToSelectMenuOptions } from 'src/common/utils/form';

const CreateTeam = () => {
  const navigate = useNavigate();
  const { enqueueSnackbar } = useSnackbar();
  const {
    watch,
    formState: { isValid },
    handleSubmit,
    reset,
    control,
  } = useForm<CreateTeamMutationInput>({
    mode: 'all',
    defaultValues: {
      name: '',
      organizationId: '',
    },
  });

  const watchOrganizationId = watch('organizationId', '');
  const createTeam = useCreateTeam();
  const resetSelectedUserIds = useStore((state) => state.resourceUsers.resetSelectedUserIds);
  const selectedUserIds = useStore((state) => state.resourceUsers.selectedUserIds);
  const userInfoQuery = useQuery<UserInfoQueryResponse>('userInfo');

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
    reset({ name: '', organizationId: '' });
    useStore.setState((state) => ({
      resourceUsers: {
        ...state.resourceUsers,
        selectedUserIds: initialSelectedItemIds([] as User[], 'user_id'),
      },
    }));
  }, [reset]);

  let createTeamComponent;

  const onSubmit = async (createTeamInput: CreateTeamMutationInput) => {
    createTeamInput.userIds = selectedUserIds;

    createTeam.mutate(
      { createTeamInput },
      {
        onSuccess: (data) => {
          const createdTeam = data as Team;
          enqueueSnackbar(`Created team successfully: ${createdTeam.name}`, {
            variant: 'success',
          });
          navigate('/teams');
        },
      },
    );
  };

  let organizationSelectMenu;
  let organizationUsersGrid;

  if (userInfoQuery.status === 'loading' || userInfoQuery.isFetching) {
    organizationSelectMenu = <Typography paragraph>Loading...</Typography>;
    organizationUsersGrid = <Typography paragraph>Loading...</Typography>;
  } else if (userInfoQuery.status === 'error' && userInfoQuery.error instanceof Error) {
    organizationSelectMenu = (
      <Typography paragraph>Error: {userInfoQuery.error.message}</Typography>
    );
  } else if (userInfoQuery.isSuccess) {
    const options = resourcesToSelectMenuOptions<Organization>(
      userInfoQuery.data.userInfo.organizations,
      'organization_id',
      'name',
    );
    organizationSelectMenu = (
      <FormSelectMenu
        name="organizationId"
        control={control}
        label="Organization"
        options={options}
        rules={{
          required: { value: true, message: 'This field is required' },
        }}
      />
    );

    organizationUsersGrid = <ResourceUsersGrid organizationId={watchOrganizationId} />;
  }

  createTeamComponent = (
    <div>
      <Typography variant="h4">Create New Team</Typography>

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

        {watchOrganizationId && organizationUsersGrid}

        <Grid container justifyContent="flex-end" sx={{ mt: 8 }}>
          <Grid item>
            <Button
              onClick={handleSubmit(onSubmit)}
              variant="contained"
              disabled={!isValid}
              sx={{ mx: 1 }}
            >
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
      </Paper>
    </div>
  );

  return (
    <Page title="Create New Team">
      <div>{createTeamComponent}</div>
    </Page>
  );
};

export default CreateTeam;
