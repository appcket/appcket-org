import {
  AppShell,
  Burger,
  Group,
  Text,
  Menu,
  UnstyledButton,
  rem,
  Box,
  Tooltip,
} from '@mantine/core';
import {
  HiArrowRightOnRectangle,
  HiOutlineShieldCheck,
  HiOutlineIdentification,
} from 'react-icons/hi2';
import { Link } from '@tanstack/react-router';
import * as m from 'src/paraglide/messages';
import { ThemeToggle } from 'src/components/ThemeToggle';
import { LanguagePicker } from 'src/components/LanguagePicker';
import { UserAvatar } from 'src/components/UserAvatar';
import { User } from 'src/lib/session';

interface MainHeaderProps {
  user: User;
  mobileOpened: boolean;
  desktopOpened: boolean;
  toggleMobile: () => void;
  toggleDesktop: () => void;
  handleLogout?: () => void;
}

export function MainHeader({
  user,
  mobileOpened,
  desktopOpened,
  toggleMobile,
  toggleDesktop,
  handleLogout,
}: MainHeaderProps) {
  const userDisplayName = user.firstName || user.username || user.email;
  const fullName =
    user.firstName && user.lastName ? `${user.firstName} ${user.lastName}` : userDisplayName;

  return (
    <AppShell.Header>
      <Group h="100%" px="md" justify="space-between">
        <Group>
          <Burger opened={mobileOpened} onClick={toggleMobile} hiddenFrom="sm" size="sm" />
          <Burger opened={desktopOpened} onClick={toggleDesktop} visibleFrom="sm" size="sm" />
          <Link to="/" style={{ display: 'flex', alignItems: 'center' }}>
            <img src="/logo.svg" alt="Appcket Logo" style={{ height: '30px' }} />
          </Link>
        </Group>
        <Group>
          <LanguagePicker />
          <ThemeToggle />

          <Menu
            shadow="md"
            width={220}
            position="bottom-end"
            transitionProps={{ transition: 'pop-top-right' }}
          >
            <Menu.Target>
              <Tooltip label={userDisplayName} position="left" withArrow>
                <UnstyledButton style={{ display: 'flex', alignItems: 'center' }}>
                  <Box visibleFrom="xs">
                    <UserAvatar
                      size="md"
                      firstName={user.firstName}
                      lastName={user.lastName}
                      username={user.username}
                    />
                  </Box>
                  <Box hiddenFrom="xs">
                    <UserAvatar
                      size="sm"
                      firstName={user.firstName}
                      lastName={user.lastName}
                      username={user.username}
                    />
                  </Box>
                </UnstyledButton>
              </Tooltip>
            </Menu.Target>
            <Menu.Dropdown>
              <Menu.Label>{m.common_userprofile()}</Menu.Label>
              <Menu.Item
                leftSection={
                  <HiOutlineIdentification style={{ width: rem(16), height: rem(16) }} />
                }
              >
                <Box>
                  <Text size="sm" fw={500}>
                    {fullName}
                  </Text>
                  {user.jobTitle && (
                    <Text size="xs" c="dimmed">
                      {user.jobTitle}
                    </Text>
                  )}
                </Box>
              </Menu.Item>

              <Menu.Divider />

              <Menu.Label>{m.common_userinformation()}</Menu.Label>
              <Menu.Item
                color="appBlue"
                leftSection={<HiOutlineShieldCheck style={{ width: rem(16), height: rem(16) }} />}
              >
                Role: {user.role || 'User'}
              </Menu.Item>

              <Menu.Divider />

              <Menu.Item
                color="red"
                leftSection={
                  <HiArrowRightOnRectangle style={{ width: rem(16), height: rem(16) }} />
                }
                onClick={handleLogout}
              >
                {m.common_logout()}
              </Menu.Item>
            </Menu.Dropdown>{' '}
          </Menu>
        </Group>
      </Group>
    </AppShell.Header>
  );
}
