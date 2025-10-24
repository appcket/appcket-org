import { createTheme, PaletteMode, PaletteOptions } from '@mui/material';

import { colors, themeColors } from 'src/common/theme/colors';

declare module '@mui/material/styles' {
  interface Components {
    [key: string]: any;
  }
}

export const getTheme = (mode: PaletteMode = 'light') => {
  const lightPalette = {
    mode: 'light',
    primary: {
      main: themeColors.primary,
    },
    secondary: {
      main: themeColors.darkBlue,
    },
    background: {
      default: '#f0f1f7',
      pageHeader: colors.alpha.black[5],
    },
  } as PaletteOptions;

  const darkPalette = {
    mode: 'dark',
    primary: {
      main: themeColors.primary,
    },
    secondary: {
      main: themeColors.darkBlue,
    },
    background: {
      default: '#1f1f1f',
      paper: '#1f1f1f',
      pageHeader: colors.alpha.black[30],
    },
  } as PaletteOptions;

  const palette = mode === 'light' ? lightPalette : darkPalette;

  const theme = createTheme({
    palette,
  });

  return createTheme({
    palette,
    components: {
      MuiAppBar: {
        styleOverrides: {
          root: {
            background: themeColors.appBar[mode],
            color: themeColors.appBarText[mode],
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
      MuiDataGrid: {
        styleOverrides: {
          root: {
            '& .MuiDataGrid-cell': {
              padding: '0 30px',
            },
            '& .MuiDataGrid-columnHeader': {
              fontSize: 16,
              padding: '0 30px',
            },
            '& .MuiDataGrid-columnHeader--sorted': {
              fontSize: 16,
            },
            '& .MuiDataGrid-cell a': {
              color: themeColors.linkText[mode],
            },
            '& .MuiDataGrid-cell a:visited': {
              color: themeColors.linkTextVisited[mode],
            },
          },
        },
      },
      MuiDrawer: {
        styleOverrides: {
          paper: {
            background: theme.palette.secondary.main,
            color: colors.alpha.white[70],
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
      MuiListItem: {
        styleOverrides: {
          root: {
            paddingTop: '2px',
            paddingBottom: '2px',
          },
        },
      },
      MuiLink: {
        styleOverrides: {
          root: {
            textDecoration: 'none',
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
            boxShadow: colors.shadows[mode].card,
          },
          elevation2: {
            boxShadow: colors.shadows[mode].cardSm,
          },
          elevation24: {
            boxShadow: colors.shadows[mode].cardLg,
          },
          outlined: {
            boxShadow: colors.shadows[mode].card,
          },
        },
      },
    },
    spacing: 9,
    shape: {
      borderRadius: 6,
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
        fontSize: 30,
      },
      h2: {
        fontWeight: 700,
        fontSize: 26,
      },
      h3: {
        fontWeight: 700,
        fontSize: 22,
        lineHeight: 1.4,
      },
      h4: {
        fontWeight: 700,
        fontSize: 16,
      },
      h5: {
        fontWeight: 700,
        fontSize: 14,
      },
      h6: {
        fontSize: 15,
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
      },
      subtitle1: {
        fontSize: 14,
      },
      subtitle2: {
        fontWeight: 400,
        fontSize: 15,
      },
      overline: {
        fontSize: 13,
        fontWeight: 700,
        textTransform: 'uppercase',
      },
    },
  });
};
