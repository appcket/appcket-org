import { useEffect } from 'react';
import { useForm } from 'react-hook-form';
import { NavLink, useNavigate, useParams } from 'react-router-dom';
import Button from '@mui/material/Button';
import Grid from '@mui/material/Grid';
import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';
import { useSnackbar } from 'notistack';

import Page from 'src/common/components/Page';
import PageHeader from 'src/common/components/PageHeader';
import UpdateTaskInput from 'src/common/models/inputs/UpdateTaskInput';
import { useGetTask, useUpdateTask } from 'src/common/api/task';
import Task from 'src/common/models/Task';
import { FormTextField } from 'src/common/components/form/FormTextField';
import FormSelectMenu from 'src/common/components/form/FormSelectMenu';
import CancelButton from 'src/common/components/buttons/CancelButton';
import Loading from 'src/common/components/Loading';

const EditTask = () => {
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
      taskStatusTypeId: getTaskQuery?.data?.getTask?.taskStatusType.id ?? '',
      assignedTo: getTaskQuery?.data?.getTask?.assignedTo.id ?? '',
    });
  }, [reset, getTaskQuery?.data?.getTask]);

  let taskStatusTypeFormField;
  let assignedToFormField;
  let editTaskComponent;

  if (getTaskQuery.status === 'loading' || getTaskQuery.isFetching) {
    editTaskComponent = <Loading />;
  } else if (getTaskQuery.status === 'error' && getTaskQuery.error instanceof Error) {
    editTaskComponent = <Typography paragraph>Error: {getTaskQuery.error.message}</Typography>;
  } else if (getTaskQuery.isSuccess) {
    editTaskComponent = <Typography paragraph>Unable to view Task</Typography>;

    const taskStatusTypeOptions = getTaskQuery.data.getTaskStatusTypes.map((taskStatusType) => {
      return { id: taskStatusType.id, label: taskStatusType.name };
    });
    taskStatusTypeFormField = (
      <FormSelectMenu
        name="taskStatusTypeId"
        className="mb-4"
        control={control}
        label="Status"
        options={taskStatusTypeOptions}
      />
    );

    const projectUserOptions = getTaskQuery.data.getTask.project.users.map((user) => {
      return { id: user.id, label: `${user.firstName} ${user.lastName ? user.lastName : ''}` };
    });
    assignedToFormField = (
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
        label="Assigned To"
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
            enqueueSnackbar(`Updated Task successfully: ${updatedTask.name}`, {
              variant: 'success',
            });
            navigate(`/tasks/${updatedTask.id}`);
          },
        },
      );
    };

    editTaskComponent = (
      <Paper elevation={1} sx={{ my: { xs: 3, md: 3 }, p: { xs: 2, md: 3 } }}>
        <Grid container justifyContent="flex-end">
          <Grid item>
            <CancelButton linkTo={`../${taskId}`} />
          </Grid>
        </Grid>
        <Typography variant="body1" sx={{ mb: 3 }}>
          Project:{' '}
          <NavLink to={`/projects/${getTaskQuery.data.getTask.project.id}`}>
            {getTaskQuery.data.getTask.project.name}
          </NavLink>
        </Typography>
        <Grid item xs={24} sm={12} sx={{ mb: 2 }}>
          <FormTextField
            name="name"
            control={control}
            label="Task Name"
            rules={{
              required: { value: true, message: 'This field is required' },
              maxLength: { value: 100, message: 'This field must be less than 100 characters' },
              minLength: { value: 1, message: 'This field must be more than 1 character' },
            }}
          />
        </Grid>

        <FormTextField
          name="description"
          className="mb-4"
          control={control}
          label="Description"
          rules={{
            maxLength: { value: 5000, message: 'This field must be less than 5000 characters' },
          }}
        />

        {taskStatusTypeFormField}

        {assignedToFormField}

        <Grid container justifyContent="flex-end" sx={{ mt: 8 }}>
          <Grid item>
            <Button
              onClick={() => {
                reset();
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
    <Page title={`Edit Task - ${getTaskQuery?.data?.getTask?.name}`}>
      <PageHeader title={getTaskQuery?.data?.getTask?.name} subTitle="Edit Task details" />
      <div>{editTaskComponent}</div>
    </Page>
  );
};

export default EditTask;
