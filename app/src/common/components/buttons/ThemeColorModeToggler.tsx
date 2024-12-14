import * as React from 'react';
import { styled } from '@mui/material/styles';
import LightModeIcon from '@mui/icons-material/LightMode';
import ModeNightIcon from '@mui/icons-material/ModeNight';
import ToggleButton from '@mui/material/ToggleButton';
import ToggleButtonGroup from '@mui/material/ToggleButtonGroup';
import Tooltip from '@mui/material/Tooltip';
import { PaletteMode } from '@mui/material';
import { useTranslation } from 'react-i18next';

import { useStore } from 'src/common/store';
import { isNull } from 'lodash';

export default function ToggleButtons() {
  const { t } = useTranslation();
  const themeColorMode = useStore((state) => state.uiSettings.themeColorMode) as PaletteMode;

  const StyledToggleButtonGroup = styled(ToggleButtonGroup)(({ theme }) => ({
    '& .MuiToggleButtonGroup-grouped': {
      margin: theme.spacing(0.5),
      border: 0,
      '&.Mui-disabled': {
        border: 0,
      },
      '&:not(:first-of-type)': {
        borderRadius: theme.shape.borderRadius,
      },
      '&:first-of-type': {
        borderRadius: theme.shape.borderRadius,
      },
    },
  }));

  const handleToggle = (event: React.MouseEvent<HTMLElement>, newThemeColorMode: PaletteMode) => {
    // only change the store value if value from toggle button is not null and different from the current theme mode
    if (!isNull(newThemeColorMode) && themeColorMode !== newThemeColorMode) {
      useStore.setState((state) => ({
        uiSettings: {
          ...state.uiSettings,
          themeColorMode: newThemeColorMode as PaletteMode,
        },
      }));
    }
  };

  return (
    <StyledToggleButtonGroup
      size="small"
      value={themeColorMode}
      exclusive
      onChange={handleToggle}
      aria-label="Change Theme Color Mode"
    >
      <ToggleButton value="light" aria-label={t('common.lightMode')}>
        <Tooltip title={t('common.lightMode')}>
          <LightModeIcon
            style={{
              height: 18,
            }}
          />
        </Tooltip>
      </ToggleButton>
      <ToggleButton value="dark" aria-label={t('common.darkMode')}>
        <Tooltip title={t('common.darkMode')}>
          <ModeNightIcon
            style={{
              height: 18,
            }}
          />
        </Tooltip>
      </ToggleButton>
    </StyledToggleButtonGroup>
  );
}
