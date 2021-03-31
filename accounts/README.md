# Accounts

Appcket's accounts microservice for authentication, authorization and user management

## Initial Admin Setup

You can either setup the Realm, Roles, Permissions, etc. manually using the instructions below, or you can import the accounts/realm-export.json file to get started faster. Just go to Add realm and click the import button to select the file.

Create your users as needed.

Login to local Keycloak instance, https://accounts.appcket.localhost

Create a new realm: appcket

In Realm Settings -> General, set the Frontend URL to the kubernetes pod name and port: http://accounts:8080/auth
This is needed so the issuer is not invalid when checking the Bearer token received by the front and app during the check entitlements POST request process on the api side. See https://issues.redhat.com/browse/KEYCLOAK-6073.

Create two clients in keycloak admin area under the realm you just created

appcket_app
    Access Type = public
    Root URL = http://app.appcket.localhost
    Valid Redirect URLS = http://app.appcket.localhost/*, https://appcket.localhost
    Base URL = /
    Web Origins = http://app.appcket.localhost
    Advanced Settings
        - Acess token lifespan, 8 hours
    Authentication Flow Overrides: (???)
        - Browser Flow -> browser
        - Direct Grant Flow -> direct grant
appcket_api
    Access Type = confidential
    Authorization enabled = On

Get the appcket_api Client Secret (Appcket realm, appcket_api client, Credentials tab) and add it as the KEYCLOAK_CLIENT_SECRET env var in the api.yaml Istio resource manifest

Get the appcket_api Client Public Key (go to the appcket Realm settings, click on Keys tab, and then click the Public Keys button in the RS256 row. A dialog will pop up that you can copy from) and add it as the KEYCLOAK_CLIENT_PUBLIC_KEY env var in the api.yaml Istio resource manifest. Make sure this value is set in the keycloak config for the 'realm-public-key' value.

### Verify Audience

For a higher level of security, you will want to verify the audience when validating the token on the appcket_api side. To do this, make sure verify-toke-audience: true in your appcket_api keycloak config setup in app.module.ts.

Then create a new Protocol Mapper in the appcket_app client as described below.

    1. In the appcket_app client, click on Mappers tab and Create button
    1. Name: Audience for appcket_app
    1. Type: Audience
    1. Included Client Audience: appcket_api <--- important, make sure to select the api client and not app here
    1. Add to access token: On

See Keycloak documentation for more information: https://www.keycloak.org/docs/latest/server_admin/#_audience_hardcoded

### Setting up roles and permissions for use in Appcket based system

Precondition: have a client created for each microservice needed for your application, ie: appcket_api. All the authorization/permissions will be applied per service (client in keycloak terminology) since each microservice has different authorization needs.

Have users already created (in the new realm you previously created) that you can add to various roles.

#### Add Roles

    1. Login to keycloak admin console
    1. Select the desired realm
    1. Go to Roles
    1. Add roles as needed (User, Customer, Employee, Manager, Captain, Teammate, Spectator etc)
    1. Set Permissions to Enabled
    1. Add users to role(s) as needed

#### Add Resources

    1. Add resources that map to your application needs:
        * Resource name: Task (for multi-word resources, capitalize camel case, no spaces: "MyResource" instead of "My Resource")

    You can use the admin console (GUI) to add resources, or POST to the Protection API* `resource_set` endpoint /auth/realms/${realm_name}/authz/protection/resource_set
    See https://www.keycloak.org/docs/latest/authorization_services/#creating-a-resource for more information.

    * You will need a valid [Protection API Token - PAT](https://www.keycloak.org/docs/latest/authorization_services/#_service_protection_whatis_obtain_pat) in order to use the Protection API.

    Use Postman or Insomnia client to interact with REST Protection API

#### Add Authorization Scopes

    Protection API:
    PUT endpoint https://accounts.appcket.localhost/auth/realms/${realm_name}/authz/protection/resource_set/{resource_id}
    JSON Body:
    {
        "_id": "Task",
        "name":"Task",
        "resource_scopes": [
            "task:read",
            "task:create",
            "task:update",
            "task:delete"
        ]
    }

    Admin Console - GUI
    1. Navigate to the desired service client (api for example) from precondition above and click on Authorization tab
    1. Click Authorization Scopes tab
    1. Add new auth scopes that your application needs (usually these are just CRUD-type actions), ie: project:read, project:create, project:update
        * Informational: associated permissions for these scopes (created in step below) would be as follows: Read Project Permission, Create Project Permission, Edit Project Permission
        * As a matter of preference and choosing a standard, use camelCase resource names (myResource instead of my_resource)
        * i.e.
            task:read
            task:create
            task:update
            task:delete
            team:read
            team:create
            team:update
            team:delete
            organization:read
            organization:create
            organization:update
            organization:delete

#### Associate Resources with Authorization Scopes

    Admin Console - GUI
    1. Click back into each resource, and add the associated scopes. ex: MyResource will have the following scopes: MyResource:create, MyResource:update, MyResource:read, MyResource:delete

#### Add Policies

    1. Click Policies tab
    1. Create new "role" based policies that map to roles, ie:
        - "Role" Policy -> "user" role
        - Manager Policy -> Manager role
        - Captain Policy -> Captain role
        - etc.
    1. Name: Captain Role Policy
    1. Required: unchecked
    1. Realm Role: select associated role
    1. Clients: don't need to set
    1. Logic: Positive

#### Permissions

This is where it all comes together.

    1. Click Permissions tab
    1. Create "scope" based permissions
        * Name: Create Team Permission
        * Description: don't need to set, since the name implies what the permission is for
        * Resource: select the applicable resource created from above: Team
        * Scopes: select the applicable scope(s) created from above: team:create
        * Apply policy: add all the the policies (roles) to which this permission should apply: Admin, User, Employee, Customer, Manager, Captain etc.
        * Decision strategy: Affirmative

    Organization Read Permission
    Organization Create Permission
    Organization Update Permission
    Organization Delete Permission

    Team Read Permission
    Team Create Permission
    Team Update Permission
    Team Delete Permission

    Task Read Permission
    Task Create Permission
    Task Update Permission
    Task Delete Permission

#### Test permission in Evaluate tab

    Use the Evaluate tab to test permissions against certain roles

#### Get a Bearer Token to test api endpoints

Setup environment variables in Insomnia and POST to the openid-connect token endpoint for the accounts server

curl --request POST \
  --url https://accounts.appcket.localhost/auth/realms/appcket/protocol/openid-connect/token \
  --header 'content-type: application/x-www-form-urlencoded' \
  --data client_id=appcket_api \
  --data grant_type=password \
  --data client_secret=clientsecretid \
  --data scope=openid \
  --data username=yourusername \
  --data password=yourpasswordforusername

### App

    - React for the client side

### Troubleshooting

If you ever need to just run Keycloak in Docker Compose without Kubernetes and Istio (first time setup, debugging database connection start up issues, etc.), just add the following lines to the accounts service in docker-compose.yml:

    ``` yaml
    ports:
        - 8080:8080
    environment:
        - KEYCLOAK_USER=admin
        - KEYCLOAK_PASSWORD=admin
        - KEYCLOAK_LOGLEVEL=DEBUG
        - PROXY_ADDRESS_FORWARDING=true
        - DB_ADDR=appcket_database_1
        - DB_PORT=5432
        - DB_USER=keycloak
        - DB_PASSWORD=password
        - DB_DATABASE=keycloak
        - DB_VENDOR=POSTGRES
    ```

After starting the accounts service in docker-compose, you can access it http://accounts.appcket.localhost:8080/auth. Otherwise, the normal way to access Keycloak, if you followed the Initial Setup Guide, is at https://accounts.appcket.localhost
