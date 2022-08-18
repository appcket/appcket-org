import { useEffect, useState } from 'react';
import { Outlet } from 'react-router-dom';
import { Scrollbars } from 'react-custom-scrollbars-2';
import { styled } from '@mui/material/styles';
import useMediaQuery from '@mui/material/useMediaQuery';

import SideBar from 'src/common/components/layouts/MainLayout/SideBar';
import SideBarHeader from 'src/common/components/layouts/MainLayout/SideBar/Header';
import TopBar from 'src/common/components/layouts/MainLayout/TopBar';

import theme from 'src/common/theme';

const drawerWidth = 280;

const Main = styled('main', { shouldForwardProp: (prop) => prop !== 'open' })<{
  open?: boolean;
}>(({ theme, open }) => ({
  flexGrow: 1,
  transition: theme.transitions.create('margin', {
    easing: theme.transitions.easing.sharp,
    duration: theme.transitions.duration.leavingScreen,
  }),
  ...(open && {
    transition: theme.transitions.create('margin', {
      easing: theme.transitions.easing.easeOut,
      duration: theme.transitions.duration.enteringScreen,
    }),
    marginLeft: drawerWidth,
  }),
}));

const MainLayout = () => {
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
    } else {
      setOpen(true);
    }
  }, [lessThanSmall]);

  return (
    <>
      <TopBar open={open} handleSideBarOpen={handleSideBarOpen} />
      <SideBar open={open} handleSideBarClose={handleSideBarClose} drawerWidth={drawerWidth} />
      <Scrollbars autoHide autoHideTimeout={1000} autoHideDuration={200}>
        <Main open={open}>
          <SideBarHeader />
          <Outlet />
        </Main>
      </Scrollbars>
    </>
  );
};

export default MainLayout;
