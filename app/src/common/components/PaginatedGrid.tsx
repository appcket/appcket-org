import { useCallback, useEffect, useState, useRef } from 'react';
import {
  DataGrid,
  GridRowsProp,
  GridColDef,
  GridFilterModel,
  GridPaginationModel,
  GridSortModel,
} from '@mui/x-data-grid';

import QueryStatuses from 'src/common/enums/queryStatuses.enum';
import PageInfo from 'src/common/models/responses/PageInfo';

type Props = {
  status: string;
  rows: GridRowsProp;
  columns: GridColDef[];
  totalCount: number;
  pageInfo: PageInfo;
  currentPage: number;
  pageSize?: number;
  onPaginate: (pageSize: number, currentPage: number, cursor: string) => void;
  onSort: (orderByFieldName: string, orderByDirection: string) => void;
  onFilter: (searchValue: string, searchFieldName: string) => void;
};

const PaginatedGrid = ({
  status,
  rows,
  columns,
  totalCount,
  pageInfo,
  currentPage,
  pageSize,
  onPaginate,
  onSort,
  onFilter,
}: Props) => {
  const PAGE_SIZE = 10;

  const mapPageToNextCursor = useRef<{ [page: number]: string }>({});

  const [paginationModel, setPaginationModel] = useState({
    page: currentPage,
    pageSize: pageSize ? pageSize : PAGE_SIZE,
  });

  useEffect(() => {
    if (pageInfo.endCursor) {
      mapPageToNextCursor.current[paginationModel.page] = pageInfo.endCursor;
    }
  }, [paginationModel.page, pageInfo.endCursor]);

  const [rowCountState, setRowCountState] = useState(totalCount || 0);

  useEffect(() => {
    setRowCountState((prevRowCountState: number) =>
      totalCount !== undefined ? totalCount : prevRowCountState,
    );
  }, [totalCount, setRowCountState]);

  const handlePaginationModelChange = (newPaginationModel: GridPaginationModel) => {
    const cursor = mapPageToNextCursor.current[newPaginationModel.page - 1];

    if (newPaginationModel.page === 0 || cursor) {
      setPaginationModel(newPaginationModel);
      onPaginate(newPaginationModel.pageSize, newPaginationModel.page, cursor);
    }
  };

  const handleSortModelChange = useCallback((sortModel: GridSortModel) => {
    let orderByField = 'name';
    let orderByDirection = 'ASC';

    if (sortModel.length > 0 && sortModel[0].field) {
      orderByField = sortModel[0].field;
    }

    if (sortModel.length > 0 && sortModel[0].sort === 'desc') {
      orderByDirection = 'DESC';
    }

    onSort(orderByField, orderByDirection);
  }, []);

  const handleFilterChange = useCallback((filterModel: GridFilterModel) => {
    let searchValue = '';
    let searchFieldName = 'name';

    if (filterModel.items.length > 0 && filterModel.items[0].value) {
      searchValue = filterModel.items[0].value;
    }

    if (filterModel.items.length > 0 && filterModel.items[0].field) {
      searchFieldName = filterModel.items[0].field;
    }

    onFilter(searchValue, searchFieldName);
  }, []);

  return (
    <DataGrid
      loading={status === QueryStatuses.Pending ? true : false}
      disableRowSelectionOnClick
      rows={rows}
      getRowId={(row) => row.node.id}
      rowCount={rowCountState}
      pageSizeOptions={[PAGE_SIZE]}
      paginationMode="server"
      onPaginationModelChange={handlePaginationModelChange}
      paginationModel={paginationModel}
      sortingMode="server"
      onSortModelChange={handleSortModelChange}
      filterMode="server"
      onFilterModelChange={handleFilterChange}
      columns={columns}
    />
  );
};

export default PaginatedGrid;
