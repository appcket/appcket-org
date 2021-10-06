import React, { useState } from 'react';
import { Link as RouterLink } from 'react-router-dom';
import clsx from 'clsx';
import PropTypes from 'prop-types';
import { AppBar, Badge, Box, Hidden, IconButton, Toolbar } from '@mui/material';
import makeStyles from '@mui/styles/makeStyles';
import MenuIcon from '@mui/icons-material/Menu';
import NotificationsIcon from '@mui/icons-material/NotificationsOutlined';
import InputIcon from '@mui/icons-material/Input';
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
    <AppBar
      className={clsx(classes.root, className)}
      color="primary"
      elevation={0}
      {...rest}
    >
      <Toolbar>
        <RouterLink to="/">
          <Logo />
        </RouterLink>
        <Box flexGrow={1} />
        <IconButton color="inherit" size="large">
          <Badge
            badgeContent={notifications.length}
            color="primary"
            variant="dot"
          >
            <NotificationsIcon />
          </Badge>
        </IconButton>
        <IconButton color="inherit" size="large">
          <InputIcon />
        </IconButton>
        <Hidden lgUp>
          <IconButton color="inherit" onClick={onSideBarOpen} size="large">
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
