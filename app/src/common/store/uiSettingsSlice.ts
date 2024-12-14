import { StateCreator } from 'zustand';

export interface UiSettingsSlice {
  uiSettings: {
    themeColorMode: string;
    locale: string;
  };
}

export const createUiSettingsSlice: StateCreator<UiSettingsSlice> = (set) => ({
  uiSettings: {
    themeColorMode: 'light',
    locale: 'en',
  },
});
