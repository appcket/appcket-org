import Skeleton from '@mui/material/Skeleton';
import Typography from '@mui/material/Typography';
import {
  DataGrid,
  GridRowsProp,
  GridColDef,
  GRID_CHECKBOX_SELECTION_COL_DEF,
  GridRowSelectionModel,
  GridRowId,
} from '@mui/x-data-grid';
import PropTypes from 'prop-types';
import { useTranslation } from 'react-i18next';

import { useSearchUsers } from 'src/common/api/user';
import { useStore } from 'src/common/store';
import User from '../models/User';
import { useEffect, useState } from 'react';

type Props = {
  resourceType: string;
  organizationId: string;
};

const getFullName = (value: string, row: User) => `${row.firstName || ''} ${row.lastName || ''}`;

const ResourceUsersGrid = ({ resourceType, organizationId }: Props) => {
  const { t } = useTranslation();
  const searchUsersQuery = useSearchUsers(organizationId);
  const selectedUserIds = useStore((state) => state.resourceUsers.selectedUserIds);
  const [rowSelectionModel, setRowSelectionModel] = useState<GridRowSelectionModel>({
    type: 'include',
    ids: new Set(),
  });

  useEffect(() => {
    setRowSelectionModel({
      type: 'include',
      ids: new Set(selectedUserIds),
    });
  }, [rowSelectionModel]);

  const columns: GridColDef[] = [
    {
      ...GRID_CHECKBOX_SELECTION_COL_DEF,
      width: 110,
    },
    {
      field: 'name',
      headerName: t('common.name'),
      flex: 1,
      minWidth: 150,
      valueGetter: getFullName,
    },
  ];

  if (searchUsersQuery.isSuccess) {
    const rows: GridRowsProp = searchUsersQuery.data;

    return (
      <div>
        <Typography variant="body1" sx={{ mb: 2 }}>
          {resourceType} {t('labels.users')}:
        </Typography>
        <DataGrid
          rows={rows}
          columns={columns}
          checkboxSelection
          disableRowSelectionOnClick
          rowSelectionModel={rowSelectionModel}
          onRowSelectionModelChange={(userIds) => {
            setRowSelectionModel(userIds);
            useStore.setState((state) => ({
              resourceUsers: {
                ...state.resourceUsers,
                selectedUserIds: userIds.ids as unknown as string[],
              },
            }));
          }}
        />
      </div>
    );
  } else {
    return <Skeleton variant="rectangular" height={60} />;
  }
};

ResourceUsersGrid.propTypes = {
  organizationId: PropTypes.string,
};

export default ResourceUsersGrid;
