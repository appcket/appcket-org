import { Link, useParams } from 'react-router-dom';
import Button from '@mui/material/Button';
import Grid from '@mui/material/Grid';
import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';

import { useUserInfo } from 'src/common/api/user';
import Loading from 'src/common/components/Loading';
import Page from 'src/common/components/Page';
import PageHeader from 'src/common/components/PageHeader';
import { useGetTask } from 'src/common/api/task';
import hasPermission from 'src/common/utils/hasPermission';
import { TaskPermission } from 'src/common/enums/permissions.enum';
import Resources from 'src/common/enums/resources.enum';
import Permission from 'src/common/models/Permission';
import EditButton from 'src/common/components/buttons/EditButton';
import { displayUser } from 'src/common/utils/general';
import EntityHistory from 'src/common/components/EntityHistory';

const Task = () => {
  const params = useParams();
  const taskId = params.taskId || '';
  const userInfo = useUserInfo();

  const updateTaskPermission = hasPermission(
    userInfo.data?.permissions as Permission[],
    Resources.Task,
    TaskPermission.update,
  );
  const readTaskHistoryPermission = hasPermission(
    userInfo.data?.permissions as Permission[],
    Resources.Task,
    TaskPermission.readHistory,
  );
  const { status, data, error, isFetching, isLoading } = useGetTask(taskId);

  let taskComponent;
  let entityHistoryComponent;

  if (isLoading || isFetching) {
    taskComponent = <Loading />;
  } else if (status === 'error' && error instanceof Error) {
    taskComponent = <Typography paragraph>Error: {error.message}</Typography>;
  } else {
    taskComponent = <Typography paragraph>Unable to view Task</Typography>;

    let updateTaskButton = <EditButton variant="outlined" isDisabled={true} />;

    if (updateTaskPermission) {
      updateTaskButton = <EditButton variant="contained" isDisabled={false} linkTo="edit" />;
    }

    if (readTaskHistoryPermission) {
      entityHistoryComponent = <EntityHistory entityId={taskId} entityType={Resources.Task} />;
    }

    const displayedUser = displayUser(data?.getTask?.assignedTo);

    taskComponent = (
      <Paper elevation={1} sx={{ my: { xs: 3, md: 3 }, p: { xs: 2, md: 3 } }}>
        <Grid container justifyContent="flex-end">
          <Grid item>{updateTaskButton}</Grid>
        </Grid>
        <Grid item xs={12} sm={6}>
          <Typography variant="body1" sx={{ mb: 3 }}>
            Project:{' '}
            <Button component={Link} to={`/projects/${data?.getTask?.project.id}`}>
              {data?.getTask?.project.name}
            </Button>
          </Typography>
          <Typography variant="body1">
            Status:{' '}
            {data?.getTask?.taskStatusType ? data?.getTask?.taskStatusType?.name : 'Status Not Set'}
          </Typography>
          <Typography variant="body1">
            Assigned to: {displayedUser ? `${displayedUser}` : 'Unassigned'}
          </Typography>
          <Typography variant="body1">Description: {data?.getTask?.description}</Typography>
        </Grid>
        {entityHistoryComponent}
      </Paper>
    );
  }

  return (
    <Page title={`Task - ${data?.getTask?.name}`}>
      <PageHeader title={data?.getTask?.name} subTitle="Task details" />
      {taskComponent}
    </Page>
  );
};

export default Task;
