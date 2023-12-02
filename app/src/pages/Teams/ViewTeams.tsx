import { useState } from 'react';
import { Link, NavLink } from 'react-router-dom';
import { GridRowsProp, GridColDef } from '@mui/x-data-grid';
import Button from '@mui/material/Button';
import Grid from '@mui/material/Unstable_Grid2/Grid2';
import { AddCircleOutlineOutlined } from '@mui/icons-material';

import Page from 'src/common/components/Page';
import PageHeader from 'src/common/components/PageHeader';
import { useSearchTeams } from 'src/common/api/team';
import hasPermission from 'src/common/utils/hasPermission';
import { TeamPermission } from 'src/common/enums/permissions.enum';
import Resources from 'src/common/enums/resources.enum';
import Permission from 'src/common/models/Permission';
import { formatDatetime } from 'src/common/utils/general';
import PaginatedGrid from 'src/common/components/PaginatedGrid';
import { Card } from '@mui/material';
import { useUserInfo } from 'src/common/api/user';

const PAGE_SIZE = 10;

const ViewTeams = () => {
  const userInfo = useUserInfo();

  const [queryOptions, setQueryOptions] = useState({
    pageSize: PAGE_SIZE,
    cursor: '',
    orderByFieldName: 'name',
    orderByDirection: 'ASC',
    searchValue: '',
    searchFieldName: 'name',
  });

  const [currentPage, setCurrentPage] = useState(0);

  const { status, data } = useSearchTeams(
    queryOptions.searchValue,
    queryOptions.pageSize,
    queryOptions.cursor ? queryOptions.cursor : null,
    `[{ fieldName: "${queryOptions.orderByFieldName}", direction: ${queryOptions.orderByDirection} }]`,
  );

  const createTeamPermission = hasPermission(
    userInfo.data?.permissions as Permission[],
    Resources.Team,
    TeamPermission.create,
  );

  let createTeamButton = (
    <Button variant="outlined" startIcon={<AddCircleOutlineOutlined />} disabled>
      Create Team
    </Button>
  );

  if (createTeamPermission) {
    createTeamButton = (
      <Button
        variant="contained"
        color="secondary"
        component={Link}
        to="create"
        startIcon={<AddCircleOutlineOutlined />}
      >
        Create Team
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
          <NavLink to={`/teams/${cellValues.row.node.id}`}>{cellValues.row.node.name}</NavLink>
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

  const teamsGrid = (
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
    <Page title="Teams">
      <PageHeader title="Teams" subTitle="Manage teams for an organization">
        <Grid container justifyContent="flex-end">
          <Grid>{createTeamButton}</Grid>
        </Grid>
      </PageHeader>
      <Card sx={{ mx: { xs: 3, md: 3 } }}>{teamsGrid}</Card>
    </Page>
  );
};

export default ViewTeams;
