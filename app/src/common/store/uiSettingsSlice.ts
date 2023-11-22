import { StateCreator } from 'zustand';

export interface UiSettingsSlice {
  uiSettings: {
    themeColorMode: string;
  };
}

export const createUiSettingsSlice: StateCreator<UiSettingsSlice> = (set) => ({
  uiSettings: {
    themeColorMode: 'light',
  },
});
