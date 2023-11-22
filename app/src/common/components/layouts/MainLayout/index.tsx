import { useEffect, useState } from 'react';
import { Outlet } from 'react-router-dom';
import { Scrollbars } from 'rc-scrollbars';
import { styled, useTheme } from '@mui/material/styles';
import useMediaQuery from '@mui/material/useMediaQuery';
import Box from '@mui/material/Box';

import SideBar from 'src/common/components/layouts/MainLayout/SideBar';
import BottomBar from 'src/common/components/layouts/MainLayout/BottomBar';
import TopBar from 'src/common/components/layouts/MainLayout/TopBar';

const drawerWidth = 240;
let marginLeftSize = drawerWidth;

const Main = styled('main', { shouldForwardProp: (prop) => prop !== 'open' })<{
  open?: boolean;
}>(({ theme, open }) => ({
  flexGrow: 1,
  transition: theme.transitions.create('margin', {
    easing: theme.transitions.easing.sharp,
    duration: theme.transitions.duration.leavingScreen,
  }),
  marginLeft: `-${marginLeftSize}px`,
  ...(open && {
    transition: theme.transitions.create('margin', {
      easing: theme.transitions.easing.easeOut,
      duration: theme.transitions.duration.enteringScreen,
    }),
    marginLeft: 0,
  }),
}));

const MainLayout = () => {
  const theme = useTheme();
  const lessThanSmall = useMediaQuery(theme.breakpoints.down('sm'));

  const [open, setOpen] = useState(true);

  const handleSideBarOpen = () => {
    setOpen(true);
  };

  const handleSideBarClose = () => {
    setOpen(false);
  };

  useEffect(() => {
    // if on mobile, close the drawer initially; if switch to mobile, close the drawer
    if (lessThanSmall) {
      handleSideBarClose();
      marginLeftSize = 0;
    } else {
      setOpen(true);
      marginLeftSize = drawerWidth;
    }
  }, [lessThanSmall]);

  return (
    <Box sx={{ display: 'flex', pb: '44px', height: 'inherit' }}>
      <TopBar open={open} drawerWidth={drawerWidth} handleSideBarOpen={handleSideBarOpen} />
      <SideBar
        open={open}
        handleSideBarClose={handleSideBarClose}
        drawerWidth={drawerWidth}
        lessThanSmall={lessThanSmall}
      />
      <Main open={open}>
        <Scrollbars autoHide autoHideTimeout={1000} autoHideDuration={200}>
          <Outlet />
        </Scrollbars>
      </Main>
      <BottomBar
        open={open}
        theme={theme}
        drawerWidth={drawerWidth}
        marginLeftSize={marginLeftSize}
        lessThanSmall={lessThanSmall}
      />
    </Box>
  );
};

export default MainLayout;
