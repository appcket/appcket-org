import { NavLink, useParams } from 'react-router-dom';
import { useQuery } from '@tanstack/react-query';
import Grid from '@mui/material/Grid';
import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';

import Loading from 'src/common/components/Loading';
import Page from 'src/common/components/Page';
import PageHeader from 'src/common/components/PageHeader';
import { useGetTask } from 'src/common/api/task';
import hasPermission from 'src/common/utils/hasPermission';
import { TaskPermission } from 'src/common/enums/permissions.enum';
import Resources from 'src/common/enums/resources.enum';
import UserInfoResponse from 'src/common/models/responses/UserInfoResponse';
import Permission from 'src/common/models/Permission';
import EditButton from 'src/common/components/buttons/EditButton';

const Task = () => {
  const params = useParams();
  const taskId = params.taskId || '';
  const userInfoQuery = useQuery<UserInfoResponse>(['userInfo']);

  const updateTaskPermission = hasPermission(
    userInfoQuery.data?.userInfo.permissions as Permission[],
    Resources.Task,
    TaskPermission.update,
  );
  const { status, data, error, isFetching } = useGetTask(taskId);

  let taskComponent;

  if (status === 'loading' || isFetching) {
    taskComponent = <Loading />;
  } else if (status === 'error' && error instanceof Error) {
    taskComponent = <Typography paragraph>Error: {error.message}</Typography>;
  } else {
    taskComponent = <Typography paragraph>Unable to view Task</Typography>;

    let updateTaskButton = <EditButton variant="outlined" isDisabled={true} />;

    if (updateTaskPermission) {
      updateTaskButton = <EditButton variant="contained" isDisabled={false} linkTo="edit" />;
    }

    taskComponent = (
      <Paper elevation={1} sx={{ my: { xs: 3, md: 3 }, p: { xs: 2, md: 3 } }}>
        <Grid container justifyContent="flex-end">
          <Grid item>{updateTaskButton}</Grid>
        </Grid>
        <Grid item xs={12} sm={6}>
          <Typography variant="body1" sx={{ mb: 3 }}>
            Project:{' '}
            <NavLink to={`/projects/${data?.getTask?.project.id}`}>
              {data?.getTask?.project.name}
            </NavLink>
          </Typography>
          <Typography variant="body1">Status: {data?.getTask?.taskStatusType.name}</Typography>
          <Typography variant="body1">Assigned to: {data?.getTask?.assignedTo.username}</Typography>
          <Typography variant="body1">Description: {data?.getTask?.description}</Typography>
        </Grid>
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
