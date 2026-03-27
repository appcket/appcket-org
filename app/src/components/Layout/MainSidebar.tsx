import { AppShell, NavLink, Stack } from '@mantine/core';
import { RiHome4Line, RiInformationLine } from 'react-icons/ri';
import { TbShirtSport } from 'react-icons/tb';
import { CgBriefcase } from 'react-icons/cg';
import { Link, useLocation } from '@tanstack/react-router';
import * as m from 'src/paraglide/messages';
import classes from './MainSidebar.module.css';

interface MainSidebarProps {
  handleLogout?: () => void;
}

export function MainSidebar({ handleLogout }: MainSidebarProps) {
  const location = useLocation();
  const currentPath = location.pathname === '' ? '/' : location.pathname;

  const links = [
    { icon: RiHome4Line, label: m.common_navigation_home(), to: '/' },
    { icon: TbShirtSport, label: m.common_navigation_teams(), to: '/teams' as any },
    { icon: CgBriefcase, label: m.common_navigation_projects(), to: '/projects' as any },
    { icon: RiInformationLine, label: m.common_navigation_about(), to: '/about' as any },
  ];

  return (
    <AppShell.Navbar p="md">
      <AppShell.Section grow>
        <Stack gap="xs">
          {links.map((item) => (
            <NavLink
              key={item.label}
              component={Link}
              to={item.to}
              label={item.label}
              leftSection={<item.icon size="1.2rem" />}
              active={currentPath === item.to}
              variant="filled"
              color="appBlue"
              className={classes.navLink}
            />
          ))}
        </Stack>
      </AppShell.Section>
    </AppShell.Navbar>
  );
}
