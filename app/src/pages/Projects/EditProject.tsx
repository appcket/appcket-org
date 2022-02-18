import React, { useEffect } from 'react';
import { useForm } from 'react-hook-form';
import { useParams } from 'react-router-dom';
import Button from '@mui/material/Button';
import Grid from '@mui/material/Grid';
import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';
import { useNavigate } from 'react-router-dom';
import { useSnackbar } from 'notistack';
import { get } from 'lodash';

import Page from 'src/common/components/Page';
import UpdateProjectMutationInput from 'src/common/models/inputs/UpdateProjectMutationInput';
import { useGetProject, useUpdateProject } from 'src/common/api/project';
import Project from 'src/common/models/Project';
import User from 'src/common/models/User';
import { FormTextField } from 'src/common/components/form/FormTextField';
import ResourceUsersGrid from 'src/common/components/ResourceUsersGrid';
import { useStore } from 'src/common/store';

const EditProject = () => {
  const params = useParams();
  const navigate = useNavigate();
  const { enqueueSnackbar } = useSnackbar();
  const {
    formState: { isValid },
    handleSubmit,
    reset,
    control,
  } = useForm<UpdateProjectMutationInput>({
    mode: 'all',
    defaultValues: {
      name: '',
    },
  });

  const getProjectQuery = useGetProject(params.projectId!);
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
    reset({ name: getProjectQuery?.data?.name ?? '' });
    useStore.setState((state) => ({
      resourceUsers: {
        ...state.resourceUsers,
        selectedUserIds: initialSelectedItemIds(getProjectQuery?.data?.users as User[], 'user_id'),
      },
    }));
  }, [reset, getProjectQuery.data]);

  useStore.setState((state) => ({
    resourceUsers: {
      ...state.resourceUsers,
      initialSelectedUserIds: initialSelectedItemIds(
        getProjectQuery?.data?.users as User[],
        'user_id',
      ),
    },
  }));

  let editProjectComponent;

  if (getProjectQuery.status === 'loading' || getProjectQuery.isFetching) {
    editProjectComponent = <Typography paragraph>Loading...</Typography>;
  } else if (getProjectQuery.status === 'error' && getProjectQuery.error instanceof Error) {
    editProjectComponent = (
      <Typography paragraph>Error: {getProjectQuery.error.message}</Typography>
    );
  } else if (getProjectQuery.isSuccess) {
    editProjectComponent = <Typography paragraph>Unable to view Project</Typography>;

    const onSubmit = async (updateProjectInput: UpdateProjectMutationInput) => {
      updateProjectInput.organizationId = getProjectQuery.data.organization.organization_id;
      updateProjectInput.projectId = getProjectQuery.data.project_id;
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
      <div>
        <Typography variant="h4">{getProjectQuery.data.name}</Typography>

        <Paper elevation={1} sx={{ my: { xs: 3, md: 3 }, p: { xs: 2, md: 3 } }}>
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

          <ResourceUsersGrid organizationId={getProjectQuery.data.organization.organization_id} />

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
  }

  return (
    <Page title={`Edit Project - ${getProjectQuery.data?.name}`}>
      <div>{editProjectComponent}</div>
    </Page>
  );
};

export default EditProject;
