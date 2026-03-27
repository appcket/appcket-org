import { createFileRoute } from '@tanstack/react-router';
import { getOIDCConfig } from 'src/lib/oidc';
import { getIronSession } from 'iron-session';
import { sessionOptions } from 'src/lib/session';

export const Route = createFileRoute('/api/logout')({
  server: {
    handlers: {
      GET: async ({ request }) => {
        const config = await getOIDCConfig();

        const response = new Response(null, {
          status: 302,
        });

        const session = await getIronSession<any>(request, response, sessionOptions);

        // Destroy local session
        session.destroy();
        await session.save();

        // Keycloak Logout URL
        const logoutUrl = new URL(config.serverMetadata().end_session_endpoint!);
        logoutUrl.searchParams.set('post_logout_redirect_uri', new URL('/', request.url).href);
        // Add client_id as hint since we dropped id_token to save space
        logoutUrl.searchParams.set('client_id', 'appcket_app');

        response.headers.set('Location', logoutUrl.href);
        return response;
      },
    },
  },
});
