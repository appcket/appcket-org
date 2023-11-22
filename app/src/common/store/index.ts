import { create } from 'zustand';
import { mountStoreDevtool } from 'simple-zustand-devtools';

import { ResourceUsersSlice, createResourceUsersSlice } from 'src/common/store/resourceUsersSlice';
import { UiSettingsSlice, createUiSettingsSlice } from 'src/common/store/uiSettingsSlice';

export const useStore = create<ResourceUsersSlice & UiSettingsSlice>()((...a) => ({
  ...createResourceUsersSlice(...a),
  ...createUiSettingsSlice(...a),
}));

if (import.meta.env.MODE === 'development') {
  mountStoreDevtool('Store', useStore);
}
