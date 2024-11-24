export interface IEdge<T> {
  node: T;
}

export interface IPageInfo {
  endCursor: string;
  hasNextPage: boolean;
  startCursor: string;
  hasPreviousPage: boolean;
}

export interface IPaginated<T> {
  totalCount: number;
  edges: IEdge<T>[];
  pageInfo: IPageInfo;
}
