import * as oidc from 'openid-client';

const issuer = process.env.KEYCLOAK_ISSUER || 'https://accounts.appcket.test/realms/appcket';
const client_id = process.env.KEYCLOAK_CLIENT_ID || 'appcket_app';
const client_secret = process.env.KEYCLOAK_CLIENT_SECRET || 'test-client-secret';
const redirect_uri = process.env.KEYCLOAK_REDIRECT_URI || 'https://app.appcket.test/api/callback';

export async function getOIDCConfig() {
  const config = await oidc.discovery(
    new URL(issuer),
    client_id,
    client_secret,
  );
  return config;
}

export { redirect_uri };
