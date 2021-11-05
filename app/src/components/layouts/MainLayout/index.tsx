import React, { useState } from 'react';
import { Outlet } from 'react-router-dom';
import makeStyles from '@mui/styles/makeStyles';

import TopBar from './TopBar';
import SideBar from './SideBar';

const useStyles = makeStyles((theme) => ({
  root: {
    backgroundColor: theme.palette.background.default,
    display: 'flex',
    height: '100%',
    overflow: 'hidden',
    width: '100%',
  },
  topBar: {
    display: 'flex',
  },
  wrapper: {
    display: 'flex',
    flex: '1 1 auto',
    overflow: 'hidden',
    paddingTop: 64,
    [theme.breakpoints.up('lg')]: {
      paddingLeft: 256,
    },
  },
  contentContainer: {
    display: 'flex',
    flex: '1 1 auto',
    overflow: 'hidden',
    paddingTop: '24px',
  },
  content: {
    flex: '1 1 auto',
    height: '100%',
    overflow: 'auto',
  },
}));

const MainLayout = () => {
  const classes = useStyles();
  const [isSideBarOpen, setSideBarOpen] = useState(false);

  return (
    <div className={classes.root}>
      <TopBar className={classes.topBar} onSideBarOpen={() => setSideBarOpen(true)} />
      <SideBar onSideBarClose={() => setSideBarOpen(false)} openSideBar={isSideBarOpen} />
      <div className={classes.wrapper}>
        <div className={classes.contentContainer}>
          <div className={classes.content}>
            <Outlet />
          </div>
        </div>
      </div>
    </div>
  );
};

export default MainLayout;
