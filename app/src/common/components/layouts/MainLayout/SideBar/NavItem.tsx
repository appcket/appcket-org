import { ElementType } from 'react';
import { NavLink } from 'react-router-dom';
import PropTypes from 'prop-types';
import ListItem from '@mui/material/ListItem';
import ListItemButton from '@mui/material/ListItemButton';
import ListItemIcon from '@mui/material/ListItemIcon';
import ListItemText from '@mui/material/ListItemText';

type Props = {
  className: string;
  href: string;
  icon: ElementType;
  title: string;
};

const NavItem = ({ href, icon: Icon, title }: Props) => {
  return (
    <ListItem disablePadding className="pl-4 pr-4">
      <ListItemButton className="rounded-md hover:bg-slate-100/[.08]" component={NavLink} to={href}>
        <ListItemIcon>
          <Icon size="20" className="text-slate-400" />
        </ListItemIcon>
        <ListItemText primary={title} />
      </ListItemButton>
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
