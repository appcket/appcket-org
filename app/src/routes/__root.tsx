/// <reference types="vite/client" />
import type { ReactNode } from 'react';
import {
  Outlet,
  createRootRoute,
  HeadContent,
  Scripts,
  redirect,
  useLocation,
  useRouter,
  useSearch,
  useNavigate,
} from '@tanstack/react-router';
import { getSession } from 'src/lib/auth-server';
import { getLocale } from 'src/lib/i18n';
import * as runtime from 'src/paraglide/runtime';
import { MantineProvider, ColorSchemeScript } from '@mantine/core';
import { Notifications, notifications } from '@mantine/notifications';
import { QueryClientProvider, QueryClient } from '@tanstack/react-query';
import { ReactQueryDevtools } from '@tanstack/react-query-devtools';
import { theme } from 'src/theme';
import { MainLayout } from 'src/components/Layout/MainLayout';
import { SocketProvider } from 'src/components/SocketProvider';
import { GlobalEventHandler } from 'src/components/GlobalEventHandler';
import { useEffect } from 'react';
import * as m from 'src/paraglide/messages';

import '@mantine/core/styles.css';
import '@mantine/notifications/styles.css';

function GlobalFlashHandler() {
  const search = useSearch({ from: '__root__' }) as any;
  const navigate = useNavigate();

  useEffect(() => {
    if (search.flash === 'unauthorized') {
      notifications.show({
        title: m.messages_error_error(),
        message: m.messages_error_unauthorized(),
        color: 'red',
      });

      // Clear the flash parameter from the URL after showing the toast
      const newSearch = { ...search };
      delete newSearch.flash;
      navigate({ search: newSearch, replace: true });
    }
  }, [search.flash]);

  return null;
}

export const Route = createRootRoute({
  beforeLoad: async ({ location }) => {
    // Skip check for login page and api routes to avoid loops and blocking auth handling
    if (location.pathname === '/login' || location.pathname.startsWith('/api')) {
      return;
    }

    try {
      const [session, locale] = await Promise.all([getSession(), getLocale()]);

      if (!session) {
        throw redirect({
          to: '/login' as any,
        });
      }
      return { session, locale };
    } catch (error) {
      // If getSession fails or throws (e.g. redirect), pass it through
      if (
        error instanceof Response ||
        (typeof error === 'object' && error !== null && 'to' in error)
      ) {
        throw error;
      }
      // On error, redirect to login to be safe
      throw redirect({
        to: '/login' as any,
      });
    }
  },
  head: () => ({
    meta: [
      {
        charSet: 'utf-8',
      },
      {
        name: 'viewport',
        content: 'width=device-width, initial-scale=1',
      },
      {
        title: 'Appcket',
      },
    ],
    links: [
      {
        rel: 'icon',
        href: '/favicon.svg',
        type: 'image/svg+xml',
      },
    ],
  }),
  component: RootComponent,
  notFoundComponent: () => (
    <div className="p-4">
      <h1>404 - Not Found</h1>
      <p>The page you are looking for does not exist.</p>
    </div>
  ),
});

function RootComponent() {
  const router = useRouter();
  const queryClient = (router.options.context as any).queryClient;
  const context = Route.useRouteContext();
  const location = useLocation();
  const session = context?.session;
  const locale = context?.locale || runtime.baseLocale;

  // Set the paraglide language tag for the current request/render
  runtime.setLocale(locale);

  const handleLogout = () => {
    window.location.href = '/api/logout';
  };

  const content = <Outlet />;

  return (
    <RootDocument locale={locale}>
      <QueryClientProvider client={queryClient}>
        <MantineProvider theme={theme} defaultColorScheme="auto">
          <Notifications position="top-right" zIndex={1000} />
          <GlobalFlashHandler />
          <SocketProvider accessToken={session?.accessToken}>
            <GlobalEventHandler />
            {session && !location.pathname.startsWith('/login') ? (
              <MainLayout user={session.user} handleLogout={handleLogout}>
                {content}
              </MainLayout>
            ) : (
              content
            )}
          </SocketProvider>
        </MantineProvider>
        <ReactQueryDevtools initialIsOpen={false} />
      </QueryClientProvider>
    </RootDocument>
  );
}

function RootDocument({ children, locale }: Readonly<{ children: ReactNode; locale: string }>) {
  return (
    <html
      lang={locale}
      suppressHydrationWarning
      style={{ scrollbarGutter: 'stable', overflowY: 'scroll' }}
    >
      <head>
        <HeadContent />
        <ColorSchemeScript />
      </head>
      <body>
        {children}
        <Scripts />
      </body>
    </html>
  );
}
