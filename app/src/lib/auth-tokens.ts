import { getRequest } from '@tanstack/react-start/server';
import { getIronSession } from 'iron-session';

import { sessionOptions, SessionData } from 'src/lib/session';

/**
 * Server-only utility to retrieve the raw Keycloak Access Token.
 * This can be used in Loaders and Server Functions to authorize
 * requests to the backend GraphQL API.
 */
export async function getKeycloakToken(): Promise<string | null> {
  const request = getRequest();
  if (!request) return null;

  try {
    const session = await getIronSession<SessionData>(request, new Response(), sessionOptions);
    return session.accessToken || null;
  } catch (error) {
    console.error('Failed to retrieve Keycloak token:', error);
    return null;
  }
}
