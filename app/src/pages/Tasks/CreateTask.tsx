import { useEffect } from 'react';
import { useForm } from 'react-hook-form';
import { Link, useNavigate, useParams } from 'react-router-dom';
import { Save, Undo } from '@mui/icons-material';
import Button from '@mui/material/Button';
import Grid from '@mui/material/Grid2';
import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';
import { useSnackbar } from 'notistack';
import { useTranslation } from 'react-i18next';

import { useGetProject } from 'src/common/api/project';
import { useCreateTask } from 'src/common/api/task';
import Page from 'src/common/components/Page';
import CancelButton from 'src/common/components/buttons/CancelButton';
import FormSelectMenu from 'src/common/components/form/FormSelectMenu';
import { FormTextField } from 'src/common/components/form/FormTextField';
import Loading from 'src/common/components/Loading';
import PageHeader from 'src/common/components/PageHeader';
import QueryStatuses from 'src/common/enums/QueryStatuses';
import CreateTaskInput from 'src/common/models/inputs/CreateTaskInput';
import Task from 'src/common/models/Task';
import { FormFields } from 'src/common/constants';

const CreateTask = () => {
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
  } = useForm<CreateTaskInput>({
    mode: 'all',
    defaultValues: {
      name: '',
      description: '',
      assignedTo: '',
    },
  });

  const createTask = useCreateTask();
  const getProjectQuery = useGetProject(projectId);

  useEffect(() => {
    reset({
      name: '',
      description: '',
      taskStatusTypeId: '',
      assignedTo: '',
    });
  }, [reset]);

  let taskStatusTypeFormField;
  let assignedToFormField;
  let createTaskComponent;

  if (getProjectQuery.isFetching) {
    createTaskComponent = <Loading />;
  } else if (
    getProjectQuery.status === QueryStatuses.Error &&
    getProjectQuery.error instanceof Error
  ) {
    createTaskComponent = (
      <Typography component="p">Error: {getProjectQuery.error.message}</Typography>
    );
  } else if (getProjectQuery.isSuccess) {
    createTaskComponent = <Typography component="p">Unable to get Project</Typography>;

    const taskStatusTypeOptions = getProjectQuery.data.getTaskStatusTypes.map((taskStatusType) => {
      return { id: taskStatusType.id, label: taskStatusType.name };
    });
    taskStatusTypeFormField = (
      <FormSelectMenu
        name="taskStatusTypeId"
        className="mb-4"
        control={control}
        label={t('labels.status')}
        options={taskStatusTypeOptions}
      />
    );

    const projectUserOptions = getProjectQuery.data.getProject.users.map((user) => {
      return { id: user.id, label: `${user.firstName} ${user.lastName ? user.lastName : ''}` };
    });
    assignedToFormField = (
      <FormSelectMenu
        name="assignedTo"
        className="mb-4"
        control={control}
        label={t('labels.assignedTo')}
        options={projectUserOptions}
      />
    );

    const onSubmit = async (createTaskInput: CreateTaskInput) => {
      createTaskInput.projectId = getProjectQuery.data.getProject.id;

      createTask.mutate(
        { createTaskInput },
        {
          onSuccess: (data) => {
            const createdTask = data as Task;
            enqueueSnackbar(`${t('entities.task')} ${t('common.created')}: ${createdTask.name}`, {
              variant: 'success',
            });
            navigate(`/tasks/${createdTask.id}`);
          },
        },
      );
    };

    createTaskComponent = (
      <Paper elevation={1} sx={{ my: { xs: 3, md: 3 }, p: { xs: 2, md: 3 } }}>
        <Grid container justifyContent="flex-end">
          <Grid>
            <CancelButton linkTo={`../${projectId}`} />
          </Grid>
        </Grid>
        <Typography variant="body1" sx={{ mb: 3 }}>
          {t('entities.project')}:{' '}
          <Button component={Link} to={`/projects/${getProjectQuery.data.getProject.id}`}>
            {getProjectQuery.data.getProject.name}
          </Button>
        </Typography>
        <Grid size={{ xs: 24, sm: 12 }} sx={{ mb: 2 }}>
          <FormTextField
            name="name"
            control={control}
            label={t('pages.tasks.taskName')}
            rules={{
              required: { value: true, message: t('messages.error.requiredField') },
              maxLength: {
                value: FormFields.task.name.maxLength,
                message: t('messages.error.fieldLessThan_other', {
                  count: FormFields.task.name.maxLength,
                }),
              },
              minLength: {
                value: FormFields.task.name.minLength,
                message: t('messages.error.fieldMoreThan_one'),
              },
            }}
          />
        </Grid>

        <FormTextField
          name="description"
          className="mb-4"
          control={control}
          label={t('labels.description')}
          multiline
          rows={3}
          rules={{
            maxLength: {
              value: FormFields.task.description.maxLength,
              message: t('messages.error.fieldLessThan_other', {
                count: FormFields.task.description.maxLength,
              }),
            },
          }}
        />

        {taskStatusTypeFormField}

        {assignedToFormField}

        <Grid container justifyContent="flex-end" sx={{ mt: 3 }}>
          <Grid>
            <Button
              onClick={() => {
                reset();
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
    <Page title={t('pages.tasks.createTask.title')}>
      <PageHeader
        title={t('pages.tasks.createTask.title')}
        subTitle={t('pages.tasks.createTask.subTitle')}
      />
      <div>{createTaskComponent}</div>
    </Page>
  );
};

export default CreateTask;
