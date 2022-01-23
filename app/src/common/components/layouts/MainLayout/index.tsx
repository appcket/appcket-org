import React, { useState } from 'react';
import { styled } from '@mui/material/styles';
import { Outlet } from 'react-router-dom';
import Box from '@mui/material/Box';
import { Scrollbars } from 'react-custom-scrollbars-2';

import SideBar from 'src/common/components/layouts/MainLayout/SideBar';
import SideBarHeader from 'src/common/components/layouts/MainLayout/SideBar/Header';
import TopBar from 'src/common/components/layouts/MainLayout/TopBar';

const drawerWidth = 240;

const Main = styled('main', { shouldForwardProp: (prop) => prop !== 'open' })<{
  open?: boolean;
}>(({ theme, open }) => ({
  flexGrow: 1,
  padding: theme.spacing(3),
  marginRight: 20,
  transition: theme.transitions.create('margin', {
    easing: theme.transitions.easing.sharp,
    duration: theme.transitions.duration.leavingScreen,
  }),
  marginLeft: 20,
  ...(open && {
    transition: theme.transitions.create('margin', {
      easing: theme.transitions.easing.easeOut,
      duration: theme.transitions.duration.enteringScreen,
    }),
    marginLeft: 20,
  }),
}));

const MainLayout = () => {
  // open sidebar by default
  const [open, setOpen] = useState(true);

  const handleSideBarOpen = () => {
    setOpen(true);
  };

  const handleSideBarClose = () => {
    setOpen(false);
  };

  return (
    <Box sx={{ display: 'flex', height: '100%' }}>
      <TopBar open={open} handleSideBarOpen={handleSideBarOpen} />
      <SideBar open={open} handleSideBarClose={handleSideBarClose} drawerWidth={drawerWidth} />
      <Scrollbars autoHide autoHideTimeout={1000} autoHideDuration={200}>
        <Main open={open}>
          <SideBarHeader />
          <Outlet />
        </Main>
      </Scrollbars>
    </Box>
  );
};

export default MainLayout;
