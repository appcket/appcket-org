import { createServerFn } from '@tanstack/react-start';
import { getRequest } from '@tanstack/react-start/server';
import { getIronSession } from 'iron-session';
import { gql } from 'graphql-request';
import { sessionOptions, SessionData } from 'src/lib/session';
import { callApi } from 'src/hooks/useApi';

export const getSession = createServerFn({ method: 'GET' }).handler(async () => {
  const request = getRequest();
  if (!request) return null;

  // 1. Get the lightweight session from the cookie
  const session = await getIronSession<SessionData>(request, new Response(), sessionOptions);

  if (!session.accessToken) {
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
    console.error('[getSession] Failed to enrich session:', error);
    // If the API call fails (e.g., token expired), we return null to trigger a re-login
    return null;
  }
});
