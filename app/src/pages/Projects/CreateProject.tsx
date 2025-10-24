import { useEffect } from 'react';
import { useForm } from 'react-hook-form';
import { Save, Undo } from '@mui/icons-material';
import Button from '@mui/material/Button';
import Grid from '@mui/material/Grid';
import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';
import { useNavigate } from 'react-router-dom';
import { useSnackbar } from 'notistack';
import { useTranslation } from 'react-i18next';

import { useUserInfo } from 'src/common/api/user';
import { useCreateProject } from 'src/common/api/project';
import Page from 'src/common/components/Page';
import PageHeader from 'src/common/components/PageHeader';
import QueryStatuses from 'src/common/enums/QueryStatuses';
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
import { FormFields } from 'src/common/constants';

const CreateProject = () => {
  const { t } = useTranslation();
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
      return items.map((item) => (item as any)?.[key] as string);
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
    createProjectInput.userIds = Array.from(selectedUserIds);

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
        label={t('labels.organization')}
        options={options}
        rules={{
          required: { value: true, message: t('messages.error.requiredField') },
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

      {watchOrganizationId && organizationUsersGrid}

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

  return (
    <Page title={t('pages.projects.createProject.title')}>
      <PageHeader
        title={t('pages.projects.createProject.title')}
        subTitle={t('pages.projects.createProject.subTitle')}
      >
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
