import * as React from 'react';
import { styled } from '@mui/material/styles';
import Toolbar from '@mui/material/Toolbar';
import IconButton from '@mui/material/IconButton';
import { Menu as MenuIcon } from '@mui/icons-material';
import { LogoutOutlined } from '@mui/icons-material';
import MuiAppBar, { AppBarProps as MuiAppBarProps } from '@mui/material/AppBar';
import Typography from '@mui/material/Typography';
import { useAuth } from 'react-oidc-context';
import Menu from '@mui/material/Menu';
import MenuItem from '@mui/material/MenuItem';
import Box from '@mui/material/Box';
import Tooltip from '@mui/material/Tooltip';
import Avatar from '@mui/material/Avatar';
import Container from '@mui/material/Container';

import { FaUserShield } from 'react-icons/fa';
import { useUserInfo } from 'src/common/api/user';
import { displayUser } from 'src/common/utils/general';
import ThemeColorModeToggler from 'src/common/components/buttons/ThemeColorModeToggler';

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
  open: boolean;
  drawerWidth: number;
  handleSideBarOpen?: () => void;
};

const TopBar = ({ open, drawerWidth, handleSideBarOpen }: Props) => {
  const auth = useAuth();
  const { data } = useUserInfo();
  const [anchorElUser, setAnchorElUser] = React.useState<null | HTMLElement>(null);

  const handleOpenUserMenu = (event: React.MouseEvent<HTMLElement>) => {
    setAnchorElUser(event.currentTarget);
  };

  const handleCloseUserMenu = () => {
    setAnchorElUser(null);
  };

  return (
    <AppBar
      position="fixed"
      open={open}
      drawerwidth={drawerWidth}
      elevation={0}
      sx={{ backdropFilter: 'blur(8px)' }}
    >
      <Toolbar disableGutters>
        <IconButton
          color="inherit"
          aria-label="open drawer"
          onClick={handleSideBarOpen}
          edge="start"
          sx={{ ml: 1, mr: 2, ...(open && { display: 'none' }) }}
        >
          <MenuIcon />
        </IconButton>
        <Box sx={{ flexGrow: 1, display: { xs: 'flex' } }}>
          <Typography
            variant="h6"
            noWrap
            component="div"
            sx={{ flexGrow: 1, display: { xs: 'flex' } }}
          >
            {/* Top Toolbar */}
          </Typography>
        </Box>
        <Box sx={{ mr: 2 }}>
          <ThemeColorModeToggler />
        </Box>
        <Box sx={{ flexGrow: 0 }}>
          <Tooltip title="User Settings">
            <IconButton onClick={handleOpenUserMenu} sx={{ p: 0, mr: 2 }}>
              <Avatar alt={displayUser(data)} src="/images/avatars/avatar_1.png" />
            </IconButton>
          </Tooltip>
          <Menu
            sx={{ mt: '45px' }}
            id="menu-appbar"
            anchorEl={anchorElUser}
            anchorOrigin={{
              vertical: 'top',
              horizontal: 'right',
            }}
            keepMounted
            transformOrigin={{
              vertical: 'top',
              horizontal: 'right',
            }}
            open={Boolean(anchorElUser)}
            onClose={handleCloseUserMenu}
          >
            <MenuItem key="role">
              <FaUserShield title="Role" />
              <Typography sx={{ ml: '5px' }} textAlign="center">
                {data?.role}
              </Typography>
            </MenuItem>
            <MenuItem key="logout" onClick={() => auth.signoutRedirect()}>
              <LogoutOutlined />
              <Typography sx={{ ml: '5px' }} textAlign="center">
                Logout
              </Typography>
            </MenuItem>
          </Menu>
        </Box>
      </Toolbar>
    </AppBar>
  );
};

export default TopBar;
