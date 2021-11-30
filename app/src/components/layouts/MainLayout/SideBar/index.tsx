import React, { useEffect } from 'react';
import { Link, useLocation } from 'react-router-dom';
import PropTypes from 'prop-types';
import { Avatar, Box, colors, Divider, Drawer, Hidden, List, Typography } from '@mui/material';
import makeStyles from '@mui/styles/makeStyles';
import { RiHome4Fill, RiInformationFill, RiTeamFill } from 'react-icons/ri';

import { useUserInfo } from 'src/common/api/user';
import NavItem from './NavItem';

const items = [
  {
    href: '/',
    icon: RiHome4Fill,
    title: 'Home',
  },
  {
    href: '/teams',
    icon: RiTeamFill,
    title: 'Teams',
  },
  {
    href: '/about',
    icon: RiInformationFill,
    title: 'About',
  },
];

const useStyles = makeStyles(() => ({
  mobileDrawer: {
    width: 256,
  },
  desktopDrawer: {
    width: 256,
    top: 64,
    height: 'calc(100% - 64px)',
    backgroundColor: colors.grey[50],
  },
  avatar: {
    cursor: 'pointer',
    width: 64,
    height: 64,
  },
}));

type Props = {
  openSideBar: boolean;
  onSideBarClose: () => void;
};

const SideBar = ({ onSideBarClose, openSideBar }: Props) => {
  const classes = useStyles();
  const location = useLocation();
  const { data } = useUserInfo();

  useEffect(() => {
    if (openSideBar && onSideBarClose) {
      onSideBarClose();
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [location.pathname]);

  const content = (
    <Box height="100%" display="flex" flexDirection="column">
      <Box alignItems="center" display="flex" flexDirection="column" p={2}>
        <Avatar
          className={classes.avatar}
          component={Link}
          src="/images/avatars/avatar_1.png"
          to="/profile"
        />
        <Typography className="" color="textPrimary" variant="h5">
          {data?.firstName}
        </Typography>
        <Typography color="textSecondary" variant="body2">
          {data?.jobTitle}
        </Typography>
      </Box>
      <Divider />
      <Box p={2}>
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
      </Box>
    </Box>
  );

  return (
    <>
      <Hidden lgUp>
        <Drawer
          anchor="left"
          classes={{ paper: classes.mobileDrawer }}
          onClose={onSideBarClose}
          open={openSideBar}
          variant="temporary"
        >
          {content}
        </Drawer>
      </Hidden>
      <Hidden lgDown>
        <Drawer anchor="left" classes={{ paper: classes.desktopDrawer }} open variant="persistent">
          {content}
        </Drawer>
      </Hidden>
    </>
  );
};

SideBar.propTypes = {
  onSideBarClose: PropTypes.func,
  openSideBar: PropTypes.bool,
};

SideBar.defaultProps = {
  onSideBarClose: () => {},
  openSideBar: false,
};

export default SideBar;
