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
import { FaUserCog, FaUserShield } from 'react-icons/fa';
import { useTranslation } from 'react-i18next';

import { useUserInfo } from 'src/common/api/user';
import { displayUser } from 'src/common/utils/general';
import ThemeColorModeToggler from 'src/common/components/buttons/ThemeColorModeToggler';
import LocaleSwitcher from 'src/common/components/LocaleSwitcher';
import QueryStatuses from 'src/common/enums/QueryStatuses';
import { Link } from '@mui/material';

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
  const { t } = useTranslation();
  const auth = useAuth();
  const userInfo = useUserInfo();
  const [anchorElUser, setAnchorElUser] = React.useState<null | HTMLElement>(null);

  const handleOpenUserMenu = (event: React.MouseEvent<HTMLElement>) => {
    setAnchorElUser(event.currentTarget);
  };

  const handleCloseUserMenu = () => {
    setAnchorElUser(null);
  };

  const Role = () => {
    if (userInfo.status === QueryStatuses.Success) {
      return t(`common.roles.${userInfo.data?.role.toLowerCase()}`);
    }
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
        <Box sx={{ mr: 1, display: 'inline-flex' }}>
          <LocaleSwitcher />
          <ThemeColorModeToggler />
        </Box>
        <Box sx={{ flexGrow: 0 }}>
          <Tooltip title={t('common.userInformation')}>
            <IconButton onClick={handleOpenUserMenu} sx={{ p: 0, mr: 2 }}>
              <Avatar alt={displayUser(userInfo.data)} src="/images/avatars/avatar_1.png" />
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
              <FaUserShield title="Role" style={{ marginRight: '5px' }} />
              <Typography textAlign="center">
                <Role />
              </Typography>
            </MenuItem>
            <MenuItem key="userProfile">
              <Link
                href={`${import.meta.env.VITE_ACCOUNTS_URL}/realms/${import.meta.env.VITE_ACCOUNTS_REALM_NAME}/account`}
                color="inherit"
                target="_blank"
                rel="noopener noreferrer"
              >
                <Typography textAlign="center">
                  <FaUserCog style={{ marginRight: '5px' }} />
                  {t('common.userProfile')}
                </Typography>
              </Link>
            </MenuItem>
            <MenuItem key="logout" onClick={() => auth.signoutRedirect()}>
              <LogoutOutlined style={{ marginRight: '5px' }} />
              <Typography textAlign="center">{t('common.logout')}</Typography>
            </MenuItem>
          </Menu>
        </Box>
      </Toolbar>
    </AppBar>
  );
};

export default TopBar;
