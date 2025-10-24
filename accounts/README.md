# Accounts

Appcket's accounts microservice for authentication, authorization and user management powered by [Keycloak](https://www.keycloak.org/)

## Initial Admin Setup

See the Accounts documentation for [setting up a new realm](https://appcket.org/getting-started/installation-initial-setup#accounts-keycloak-admin-setup) in Keycloak.

## Theme customization

The default Keycloak theme was lightly customized with [Keycloakify](https://www.keycloakify.dev/).

If you want to further change the theme or modify the logo/background, you will need to clone the [Keycloakify Starter repo](https://github.com/keycloakify/keycloakify-starter) and follow the docs to update and rebuild the theme. Once you have rebuilt the theme (you need Maven installed), copy the `keycloak-theme-for-kc-all-other-versions.jar` file from the `dist_keycloak` folder and paste it into the accounts folder as `keycloak-theme.jar`.

From here, you can re-build your Accounts Dockerfile and re-start the application with `./deployment/environment/local/start.sh`.

Under the appcket Realm settings, choose the `keycloakify-starter` as the "Login Theme".

Seethe [Deploying Your Theme section of the Keycloakify docs](https://docs.keycloakify.dev/deploying-your-theme) for more information.