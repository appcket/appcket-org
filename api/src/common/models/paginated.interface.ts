export interface IEdge<T> {
  cursor: string;
  node: T;
}

export interface IPageInfo {
  endCursor: string;
  hasNextPage: boolean;
  startCursor: string;
  hasPreviousPage: boolean;
}

export interface IPaginated<T> {
  previousCount: number;
  currentCount: number;
  totalCount: number;
  edges: IEdge<T>[];
  pageInfo: IPageInfo;
}
