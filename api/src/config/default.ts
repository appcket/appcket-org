const realm = process.env.KEYCLOAK_REALM;
const authServerUrl = `${process.env.ACCOUNTS_URL}/auth`;
const tokenEndpointUrl = `${authServerUrl}/realms/${realm}/protocol/openid-connect/token`;

export const config = {
  appUrl: process.env.APP_URL,
  keycloak: {
    realm,
    'bearer-only': true,
    'auth-server-url': authServerUrl,
    'ssl-required': 'all',
    resource: 'appcket_api',
    'verify-token-audience': true,
    'confidential-port': 0,
    'use-resource-role-mappings': true,
    'realm-public-key': process.env.KEYCLOAK_CLIENT_PUBLIC_KEY,
    secret: process.env.KEYCLOAK_CLIENT_SECRET,
    // custom keycloak config needed for authorization endpoint
    tokenEndpointUrl,
  },
};
