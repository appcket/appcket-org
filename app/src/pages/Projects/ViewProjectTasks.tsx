import { useQuery } from '@tanstack/react-query';
import Typography from '@mui/material/Typography';
import { Link, NavLink, useParams } from 'react-router-dom';
import { DataGrid, GridRowsProp, GridColDef } from '@mui/x-data-grid';
import Grid from '@mui/material/Grid';
import Button from '@mui/material/Button';

import AddCircleOutlineOutlinedIcon from '@mui/icons-material/AddCircleOutlineOutlined';
import Page from 'src/common/components/Page';
import PageHeader from 'src/common/components/PageHeader';
import { useSearchTasks } from 'src/common/api/task';
import { useGetProject } from 'src/common/api/project';
import Task from 'src/common/models/Task';
import Loading from 'src/common/components/Loading';
import hasPermission from 'src/common/utils/hasPermission';
import { TaskPermission } from 'src/common/enums/permissions.enum';
import Resources from 'src/common/enums/resources.enum';
import UserInfoQueryResponse from 'src/common/models/responses/UserInfoQueryResponse';
import Permission from 'src/common/models/Permission';

const ViewProjectTasks = () => {
  const params = useParams();
  let projectId = '';
  if (params.projectId) {
    projectId = params.projectId;
  }
  const { status, data, error } = useSearchTasks([projectId]);
  const getProjectResult = useGetProject(projectId);

  const userInfoQuery = useQuery<UserInfoQueryResponse>(['userInfo']);
  const createTaskPermission = hasPermission(
    userInfoQuery.data?.userInfo.permissions as Permission[],
    Resources.Task,
    TaskPermission.create,
  );

  let createTaskButton = (
    <Button variant="outlined" disabled>
      Create
    </Button>
  );

  if (createTaskPermission) {
    createTaskButton = (
      <Button
        variant="contained"
        component={Link}
        to="create"
        startIcon={<AddCircleOutlineOutlinedIcon />}
      >
        Create Task
      </Button>
    );
  }

  let tasksComponent = <Typography paragraph>Unable to view Tasks</Typography>;

  const columns: GridColDef[] = [
    {
      field: 'name',
      headerName: 'Name',
      flex: 0.25,
      renderCell: (cellValues) => {
        return <NavLink to={`/tasks/${cellValues.row.task_id}`}>{cellValues.row.name}</NavLink>;
      },
    },
    {
      field: 'updated_at',
      headerName: 'Updated',
      flex: 0.75,
      type: 'dateTime',
      valueGetter: ({ value }) =>
        value &&
        new Intl.DateTimeFormat('en-US', {
          weekday: 'short',
          year: 'numeric',
          month: 'short',
          day: '2-digit',
          hour: '2-digit',
          minute: '2-digit',
          hour12: true,
        }).format(new Date(value)),
    },
  ];

  if (status === 'loading') {
    tasksComponent = <Loading />;
  } else if (status === 'error' && error instanceof Error) {
    tasksComponent = <Typography paragraph>Error: {error.message}</Typography>;
  } else {
    // convert api data to mui grid-compatible data
    data?.forEach((task: Task) => {
      task.id = task.task_id;
    });

    const rows: GridRowsProp = data ? data : [];

    tasksComponent = (
      <div style={{ height: 300, width: '100%' }}>
        <DataGrid disableSelectionOnClick={true} rows={rows} columns={columns} />
      </div>
    );
  }

  return (
    <Page title={`${getProjectResult.data?.name} Tasks`}>
      <PageHeader
        title={`${getProjectResult.data?.name} Tasks`}
        subTitle="Manage tasks for a project"
      >
        <Grid container justifyContent="flex-end">
          <Grid>{createTaskButton}</Grid>
        </Grid>
      </PageHeader>
      <div>{tasksComponent}</div>
    </Page>
  );
};

export default ViewProjectTasks;
