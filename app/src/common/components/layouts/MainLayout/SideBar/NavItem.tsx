import { alpha } from '@mui/material';
import { ElementType } from 'react';
import { NavLink } from 'react-router-dom';
import PropTypes from 'prop-types';
import ListItem from '@mui/material/ListItem';
import ListItemButton from '@mui/material/ListItemButton';
import ListItemIcon from '@mui/material/ListItemIcon';
import ListItemText from '@mui/material/ListItemText';
import { styled } from '@mui/material/styles';
import Box from '@mui/material/Box';

type Props = {
  className: string;
  href: string;
  icon: ElementType;
  title: string;
};

const NavItemWrapper = styled(Box)(
  ({ theme }) => `
  .MuiListItemButton-root {
    padding: ${theme.spacing(1.2, 3)};

    .MuiListItemIcon-root {
      color: ${alpha(theme.palette.common.white, 0.4)};
      transition: ${theme.transitions.create(['color'])};
      min-width: 40px;
    }

    &.active,
    &:hover {
      background-color: ${alpha(theme.palette.common.white, 0.06)};
      color: ${theme.palette.common.white};

      .MuiListItemIcon-root {
        color: ${theme.palette.common.white};
      }
    }
  }
`,
);

const NavItem = ({ href, icon: Icon, title }: Props) => {
  return (
    <NavItemWrapper>
      <ListItem disablePadding className="pl-4 pr-4 mb-1">
        <ListItemButton className="rounded-md" component={NavLink} to={href}>
          <ListItemIcon>
            <Icon size="20" />
          </ListItemIcon>
          <ListItemText primary={title} />
        </ListItemButton>
      </ListItem>
    </NavItemWrapper>
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
