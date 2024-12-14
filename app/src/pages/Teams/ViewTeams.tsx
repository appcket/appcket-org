import { useEffect, useState } from 'react';
import { GridRowsProp, GridColDef } from '@mui/x-data-grid';
import Button from '@mui/material/Button';
import Grid from '@mui/material/Grid2';
import { AddCircleOutlineOutlined } from '@mui/icons-material';
import { Card } from '@mui/material';
import { useTranslation } from 'react-i18next';
import { Link, NavLink } from 'react-router-dom';

import { useUserInfo } from 'src/common/api/user';
import { useSearchTeams } from 'src/common/api/team';
import Page from 'src/common/components/Page';
import PageHeader from 'src/common/components/PageHeader';
import PaginatedGrid from 'src/common/components/PaginatedGrid';
import { TeamPermission } from 'src/common/enums/permissions.enum';
import QueryStatuses from 'src/common/enums/queryStatuses.enum';
import Resources from 'src/common/enums/resources.enum';
import Permission from 'src/common/models/Permission';
import hasPermission from 'src/common/utils/hasPermission';
import { formatDatetime } from 'src/common/utils/general';

const PAGE_SIZE = 10;

const ViewTeams = () => {
  const { t } = useTranslation();
  const userInfo = useUserInfo();

  const [queryOptions, setQueryOptions] = useState({
    pageSize: PAGE_SIZE,
    cursor: '',
    orderByFieldName: 'name',
    orderByInnerFieldName: '',
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

  const { status, data } = useSearchTeams(
    queryOptions.searchValue,
    queryOptions.pageSize,
    queryOptions.cursor ? queryOptions.cursor : null,
    `[{ fieldName: "${queryOptions.orderByFieldName}", innerFieldName: "${queryOptions.orderByInnerFieldName}",  direction: ${queryOptions.orderByDirection} }]`,
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
        {t('pages.teams.viewTeams.createTeam')}
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
          <NavLink to={`/teams/${cellValues.row.node.id}`}>{cellValues.row.node.name}</NavLink>
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
        return formatDatetime(cellValues.row.node.updatedAt);
      },
    },
    {
      field: 'createdAt',
      headerName: t('common.created'),
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
      orderByInnerFieldName: queryOptions.orderByFieldName === 'organization' ? 'name' : '',
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
      orderByInnerFieldName: orderByFieldName === 'organization' ? 'name' : '',
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
      orderByInnerFieldName: queryOptions.orderByInnerFieldName,
      orderByDirection: queryOptions.orderByDirection,
      searchValue,
      searchFieldName,
    });
  };

  const rows: GridRowsProp = data?.edges ? data.edges : [];

  const teamsGrid = (
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
    <Page title={t('pages.teams.viewTeams.title')}>
      <PageHeader
        title={t('pages.teams.viewTeams.title')}
        subTitle={t('pages.teams.viewTeams.subTitle')}
      >
        <Grid container justifyContent="flex-end">
          <Grid>{createTeamButton}</Grid>
        </Grid>
      </PageHeader>
      <Card sx={{ mx: { xs: 3, md: 3 } }}>{teamsGrid}</Card>
    </Page>
  );
};

export default ViewTeams;
