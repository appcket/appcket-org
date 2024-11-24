import { useEffect } from 'react';
import { useForm } from 'react-hook-form';
import Button from '@mui/material/Button';
import Grid from '@mui/material/Grid2';
import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';
import { useNavigate } from 'react-router-dom';
import { useSnackbar } from 'notistack';
import { get } from 'lodash';

import { useUserInfo } from 'src/common/api/user';
import { useCreateProject } from 'src/common/api/project';
import Page from 'src/common/components/Page';
import PageHeader from 'src/common/components/PageHeader';
import QueryStatuses from 'src/common/enums/queryStatuses.enum';
import CreateProjectInput from 'src/common/models/inputs/CreateProjectInput';
import Project from 'src/common/models/Project';
import Organization from 'src/common/models/Organization';
import User from 'src/common/models/User';
import { FormTextField } from 'src/common/components/form/FormTextField';
import FormSelectMenu from 'src/common/components/form/FormSelectMenu';
import ResourceUsersGrid from 'src/common/components/ResourceUsersGrid';
import { useStore } from 'src/common/store';
import { resourcesToSelectMenuOptions } from 'src/common/utils/form';
import CancelButton from 'src/common/components/buttons/CancelButton';
import Loading from 'src/common/components/Loading';

const CreateProject = () => {
  const navigate = useNavigate();
  const { enqueueSnackbar } = useSnackbar();
  const {
    watch,
    formState: { isValid },
    handleSubmit,
    reset,
    control,
  } = useForm<CreateProjectInput>({
    mode: 'all',
    defaultValues: {
      name: '',
      description: '',
      organizationId: '',
    },
  });

  const watchOrganizationId = watch('organizationId', '');
  const createProject = useCreateProject();
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
        selectedUserIds: initialSelectedItemIds([] as User[], 'id'),
      },
    }));
  }, [reset]);

  const onSubmit = async (createProjectInput: CreateProjectInput) => {
    createProjectInput.userIds = selectedUserIds;

    createProject.mutate(
      { createProjectInput },
      {
        onSuccess: (data) => {
          const createdProject = data as Project;
          enqueueSnackbar(`Project created: ${createdProject.name}`, {
            variant: 'success',
          });
          navigate('/projects');
        },
      },
    );
  };

  let organizationSelectMenu;
  let organizationUsersGrid;

  if (userInfo.isLoading || userInfo.isFetching) {
    organizationSelectMenu = <Loading />;
    organizationUsersGrid = <Loading />;
  } else if (userInfo.status === QueryStatuses.Error && userInfo.error instanceof Error) {
    organizationSelectMenu = <Typography component="p">Error: {userInfo.error.message}</Typography>;
  } else if (userInfo.isSuccess && userInfo.data.organizations) {
    const options = resourcesToSelectMenuOptions<Organization>(
      userInfo.data.organizations,
      'id',
      'name',
    );

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
      <ResourceUsersGrid resourceType="Project" organizationId={watchOrganizationId} />
    );
  }

  const createProjectComponent = (
    <Paper elevation={1} sx={{ my: { xs: 3, md: 3 }, p: { xs: 2, md: 3 } }}>
      <Grid size={{ xs: 24, sm: 12 }} sx={{ mb: 2 }}>
        {organizationSelectMenu}

        <FormTextField
          name="name"
          control={control}
          label="Project Name"
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
        <Grid>
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
    <Page title="Create New Project">
      <PageHeader title="New Project" subTitle="Create a new project for an organization">
        <Grid container justifyContent="flex-end">
          <Grid>
            <CancelButton linkTo="../" />
          </Grid>
        </Grid>
      </PageHeader>
      <div>{createProjectComponent}</div>
    </Page>
  );
};

export default CreateProject;
