import { useEffect, useState } from 'react';
import { Link, Outlet } from 'react-router-dom';
import Box from '@mui/material/Box';
import { Scrollbars } from 'react-custom-scrollbars-2';
import { styled } from '@mui/material/styles';
import useMediaQuery from '@mui/material/useMediaQuery';

import Toolbar from '@mui/material/Toolbar';
import List from '@mui/material/List';
import Typography from '@mui/material/Typography';
import Divider from '@mui/material/Divider';
import IconButton from '@mui/material/IconButton';
import MenuIcon from '@mui/icons-material/Menu';

import Drawer from '@mui/material/Drawer';
import Avatar from '@mui/material/Avatar';
import MuiAppBar, { AppBarProps as MuiAppBarProps } from '@mui/material/AppBar';
import { grey } from '@mui/material/colors';
import { RiHome4Line, RiInformationLine, RiTeamLine } from 'react-icons/ri';
import { CgBriefcase } from 'react-icons/cg';

import { ReactComponent as Logo } from 'src/assets/logo.svg';

// import SideBar from 'src/common/components/layouts/MainLayout/SideBar';
// import SideBarHeader from 'src/common/components/layouts/MainLayout/SideBar/Header';
// import TopBar from 'src/common/components/layouts/MainLayout/TopBar';

import theme from 'src/common/theme';
import NavItem from 'src/common/components/layouts/MainLayout/SideBar/NavItem';

const drawerWidth = 280;

const items = [
  {
    href: '/',
    icon: RiHome4Line,
    title: 'Home',
  },
  {
    href: '/teams',
    icon: RiTeamLine,
    title: 'Teams',
  },
  {
    href: '/projects',
    icon: CgBriefcase,
    title: 'Projects',
  },
  {
    href: '/about',
    icon: RiInformationLine,
    title: 'About',
  },
];

const Main = styled('main', { shouldForwardProp: (prop) => prop !== 'open' })<{
  open?: boolean;
}>(({ theme, open }) => ({
  flexGrow: 1,
  padding: theme.spacing(3),
  transition: theme.transitions.create('margin', {
    easing: theme.transitions.easing.sharp,
    duration: theme.transitions.duration.leavingScreen,
  }),
  ...(open && {
    transition: theme.transitions.create('margin', {
      easing: theme.transitions.easing.easeOut,
      duration: theme.transitions.duration.enteringScreen,
    }),
    marginLeft: 280,
  }),
}));

interface AppBarProps extends MuiAppBarProps {
  open?: boolean;
}

const AppBar = styled(MuiAppBar, {
  shouldForwardProp: (prop) => prop !== 'open',
})<AppBarProps>(({ theme, open }) => ({
  transition: theme.transitions.create(['margin', 'width'], {
    easing: theme.transitions.easing.sharp,
    duration: theme.transitions.duration.leavingScreen,
  }),
  ...(open && {
    width: `calc(100% - ${drawerWidth}px)`,
    marginLeft: `${drawerWidth}px`,
    transition: theme.transitions.create(['margin', 'width'], {
      easing: theme.transitions.easing.easeOut,
      duration: theme.transitions.duration.enteringScreen,
    }),
  }),
}));

const DrawerHeader = styled('div')(({ theme }) => ({
  display: 'flex',
  alignItems: 'center',
  padding: theme.spacing(0, 1),
  // necessary for content to be below app bar
  ...theme.mixins.toolbar,
  justifyContent: 'flex-end',
}));

const MainLayout = () => {
  const lessThanSmall = useMediaQuery(theme.breakpoints.down('sm'));

  const [open, setOpen] = useState(true);

  const handleDrawerOpen = () => {
    setOpen(true);
  };

  const handleDrawerClose = () => {
    setOpen(false);
  };

  useEffect(() => {
    // if on mobile, close the drawer initially; if switch to mobile, close the drawer
    if (lessThanSmall) {
      handleDrawerClose();
    } else {
      setOpen(true);
    }
  }, [lessThanSmall]);

  return (
    <>
      <AppBar position="fixed" open={open}>
        <Toolbar>
          <IconButton
            color="inherit"
            aria-label="open drawer"
            onClick={handleDrawerOpen}
            edge="start"
            sx={{ mr: 2, ...(open && { display: 'none' }) }}
          >
            <MenuIcon />
          </IconButton>
        </Toolbar>
      </AppBar>
      <Drawer
        sx={{
          width: drawerWidth,
          flexShrink: 0,
          '& .MuiDrawer-paper': {
            width: drawerWidth,
            boxSizing: 'border-box',
          },
        }}
        variant="persistent"
        anchor="left"
        open={open}
      >
        <DrawerHeader className="w-fit">
          <Link to="/">
            <Logo width={170} className="mt-2 ml-2" />
          </Link>
          <IconButton sx={{ color: grey[300] }} onClick={handleDrawerClose} className="ml-8">
            {theme.direction === 'ltr' ? <MenuIcon /> : <MenuIcon />}
          </IconButton>
        </DrawerHeader>
        <Scrollbars
          autoHide
          autoHideTimeout={1000}
          autoHideDuration={200}
          renderThumbVertical={() => {
            return (
              <Box
                sx={{
                  width: 5,
                  background: `${theme.palette.grey[500]}`,
                  borderRadius: 4,
                  transition: `${theme.transitions.create(['background'])}`,

                  '&:hover': {
                    background: `${theme.palette.grey[300]}`,
                  },
                }}
              />
            );
          }}
        >
          <Box alignItems="center" display="flex" flexDirection="column" p={2}>
            <Avatar
              sx={{
                cursor: 'pointer',
                width: 96,
                height: 96,
              }}
              component={Link}
              src="/images/avatars/avatar_1.png"
              to="/profile"
            />
            <Typography className="text-slate-200 mt-4" variant="h4">
              George Costanza
            </Typography>
            <Typography className="text-slate-200" variant="body2">
              Assistant to the Traveling Secretary
            </Typography>
          </Box>
          <Divider />
          <List>
            {items.map((item) => (
              <NavItem
                className=""
                href={item.href}
                key={item.title}
                title={item.title}
                icon={item.icon}
              />
            ))}
          </List>
        </Scrollbars>
      </Drawer>
      <Scrollbars autoHide autoHideTimeout={1000} autoHideDuration={200}>
        <Main open={open}>
          <DrawerHeader />
          <Outlet />
        </Main>
      </Scrollbars>
    </>
  );
};

export default MainLayout;
