import { styled } from '@mui/material/styles';

// @ts-ignore
const SideBarHeader = styled('div')(({ theme }) => ({
  display: 'flex',
  alignItems: 'center',
  padding: theme.spacing(0, 2),
  // necessary for content to be below app bar
  ...theme.mixins.toolbar,
  justifyContent: 'flex-begin',
}));

export default SideBarHeader;
