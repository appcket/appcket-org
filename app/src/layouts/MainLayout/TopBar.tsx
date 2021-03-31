import React, { useState } from 'react';
import { Link as RouterLink } from 'react-router-dom';
import clsx from 'clsx';
import PropTypes from 'prop-types';
import { AppBar, Badge, Box, Hidden, IconButton, Toolbar, makeStyles } from '@material-ui/core';
import MenuIcon from '@material-ui/icons/Menu';
import NotificationsIcon from '@material-ui/icons/NotificationsOutlined';
import InputIcon from '@material-ui/icons/Input';
import Logo from 'src/components/Logo';

const useStyles = makeStyles(() => ({
  root: {},
  avatar: {
    width: 60,
    height: 60,
  },
}));

type Props = {
  className: string;
  onSideBarOpen: () => void;
};

const TopBar = ({ className, onSideBarOpen, ...rest }: Props) => {
  const classes = useStyles();
  const [notifications] = useState([]);

  return (
    <AppBar className={clsx(classes.root, className)} color="primary" elevation={0} {...rest}>
      <Toolbar>
        <RouterLink to="/">
          <Logo />
        </RouterLink>
        <Box flexGrow={1} />
        <IconButton color="inherit">
          <Badge badgeContent={notifications.length} color="primary" variant="dot">
            <NotificationsIcon />
          </Badge>
        </IconButton>
        <IconButton color="inherit">
          <InputIcon />
        </IconButton>
        <Hidden lgUp>
          <IconButton color="inherit" onClick={onSideBarOpen}>
            <MenuIcon />
          </IconButton>
        </Hidden>
      </Toolbar>
    </AppBar>
  );
};

TopBar.defaultProps = {
  className: '',
  onSideBarOpen: () => {},
};

TopBar.propTypes = {
  className: PropTypes.string,
  onSideBarOpen: PropTypes.func,
};

export default TopBar;
