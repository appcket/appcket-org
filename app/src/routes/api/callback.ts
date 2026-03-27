import { createFileRoute } from '@tanstack/react-router';
import * as oidc from 'openid-client';
import { getOIDCConfig, redirect_uri } from 'src/lib/oidc';
import { getIronSession } from 'iron-session';
import { sessionOptions, SessionData } from 'src/lib/session';

export const Route = createFileRoute('/api/callback')({
  server: {
    handlers: {
      GET: async ({ request }) => {
        const config = await getOIDCConfig();
        const url = new URL(request.url);

        // 1. Create a dummy response to hold the session cookie
        const response = new Response(null, {
          status: 302,
          headers: {
            Location: '/',
          },
        });

        // 2. Get session to retrieve verifier and state
        const session = await getIronSession<any>(request, response, sessionOptions);
        const { code_verifier, state } = session;

        if (!code_verifier || !state) {
          return new Response('Invalid session state', { status: 400 });
        }

        try {
          // 3. Exchange code for tokens
          const tokens = await oidc.authorizationCodeGrant(config, url, {
            pkceCodeVerifier: code_verifier,
            expectedState: state,
          });

          // 4. Get ID Token claims (Basic Info)
          const claims = tokens.claims();
          if (!claims) {
            throw new Error('No claims found in ID token');
          }

          // 5. Save ONLY tokens and userId to session to keep cookie small
          const sessionData: SessionData = {
            userId: claims.sub,
            accessToken: tokens.access_token,
            refreshToken: tokens.refresh_token,
            expiresAt: Math.floor(Date.now() / 1000) + (tokens.expires_in || 3600),
          };

          // Clear temp PKCE values and save session
          session.code_verifier = undefined;
          session.state = undefined;
          Object.assign(session, sessionData);
          await session.save();

          return response;
        } catch (error) {
          console.error('OIDC Callback Error:', error);
          return new Response('Authentication failed', { status: 500 });
        }
      },
    },
  },
});
