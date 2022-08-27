import { StateCreator } from 'zustand';

export interface ResourceUsersSlice {
  resourceUsers: {
    initialSelectedUserIds: string[];
    selectedUserIds: string[];
    resetSelectedUserIds: () => void;
  };
}

export const createResourceUsersSlice: StateCreator<ResourceUsersSlice> = (set) => ({
  resourceUsers: {
    initialSelectedUserIds: [],
    selectedUserIds: [],
    resetSelectedUserIds: () =>
      set((state: ResourceUsersSlice) => ({
        // can also use immer to update nested states if necessary
        resourceUsers: {
          ...state.resourceUsers,
          selectedUserIds: state.resourceUsers.initialSelectedUserIds,
        },
      })),
  },
});
