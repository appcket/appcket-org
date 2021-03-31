const realm = process.env.KEYCLOAK_REALM;
const authServerUrl = `${process.env.ACCOUNTS_URL}/auth`;
const tokenEndpointUrl = `${authServerUrl}/realms/${realm}/protocol/openid-connect/token`;

export const config = {
  appUrl: process.env.APP_URL,
  database: {
    host: process.env.DB_ADDR,
    username: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    port: 5432,
    database: 'appcket',
    schema: 'appcket',
  },
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
