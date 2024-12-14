// https://phrase.com/blog/posts/localizing-react-apps-with-i18next/ was helpful in understanding a practical implementation of react-i18next

export default {
  lowercase,
  uppercase,
  datetime,
  number,
  currency,
} as const;

export function lowercase(value: string) {
  return value.toLowerCase();
}

export function uppercase(value: string) {
  return value.toUpperCase();
}

/**
 * Returns the default qualified locale code
 * (language-REGION) for the given locale.
 *
 * @param lng The locale code.
 * @returns The qualified locale code, including region.
 */
function qualifiedLngFor(lng: string): string {
  switch (lng) {
    case 'en':
      return 'en-US';
    case 'es':
      return 'es-ES';
    default:
      return lng;
  }
}

/**
 * Formats a datetime.
 *
 * @param value - The datetime as a string to format, ex: 2024-12-15T02:20:36.132Z.
 * @param lng - The language to format the number in.
 * @param options - passed to Intl.DateTimeFormat.
 * @returns The formatted datetime.
 */
export function datetime(
  value: string,
  lng: string | undefined,
  options?: Intl.DateTimeFormatOptions,
): string {
  return new Intl.DateTimeFormat(qualifiedLngFor(lng!), options).format(new Date(value));
}

/**
 * Formats a number.
 *
 * @param value - The number to format.
 * @param lng - The language to format the number in.
 * @param options - passed to Intl.NumberFormat.
 * @returns The formatted number.
 */
export function number(
  value: number,
  lng: string | undefined,
  options?: Intl.NumberFormatOptions,
): string {
  return new Intl.NumberFormat(qualifiedLngFor(lng!), options).format(value);
}

/**
 * Formats a number as currency.
 *
 * @param value - The number to format.
 * @param lng - The language to format the number in.
 * @param options - passed to Intl.NumberFormat.
 * @returns The formatted currency string.
 */
export function currency(
  value: number,
  lng: string | undefined,
  options?: Intl.NumberFormatOptions,
): string {
  return number(value, lng, {
    style: 'currency',
    ...options,
  });
}
