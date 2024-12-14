import { Link } from 'react-router-dom';
import PropTypes from 'prop-types';
import { RiHome4Line, RiInformationLine } from 'react-icons/ri';
import { TbShirtSport } from 'react-icons/tb';
import { CgBriefcase } from 'react-icons/cg';
import { Scrollbars } from 'rc-scrollbars';
import { Menu as MenuIcon } from '@mui/icons-material';
import Avatar from '@mui/material/Avatar';
import Box from '@mui/material/Box';
import { grey } from '@mui/material/colors';
import Drawer from '@mui/material/Drawer';
import IconButton from '@mui/material/IconButton';
import List from '@mui/material/List';
import Skeleton from '@mui/material/Skeleton';
import Typography from '@mui/material/Typography';
import { find } from 'lodash';
import { useTranslation } from 'react-i18next';

import { getTheme } from 'src/common/theme';
import { useUserInfo } from 'src/common/api/user';
import ReactLogo from 'src/assets/logo.svg?react';
import SideBarHeader from 'src/common/components/layouts/MainLayout/SideBar/Header';
import NavItem from 'src/common/components/layouts/MainLayout/SideBar/NavItem';
import QueryStatuses from 'src/common/enums/queryStatuses.enum';

type Props = {
  open: boolean;
  handleSideBarClose: () => void;
  drawerWidth: number;
  lessThanSmall: boolean;
};

const SideBar = ({ open, handleSideBarClose, drawerWidth, lessThanSmall }: Props) => {
  const { t } = useTranslation();
  const theme = getTheme();
  const userInfo = useUserInfo();
  const drawerVariant = lessThanSmall ? 'temporary' : 'persistent';
  const handleClose = () => handleSideBarClose();

  const items = [
    {
      href: '/',
      icon: RiHome4Line,
      title: t('common.navigation.home'),
    },
    {
      href: '/teams',
      icon: TbShirtSport,
      title: t('common.navigation.teams'),
    },
    {
      href: '/projects',
      icon: CgBriefcase,
      title: t('common.navigation.projects'),
    },
    {
      href: '/about',
      icon: RiInformationLine,
      title: t('common.navigation.about'),
    },
  ];

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
          <ReactLogo width={140} className="mt-1 ml-2" />
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
          {userInfo?.status !== QueryStatuses.Pending ? (
            <Typography className="text-slate-200 mt-4" variant="h4">
              {userInfo?.data?.firstName} {userInfo?.data?.lastName}
            </Typography>
          ) : (
            <Skeleton variant="rectangular" width={160} height={10} sx={{ mt: 3, mb: 1 }} />
          )}
          {userInfo?.status !== QueryStatuses.Pending ? (
            <Typography className="text-slate-200" variant="body2">
              {find(userInfo?.data?.attributes, { name: 'jobTitle' })?.value}
            </Typography>
          ) : (
            <Skeleton variant="rectangular" width={160} height={10} />
          )}
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

export default SideBar;
