import { Link } from 'react-router-dom';
import PropTypes from 'prop-types';
import { RiHome4Line, RiInformationLine, RiTeamLine } from 'react-icons/ri';
import { CgBriefcase } from 'react-icons/cg';
import { Scrollbars } from 'react-custom-scrollbars-2';
import List from '@mui/material/List';
import Typography from '@mui/material/Typography';
import Divider from '@mui/material/Divider';
import Drawer from '@mui/material/Drawer';
import Avatar from '@mui/material/Avatar';
import Box from '@mui/material/Box';
import IconButton from '@mui/material/IconButton';
import MenuIcon from '@mui/icons-material/Menu';

import { grey } from '@mui/material/colors';
import theme from 'src/common/theme';
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
    icon: RiTeamLine,
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
};

const SideBar = ({ open, handleSideBarClose, drawerWidth }: Props) => {
  const { data } = useUserInfo();

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
      variant="persistent"
      anchor="left"
      open={open}
    >
      <SideBarHeader className="w-fit">
        <Link to="/">
          <Logo width={170} className="mt-2 ml-2" />
        </Link>
        <IconButton sx={{ color: grey[300] }} onClick={handleSideBarClose} className="ml-8">
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
              width: 96,
              height: 96,
            }}
            component={Link}
            src="/images/avatars/avatar_1.png"
            to="/profile"
          />
          <Typography className="text-slate-200 mt-4" variant="h4">
            {data?.firstName} {data?.lastName}
          </Typography>
          <Typography className="text-slate-200" variant="body2">
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
  );
};

SideBar.propTypes = {
  handleSideBarClose: PropTypes.func,
  open: PropTypes.bool,
  drawerWidth: PropTypes.number,
};

SideBar.defaultProps = {
  handleSideBarClose: () => {
    // do nothing
  },
  open: false,
  drawerWidth: 280,
};

export default SideBar;
