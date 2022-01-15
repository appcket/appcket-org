import React from 'react';
import { DataGrid, GridRowsProp, GridColDef, GridValueGetterParams } from '@mui/x-data-grid';

import User from 'src/common/models/User';
import { useSearchUsers } from 'src/common/api/user';
import { useStore } from 'src/common/store';

function getFullName(params: GridValueGetterParams) {
  return `${params.row.firstName || ''} ${params.row.lastName || ''}`;
}

const TeamUsersGrid = () => {
  const searchUsersQuery = useSearchUsers();
  const selectedUserIds = useStore((state) => state.teamUsers.selectedUserIds);

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
      <div style={{ height: 300, width: '100%' }}>
        <DataGrid
          rows={rows}
          columns={columns}
          checkboxSelection
          selectionModel={selectedUserIds}
          onSelectionModelChange={(userIds) => {
            useStore.setState((state) => ({
              teamUsers: {
                ...state.teamUsers,
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

export default TeamUsersGrid;
