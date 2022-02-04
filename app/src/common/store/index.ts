import create, { GetState, SetState } from 'zustand';

import { ResourceUsersSlice, createResourceUsersSlice } from './resourceUsersSlice';

export type StoreState = ResourceUsersSlice; // & OtherSlice & AnotherSlice etc.

export type StoreSlice<T> = (set: SetState<StoreState>, get: GetState<StoreState>) => T;

export const useStore = create<StoreState>((set, get) => ({
  ...createResourceUsersSlice(set, get),
}));
