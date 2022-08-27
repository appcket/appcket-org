import { styled, Theme } from '@mui/material/styles';
import MuiAppBar, { AppBarProps as MuiAppBarProps } from '@mui/material/AppBar';
import Typography from '@mui/material/Typography';
import Toolbar from '@mui/material/Toolbar';

interface AppBarProps extends MuiAppBarProps {
  open?: boolean;
  drawerwidth?: number;
}

const AppBar = styled(MuiAppBar, {
  shouldForwardProp: (prop) => prop !== 'open',
})<AppBarProps>(({ theme, open, drawerwidth }) => ({
  transition: theme.transitions.create(['margin', 'width'], {
    easing: theme.transitions.easing.sharp,
    duration: theme.transitions.duration.leavingScreen,
  }),
  ...(open && {
    width: `calc(100% - ${drawerwidth}px)`,
    marginLeft: `${drawerwidth}px`,
    transition: theme.transitions.create(['margin', 'width'], {
      easing: theme.transitions.easing.easeOut,
      duration: theme.transitions.duration.enteringScreen,
    }),
  }),
}));

type Props = {
  theme: Theme;
  open: boolean;
  drawerWidth: number;
  handleSideBarOpen?: () => void;
};

const BottomBar = ({ theme, open, drawerWidth }: Props) => {
  return (
    <AppBar
      position="fixed"
      open={open}
      drawerwidth={drawerWidth}
      sx={{ top: 'auto', bottom: 0, height: '64px', background: theme.palette.grey[400] }}
    >
      <Toolbar>
        <Typography variant="h6" noWrap component="div">
          &copy;{' '}
          {new Intl.DateTimeFormat('en-US', {
            year: 'numeric',
          }).format(new Date())}{' '}
          Appcket
        </Typography>
      </Toolbar>
    </AppBar>
  );
};

export default BottomBar;
