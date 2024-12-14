import { useTranslation } from 'react-i18next';
import { Translate } from '@mui/icons-material';
import { Box, Select, MenuItem, SelectChangeEvent } from '@mui/material';
import Flag from 'react-flagpack';
import 'react-flagpack/dist/style.css';

import { useStore } from 'src/common/store';
import { flagCodes, supportedLngs } from 'src/i18n/config';

export default function LocaleSwitcher() {
  const { i18n, t } = useTranslation();
  const locale = useStore((state) => state.uiSettings.locale);

  const handleChange = (event: SelectChangeEvent) => {
    const newLocale = event.target.value;
    useStore.setState((state) => ({
      uiSettings: {
        ...state.uiSettings,
        locale: newLocale,
      },
    }));
    i18n.changeLanguage(newLocale);
  };

  return (
    <Box sx={{ display: 'inline-flex', alignItems: 'center' }}>
      <Translate fontSize="small" />

      <Select value={locale} onChange={handleChange} size="small" sx={{ ml: 1, mr: 1 }}>
        {Object.entries(supportedLngs).map(([code, name]) => (
          <MenuItem value={code} key={code}>
            <Flag
              code={flagCodes[code as keyof typeof flagCodes]}
              gradient="real-linear"
              size="m"
            />
            &nbsp;
            {name}
          </MenuItem>
        ))}
      </Select>
    </Box>
  );
}
