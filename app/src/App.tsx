import * as React from 'react';
import { Link } from 'react-router-dom';
import { grey } from '@mui/material/colors';
import { ReactComponent as Logo } from 'src/assets/logo.svg';
import Loading from 'src/common/components/Loading';
import { Scrollbars } from 'react-custom-scrollbars-2';
import { SnackbarProvider } from 'notistack';
import { CssBaseline } from '@mui/material';
import Box from '@mui/material/Box';
import { styled, ThemeProvider } from '@mui/material/styles';
import { useAuth } from 'react-oidc-context';
import Drawer from '@mui/material/Drawer';
import Avatar from '@mui/material/Avatar';
import MuiAppBar, { AppBarProps as MuiAppBarProps } from '@mui/material/AppBar';
import Toolbar from '@mui/material/Toolbar';
import List from '@mui/material/List';
import Typography from '@mui/material/Typography';
import Divider from '@mui/material/Divider';
import IconButton from '@mui/material/IconButton';
import MenuIcon from '@mui/icons-material/Menu';
import ListItem from '@mui/material/ListItem';
import ListItemButton from '@mui/material/ListItemButton';
import ListItemIcon from '@mui/material/ListItemIcon';
import ListItemText from '@mui/material/ListItemText';
import InboxIcon from '@mui/icons-material/MoveToInbox';
import MailIcon from '@mui/icons-material/Mail';
import useMediaQuery from '@mui/material/useMediaQuery';

import theme from 'src/common/theme';

const drawerWidth = 280;

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

export default function App() {
  const auth = useAuth();
  const lessThanSmall = useMediaQuery(theme.breakpoints.down('sm'));

  const [open, setOpen] = React.useState(true);

  const handleDrawerOpen = () => {
    setOpen(true);
  };

  const handleDrawerClose = () => {
    setOpen(false);
  };

  React.useEffect(() => {
    // if on mobile, close the drawer initially; if switch to mobile, close the drawer
    if (lessThanSmall) {
      handleDrawerClose();
    } else {
      setOpen(true);
    }
  }, [lessThanSmall]);

  if (auth.isLoading) {
    return <Loading />;
  } else {
    if (!auth.isAuthenticated) {
      auth.signinRedirect();
    }
  }

  if (auth.error) {
    return <div>Authentication error... {auth.error.message}</div>;
  }

  if (auth.isAuthenticated) {
    return (
      <ThemeProvider theme={theme}>
        <CssBaseline />
        <SnackbarProvider
          maxSnack={3}
          autoHideDuration={7000}
          anchorOrigin={{
            vertical: 'top',
            horizontal: 'right',
          }}
          iconVariant={{
            success: '✅ ',
            error: '✖️ ',
            warning: '⚠️ ',
            info: 'ℹ️ ',
          }}
        >
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
                    width: 64,
                    height: 64,
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
                {['Inbox', 'Starred', 'Send email', 'Drafts'].map((text, index) => (
                  <ListItem key={text} disablePadding>
                    <ListItemButton>
                      <ListItemIcon>{index % 2 === 0 ? <InboxIcon /> : <MailIcon />}</ListItemIcon>
                      <ListItemText primary={text} />
                    </ListItemButton>
                  </ListItem>
                ))}
              </List>
              <Divider />
              <List>
                {['All mail', 'Trash', 'Spam'].map((text, index) => (
                  <ListItem key={text} disablePadding>
                    <ListItemButton>
                      <ListItemIcon>{index % 2 === 0 ? <InboxIcon /> : <MailIcon />}</ListItemIcon>
                      <ListItemText primary={text} />
                    </ListItemButton>
                  </ListItem>
                ))}
              </List>
            </Scrollbars>
          </Drawer>
          <Scrollbars autoHide autoHideTimeout={1000} autoHideDuration={200}>
            <Main open={open}>
              <DrawerHeader />
              <Typography paragraph>
                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
                incididunt ut labore et dolore magna aliqua. Rhoncus dolor purus non enim praesent
                elementum facilisis leo vel. Risus at ultrices mi tempus imperdiet. Semper risus in
                hendrerit gravida rutrum quisque non tellus. Convallis convallis tellus id interdum
                velit laoreet id donec ultrices. Odio morbi quis commodo odio aenean sed adipiscing.
                Amet nisl suscipit adipiscing bibendum est ultricies integer quis. Cursus euismod
                quis viverra nibh cras. Metus vulputate eu scelerisque felis imperdiet proin
                fermentum leo. Mauris commodo quis imperdiet massa tincidunt. Cras tincidunt
                lobortis feugiat vivamus at augue. At augue eget arcu dictum varius duis at
                consectetur lorem. Velit sed ullamcorper morbi tincidunt. Lorem donec massa sapien
                faucibus et molestie ac.
              </Typography>
              <Typography paragraph>
                Consequat mauris nunc congue nisi vitae suscipit. Fringilla est ullamcorper eget
                nulla facilisi etiam dignissim diam. Pulvinar elementum integer enim neque volutpat
                ac tincidunt. Ornare suspendisse sed nisi lacus sed viverra tellus. Purus sit amet
                volutpat consequat mauris. Elementum eu facilisis sed odio morbi. Euismod lacinia at
                quis risus sed vulputate odio. Morbi tincidunt ornare massa eget egestas purus
                viverra accumsan in. In hendrerit gravida rutrum quisque non tellus orci ac.
                Pellentesque nec nam aliquam sem et tortor. Habitant morbi tristique senectus et.
                Adipiscing elit duis tristique sollicitudin nibh sit. Ornare aenean euismod
                elementum nisi quis eleifend. Commodo viverra maecenas accumsan lacus vel facilisis.
                Nulla posuere sollicitudin aliquam ultrices sagittis orci a.
              </Typography>
            </Main>
          </Scrollbars>
        </SnackbarProvider>
      </ThemeProvider>
    );
  }

  return <button onClick={() => void auth.signinRedirect()}>Log in</button>;
}
