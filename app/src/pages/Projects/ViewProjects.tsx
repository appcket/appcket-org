import { useState } from 'react';
import { useQuery } from '@tanstack/react-query';
import { Link, NavLink } from 'react-router-dom';
import { GridRowsProp, GridColDef, GridSortModel } from '@mui/x-data-grid';
import Button from '@mui/material/Button';
import Grid from '@mui/material/Unstable_Grid2/Grid2';
import { AddCircleOutlineOutlined } from '@mui/icons-material';
import { Card } from '@mui/material';

import Page from 'src/common/components/Page';
import PageHeader from 'src/common/components/PageHeader';
import { useSearchProjects } from 'src/common/api/project';
import hasPermission from 'src/common/utils/hasPermission';
import { ProjectPermission } from 'src/common/enums/permissions.enum';
import Resources from 'src/common/enums/resources.enum';
import UserInfoResponse from 'src/common/models/responses/UserInfoResponse';
import Permission from 'src/common/models/Permission';
import { formatDatetime } from 'src/common/utils/general';
import PaginatedGrid from 'src/common/components/PaginatedGrid';

const PAGE_SIZE = 10;

const ViewProjects = () => {
  const userInfoQuery = useQuery<UserInfoResponse>(['userInfo']);

  const [queryOptions, setQueryOptions] = useState({
    pageSize: PAGE_SIZE,
    cursor: '',
    orderByFieldName: 'name',
    orderByDirection: 'ASC',
    searchValue: '',
    searchFieldName: 'name',
  });

  const [currentPage, setCurrentPage] = useState(0);

  const { status, data, error } = useSearchProjects(
    queryOptions.searchValue,
    queryOptions.pageSize,
    queryOptions.cursor ? queryOptions.cursor : null,
    `[{ fieldName: "${queryOptions.orderByFieldName}", direction: ${queryOptions.orderByDirection} }]`,
  );

  const createProjectPermission = hasPermission(
    userInfoQuery.data?.userInfo.permissions as Permission[],
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
        Create Project
      </Button>
    );
  }

  const columns: GridColDef[] = [
    {
      field: 'name',
      headerName: 'Name',
      flex: 0.25,
      renderCell: (cellValues) => {
        return (
          <NavLink to={`/projects/${cellValues.row.node.id}`}>{cellValues.row.node.name}</NavLink>
        );
      },
    },
    {
      field: 'updatedAt',
      headerName: 'Updated',
      filterable: false,
      flex: 0.25,
      renderCell: (cellValues) => {
        return formatDatetime(cellValues.row.node.updatedAt);
      },
    },
    {
      field: 'createdAt',
      headerName: 'Created',
      filterable: false,
      flex: 0.25,
      renderCell: (cellValues) => {
        return formatDatetime(cellValues.row.node.createdAt);
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

  const totalCount = data?.totalCount ? data.totalCount : 0;
  const pageInfo = data?.pageInfo
    ? data.pageInfo
    : {
        endCursor: '',
        startCursor: '',
        hasPreviousPage: false,
        hasNextPage: false,
      };

  const projectsGrid = (
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
    <Page title="Projects">
      <PageHeader title="Projects" subTitle="Manage projects for an organization">
        <Grid container justifyContent="flex-end">
          <Grid>{createProjectButton}</Grid>
        </Grid>
      </PageHeader>
      <Card sx={{ mx: { xs: 3, md: 3 } }}>{projectsGrid}</Card>
    </Page>
  );
};

export default ViewProjects;
