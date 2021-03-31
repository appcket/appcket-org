import { createMuiTheme, colors } from '@material-ui/core';

const primary = '#03071D';
const secondary = '#E14A1B';

const theme = createMuiTheme({
  palette: {
    background: {
      default: colors.common.white,
      paper: colors.common.white,
    },
    primary: {
      main: primary,
    },
    secondary: {
      main: secondary,
    },
    text: {
      primary: colors.blueGrey[900],
      secondary: colors.blueGrey[600],
    },
  },
});

export default theme;
