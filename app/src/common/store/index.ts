import create, { GetState, SetState } from 'zustand';

import { TeamUsersSlice, createTeamUsersSlice } from './teamUsersSlice';

export type StoreState = TeamUsersSlice; // & OtherSlice & AnotherSlice etc.

export type StoreSlice<T> = (set: SetState<StoreState>, get: GetState<StoreState>) => T;

export const useStore = create<StoreState>((set, get) => ({
  ...createTeamUsersSlice(set, get),
}));
