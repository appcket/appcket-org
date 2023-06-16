import { create } from 'zustand';
import { mountStoreDevtool } from 'simple-zustand-devtools';

import { ResourceUsersSlice, createResourceUsersSlice } from './resourceUsersSlice';

export const useStore = create<ResourceUsersSlice>()((...a) => ({
  ...createResourceUsersSlice(...a),
}));

if (import.meta.env.MODE === 'development') {
  mountStoreDevtool('Store', useStore);
}
