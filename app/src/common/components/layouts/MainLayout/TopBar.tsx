import React from 'react';
import PropTypes from 'prop-types';
import { styled } from '@mui/material/styles';
import Box from '@mui/material/Box';
import Toolbar from '@mui/material/Toolbar';
import IconButton from '@mui/material/IconButton';
import InputIcon from '@mui/icons-material/Input';
import MenuIcon from '@mui/icons-material/Menu';
import { useKeycloak } from '@react-keycloak/web';
import MuiAppBar, { AppBarProps as MuiAppBarProps } from '@mui/material/AppBar';

interface AppBarProps extends MuiAppBarProps {
  open?: boolean;
}

const drawerWidth = 240;

const AppBar = styled(MuiAppBar, {
  shouldForwardProp: (prop) => prop !== 'open',
})<AppBarProps>(({ theme, open }) => ({
  transition: theme.transitions.create(['margin', 'width'], {
    easing: theme.transitions.easing.sharp,
    duration: theme.transitions.duration.leavingScreen,
  }),
  ...(open && {
    width: `calc(100% - ${drawerWidth}px)`,
    transition: theme.transitions.create(['margin', 'width'], {
      easing: theme.transitions.easing.easeOut,
      duration: theme.transitions.duration.enteringScreen,
    }),
  }),
}));

type Props = {
  open: boolean;
  handleSideBarOpen: () => void;
};

const TopBar = ({ open, handleSideBarOpen }: Props) => {
  const { keycloak } = useKeycloak();

  return (
    <AppBar position="fixed" open={open}>
      <Toolbar>
        <IconButton
          color="inherit"
          aria-label="Open Sidebar"
          title="Open Sidebar"
          onClick={handleSideBarOpen}
          edge="start"
          sx={{ mr: 2, ...(open && { display: 'none' }) }}
        >
          <MenuIcon />
        </IconButton>
        <Box flexGrow={1} />
        <IconButton
          size="large"
          onClick={() => keycloak.logout()}
          title="Logout"
          aria-label="Logout"
        >
          <InputIcon />
        </IconButton>
      </Toolbar>
    </AppBar>
  );
};

TopBar.propTypes = {
  handleSideBarOpen: PropTypes.func,
  open: PropTypes.bool,
};

TopBar.defaultProps = {
  handleSideBarOpen: () => {},
  open: false,
};

export default TopBar;
