import { createServerFn } from '@tanstack/react-start';
import { getRequest, setResponseHeader } from '@tanstack/react-start/server';
import * as runtime from 'src/paraglide/runtime';

export const COOKIE_NAME = 'appcket_locale';

export type AvailableLanguageTag = (typeof runtime.locales)[number];

export const getLocale = createServerFn({ method: 'GET' }).handler(async () => {
  const request = getRequest();
  const cookies = request?.headers.get('cookie');
  const localeCookie = cookies
    ?.split(';')
    .find((c) => c.trim().startsWith(`${COOKIE_NAME}=`))
    ?.split('=')[1]
    ?.trim();

  const locale = (localeCookie as AvailableLanguageTag) || runtime.baseLocale;

  if (runtime.locales.includes(locale)) {
    return locale;
  }
  
  return runtime.baseLocale;
});

export const setLocale = createServerFn({ method: 'POST' })
  .inputValidator((locale: string) => {
    if (runtime.locales.includes(locale as any)) {
      return locale as AvailableLanguageTag;
    }
    throw new Error('Invalid locale');
  })
  .handler(async ({ data: locale }) => {
    setResponseHeader(
      'Set-Cookie',
      `${COOKIE_NAME}=${locale}; Path=/; Max-Age=31536000; SameSite=Lax`,
    );
    return { success: true };
  });

/**
 * Formats a date string, number, or Date object according to the current locale.
 */
export function formatDate(date: string | number | Date) {
  return new Intl.DateTimeFormat(runtime.getLocale(), {
    year: 'numeric',
    month: 'short',
    day: 'numeric',
  }).format(new Date(date));
}

/**
 * Formats a date and time string, number, or Date object according to the current locale.
 */
export function formatDateTime(date: string | number | Date) {
  return new Intl.DateTimeFormat(runtime.getLocale(), {
    year: 'numeric',
    month: 'numeric',
    day: 'numeric',
    hour: 'numeric',
    minute: 'numeric',
    second: 'numeric',
  }).format(new Date(date));
}
