import ormConfig from 'src/config/mikro-orm.config';

const realm = process.env.KEYCLOAK_REALM;
const authServerUrl = `${process.env.ACCOUNTS_URL}`;
const tokenEndpointUrl = `${authServerUrl}/realms/${realm}/protocol/openid-connect/token`;
const userAccountEndpointUrl = `${authServerUrl}/realms/${realm}/account`;
const userRoleMappingsEndpointUrl = `${authServerUrl}/admin/realms/${realm}/users/__USER_ID__/role-mappings`;
const adminEndpointUrl = `${authServerUrl}/admin/realms/${realm}`;

const config = {
  appUrl: process.env.APP_URL,
  appId: process.env.APP_ID,
  orm: ormConfig,
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
  redpanda: {
    brokers: process.env.REDPANDA_BROKERS
      ? process.env.REDPANDA_BROKERS.split(',')
          .map((s) => s.trim())
          .filter(Boolean)
      : ['localhost:9092'],
  },
  clickhouse: {
    url: `${process.env.CLICKHOUSE_SSL_MODE === 'true' ? 'https' : 'http'}://${process.env.CLICKHOUSE_ADDR}:${process.env.CLICKHOUSE_PORT}`,
    username: process.env.CLICKHOUSE_USER,
    password: process.env.CLICKHOUSE_PASSWORD,
    database: process.env.CLICKHOUSE_DATABASE,
  },
};

export default () => config;
