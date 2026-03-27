import { createTheme, MantineColorsTuple } from '@mantine/core';

const appBlue: MantineColorsTuple = [
  '#eef3ff',
  '#dce4f5',
  '#b9c7e2',
  '#94a8d0',
  '#748dc1',
  '#5f7cb9',
  '#5474b6',
  '#4463a1',
  '#395891',
  '#2d4b81',
];

const appRed: MantineColorsTuple = [
  '#fff0f0',
  '#ffe1e1',
  '#ffc1c1',
  '#fe9f9f',
  '#fe8282',
  '#fe7070',
  '#fe6666',
  '#e35656',
  '#cb4a4a',
  '#b13d3d',
];

const appYellow: MantineColorsTuple = [
  '#fffce1',
  '#fff8cc',
  '#fff09b',
  '#ffe864',
  '#ffe13a',
  '#ffdc20',
  '#ffd910',
  '#e3c000',
  '#c9aa00',
  '#ae9300',
];

const appSky: MantineColorsTuple = [
  '#e5f4ff',
  '#d1e7ff',
  '#a3cdff',
  '#71b1ff',
  '#4a99fe',
  '#328afe',
  '#2383ff',
  '#1370e4',
  '#0063cc',
  '#0056b4',
];

export const theme = createTheme({
  primaryColor: 'appBlue',
  colors: {
    appBlue,
    appRed,
    appYellow,
    appSky,
  },
  primaryShade: 9,
});
