import { createTheme, colors } from '@mui/material';

const primary = '#03071D';
const secondary = '#E14A1B';

const theme = createTheme({
  components: {
    MuiCssBaseline: {
      styleOverrides: {
        html: {
          height: '100%',
        },
        body: {
          height: '100%',
          fontFamily: "'Montserrat', 'Ubuntu', 'Helvetica Neue'",
        },
        '#root': {
          height: '100%',
        },
      },
    },
    MuiIconButton: {
      styleOverrides: {
        root: {
          color: colors.grey[500],
        },
      },
    },
  },
  palette: {
    // mode: 'dark',
    primary: {
      main: primary,
    },
    secondary: {
      main: secondary,
    },
  },
});

export default theme;
