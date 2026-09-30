import { createServerFn } from '@tanstack/react-start';
import { getRequest } from '@tanstack/react-start/server';
import { getIronSession } from 'iron-session';
import { ClientError, gql } from 'graphql-request';
import { sessionOptions, SessionData } from '@/lib/session';
import { callApi } from '@/hooks/useApi';

export const getSession = createServerFn({ method: 'GET' }).handler(async () => {
  const request = getRequest();
  if (!request) return null;

  // 1. Get the lightweight session from the cookie
  const session = await getIronSession<SessionData>(request, new Response(), sessionOptions);

  // The cookie can outlive the access token. Re-enter OIDC login before
  // sending an expired token to the API (Keycloak rejects it with HTTP 403).
  const hasExpired = () =>
    typeof session.expiresAt !== 'number' ||
    !Number.isFinite(session.expiresAt) ||
    session.expiresAt <= Math.floor(Date.now() / 1000) + 30;

  if (!session.accessToken || hasExpired()) {
    return null;
  }

  try {
    // 2. Fetch the full user profile using our centralized callApi helper
    // This automatically handles the JWT header and Correlation ID
    const result = await callApi({
      data: {
        query: gql`
          query GetSessionUserInfo {
            userInfo {
              id
              username
              email
              firstName
              lastName
              role
              attributes {
                jobTitle
              }
              permissions {
                rsname
                scopes
              }
            }
          }
        `,
      },
    });

    const apiUser = (result as any)?.userInfo;

    if (!apiUser) {
      throw new Error('User not found in API response');
    }

    // 3. Return the enriched session object
    return {
      user: apiUser,
      accessToken: session.accessToken,
      expiresAt: session.expiresAt,
    };
  } catch (error) {
    // Also cover expiry while the profile request was in flight.
    if (hasExpired()) return null;

    // The identity provider may reject a session before expiresAt (e.g. SSO
    // idle timeout or revocation). Do not turn permissions/outage errors into
    // login redirects, which would recreate the previous redirect loop.
    if (
      error instanceof ClientError &&
      (error.response.status === 401 ||
        error.response.errors?.some((error) => error.extensions?.code === 'UNAUTHENTICATED'))
    ) {
      return null;
    }

    console.error('[getSession] Failed to enrich session:', error);
    // A profile lookup failure is not evidence that the login session is missing.
    throw new Error('Unable to load your profile. Please try again shortly.');
  }
});
