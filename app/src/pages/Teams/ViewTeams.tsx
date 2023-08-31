import { useState, useRef } from 'react';
import { useQuery } from '@tanstack/react-query';
import Typography from '@mui/material/Typography';
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
import UserInfoResponse from 'src/common/models/responses/UserInfoResponse';
import Permission from 'src/common/models/Permission';
import Loading from 'src/common/components/Loading';
import { formatDatetime } from 'src/common/utils/general';
import PaginatedGrid from 'src/common/components/PaginatedGrid';

const PAGE_SIZE = 5;
const orderByFieldName = 'name';
const orderByDirection = 'ASC';

const ViewTeams = () => {
  const userInfoQuery = useQuery<UserInfoResponse>(['userInfo']);

  const [queryOptions, setQueryOptions] = useState({ pageSize: PAGE_SIZE, cursor: '' });

  const [currentPage, setCurrentPage] = useState(0);

  const mapPageToNextCursor = useRef<{ [page: number]: string }>({});

  // TODO: user input from Team name filter input field should drive table results
  const { status, data, error } = useSearchTeams(
    '',
    queryOptions.pageSize,
    queryOptions.cursor ? queryOptions.cursor : null,
    `[{ fieldName: "${orderByFieldName}", orderDirection: ${orderByDirection} }]`,
    queryOptions.cursor ? queryOptions.cursor : '',
  );

  const createTeamPermission = hasPermission(
    userInfoQuery.data?.userInfo.permissions as Permission[],
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
        component={Link}
        to="create"
        startIcon={<AddCircleOutlineOutlined />}
      >
        Create Team
      </Button>
    );
  }

  let teamsGrid = <Typography paragraph>Unable to view Teams</Typography>;

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
      flex: 0.25,
      sortable: false,
      renderCell: (cellValues) => {
        return formatDatetime(cellValues.row.node.updatedAt);
      },
    },
    {
      field: 'createdAt',
      headerName: 'Created',
      flex: 0.25,
      sortable: false,
      renderCell: (cellValues) => {
        return formatDatetime(cellValues.row.node.createdAt);
      },
    },
  ];

  const handlePaginate = (pageSize: number, currentPage: number, cursor: string) => {
    setQueryOptions({ pageSize, cursor });
    setCurrentPage(currentPage);
  };

  if (status === 'loading') {
    teamsGrid = <Loading />;
  } else if (status === 'error' && error instanceof Error) {
    teamsGrid = <Typography paragraph>Error: {error.message}</Typography>;
  } else {
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

    teamsGrid = (
      <PaginatedGrid
        rows={rows}
        columns={columns}
        totalCount={totalCount}
        pageInfo={pageInfo}
        currentPage={currentPage}
        mapPageToNextCursor={mapPageToNextCursor}
        onPaginate={handlePaginate}
      />
    );
  }

  return (
    <Page title="Teams">
      <PageHeader title="Teams" subTitle="Manage teams for an organization">
        <Grid container justifyContent="flex-end">
          <Grid>{createTeamButton}</Grid>
        </Grid>
      </PageHeader>
      {teamsGrid}
    </Page>
  );
};

export default ViewTeams;
