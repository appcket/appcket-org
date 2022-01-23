import React, { ElementType } from 'react';
import { NavLink } from 'react-router-dom';
import PropTypes from 'prop-types';
import { Button, ListItem } from '@mui/material';

type Props = {
  className: string;
  href: string;
  icon: ElementType;
  title: string;
};

const NavItem = ({ href, icon: Icon, title, ...rest }: Props) => {
  return (
    <ListItem
      sx={{
        display: 'flex',
        paddingTop: 0,
        paddingBottom: 0,
      }}
      disableGutters
      {...rest}
    >
      <Button
        sx={{
          fontSize: '16px',
          color: 'text.primary',
          fontWeight: 'typography.fontWeightMedium',
          justifyContent: 'flex-start',
          padding: '10px 8px 10px 20px',
          textTransform: 'none',
          width: '100%',
        }}
        component={NavLink}
        to={href}
      >
        {Icon && <Icon size="20" />}
        &nbsp;
        <span>{title}</span>
      </Button>
    </ListItem>
  );
};

NavItem.defaultProps = {
  href: '',
  icon: {},
  title: '',
};

NavItem.propTypes = {
  href: PropTypes.string,
  icon: PropTypes.elementType,
  title: PropTypes.string,
};

export default NavItem;
