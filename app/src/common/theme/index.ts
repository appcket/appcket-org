import { alpha, createTheme, lighten, darken } from '@mui/material';

declare module '@mui/material/styles' {
  interface Components {
    [key: string]: any;
  }
}

const themeColors = {
  primary: '#03071D',
  secondary: '#E14A1B',
  success: '#57CA22',
  warning: '#FFA319',
  error: '#FF1943',
  info: '#33C2FF',
  black: '#000000',
  white: '#ffffff',
  primaryAlt: '#000C57',
};

const colors = {
  gradients: {
    blue1: 'linear-gradient(135deg, #6B73FF 0%, #000DFF 100%)',
    blue2: 'linear-gradient(135deg, #ABDCFF 0%, #0396FF 100%)',
    blue3: 'linear-gradient(127.55deg, #141E30 3.73%, #243B55 92.26%)',
    blue4: 'linear-gradient(-20deg, #2b5876 0%, #4e4376 100%)',
    blue5: 'linear-gradient(135deg, #97ABFF 10%, #123597 100%)',
    orange1: 'linear-gradient(135deg, #FCCF31 0%, #F55555 100%)',
    orange2: 'linear-gradient(135deg, #FFD3A5 0%, #FD6585 100%)',
    orange3: 'linear-gradient(120deg, #f6d365 0%, #fda085 100%)',
    purple1: 'linear-gradient(135deg, #43CBFF 0%, #9708CC 100%)',
    purple3: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
    pink1: 'linear-gradient(135deg, #F6CEEC 0%, #D939CD 100%)',
    pink2: 'linear-gradient(135deg, #F761A1 0%, #8C1BAB 100%)',
    green1: 'linear-gradient(135deg, #FFF720 0%, #3CD500 100%)',
    green2: 'linear-gradient(to bottom, #00b09b, #96c93d)',
    black1: 'linear-gradient(100.66deg, #434343 6.56%, #000000 93.57%)',
    black2: 'linear-gradient(60deg, #29323c 0%, #485563 100%)',
  },
  shadows: {
    card: '0px 5px 14px rgba(159, 162, 191, .2), 0px 2px 2px rgba(159, 162, 191, 0.35)',
    cardSm: '0px 2px 3px rgba(159, 162, 191, .18), 0px 1px 1px rgba(159, 162, 191, 0.32)',
    cardLg:
      '0 5rem 14rem 0 rgb(255 255 255 / 30%), 0 0.8rem 2.3rem rgb(0 0 0 / 60%), 0 0.2rem 0.3rem rgb(0 0 0 / 45%)',
  },
  layout: {
    general: {
      bodyBg: '#e9eef3',
    },
    sidebar: {
      background: themeColors.white,
      textColor: themeColors.secondary,
      dividerBg: '#f2f5f9',
      menuItemColor: '#242E6F',
      menuItemColorActive: themeColors.primary,
      menuItemBg: themeColors.white,
      menuItemBgActive: '#f2f5f9',
      menuItemIconColor: lighten(themeColors.secondary, 0.3),
      menuItemIconColorActive: themeColors.primary,
      menuItemHeadingColor: darken(themeColors.secondary, 0.3),
    },
  },
  alpha: {
    white: {
      5: alpha(themeColors.white, 0.02),
      10: alpha(themeColors.white, 0.1),
      30: alpha(themeColors.white, 0.3),
      50: alpha(themeColors.white, 0.5),
      70: alpha(themeColors.white, 0.7),
      100: themeColors.white,
    },
    trueWhite: {
      5: alpha(themeColors.white, 0.02),
      10: alpha(themeColors.white, 0.1),
      30: alpha(themeColors.white, 0.3),
      50: alpha(themeColors.white, 0.5),
      70: alpha(themeColors.white, 0.7),
      100: themeColors.white,
    },
    black: {
      5: alpha(themeColors.black, 0.02),
      10: alpha(themeColors.black, 0.1),
      30: alpha(themeColors.black, 0.3),
      50: alpha(themeColors.black, 0.5),
      70: alpha(themeColors.black, 0.7),
      100: themeColors.black,
    },
  },
  secondary: {
    lighter: lighten(themeColors.secondary, 0.85),
    light: lighten(themeColors.secondary, 0.25),
    main: themeColors.secondary,
    dark: darken(themeColors.secondary, 0.2),
  },
  primary: {
    lighter: lighten(themeColors.primary, 0.85),
    light: lighten(themeColors.primary, 0.3),
    main: themeColors.primary,
    dark: darken(themeColors.primary, 0.2),
  },
  success: {
    lighter: lighten(themeColors.success, 0.85),
    light: lighten(themeColors.success, 0.3),
    main: themeColors.success,
    dark: darken(themeColors.success, 0.2),
  },
  warning: {
    lighter: lighten(themeColors.warning, 0.85),
    light: lighten(themeColors.warning, 0.3),
    main: themeColors.warning,
    dark: darken(themeColors.warning, 0.2),
  },
  error: {
    lighter: lighten(themeColors.error, 0.85),
    light: lighten(themeColors.error, 0.3),
    main: themeColors.error,
    dark: darken(themeColors.error, 0.2),
  },
  info: {
    lighter: lighten(themeColors.info, 0.85),
    light: lighten(themeColors.info, 0.3),
    main: themeColors.info,
    dark: darken(themeColors.info, 0.2),
  },
};

const theme = createTheme({
  components: {
    MuiAppBar: {
      styleOverrides: {
        root: {
          background: themeColors.white,
          color: themeColors.primary,
        },
      },
    },
    MuiButton: {
      styleOverrides: {
        root: {
          borderRadius: 18,
          boxShadow: 'none',
          whiteSpace: 'nowrap',
          ':active': {
            boxShadow: 'none',
          },
          ':hover': {
            boxShadow: 'none',
          },
        },
      },
    },
    MuiCssBaseline: {
      styleOverrides: {
        html: {
          height: '100%',
        },
        body: {
          height: '100%',
        },
        '#root': {
          height: '100%',
        },
      },
    },
    MuiDrawer: {
      styleOverrides: {
        paper: {
          background: themeColors.primary,
          color: themeColors.white,
        },
      },
    },
    MuiDataGrid: {
      styleOverrides: {
        root: {
          background: themeColors.white,
          color: themeColors.primary,
          '& .MuiDataGrid-cell': {
            padding: '0 30px',
          },
          '& .MuiDataGrid-columnHeaders': {
            background: darken(themeColors.white, 0.03),
          },
          '& .MuiDataGrid-row': {
            ':hover': {
              background: darken(themeColors.white, 0.07),
            },
          },
          '& .MuiDataGrid-columnHeader': {
            fontSize: 16,
            padding: '0 30px',
            color: colors.alpha.black[100],
            ':hover': {
              color: colors.alpha.black[70],
            },
          },
          '& .MuiDataGrid-columnHeader--sorted': {
            fontSize: 16,
            color: colors.alpha.black[100],
            ':hover': {
              color: colors.alpha.black[100],
            },
          },
        },
      },
    },
    MuiFormHelperText: {
      styleOverrides: {
        root: {
          textTransform: 'none',
        },
      },
    },
    MuiIconButton: {
      styleOverrides: {
        root: {
          color: colors.alpha.black[50],
        },
      },
    },
    MuiListItem: {
      styleOverrides: {
        root: {
          paddingTop: '2px',
          paddingBottom: '2px',
        },
      },
    },
    MuiPaper: {
      styleOverrides: {
        root: {
          padding: 0,
        },
        elevation0: {
          boxShadow: 'none',
        },
        elevation: {
          boxShadow: colors.shadows.card,
        },
        elevation2: {
          boxShadow: colors.shadows.cardSm,
        },
        elevation24: {
          boxShadow: colors.shadows.cardLg,
        },
        outlined: {
          boxShadow: colors.shadows.card,
        },
      },
    },
  },
  spacing: 9,
  shape: {
    borderRadius: 8,
  },
  palette: {
    common: {
      black: colors.alpha.black[100],
      white: colors.alpha.white[100],
    },
    mode: 'light',
    primary: {
      light: colors.primary.light,
      main: colors.primary.main,
      dark: colors.primary.dark,
    },
    secondary: {
      light: colors.secondary.light,
      main: colors.secondary.main,
      dark: colors.secondary.dark,
    },
    error: {
      light: colors.error.light,
      main: colors.error.main,
      dark: colors.error.dark,
      contrastText: colors.alpha.white[100],
    },
    success: {
      light: colors.success.light,
      main: colors.success.main,
      dark: colors.success.dark,
      contrastText: colors.alpha.white[100],
    },
    info: {
      light: colors.info.light,
      main: colors.info.main,
      dark: colors.info.dark,
      contrastText: colors.alpha.white[100],
    },
    warning: {
      light: colors.warning.light,
      main: colors.warning.main,
      dark: colors.warning.dark,
      contrastText: colors.alpha.white[100],
    },
    text: {
      primary: colors.alpha.black[100],
      secondary: colors.alpha.black[70],
      disabled: colors.alpha.black[50],
    },
    background: {
      paper: colors.alpha.white[100],
      default: colors.layout.general.bodyBg,
    },
    action: {
      active: colors.alpha.black[100],
      hover: colors.primary.lighter,
      hoverOpacity: 0.1,
      selected: colors.alpha.black[10],
      selectedOpacity: 0.1,
      disabled: colors.alpha.black[50],
      disabledBackground: colors.alpha.black[5],
      disabledOpacity: 0.38,
      focus: colors.alpha.black[10],
      focusOpacity: 0.05,
      activatedOpacity: 0.12,
    },
    tonalOffset: 0.5,
  },
  breakpoints: {
    values: {
      xs: 0,
      sm: 600,
      md: 960,
      lg: 1280,
      xl: 1840,
    },
  },
  typography: {
    fontFamily: '"Inter", sans-serif, "Apple Color Emoji", "Segoe UI Emoji"',
    h1: {
      fontWeight: 700,
      fontSize: 35,
      color: colors.primary.main,
    },
    h2: {
      fontWeight: 700,
      fontSize: 30,
      color: colors.primary.main,
    },
    h3: {
      fontWeight: 700,
      fontSize: 25,
      lineHeight: 1.4,
      color: colors.primary.main,
    },
    h4: {
      fontWeight: 700,
      fontSize: 16,
      color: colors.primary.main,
    },
    h5: {
      fontWeight: 700,
      fontSize: 14,
      color: colors.primary.main,
    },
    h6: {
      fontSize: 15,
      color: colors.primary.main,
    },
    body1: {
      fontSize: 15,
      fontWeight: 400,
    },
    body2: {
      fontSize: 14,
    },
    button: {
      fontWeight: 400,
      textTransform: 'none',
    },
    caption: {
      fontSize: 13,
      textTransform: 'uppercase',
      color: colors.alpha.black[50],
    },
    subtitle1: {
      fontSize: 14,
      color: colors.alpha.black[70],
    },
    subtitle2: {
      fontWeight: 400,
      fontSize: 15,
      color: colors.alpha.black[70],
    },
    overline: {
      fontSize: 13,
      fontWeight: 700,
      textTransform: 'uppercase',
    },
  },
});

export default theme;
