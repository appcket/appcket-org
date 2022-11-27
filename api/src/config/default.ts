const realm = process.env.KEYCLOAK_REALM;
const authServerUrl = `${process.env.ACCOUNTS_URL}`;
const tokenEndpointUrl = `${authServerUrl}/realms/${realm}/protocol/openid-connect/token`;
const userAccountEndpointUrl = `${authServerUrl}/realms/${realm}/account`;
const userRoleMappingsEndpointUrl = `${authServerUrl}/admin/realms/${realm}/users/__USER_ID__/role-mappings`;
const adminEndpointUrl = `${authServerUrl}/admin/realms/${realm}`;

export const config = {
  appUrl: process.env.APP_URL,
  orm: {
    dbName: process.env.DB_NAME,
    schema: process.env.DB_SCHEMA,
    type: 'postgresql',
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    host: process.env.DB_ADDR,
    port: process.env.DB_PORT,
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
    userAccountEndpointUrl,
    userRoleMappingsEndpointUrl,
    adminEndpointUrl,
  },
};
