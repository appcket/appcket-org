import { useEffect } from 'react';
import { useForm } from 'react-hook-form';
import { Link, useNavigate, useParams } from 'react-router-dom';
import { Save, Undo } from '@mui/icons-material';
import Button from '@mui/material/Button';
import Grid from '@mui/material/Grid';
import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';
import { useSnackbar } from 'notistack';
import { useTranslation } from 'react-i18next';

import { useGetTask, useUpdateTask } from 'src/common/api/task';
import CancelButton from 'src/common/components/buttons/CancelButton';
import { FormTextField } from 'src/common/components/form/FormTextField';
import Loading from 'src/common/components/Loading';
import FormSelectMenu from 'src/common/components/form/FormSelectMenu';
import Page from 'src/common/components/Page';
import PageHeader from 'src/common/components/PageHeader';
import QueryStatuses from 'src/common/enums/QueryStatuses';
import UpdateTaskInput from 'src/common/models/inputs/UpdateTaskInput';
import Task from 'src/common/models/Task';
import { FormFields } from 'src/common/constants';

const EditTask = () => {
  const { t } = useTranslation();
  const params = useParams();
  let taskId = '';
  if (params.taskId) {
    taskId = params.taskId;
  }
  const navigate = useNavigate();
  const { enqueueSnackbar } = useSnackbar();
  const {
    formState: { isValid },
    handleSubmit,
    reset,
    control,
  } = useForm<UpdateTaskInput>({
    mode: 'all',
    defaultValues: {
      name: '',
      description: '',
      assignedTo: '',
    },
  });

  const getTaskQuery = useGetTask(taskId);
  const updateTask = useUpdateTask();

  useEffect(() => {
    reset({
      name: getTaskQuery?.data?.getTask?.name ?? '',
      description: getTaskQuery?.data?.getTask?.description ?? '',
      taskStatusTypeId: getTaskQuery?.data?.getTask?.taskStatusType?.id ?? '',
      assignedTo: getTaskQuery?.data?.getTask?.assignedTo?.id ?? '',
    });
  }, [reset, getTaskQuery?.data?.getTask]);

  let taskStatusTypeFormField;
  let assignedToFormField;
  let editTaskComponent;

  if (getTaskQuery.isFetching) {
    editTaskComponent = <Loading />;
  } else if (getTaskQuery.status === QueryStatuses.Error && getTaskQuery.error instanceof Error) {
    editTaskComponent = <Typography component="p">Error: {getTaskQuery.error.message}</Typography>;
  } else if (getTaskQuery.isSuccess) {
    editTaskComponent = <Typography component="p">Unable to view Task</Typography>;

    const taskStatusTypeOptions = getTaskQuery.data.getTaskStatusTypes.map((taskStatusType) => {
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

    const projectUserOptions = getTaskQuery.data.getTask.project.users.map((user) => {
      return { id: user.id, label: `${user.firstName} ${user.lastName ? user.lastName : ''}` };
    });

    assignedToFormField = (
      // TODO: validate that you can't remove a user from a project if that user is currently assigned to any of the project's tasks
      // TODO: potentially use an autocomplete of Project's users here instead of a select menu
      // <FormAutocomplete
      //   name="assignedTo"
      //   control={control}
      //   label="Assigned To"
      //   value={{
      //     id: getTaskQuery.data.getTask.assignedTo.id,
      //     label: getTaskQuery.data.getTask.assignedTo.firstName,
      //   }}
      //   options={projectUserOptions}
      // />

      <FormSelectMenu
        name="assignedTo"
        className="mb-4"
        control={control}
        label={t('labels.assignedTo')}
        options={projectUserOptions}
      />
    );

    const onSubmit = async (updateTaskInput: UpdateTaskInput) => {
      updateTaskInput.projectId = getTaskQuery.data.getTask.project.id;
      updateTaskInput.id = getTaskQuery.data.getTask.id;

      updateTask.mutate(
        { updateTaskInput },
        {
          onSuccess: (data) => {
            const updatedTask = data as Task;
            enqueueSnackbar(
              `${t('entities.task')} ${t('common.updated').toLowerCase()}: ${updatedTask.name}`,
              {
                variant: 'success',
              },
            );
            navigate(`/tasks/${updatedTask.id}`);
          },
        },
      );
    };

    editTaskComponent = (
      <Paper elevation={1} sx={{ my: { xs: 3, md: 3 }, p: { xs: 2, md: 3 } }}>
        <Grid container justifyContent="flex-end">
          <Grid>
            <CancelButton linkTo={`../${taskId}`} />
          </Grid>
        </Grid>
        <Typography variant="body1" sx={{ mb: 3 }}>
          {t('entities.project')}:{' '}
          <Button component={Link} to={`/projects/${getTaskQuery.data.getTask.project.id}`}>
            {getTaskQuery.data.getTask.project.name}
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
    <Page
      title={`${t('pages.tasks.editTask.titleFragment')} - ${getTaskQuery?.data?.getTask?.name}`}
    >
      <PageHeader
        title={getTaskQuery?.data?.getTask?.name}
        subTitle={t('pages.tasks.editTask.subTitle')}
      />
      <div>{editTaskComponent}</div>
    </Page>
  );
};

export default EditTask;
