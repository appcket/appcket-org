import { createFileRoute } from '@tanstack/react-router';
import * as oidc from 'openid-client';
import { getOIDCConfig, redirect_uri } from 'src/lib/oidc';
import { getIronSession } from 'iron-session';
import { sessionOptions } from 'src/lib/session';

export const Route = createFileRoute('/api/login')({
  server: {
    handlers: {
      GET: async ({ request }) => {
        const config = await getOIDCConfig();

        // 1. Generate PKCE values
        const code_verifier = oidc.randomPKCECodeVerifier();
        const code_challenge = await oidc.calculatePKCECodeChallenge(code_verifier);

        // 2. Generate State for CSRF
        const state = oidc.randomState();

        // 3. Construct Authorization URL
        const parameters: Record<string, string> = {
          redirect_uri,
          scope: 'openid profile email offline_access',
          code_challenge,
          code_challenge_method: 'S256',
          state,
        };

        const redirectTo = oidc.buildAuthorizationUrl(config, parameters);

        // 4. Store verifier and state in session so we can verify them in callback
        const response = new Response(null, {
          status: 302,
          headers: {
            Location: redirectTo.href,
          },
        });

        const session = await getIronSession<any>(request, response, sessionOptions);
        session.code_verifier = code_verifier;
        session.state = state;
        await session.save();

        return response;
      },
    },
  },
});
