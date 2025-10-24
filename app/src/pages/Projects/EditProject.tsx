import { useEffect } from 'react';
import { useForm } from 'react-hook-form';
import { useNavigate, useParams } from 'react-router-dom';
import { Save, Undo } from '@mui/icons-material';
import Button from '@mui/material/Button';
import Grid from '@mui/material/Grid';
import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';
import { useSnackbar } from 'notistack';
import { useTranslation } from 'react-i18next';

import { useGetProject, useUpdateProject } from 'src/common/api/project';
import Page from 'src/common/components/Page';
import CancelButton from 'src/common/components/buttons/CancelButton';
import { FormTextField } from 'src/common/components/form/FormTextField';
import Loading from 'src/common/components/Loading';
import PageHeader from 'src/common/components/PageHeader';
import ResourceUsersGrid from 'src/common/components/ResourceUsersGrid';
import QueryStatuses from 'src/common/enums/QueryStatuses';
import UpdateProjectInput from 'src/common/models/inputs/UpdateProjectInput';
import Project from 'src/common/models/Project';
import User from 'src/common/models/User';
import { useStore } from 'src/common/store';
import { FormFields } from 'src/common/constants';

const EditProject = () => {
  const { t } = useTranslation();
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
      return items.map((item) => (item as any)?.[key] as string);
    }
    return [];
  };

  useEffect(() => {
    reset({
      name: getProjectQuery?.data?.getProject.name ?? '',
      description: getProjectQuery?.data?.getProject.description ?? '',
    });
    useStore.setState((state) => ({
      resourceUsers: {
        ...state.resourceUsers,
        selectedUserIds: initialSelectedItemIds(
          getProjectQuery?.data?.getProject.users as User[],
          'id',
        ),
      },
    }));
  }, [reset, getProjectQuery?.data?.getProject]);

  useEffect(() => {
    useStore.setState((state) => ({
      resourceUsers: {
        ...state.resourceUsers,
        initialSelectedUserIds: initialSelectedItemIds(
          getProjectQuery?.data?.getProject.users as User[],
          'id',
        ),
      },
    }));
  }, [getProjectQuery?.data?.getProject.users]);

  let editProjectComponent;

  if (getProjectQuery.isFetching) {
    editProjectComponent = <Loading />;
  } else if (
    getProjectQuery.status === QueryStatuses.Error &&
    getProjectQuery.error instanceof Error
  ) {
    editProjectComponent = (
      <Typography component="p">
        {t('messages.error.error')}: {getProjectQuery.error.message}
      </Typography>
    );
  } else if (getProjectQuery.isSuccess) {
    editProjectComponent = (
      <Typography component="p">
        {t('messages.error.unableEdit')} {t('resources.project')}
      </Typography>
    );

    const onSubmit = async (updateProjectInput: UpdateProjectInput) => {
      updateProjectInput.organizationId = getProjectQuery.data.getProject.organization.id;
      updateProjectInput.id = getProjectQuery.data.getProject.id
        ? getProjectQuery.data.getProject.id
        : '';
      updateProjectInput.userIds = [...selectedUserIds];

      updateProject.mutate(
        { updateProjectInput },
        {
          onSuccess: (data) => {
            const updatedProject = data as Project;
            enqueueSnackbar(
              `${t('entities.project')} ${t('common.updated').toLowerCase()}: ${updatedProject.name}`,
              {
                variant: 'success',
              },
            );
            navigate('/projects');
          },
        },
      );
    };

    editProjectComponent = (
      <Paper elevation={1} sx={{ my: { xs: 3, md: 3 }, p: { xs: 2, md: 3 } }}>
        <Grid container justifyContent="flex-end">
          <Grid>
            <CancelButton linkTo={`../${projectId}`} />
          </Grid>
        </Grid>
        <Typography variant="body1" sx={{ mb: 3 }}>
          {t('labels.organization')}: {getProjectQuery.data.getProject.organization.name}
        </Typography>
        <Grid size={{ xs: 24, sm: 12 }} sx={{ mb: 2 }}>
          <FormTextField
            name="name"
            control={control}
            label={t('labels.projectName')}
            rules={{
              required: { value: true, message: t('messages.error.requiredField') },
              maxLength: {
                value: FormFields.project.name.maxLength,
                message: t('messages.error.fieldLessThan_other', {
                  count: FormFields.project.name.maxLength,
                }),
              },
              minLength: {
                value: FormFields.project.name.minLength,
                message: t('messages.error.fieldMoreThan_one'),
              },
            }}
          />
        </Grid>

        <FormTextField
          name="description"
          control={control}
          label={t('labels.description')}
          multiline
          rows={3}
          rules={{
            maxLength: {
              value: FormFields.project.description.maxLength,
              message: t('messages.error.fieldLessThan_other', {
                count: FormFields.project.description.maxLength,
              }),
            },
          }}
        />

        <ResourceUsersGrid
          resourceType="Project"
          organizationId={getProjectQuery.data.getProject.organization.id}
        />

        <Grid container justifyContent="flex-end" sx={{ mt: 3 }}>
          <Grid>
            <Button
              onClick={() => {
                reset();
                resetSelectedUserIds();
              }}
              variant="outlined"
              startIcon={<Undo />}
            >
              {t('common.reset')}
            </Button>
            <Button
              onClick={handleSubmit(onSubmit)}
              variant="contained"
              disabled={!isValid}
              startIcon={<Save />}
              sx={{ mx: 1 }}
            >
              {t('common.save')}
            </Button>
          </Grid>
        </Grid>
      </Paper>
    );
  }

  return (
    <Page
      title={`${t('pages.projects.editProject.titleFragment')} - ${getProjectQuery?.data?.getProject?.name}`}
    >
      <PageHeader
        title={getProjectQuery?.data?.getProject?.name}
        subTitle={t('pages.projects.editProject.subTitle')}
      />
      <div>{editProjectComponent}</div>
    </Page>
  );
};

export default EditProject;
