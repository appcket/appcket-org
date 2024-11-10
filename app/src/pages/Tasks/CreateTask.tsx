import { useEffect } from 'react';
import { useForm } from 'react-hook-form';
import { Link, useNavigate, useParams } from 'react-router-dom';
import Button from '@mui/material/Button';
import Grid from '@mui/material/Grid2';
import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';
import { useSnackbar } from 'notistack';

import Page from 'src/common/components/Page';
import PageHeader from 'src/common/components/PageHeader';
import CreateTaskInput from 'src/common/models/inputs/CreateTaskInput';
import { useCreateTask } from 'src/common/api/task';
import { useGetProject } from 'src/common/api/project';
import Task from 'src/common/models/Task';
import { FormTextField } from 'src/common/components/form/FormTextField';
import FormSelectMenu from 'src/common/components/form/FormSelectMenu';
import CancelButton from 'src/common/components/buttons/CancelButton';
import Loading from 'src/common/components/Loading';

const CreateTask = () => {
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
  } else if (getProjectQuery.status === 'error' && getProjectQuery.error instanceof Error) {
    createTaskComponent = <Typography paragraph>Error: {getProjectQuery.error.message}</Typography>;
  } else if (getProjectQuery.isSuccess) {
    createTaskComponent = <Typography paragraph>Unable to get Project</Typography>;

    const taskStatusTypeOptions = getProjectQuery.data.getTaskStatusTypes.map((taskStatusType) => {
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

    const projectUserOptions = getProjectQuery.data.getProject.users.map((user) => {
      return { id: user.id, label: `${user.firstName} ${user.lastName ? user.lastName : ''}` };
    });
    assignedToFormField = (
      <FormSelectMenu
        name="assignedTo"
        className="mb-4"
        control={control}
        label="Assigned To"
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
            enqueueSnackbar(`Task created: ${createdTask.name}`, {
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
          Project:{' '}
          <Button component={Link} to={`/projects/${getProjectQuery.data.getProject.id}`}>
            {getProjectQuery.data.getProject.name}
          </Button>
        </Typography>
        <Grid size={{ xs: 24, sm: 12 }} sx={{ mb: 2 }}>
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
          multiline
          rows={3}
          rules={{
            maxLength: { value: 5000, message: 'This field must be less than 5000 characters' },
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
    <Page title="Create New Task">
      <PageHeader title="New Task" subTitle="Create a new task for a project" />
      <div>{createTaskComponent}</div>
    </Page>
  );
};

export default CreateTask;
