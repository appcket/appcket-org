import { AppShell } from '@mantine/core';
import { useDisclosure } from '@mantine/hooks';
import { ReactNode } from 'react';
import { User } from 'src/lib/session';
import { MainSidebar } from 'src/components/Layout/MainSidebar';
import { MainHeader } from 'src/components/Layout/MainHeader';
import { MainFooter } from 'src/components/Layout/MainFooter';

interface MainLayoutProps {
  children: ReactNode;
  user: User;
  handleLogout?: () => void;
}

export function MainLayout({ children, user, handleLogout }: MainLayoutProps) {
  const [mobileOpened, { toggle: toggleMobile }] = useDisclosure();
  const [desktopOpened, { toggle: toggleDesktop }] = useDisclosure(true);

  return (
    <AppShell
      layout="alt"
      header={{ height: 60 }}
      navbar={{
        width: 300,
        breakpoint: 'sm',
        collapsed: { mobile: !mobileOpened, desktop: !desktopOpened },
      }}
      footer={{ height: 60 }}
      padding="md"
    >
      <MainHeader
        user={user}
        mobileOpened={mobileOpened}
        desktopOpened={desktopOpened}
        toggleMobile={toggleMobile}
        toggleDesktop={toggleDesktop}
        handleLogout={handleLogout}
      />

      <MainSidebar handleLogout={handleLogout} />

      <AppShell.Main>{children}</AppShell.Main>

      <MainFooter />
    </AppShell>
  );
}
