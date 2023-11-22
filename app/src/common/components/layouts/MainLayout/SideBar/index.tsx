import { Link } from 'react-router-dom';
import PropTypes from 'prop-types';
import { RiHome4Line, RiInformationLine } from 'react-icons/ri';
import { TbShirtSport } from 'react-icons/tb';
import { CgBriefcase } from 'react-icons/cg';
import { Scrollbars } from 'rc-scrollbars';
import List from '@mui/material/List';
import Typography from '@mui/material/Typography';
import Drawer from '@mui/material/Drawer';
import Avatar from '@mui/material/Avatar';
import Box from '@mui/material/Box';
import IconButton from '@mui/material/IconButton';
import { Menu as MenuIcon } from '@mui/icons-material';
import { find } from 'lodash';

import { grey } from '@mui/material/colors';
import { getTheme } from 'src/common/theme';
import { useUserInfo } from 'src/common/api/user';
import { ReactComponent as Logo } from 'src/assets/logo.svg';
import SideBarHeader from 'src/common/components/layouts/MainLayout/SideBar/Header';
import NavItem from 'src/common/components/layouts/MainLayout/SideBar/NavItem';

const items = [
  {
    href: '/',
    icon: RiHome4Line,
    title: 'Home',
  },
  {
    href: '/teams',
    icon: TbShirtSport,
    title: 'Teams',
  },
  {
    href: '/projects',
    icon: CgBriefcase,
    title: 'Projects',
  },
  {
    href: '/about',
    icon: RiInformationLine,
    title: 'About',
  },
];

type Props = {
  open: boolean;
  handleSideBarClose: () => void;
  drawerWidth: number;
  lessThanSmall: boolean;
};

const SideBar = ({ open, handleSideBarClose, drawerWidth, lessThanSmall }: Props) => {
  const theme = getTheme();
  const { data } = useUserInfo();
  const drawerVariant = lessThanSmall ? 'temporary' : 'persistent';
  const handleClose = () => handleSideBarClose();

  return (
    <Drawer
      sx={{
        width: drawerWidth,
        flexShrink: 0,
        '& .MuiDrawer-paper': {
          width: drawerWidth,
          boxSizing: 'border-box',
        },
      }}
      variant={drawerVariant}
      onClose={handleClose}
      anchor="left"
      open={open}
    >
      <SideBarHeader className="w-fit py-3">
        <Link to="/">
          <Logo width={140} className="mt-1 ml-2" />
        </Link>
        <IconButton
          sx={{ color: grey[300], marginLeft: { xs: '24px' } }}
          onClick={handleSideBarClose}
          className="ml-8"
        >
          {theme.direction === 'ltr' ? <MenuIcon /> : <MenuIcon />}
        </IconButton>
      </SideBarHeader>
      <Scrollbars
        autoHide
        autoHideTimeout={1000}
        autoHideDuration={200}
        renderThumbVertical={() => {
          return (
            <Box
              sx={{
                width: 5,
                background: `${theme.palette.grey[500]}`,
                borderRadius: 4,
                transition: `${theme.transitions.create(['background'])}`,
                '&:hover': {
                  background: `${theme.palette.grey[300]}`,
                },
              }}
            />
          );
        }}
      >
        <Box alignItems="center" display="flex" flexDirection="column" p={2}>
          <Avatar
            sx={{
              cursor: 'pointer',
              width: 72,
              height: 72,
            }}
            component={Link}
            src="/images/avatars/avatar_1.png"
            to="/profile"
          />
          <Typography className="text-slate-200 mt-4" variant="h4">
            {data?.firstName} {data?.lastName}
          </Typography>
          <Typography className="text-slate-200" variant="body2">
            {find(data?.attributes, { name: 'jobTitle' })?.value}
          </Typography>
        </Box>
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
  );
};

SideBar.propTypes = {
  handleSideBarClose: PropTypes.func,
  open: PropTypes.bool,
  drawerWidth: PropTypes.number,
  lessThanSmall: PropTypes.bool,
};

SideBar.defaultProps = {
  handleSideBarClose: () => {
    // do nothing
  },
  open: false,
  drawerWidth: 260,
  lessThanSmall: false,
};

export default SideBar;
