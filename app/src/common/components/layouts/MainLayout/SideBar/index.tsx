import React from 'react';
import { Link } from 'react-router-dom';
import PropTypes from 'prop-types';
import { Avatar, Box, Divider, Drawer, IconButton, List, Typography } from '@mui/material';
import MenuOpenIcon from '@mui/icons-material/MenuOpen';
import { RiHome4Fill, RiInformationFill, RiTeamFill } from 'react-icons/ri';
import { Scrollbars } from 'react-custom-scrollbars-2';

import { useUserInfo } from 'src/common/api/user';
import NavItem from './NavItem';
import Logo from 'src/common/components/Logo';
import SideBarHeader from 'src/common/components/layouts/MainLayout/SideBar/Header';

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

type Props = {
  open: boolean;
  handleSideBarClose: () => void;
  drawerWidth: number;
};

const SideBar = ({ open, handleSideBarClose, drawerWidth }: Props) => {
  const { data } = useUserInfo();

  return (
    <>
      <Drawer
        sx={{
          width: open ? drawerWidth : 0,
          flexShrink: 0,
          '& .MuiDrawer-paper': {
            width: open ? drawerWidth : 0,
            boxSizing: 'border-box',
          },
        }}
        variant="persistent"
        anchor="left"
        open={open}
      >
        <SideBarHeader>
          <Link to="/">
            <Logo />
          </Link>
          <IconButton
            onClick={handleSideBarClose}
            size="small"
            sx={{ ml: 2 }}
            aria-label="Close Sidebar"
            title="Close Sidebar"
          >
            <MenuOpenIcon />
          </IconButton>
        </SideBarHeader>
        <Scrollbars autoHide autoHideTimeout={1000} autoHideDuration={200}>
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
            <Typography className="" color="textPrimary" variant="h5">
              {data?.firstName}
            </Typography>
            <Typography color="textPrimary" variant="body2">
              {data?.jobTitle}
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
    </>
  );
};

SideBar.propTypes = {
  handleSideBarClose: PropTypes.func,
  open: PropTypes.bool,
  drawerWidth: PropTypes.number,
};

SideBar.defaultProps = {
  handleSideBarClose: () => {},
  open: false,
  drawerWidth: 240,
};

export default SideBar;
