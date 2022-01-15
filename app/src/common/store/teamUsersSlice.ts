import { StoreSlice } from './index';

export interface TeamUsersSlice {
  teamUsers: {
    initialSelectedUserIds: string[];
    selectedUserIds: string[];
    resetSelectedUserIds: () => void;
  };
}

export const createTeamUsersSlice: StoreSlice<TeamUsersSlice> = (set) => ({
  teamUsers: {
    initialSelectedUserIds: [],
    selectedUserIds: [],
    resetSelectedUserIds: () =>
      set((state) => ({
        // can also use immer to update nested states if necessary
        teamUsers: { ...state.teamUsers, selectedUserIds: state.teamUsers.initialSelectedUserIds },
      })),
  },
});
