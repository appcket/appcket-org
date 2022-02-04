import { StoreSlice } from './index';

export interface ResourceUsersSlice {
  resourceUsers: {
    initialSelectedUserIds: string[];
    selectedUserIds: string[];
    resetSelectedUserIds: () => void;
  };
}

export const createResourceUsersSlice: StoreSlice<ResourceUsersSlice> = (set) => ({
  resourceUsers: {
    initialSelectedUserIds: [],
    selectedUserIds: [],
    resetSelectedUserIds: () =>
      set((state) => ({
        // can also use immer to update nested states if necessary
        resourceUsers: { ...state.resourceUsers, selectedUserIds: state.resourceUsers.initialSelectedUserIds },
      })),
  },
});
