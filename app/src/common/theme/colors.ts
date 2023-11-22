import { alpha, lighten, darken } from '@mui/material';

export const themeColors = {
  primary: '#196fd5',
  darkBlue: '#03071D',
  success: '#57CA22',
  warning: '#FFA319',
  error: '#FF1943',
  info: '#33C2FF',
  black: '#000000',
  white: '#ffffff',
  primaryAlt: '#E14A1B',
  appBar: {
    dark: 'rgb(37 39 41 / 50%)',
    light: 'rgb(255 255 255 / 30%)',
  },
  appBarText: {
    dark: '#fff',
    light: '#252729',
  },
  linkText: {
    dark: '#5f97db',
    light: '#03071D',
  },
  linkTextVisited: {
    dark: '#496e9b',
    light: '#7e7f81',
  },
};

export const colors = {
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
    light: {
      card: '0px 5px 14px rgba(159, 162, 191, .2), 0px 2px 2px rgba(159, 162, 191, 0.35)',
      cardSm: '0px 2px 3px rgba(159, 162, 191, .18), 0px 1px 1px rgba(159, 162, 191, 0.32)',
      cardLg:
        '0 5rem 14rem 0 rgb(255 255 255 / 30%), 0 0.8rem 2.3rem rgb(0 0 0 / 60%), 0 0.2rem 0.3rem rgb(0 0 0 / 45%)',
    },
    dark: {
      card: '0px 5px 14px rgb(0 1 2 / 20%), 0px 2px 2px rgb(32 24 24 / 35%)',
      cardSm: '0px 2px 3px rgb(2 2 2 / 18%), 0px 1px 1px rgb(5 5 6 / 32%)',
      cardLg:
        '0 5rem 14rem 0 rgb(147 101 101 / 30%), 0 0.8rem 2.3rem rgb(0 0 0 / 60%), 0 0.2rem 0.3rem rgb(0 0 0 / 45%)',
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
    black: {
      5: alpha(themeColors.black, 0.05),
      10: alpha(themeColors.black, 0.1),
      30: alpha(themeColors.black, 0.3),
      50: alpha(themeColors.black, 0.5),
      70: alpha(themeColors.black, 0.7),
      100: themeColors.black,
    },
  },
  secondary: {
    lighter: lighten(themeColors.darkBlue, 0.85),
    light: lighten(themeColors.darkBlue, 0.25),
    main: themeColors.darkBlue,
    dark: darken(themeColors.darkBlue, 0.2),
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
