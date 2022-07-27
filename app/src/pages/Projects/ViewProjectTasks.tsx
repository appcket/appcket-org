import React from 'react';
import Typography from '@mui/material/Typography';
import { NavLink, useParams } from 'react-router-dom';
import { DataGrid, GridRowsProp, GridColDef } from '@mui/x-data-grid';

import Page from 'src/common/components/Page';
import { useSearchTasks } from 'src/common/api/task';
import { useGetProject } from 'src/common/api/project';
import Task from 'src/common/models/Task';

const ViewProjectTasks = () => {
  const params = useParams();
  const { status, data, error } = useSearchTasks([params.projectId!]);
  const getProjectResult = useGetProject(params.projectId!);

  let tasksComponent = <Typography paragraph>Unable to view Tasks</Typography>;

  const columns: GridColDef[] = [
    {
      field: 'name',
      headerName: 'Name',
      width: 150,
      renderCell: (cellValues) => {
        return <NavLink to={`/tasks/${cellValues.row.task_id}`}>{cellValues.row.name}</NavLink>;
      },
    },
    {
      field: 'updated_at',
      headerName: 'Updated',
      width: 250,
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
    tasksComponent = <Typography paragraph>Loading...</Typography>;
  } else if (status === 'error' && error instanceof Error) {
    tasksComponent = <Typography paragraph>Error: {error.message}</Typography>;
  } else {
    // convert api data to mui grid-compatible data
    data?.forEach((task: Task) => {
      task.id = task.task_id;
    });

    const rows: GridRowsProp = data!;

    tasksComponent = (
      <div style={{ height: 300, width: '100%' }}>
        <DataGrid disableSelectionOnClick={true} rows={rows} columns={columns} />
      </div>
    );
  }

  return (
    <Page title="Tasks">
      <Typography variant="h4" gutterBottom>
        {getProjectResult.data?.name} Tasks
      </Typography>
      <div>{tasksComponent}</div>
    </Page>
  );
};

export default ViewProjectTasks;
