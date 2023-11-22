// Consumer component
import { useContext, useEffect } from 'react';
import useMediaQuery from '@mui/material/useMediaQuery';
import { PaletteMode } from '@mui/material';

import { useStore } from 'src/common/store';
import { UiSettingsContext } from 'src/App';

// set initial theme color mode in the store from user's system preferences:
// https://docs.pmnd.rs/zustand/guides/initialize-state-with-props#creating-a-context-with-react.createcontext
export function UiSettingsConsumer() {
  const prefersDarkMode = useMediaQuery('(prefers-color-scheme: dark)');
  const store = useContext(UiSettingsContext);
  if (!store) throw new Error('Missing UiSettingsContext.Provider in the tree');

  useEffect(() => {
    useStore.setState((state) => ({
      uiSettings: {
        ...state.uiSettings,
        themeColorMode: prefersDarkMode ? 'dark' : ('light' as PaletteMode),
      },
    }));
  }, []);

  return <></>;
}
