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
import UpdateProjectInput from 'src/common/models/inputs/UpdateProjectInput';
import { useGetProject, useUpdateProject } from 'src/common/api/project';
import Project from 'src/common/models/Project';
import User from 'src/common/models/User';
import { FormTextField } from 'src/common/components/form/FormTextField';
import ResourceUsersGrid from 'src/common/components/ResourceUsersGrid';
import { useStore } from 'src/common/store';
import CancelButton from 'src/common/components/buttons/CancelButton';
import Loading from 'src/common/components/Loading';

const EditProject = () => {
  const params = useParams();
  let projectId = '';
  if (params.projectId) {
    projectId = params.projectId;
  }

  const navigate = useNavigate();
  const { enqueueSnackbar } = useSnackbar();
  const {
    formState: { isValid },
    handleSubmit,
    reset,
    control,
  } = useForm<UpdateProjectInput>({
    mode: 'all',
    defaultValues: {
      name: '',
      description: '',
    },
  });

  const getProjectQuery = useGetProject(projectId);
  const updateProject = useUpdateProject();
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
    reset({
      name: getProjectQuery?.data?.name ?? '',
      description: getProjectQuery?.data?.description ?? '',
    });
    useStore.setState((state) => ({
      resourceUsers: {
        ...state.resourceUsers,
        selectedUserIds: initialSelectedItemIds(getProjectQuery?.data?.users as User[], 'id'),
      },
    }));
  }, [reset, getProjectQuery.data]);

  useEffect(() => {
    useStore.setState((state) => ({
      resourceUsers: {
        ...state.resourceUsers,
        initialSelectedUserIds: initialSelectedItemIds(
          getProjectQuery?.data?.users as User[],
          'id',
        ),
      },
    }));
  }, [getProjectQuery?.data?.users]);

  let editProjectComponent;

  if (getProjectQuery.status === 'loading' || getProjectQuery.isFetching) {
    editProjectComponent = <Loading />;
  } else if (getProjectQuery.status === 'error' && getProjectQuery.error instanceof Error) {
    editProjectComponent = (
      <Typography paragraph>Error: {getProjectQuery.error.message}</Typography>
    );
  } else if (getProjectQuery.isSuccess) {
    editProjectComponent = <Typography paragraph>Unable to view Project</Typography>;

    const onSubmit = async (updateProjectInput: UpdateProjectInput) => {
      updateProjectInput.organizationId = getProjectQuery.data.organization.id;
      updateProjectInput.id = getProjectQuery.data.id ? getProjectQuery.data.id : '';
      updateProjectInput.userIds = selectedUserIds;

      updateProject.mutate(
        { updateProjectInput },
        {
          onSuccess: (data) => {
            const updatedProject = data as Project;
            enqueueSnackbar(`Updated project successfully: ${updatedProject.name}`, {
              variant: 'success',
            });
            navigate('/projects');
          },
        },
      );
    };

    editProjectComponent = (
      <Paper elevation={1} sx={{ my: { xs: 3, md: 3 }, p: { xs: 2, md: 3 } }}>
        <Grid container justifyContent="flex-end">
          <Grid item>
            <CancelButton linkTo={`../${projectId}`} />
          </Grid>
        </Grid>
        <Typography variant="body1" sx={{ mb: 3 }}>
          Organization: {getProjectQuery.data.organization.name}
        </Typography>
        <Grid item xs={24} sm={12} sx={{ mb: 2 }}>
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
          rules={{
            maxLength: { value: 500, message: 'This field must be less than 500 characters' },
          }}
        />

        <ResourceUsersGrid organizationId={getProjectQuery.data.organization.id} />

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
    <Page title={`Edit Project - ${getProjectQuery.data?.name}`}>
      <PageHeader title={getProjectQuery.data?.name} subTitle="Edit project details" />
      <div>{editProjectComponent}</div>
    </Page>
  );
};

export default EditProject;
