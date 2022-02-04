import React from 'react';
import Typography from '@mui/material/Typography';
import { DataGrid, GridRowsProp, GridColDef, GridValueGetterParams } from '@mui/x-data-grid';

import User from 'src/common/models/User';
import { useSearchUsers } from 'src/common/api/user';
import { useStore } from 'src/common/store';

function getFullName(params: GridValueGetterParams) {
  return `${params.row.firstName || ''} ${params.row.lastName || ''}`;
}

const ResourceUsersGrid = () => {
  const searchUsersQuery = useSearchUsers();
  const selectedUserIds = useStore((state) => state.resourceUsers.selectedUserIds);

  const columns: GridColDef[] = [
    {
      field: 'name',
      headerName: 'Name',
      flex: 1,
      minWidth: 150,
      valueGetter: getFullName,
    },
  ];

  if (searchUsersQuery.isSuccess) {
    const rows: GridRowsProp = searchUsersQuery.data;

    // convert api data to mui grid-compatible data
    searchUsersQuery.data.forEach((user: User) => {
      user.id = user.user_id;
    });

    return (
      <div style={{ height: 400, width: '100%' }}>
        <Typography variant="body1" sx={{ mb: 2 }}>
          Team Users:
        </Typography>
        <DataGrid
          rows={rows}
          columns={columns}
          checkboxSelection
          selectionModel={selectedUserIds}
          onSelectionModelChange={(userIds) => {
            useStore.setState((state) => ({
              resourceUsers: {
                ...state.resourceUsers,
                selectedUserIds: userIds as string[],
              },
            }));
          }}
        />
      </div>
    );
  } else {
    return <div>Loading users...</div>;
  }
};

export default ResourceUsersGrid;
