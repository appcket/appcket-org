import { useEffect, useState } from 'react';
import { Link, NavLink } from 'react-router-dom';
import { GridRowsProp, GridColDef, GridSortModel } from '@mui/x-data-grid';
import Button from '@mui/material/Button';
import Grid from '@mui/material/Grid2';
import { AddCircleOutlineOutlined } from '@mui/icons-material';
import { Card } from '@mui/material';
import { useTranslation } from 'react-i18next';

import { useUserInfo } from 'src/common/api/user';
import Page from 'src/common/components/Page';
import PageHeader from 'src/common/components/PageHeader';
import { useSearchProjects } from 'src/common/api/project';
import hasPermission from 'src/common/utils/hasPermission';
import { ProjectPermission } from 'src/common/enums/Permissions';
import QueryStatuses from 'src/common/enums/QueryStatuses';
import Resources from 'src/common/enums/Resources';
import Permission from 'src/common/models/Permission';
import PaginatedGrid from 'src/common/components/PaginatedGrid';

const PAGE_SIZE = 10;

const ViewProjects = () => {
  const { t } = useTranslation();
  const userInfo = useUserInfo();

  const [queryOptions, setQueryOptions] = useState({
    pageSize: PAGE_SIZE,
    cursor: '',
    orderByFieldName: 'name',
    orderByDirection: 'ASC',
    searchValue: '',
    searchFieldName: 'name',
  });

  const [paginationData, setPaginationData] = useState({
    totalCount: 0,
    pageInfo: {
      endCursor: '',
      startCursor: '',
      hasPreviousPage: false,
      hasNextPage: false,
    },
  });

  const [currentPage, setCurrentPage] = useState(0);

  const { status, data, error } = useSearchProjects(
    queryOptions.searchValue,
    queryOptions.pageSize,
    queryOptions.cursor ? queryOptions.cursor : null,
    `[{ fieldName: "${queryOptions.orderByFieldName}", direction: ${queryOptions.orderByDirection} }]`,
  );

  useEffect(() => {
    if (status !== QueryStatuses.Pending) {
      const totalCount = data?.totalCount ? data.totalCount : 0;
      const pageInfo = data?.pageInfo
        ? data.pageInfo
        : {
            endCursor: '',
            startCursor: '',
            hasPreviousPage: false,
            hasNextPage: false,
          };

      setPaginationData({
        totalCount,
        pageInfo,
      });
    }
  }, [data]);

  const createProjectPermission = hasPermission(
    userInfo.data?.permissions as Permission[],
    Resources.Project,
    ProjectPermission.create,
  );

  let createProjectButton = (
    <Button variant="outlined" startIcon={<AddCircleOutlineOutlined />} disabled>
      Create Project
    </Button>
  );

  if (createProjectPermission) {
    createProjectButton = (
      <Button
        variant="contained"
        color="secondary"
        component={Link}
        to="create"
        startIcon={<AddCircleOutlineOutlined />}
      >
        {t('pages.projects.viewProjects.createProject')}
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
          <NavLink to={`/projects/${cellValues.row.node.id}`}>{cellValues.row.node.name}</NavLink>
        );
      },
    },
    {
      field: 'organization',
      headerName: t('entities.organization'),
      sortable: false,
      filterable: false,
      flex: 0.25,
      renderCell: (cellValues) => {
        return <span>{cellValues.row.node.organization.name}</span>;
      },
    },
    {
      field: 'updatedAt',
      headerName: t('common.updated'),
      filterable: false,
      flex: 0.25,
      renderCell: (cellValues) => {
        return t('common.dateTime', { value: cellValues.row.node.updatedAt });
      },
    },
    {
      field: 'createdAt',
      headerName: t('common.created'),
      filterable: false,
      flex: 0.25,
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
      orderByDirection: queryOptions.orderByDirection,
      searchValue,
      searchFieldName,
    });
  };

  const rows: GridRowsProp = data?.edges ? data.edges : [];

  const projectsGrid = (
    <PaginatedGrid
      status={status}
      rows={rows}
      columns={columns}
      totalCount={paginationData.totalCount}
      pageInfo={paginationData.pageInfo}
      currentPage={currentPage}
      pageSize={queryOptions.pageSize}
      onPaginate={handlePaginate}
      onSort={handleSort}
      onFilter={handleFilter}
    />
  );

  return (
    <Page title={t('pages.projects.viewProjects.title')}>
      <PageHeader
        title={t('pages.projects.viewProjects.title')}
        subTitle={t('pages.projects.viewProjects.subTitle')}
      >
        <Grid container justifyContent="flex-end">
          <Grid>{createProjectButton}</Grid>
        </Grid>
      </PageHeader>
      <Card sx={{ mx: { xs: 3, md: 3 } }}>{projectsGrid}</Card>
    </Page>
  );
};

export default ViewProjects;
