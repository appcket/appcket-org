import Keycloak from 'keycloak-js';

const keycloak = Keycloak({
  url: `${process.env.REACT_APP_ACCOUNTS_URL}`,
  realm: 'appcket',
  clientId: 'appcket_app',
});

export default keycloak;
