import { styled, Theme } from '@mui/material/styles';
import MuiAppBar, { AppBarProps as MuiAppBarProps } from '@mui/material/AppBar';
import Typography from '@mui/material/Typography';
import Toolbar from '@mui/material/Toolbar';

interface AppBarProps extends MuiAppBarProps {
  open?: boolean;
  drawerwidth?: number;
  marginleftsize?: number;
}

const AppBar = styled(MuiAppBar, {
  shouldForwardProp: (prop) => prop !== 'open',
})<AppBarProps>(({ theme, open, drawerwidth, marginleftsize }) => ({
  transition: theme.transitions.create(['margin', 'width'], {
    easing: theme.transitions.easing.sharp,
    duration: theme.transitions.duration.leavingScreen,
  }),
  ...(open && {
    width: `calc(100% - ${drawerwidth}px)`,
    marginLeft: `${marginleftsize}px`,
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
  marginLeftSize: number;
  lessThanSmall: boolean;
};

const BottomBar = ({ theme, open, drawerWidth, marginLeftSize, lessThanSmall }: Props) => {
  if (lessThanSmall) {
    drawerWidth = 0;
  }
  return (
    <AppBar
      position="fixed"
      open={open}
      drawerwidth={drawerWidth}
      marginleftsize={marginLeftSize}
      sx={{ top: 'auto', bottom: 0, height: '44px' }}
    >
      <Toolbar>
        <Typography variant="body2" noWrap component="div" paddingBottom={2}>
          &copy;{' '}
          {new Intl.DateTimeFormat('en-US', {
            year: 'numeric',
          }).format(new Date())}{' '}
          Appcket. All rights reserved.
        </Typography>
      </Toolbar>
    </AppBar>
  );
};

export default BottomBar;
