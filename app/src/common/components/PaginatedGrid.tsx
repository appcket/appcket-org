import { MutableRefObject, useEffect, useState } from 'react';
import { DataGrid, GridRowsProp, GridColDef, GridPaginationModel } from '@mui/x-data-grid';

import PageInfo from 'src/common/models/responses/PageInfo';

type Props = {
  rows: GridRowsProp;
  columns: GridColDef[];
  totalCount: number;
  pageInfo: PageInfo;
  currentPage: number;
  mapPageToNextCursor: MutableRefObject<{ [page: number]: string }>;
  onPaginate: (pageSize: number, currentPage: number, cursor: string) => void;
};

const PaginatedGrid = ({
  rows,
  columns,
  totalCount,
  pageInfo,
  currentPage,
  mapPageToNextCursor,
  onPaginate,
}: Props) => {
  const PAGE_SIZE = 5;

  const [paginationModel, setPaginationModel] = useState({
    page: currentPage,
    pageSize: PAGE_SIZE,
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
      onPaginate(5, newPaginationModel.page, cursor);
    }
  };

  return (
    <div>
      <DataGrid
        disableRowSelectionOnClick
        rows={rows}
        getRowId={(row) => row.node.id}
        rowCount={rowCountState}
        pageSizeOptions={[PAGE_SIZE]}
        paginationMode="server"
        onPaginationModelChange={handlePaginationModelChange}
        paginationModel={paginationModel}
        columns={columns}
        autoHeight={true}
      />
    </div>
  );
};

export default PaginatedGrid;
