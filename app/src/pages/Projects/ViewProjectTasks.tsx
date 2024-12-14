import { useState } from 'react';
import { Link, NavLink, useParams } from 'react-router-dom';
import { GridRowsProp, GridColDef } from '@mui/x-data-grid';
import Grid from '@mui/material/Grid2';
import Button from '@mui/material/Button';
import { Card } from '@mui/material';
import { useTranslation } from 'react-i18next';

import { useUserInfo } from 'src/common/api/user';
import { AddCircleOutlineOutlined } from '@mui/icons-material';
import Page from 'src/common/components/Page';
import PageHeader from 'src/common/components/PageHeader';
import { useSearchTasks } from 'src/common/api/task';
import { useGetProject } from 'src/common/api/project';
import hasPermission from 'src/common/utils/hasPermission';
import { TaskPermission } from 'src/common/enums/Permissions';
import Resources from 'src/common/enums/Resources';
import Permission from 'src/common/models/Permission';
import { displayUser } from 'src/common/utils/general';
import PaginatedGrid from 'src/common/components/PaginatedGrid';
import { getOrderByInnerFieldName } from 'src/common/utils/general';

const PAGE_SIZE = 10;

const ViewProjectTasks = () => {
  const { t } = useTranslation();
  const params = useParams();
  let projectId = '';
  if (params.projectId) {
    projectId = params.projectId;
  }

  const [queryOptions, setQueryOptions] = useState({
    pageSize: PAGE_SIZE,
    cursor: '',
    orderByFieldName: 'name',
    orderByInnerFieldName: '',
    orderByDirection: 'ASC',
    searchValue: '',
    searchFieldName: 'name',
  });

  const [currentPage, setCurrentPage] = useState(0);

  const { status, data } = useSearchTasks(
    [projectId],
    queryOptions.searchValue,
    queryOptions.pageSize,
    queryOptions.cursor ? queryOptions.cursor : null,
    queryOptions.orderByInnerFieldName === ''
      ? `[{ fieldName: "${queryOptions.orderByFieldName}",  direction: ${queryOptions.orderByDirection} }]`
      : `[{ fieldName: "${queryOptions.orderByFieldName}", innerFieldName: "${queryOptions.orderByInnerFieldName}", direction: ${queryOptions.orderByDirection} }]`,
  );
  const getProjectResult = useGetProject(projectId);

  const userInfo = useUserInfo();
  const createTaskPermission = hasPermission(
    userInfo.data?.permissions as Permission[],
    Resources.Task,
    TaskPermission.create,
  );

  let createTaskButton = (
    <Button variant="outlined" disabled>
      {t('pages.tasks.viewProjectTasks.createTask')}
    </Button>
  );

  if (createTaskPermission) {
    createTaskButton = (
      <Button
        variant="contained"
        color="secondary"
        component={Link}
        to="create"
        startIcon={<AddCircleOutlineOutlined />}
      >
        {t('pages.tasks.viewProjectTasks.createTask')}
      </Button>
    );
  }

  const columns: GridColDef[] = [
    {
      field: 'name',
      headerName: t('common.name'),
      flex: 0.25,
      renderCell: (cellValues) => {
        return (
          <NavLink to={`/tasks/${cellValues.row.node.id}`}>{cellValues.row.node.name}</NavLink>
        );
      },
    },
    {
      field: 'assignedTo',
      headerName: t('labels.assignedTo'),
      flex: 0.2,
      renderCell: (cellValues) => {
        return `${displayUser(cellValues.row.node.assignedTo)}`;
      },
    },
    {
      field: 'taskStatusType',
      headerName: t('labels.status'),
      flex: 0.15,
      renderCell: (cellValues) => {
        return `${cellValues.row.node.taskStatusType.name}`;
      },
    },
    {
      field: 'updatedAt',
      headerName: t('common.updated'),
      filterable: false,
      flex: 0.15,
      renderCell: (cellValues) => {
        return t('common.dateTime', { value: cellValues.row.node.updatedAt });
      },
    },
    {
      field: 'createdAt',
      headerName: t('common.created'),
      filterable: false,
      flex: 0.15,
      renderCell: (cellValues) => {
        return t('common.dateTime', { value: cellValues.row.node.createdAt });
      },
    },
  ];

  const handlePaginate = (pageSize: number, currentPage: number, cursor: string) => {
    setQueryOptions({
      pageSize,
      cursor,
      orderByFieldName: queryOptions.orderByFieldName,
      orderByInnerFieldName: queryOptions.orderByInnerFieldName,
      orderByDirection: queryOptions.orderByDirection,
      searchValue: queryOptions.searchValue,
      searchFieldName: queryOptions.searchFieldName,
    });
    setCurrentPage(currentPage);
  };

  const handleSort = (orderByFieldName: string, orderByDirection: string) => {
    setQueryOptions({
      pageSize: queryOptions.pageSize,
      cursor: queryOptions.cursor,
      orderByFieldName,
      orderByInnerFieldName: getOrderByInnerFieldName(orderByFieldName),
      orderByDirection,
      searchValue: queryOptions.searchValue,
      searchFieldName: queryOptions.searchFieldName,
    });
  };

  const handleFilter = (searchValue: string, searchFieldName: string) => {
    setQueryOptions({
      pageSize: queryOptions.pageSize,
      cursor: queryOptions.cursor,
      orderByFieldName: queryOptions.orderByFieldName,
      orderByInnerFieldName: getOrderByInnerFieldName(queryOptions.orderByFieldName),
      orderByDirection: queryOptions.orderByDirection,
      searchValue,
      searchFieldName,
    });
  };

  const rows: GridRowsProp = data?.edges ? data.edges : [];

  const totalCount = data?.totalCount ? data.totalCount : 0;
  const pageInfo = data?.pageInfo
    ? data.pageInfo
    : {
        endCursor: '',
        startCursor: '',
        hasPreviousPage: false,
        hasNextPage: false,
      };

  const tasksGrid = (
    <PaginatedGrid
      status={status}
      rows={rows}
      columns={columns}
      totalCount={totalCount}
      pageInfo={pageInfo}
      currentPage={currentPage}
      pageSize={queryOptions.pageSize}
      onPaginate={handlePaginate}
      onSort={handleSort}
      onFilter={handleFilter}
    />
  );

  return (
    <Page title={`${getProjectResult.data?.getProject.name} ${t('labels.tasks')}`}>
      <PageHeader
        title={`${getProjectResult.data?.getProject.name} ${t('labels.tasks')}`}
        subTitle={t('pages.tasks.viewProjectTasks.subTitle')}
      >
        <Grid container justifyContent="flex-end">
          <Grid>{createTaskButton}</Grid>
        </Grid>
      </PageHeader>
      <Card sx={{ mx: { xs: 3, md: 3 } }}>{tasksGrid}</Card>
    </Page>
  );
};

export default ViewProjectTasks;
