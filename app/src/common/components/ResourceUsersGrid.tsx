import Typography from '@mui/material/Typography';
import { DataGrid, GridRowsProp, GridColDef, GridValueGetterParams } from '@mui/x-data-grid';
import PropTypes from 'prop-types';

import { useSearchUsers } from 'src/common/api/user';
import { useStore } from 'src/common/store';

type Props = {
  resourceType: string;
  organizationId: string;
};

function getFullName(params: GridValueGetterParams) {
  return `${params.row.firstName || ''} ${params.row.lastName || ''}`;
}

const ResourceUsersGrid = ({ resourceType, organizationId }: Props) => {
  const searchUsersQuery = useSearchUsers(organizationId);
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

    return (
      <div style={{ height: 400, width: '100%' }}>
        <Typography variant="body1" sx={{ mb: 2 }}>
          {resourceType} Users:
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

ResourceUsersGrid.defaultProps = {
  organizationId: '',
};

ResourceUsersGrid.propTypes = {
  organizationId: PropTypes.string,
};

export default ResourceUsersGrid;
