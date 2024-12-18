--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0 (Debian 16.0-1.pgdg120+1)
-- Dumped by pg_dump version 16.0 (Debian 16.0-1.pgdg120+1)

-- Started on 2024-11-09 16:31:02 UTC

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 7 (class 2615 OID 16390)
-- Name: keycloak; Type: SCHEMA; Schema: -; Owner: dbuser
--

CREATE SCHEMA keycloak;


ALTER SCHEMA keycloak OWNER TO dbuser;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 16391)
-- Name: admin_event_entity; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE keycloak.admin_event_entity OWNER TO dbuser;

--
-- TOC entry 218 (class 1259 OID 16396)
-- Name: associated_policy; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.associated_policy OWNER TO dbuser;

--
-- TOC entry 219 (class 1259 OID 16399)
-- Name: authentication_execution; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE keycloak.authentication_execution OWNER TO dbuser;

--
-- TOC entry 220 (class 1259 OID 16403)
-- Name: authentication_flow; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE keycloak.authentication_flow OWNER TO dbuser;

--
-- TOC entry 221 (class 1259 OID 16411)
-- Name: authenticator_config; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE keycloak.authenticator_config OWNER TO dbuser;

--
-- TOC entry 222 (class 1259 OID 16414)
-- Name: authenticator_config_entry; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.authenticator_config_entry OWNER TO dbuser;

--
-- TOC entry 223 (class 1259 OID 16419)
-- Name: broker_link; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE keycloak.broker_link OWNER TO dbuser;

--
-- TOC entry 224 (class 1259 OID 16424)
-- Name: client; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE keycloak.client OWNER TO dbuser;

--
-- TOC entry 225 (class 1259 OID 16442)
-- Name: client_attributes; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE keycloak.client_attributes OWNER TO dbuser;

--
-- TOC entry 226 (class 1259 OID 16447)
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE keycloak.client_auth_flow_bindings OWNER TO dbuser;

--
-- TOC entry 227 (class 1259 OID 16450)
-- Name: client_initial_access; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE keycloak.client_initial_access OWNER TO dbuser;

--
-- TOC entry 228 (class 1259 OID 16453)
-- Name: client_node_registrations; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.client_node_registrations OWNER TO dbuser;

--
-- TOC entry 229 (class 1259 OID 16456)
-- Name: client_scope; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE keycloak.client_scope OWNER TO dbuser;

--
-- TOC entry 230 (class 1259 OID 16461)
-- Name: client_scope_attributes; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.client_scope_attributes OWNER TO dbuser;

--
-- TOC entry 231 (class 1259 OID 16466)
-- Name: client_scope_client; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE keycloak.client_scope_client OWNER TO dbuser;

--
-- TOC entry 232 (class 1259 OID 16472)
-- Name: client_scope_role_mapping; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.client_scope_role_mapping OWNER TO dbuser;

--
-- TOC entry 233 (class 1259 OID 16499)
-- Name: component; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE keycloak.component OWNER TO dbuser;

--
-- TOC entry 234 (class 1259 OID 16504)
-- Name: component_config; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE keycloak.component_config OWNER TO dbuser;

--
-- TOC entry 235 (class 1259 OID 16509)
-- Name: composite_role; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE keycloak.composite_role OWNER TO dbuser;

--
-- TOC entry 236 (class 1259 OID 16512)
-- Name: credential; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE keycloak.credential OWNER TO dbuser;

--
-- TOC entry 237 (class 1259 OID 16517)
-- Name: databasechangelog; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE keycloak.databasechangelog OWNER TO dbuser;

--
-- TOC entry 238 (class 1259 OID 16522)
-- Name: databasechangeloglock; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE keycloak.databasechangeloglock OWNER TO dbuser;

--
-- TOC entry 239 (class 1259 OID 16525)
-- Name: default_client_scope; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE keycloak.default_client_scope OWNER TO dbuser;

--
-- TOC entry 240 (class 1259 OID 16529)
-- Name: event_entity; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE keycloak.event_entity OWNER TO dbuser;

--
-- TOC entry 241 (class 1259 OID 16534)
-- Name: fed_user_attribute; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE keycloak.fed_user_attribute OWNER TO dbuser;

--
-- TOC entry 242 (class 1259 OID 16539)
-- Name: fed_user_consent; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE keycloak.fed_user_consent OWNER TO dbuser;

--
-- TOC entry 243 (class 1259 OID 16544)
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.fed_user_consent_cl_scope OWNER TO dbuser;

--
-- TOC entry 244 (class 1259 OID 16547)
-- Name: fed_user_credential; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE keycloak.fed_user_credential OWNER TO dbuser;

--
-- TOC entry 245 (class 1259 OID 16552)
-- Name: fed_user_group_membership; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE keycloak.fed_user_group_membership OWNER TO dbuser;

--
-- TOC entry 246 (class 1259 OID 16555)
-- Name: fed_user_required_action; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE keycloak.fed_user_required_action OWNER TO dbuser;

--
-- TOC entry 247 (class 1259 OID 16561)
-- Name: fed_user_role_mapping; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE keycloak.fed_user_role_mapping OWNER TO dbuser;

--
-- TOC entry 248 (class 1259 OID 16564)
-- Name: federated_identity; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.federated_identity OWNER TO dbuser;

--
-- TOC entry 249 (class 1259 OID 16569)
-- Name: federated_user; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.federated_user OWNER TO dbuser;

--
-- TOC entry 250 (class 1259 OID 16574)
-- Name: group_attribute; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.group_attribute OWNER TO dbuser;

--
-- TOC entry 251 (class 1259 OID 16580)
-- Name: group_role_mapping; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.group_role_mapping OWNER TO dbuser;

--
-- TOC entry 252 (class 1259 OID 16583)
-- Name: identity_provider; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL,
    organization_id character varying(255),
    hide_on_login boolean DEFAULT false
);


ALTER TABLE keycloak.identity_provider OWNER TO dbuser;

--
-- TOC entry 253 (class 1259 OID 16594)
-- Name: identity_provider_config; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.identity_provider_config OWNER TO dbuser;

--
-- TOC entry 254 (class 1259 OID 16599)
-- Name: identity_provider_mapper; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.identity_provider_mapper OWNER TO dbuser;

--
-- TOC entry 255 (class 1259 OID 16604)
-- Name: idp_mapper_config; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.idp_mapper_config OWNER TO dbuser;

--
-- TOC entry 256 (class 1259 OID 16609)
-- Name: keycloak_group; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36),
    type integer DEFAULT 0 NOT NULL
);


ALTER TABLE keycloak.keycloak_group OWNER TO dbuser;

--
-- TOC entry 257 (class 1259 OID 16612)
-- Name: keycloak_role; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE keycloak.keycloak_role OWNER TO dbuser;

--
-- TOC entry 258 (class 1259 OID 16618)
-- Name: migration_model; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE keycloak.migration_model OWNER TO dbuser;

--
-- TOC entry 259 (class 1259 OID 16622)
-- Name: offline_client_session; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE keycloak.offline_client_session OWNER TO dbuser;

--
-- TOC entry 260 (class 1259 OID 16629)
-- Name: offline_user_session; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0
);


ALTER TABLE keycloak.offline_user_session OWNER TO dbuser;

--
-- TOC entry 313 (class 1259 OID 24582)
-- Name: org; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000),
    alias character varying(255) NOT NULL,
    redirect_url character varying(2048)
);


ALTER TABLE keycloak.org OWNER TO dbuser;

--
-- TOC entry 314 (class 1259 OID 24593)
-- Name: org_domain; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


ALTER TABLE keycloak.org_domain OWNER TO dbuser;

--
-- TOC entry 261 (class 1259 OID 16635)
-- Name: policy_config; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE keycloak.policy_config OWNER TO dbuser;

--
-- TOC entry 262 (class 1259 OID 16640)
-- Name: protocol_mapper; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE keycloak.protocol_mapper OWNER TO dbuser;

--
-- TOC entry 263 (class 1259 OID 16645)
-- Name: protocol_mapper_config; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.protocol_mapper_config OWNER TO dbuser;

--
-- TOC entry 264 (class 1259 OID 16650)
-- Name: realm; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE keycloak.realm OWNER TO dbuser;

--
-- TOC entry 265 (class 1259 OID 16683)
-- Name: realm_attribute; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE keycloak.realm_attribute OWNER TO dbuser;

--
-- TOC entry 266 (class 1259 OID 16688)
-- Name: realm_default_groups; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.realm_default_groups OWNER TO dbuser;

--
-- TOC entry 267 (class 1259 OID 16691)
-- Name: realm_enabled_event_types; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE keycloak.realm_enabled_event_types OWNER TO dbuser;

--
-- TOC entry 268 (class 1259 OID 16694)
-- Name: realm_events_listeners; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE keycloak.realm_events_listeners OWNER TO dbuser;

--
-- TOC entry 269 (class 1259 OID 16697)
-- Name: realm_localizations; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE keycloak.realm_localizations OWNER TO dbuser;

--
-- TOC entry 270 (class 1259 OID 16702)
-- Name: realm_required_credential; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.realm_required_credential OWNER TO dbuser;

--
-- TOC entry 271 (class 1259 OID 16709)
-- Name: realm_smtp_config; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.realm_smtp_config OWNER TO dbuser;

--
-- TOC entry 272 (class 1259 OID 16714)
-- Name: realm_supported_locales; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE keycloak.realm_supported_locales OWNER TO dbuser;

--
-- TOC entry 273 (class 1259 OID 16717)
-- Name: redirect_uris; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE keycloak.redirect_uris OWNER TO dbuser;

--
-- TOC entry 274 (class 1259 OID 16720)
-- Name: required_action_config; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.required_action_config OWNER TO dbuser;

--
-- TOC entry 275 (class 1259 OID 16725)
-- Name: required_action_provider; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE keycloak.required_action_provider OWNER TO dbuser;

--
-- TOC entry 276 (class 1259 OID 16732)
-- Name: resource_attribute; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.resource_attribute OWNER TO dbuser;

--
-- TOC entry 277 (class 1259 OID 16738)
-- Name: resource_policy; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.resource_policy OWNER TO dbuser;

--
-- TOC entry 278 (class 1259 OID 16741)
-- Name: resource_scope; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.resource_scope OWNER TO dbuser;

--
-- TOC entry 279 (class 1259 OID 16744)
-- Name: resource_server; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE keycloak.resource_server OWNER TO dbuser;

--
-- TOC entry 280 (class 1259 OID 16749)
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE keycloak.resource_server_perm_ticket OWNER TO dbuser;

--
-- TOC entry 281 (class 1259 OID 16754)
-- Name: resource_server_policy; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE keycloak.resource_server_policy OWNER TO dbuser;

--
-- TOC entry 282 (class 1259 OID 16759)
-- Name: resource_server_resource; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE keycloak.resource_server_resource OWNER TO dbuser;

--
-- TOC entry 283 (class 1259 OID 16765)
-- Name: resource_server_scope; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE keycloak.resource_server_scope OWNER TO dbuser;

--
-- TOC entry 284 (class 1259 OID 16770)
-- Name: resource_uris; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE keycloak.resource_uris OWNER TO dbuser;

--
-- TOC entry 315 (class 1259 OID 32773)
-- Name: revoked_token; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.revoked_token (
    id character varying(255) NOT NULL,
    expire bigint NOT NULL
);


ALTER TABLE keycloak.revoked_token OWNER TO dbuser;

--
-- TOC entry 285 (class 1259 OID 16773)
-- Name: role_attribute; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE keycloak.role_attribute OWNER TO dbuser;

--
-- TOC entry 286 (class 1259 OID 16778)
-- Name: scope_mapping; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.scope_mapping OWNER TO dbuser;

--
-- TOC entry 287 (class 1259 OID 16781)
-- Name: scope_policy; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.scope_policy OWNER TO dbuser;

--
-- TOC entry 288 (class 1259 OID 16784)
-- Name: user_attribute; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE keycloak.user_attribute OWNER TO dbuser;

--
-- TOC entry 289 (class 1259 OID 16790)
-- Name: user_consent; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE keycloak.user_consent OWNER TO dbuser;

--
-- TOC entry 290 (class 1259 OID 16795)
-- Name: user_consent_client_scope; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.user_consent_client_scope OWNER TO dbuser;

--
-- TOC entry 291 (class 1259 OID 16798)
-- Name: user_entity; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE keycloak.user_entity OWNER TO dbuser;

--
-- TOC entry 292 (class 1259 OID 16806)
-- Name: user_federation_config; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.user_federation_config OWNER TO dbuser;

--
-- TOC entry 293 (class 1259 OID 16811)
-- Name: user_federation_mapper; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.user_federation_mapper OWNER TO dbuser;

--
-- TOC entry 294 (class 1259 OID 16816)
-- Name: user_federation_mapper_config; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.user_federation_mapper_config OWNER TO dbuser;

--
-- TOC entry 295 (class 1259 OID 16821)
-- Name: user_federation_provider; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE keycloak.user_federation_provider OWNER TO dbuser;

--
-- TOC entry 296 (class 1259 OID 16826)
-- Name: user_group_membership; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    membership_type character varying(255) NOT NULL
);


ALTER TABLE keycloak.user_group_membership OWNER TO dbuser;

--
-- TOC entry 297 (class 1259 OID 16829)
-- Name: user_required_action; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE keycloak.user_required_action OWNER TO dbuser;

--
-- TOC entry 298 (class 1259 OID 16833)
-- Name: user_role_mapping; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.user_role_mapping OWNER TO dbuser;

--
-- TOC entry 299 (class 1259 OID 16847)
-- Name: username_login_failure; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE keycloak.username_login_failure OWNER TO dbuser;

--
-- TOC entry 300 (class 1259 OID 16852)
-- Name: web_origins; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE keycloak.web_origins OWNER TO dbuser;

--
-- TOC entry 4170 (class 0 OID 16391)
-- Dependencies: 217
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4171 (class 0 OID 16396)
-- Dependencies: 218
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.associated_policy VALUES ('b498b31a-81fa-4a32-b625-71ca3e577dcb', 'bfaf527b-4238-46d7-aa48-1d605b7c390f');
INSERT INTO keycloak.associated_policy VALUES ('6338e03e-6909-496e-b52c-1cc62eb5eba6', 'f54d2838-ff5a-4259-8560-c50f042375ab');
INSERT INTO keycloak.associated_policy VALUES ('6338e03e-6909-496e-b52c-1cc62eb5eba6', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');
INSERT INTO keycloak.associated_policy VALUES ('6338e03e-6909-496e-b52c-1cc62eb5eba6', '53667455-8734-49e0-9e11-db6aacce6cbf');
INSERT INTO keycloak.associated_policy VALUES ('42c43075-9052-4129-bebc-691c56a66dfd', 'f54d2838-ff5a-4259-8560-c50f042375ab');
INSERT INTO keycloak.associated_policy VALUES ('42c43075-9052-4129-bebc-691c56a66dfd', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');
INSERT INTO keycloak.associated_policy VALUES ('42c43075-9052-4129-bebc-691c56a66dfd', '56cc0301-6b50-4bb1-b870-514669458695');
INSERT INTO keycloak.associated_policy VALUES ('42c43075-9052-4129-bebc-691c56a66dfd', '53667455-8734-49e0-9e11-db6aacce6cbf');
INSERT INTO keycloak.associated_policy VALUES ('f7b5232d-91c5-4444-b8ca-165d17552a5d', 'f54d2838-ff5a-4259-8560-c50f042375ab');
INSERT INTO keycloak.associated_policy VALUES ('f7b5232d-91c5-4444-b8ca-165d17552a5d', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');
INSERT INTO keycloak.associated_policy VALUES ('f7b5232d-91c5-4444-b8ca-165d17552a5d', '53667455-8734-49e0-9e11-db6aacce6cbf');
INSERT INTO keycloak.associated_policy VALUES ('b6033d87-3b1b-4002-8f97-255956c2b506', 'f54d2838-ff5a-4259-8560-c50f042375ab');
INSERT INTO keycloak.associated_policy VALUES ('b6033d87-3b1b-4002-8f97-255956c2b506', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');
INSERT INTO keycloak.associated_policy VALUES ('b6033d87-3b1b-4002-8f97-255956c2b506', '53667455-8734-49e0-9e11-db6aacce6cbf');
INSERT INTO keycloak.associated_policy VALUES ('2d99ec81-c6a8-4949-b129-0bc425126832', 'f54d2838-ff5a-4259-8560-c50f042375ab');
INSERT INTO keycloak.associated_policy VALUES ('2d99ec81-c6a8-4949-b129-0bc425126832', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');
INSERT INTO keycloak.associated_policy VALUES ('2d99ec81-c6a8-4949-b129-0bc425126832', '53667455-8734-49e0-9e11-db6aacce6cbf');
INSERT INTO keycloak.associated_policy VALUES ('48345f52-292b-474c-acd3-1cc56513aa4f', 'f54d2838-ff5a-4259-8560-c50f042375ab');
INSERT INTO keycloak.associated_policy VALUES ('48345f52-292b-474c-acd3-1cc56513aa4f', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');
INSERT INTO keycloak.associated_policy VALUES ('48345f52-292b-474c-acd3-1cc56513aa4f', '56cc0301-6b50-4bb1-b870-514669458695');
INSERT INTO keycloak.associated_policy VALUES ('48345f52-292b-474c-acd3-1cc56513aa4f', '53667455-8734-49e0-9e11-db6aacce6cbf');
INSERT INTO keycloak.associated_policy VALUES ('73c7d9cb-5b6a-4a57-a7e1-5e81ec3aa8c2', 'f54d2838-ff5a-4259-8560-c50f042375ab');
INSERT INTO keycloak.associated_policy VALUES ('73c7d9cb-5b6a-4a57-a7e1-5e81ec3aa8c2', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');
INSERT INTO keycloak.associated_policy VALUES ('73c7d9cb-5b6a-4a57-a7e1-5e81ec3aa8c2', '53667455-8734-49e0-9e11-db6aacce6cbf');
INSERT INTO keycloak.associated_policy VALUES ('beb7d05d-19f7-4690-86e9-13dd49936d71', 'f54d2838-ff5a-4259-8560-c50f042375ab');
INSERT INTO keycloak.associated_policy VALUES ('beb7d05d-19f7-4690-86e9-13dd49936d71', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');
INSERT INTO keycloak.associated_policy VALUES ('f93476a3-2536-4e2c-bcad-212d0859fbe1', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');
INSERT INTO keycloak.associated_policy VALUES ('a03337fa-5ad4-42e1-8beb-52afcac74329', 'f54d2838-ff5a-4259-8560-c50f042375ab');
INSERT INTO keycloak.associated_policy VALUES ('a03337fa-5ad4-42e1-8beb-52afcac74329', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');
INSERT INTO keycloak.associated_policy VALUES ('a03337fa-5ad4-42e1-8beb-52afcac74329', '56cc0301-6b50-4bb1-b870-514669458695');
INSERT INTO keycloak.associated_policy VALUES ('a03337fa-5ad4-42e1-8beb-52afcac74329', '53667455-8734-49e0-9e11-db6aacce6cbf');
INSERT INTO keycloak.associated_policy VALUES ('ab1f242c-d8bf-4860-a2b1-4702f367bbd5', 'f54d2838-ff5a-4259-8560-c50f042375ab');
INSERT INTO keycloak.associated_policy VALUES ('ab1f242c-d8bf-4860-a2b1-4702f367bbd5', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');
INSERT INTO keycloak.associated_policy VALUES ('ab1f242c-d8bf-4860-a2b1-4702f367bbd5', '53667455-8734-49e0-9e11-db6aacce6cbf');
INSERT INTO keycloak.associated_policy VALUES ('68061593-00a9-46ae-b3a5-b21333100a20', 'f54d2838-ff5a-4259-8560-c50f042375ab');
INSERT INTO keycloak.associated_policy VALUES ('68061593-00a9-46ae-b3a5-b21333100a20', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');
INSERT INTO keycloak.associated_policy VALUES ('7db68186-ebbb-40a8-8dd7-147deddae4ce', 'f54d2838-ff5a-4259-8560-c50f042375ab');
INSERT INTO keycloak.associated_policy VALUES ('7db68186-ebbb-40a8-8dd7-147deddae4ce', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');
INSERT INTO keycloak.associated_policy VALUES ('7db68186-ebbb-40a8-8dd7-147deddae4ce', '53667455-8734-49e0-9e11-db6aacce6cbf');
INSERT INTO keycloak.associated_policy VALUES ('69a3bcf1-89b4-4602-bc26-9d34eb5d9c55', 'f54d2838-ff5a-4259-8560-c50f042375ab');
INSERT INTO keycloak.associated_policy VALUES ('69a3bcf1-89b4-4602-bc26-9d34eb5d9c55', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');
INSERT INTO keycloak.associated_policy VALUES ('69a3bcf1-89b4-4602-bc26-9d34eb5d9c55', '56cc0301-6b50-4bb1-b870-514669458695');
INSERT INTO keycloak.associated_policy VALUES ('69a3bcf1-89b4-4602-bc26-9d34eb5d9c55', '53667455-8734-49e0-9e11-db6aacce6cbf');
INSERT INTO keycloak.associated_policy VALUES ('df6b4650-ee44-4f35-b5fe-1891afe29334', 'f54d2838-ff5a-4259-8560-c50f042375ab');
INSERT INTO keycloak.associated_policy VALUES ('df6b4650-ee44-4f35-b5fe-1891afe29334', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');
INSERT INTO keycloak.associated_policy VALUES ('dbc609b4-6662-4067-b552-7ff079e1d7ed', 'f54d2838-ff5a-4259-8560-c50f042375ab');
INSERT INTO keycloak.associated_policy VALUES ('dbc609b4-6662-4067-b552-7ff079e1d7ed', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');
INSERT INTO keycloak.associated_policy VALUES ('b1800646-850a-464a-95d9-1102358f3765', 'f54d2838-ff5a-4259-8560-c50f042375ab');
INSERT INTO keycloak.associated_policy VALUES ('b1800646-850a-464a-95d9-1102358f3765', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');
INSERT INTO keycloak.associated_policy VALUES ('b1800646-850a-464a-95d9-1102358f3765', '53667455-8734-49e0-9e11-db6aacce6cbf');
INSERT INTO keycloak.associated_policy VALUES ('6cdadd37-e036-47ea-8eca-bd1a1ace3f35', 'f54d2838-ff5a-4259-8560-c50f042375ab');
INSERT INTO keycloak.associated_policy VALUES ('6cdadd37-e036-47ea-8eca-bd1a1ace3f35', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');
INSERT INTO keycloak.associated_policy VALUES ('6cdadd37-e036-47ea-8eca-bd1a1ace3f35', '53667455-8734-49e0-9e11-db6aacce6cbf');
INSERT INTO keycloak.associated_policy VALUES ('ab198044-b3fd-4bf3-b4a1-594d06bfa10e', 'f54d2838-ff5a-4259-8560-c50f042375ab');
INSERT INTO keycloak.associated_policy VALUES ('ab198044-b3fd-4bf3-b4a1-594d06bfa10e', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');
INSERT INTO keycloak.associated_policy VALUES ('ab198044-b3fd-4bf3-b4a1-594d06bfa10e', '53667455-8734-49e0-9e11-db6aacce6cbf');
INSERT INTO keycloak.associated_policy VALUES ('57b884b6-b5b0-4447-95da-94c234fd3892', 'f54d2838-ff5a-4259-8560-c50f042375ab');
INSERT INTO keycloak.associated_policy VALUES ('57b884b6-b5b0-4447-95da-94c234fd3892', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');
INSERT INTO keycloak.associated_policy VALUES ('57b884b6-b5b0-4447-95da-94c234fd3892', '53667455-8734-49e0-9e11-db6aacce6cbf');


--
-- TOC entry 4172 (class 0 OID 16399)
-- Dependencies: 219
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.authentication_execution VALUES ('4f62210b-2060-4ae6-ab83-cb42e00b3b8a', NULL, 'auth-cookie', 'master', 'a6de927c-b820-4668-a693-eae52d3d3767', 2, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('2c1ee712-b061-49c3-a2ff-ce8fe3a76d3f', NULL, 'auth-spnego', 'master', 'a6de927c-b820-4668-a693-eae52d3d3767', 3, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('d4a73291-10bb-4e8a-9157-8cfc3e0f69df', NULL, 'identity-provider-redirector', 'master', 'a6de927c-b820-4668-a693-eae52d3d3767', 2, 25, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('583538e6-699d-43aa-a37e-670feaf8e944', NULL, NULL, 'master', 'a6de927c-b820-4668-a693-eae52d3d3767', 2, 30, true, 'adf61130-eb23-45fe-80bc-acadc595cf94', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('430dedd4-9d4f-4d98-8d74-ef4b7a0c410c', NULL, 'auth-username-password-form', 'master', 'adf61130-eb23-45fe-80bc-acadc595cf94', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('e32e6335-59f9-4153-977d-3b5d1d5073a6', NULL, NULL, 'master', 'adf61130-eb23-45fe-80bc-acadc595cf94', 1, 20, true, 'a4578bca-5f4a-4c03-97e9-a096e8dde096', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('72821d01-71aa-457c-907f-848a5a6088ff', NULL, 'conditional-user-configured', 'master', 'a4578bca-5f4a-4c03-97e9-a096e8dde096', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('0aa34337-7ec1-40a5-a4c4-880d7f7844db', NULL, 'auth-otp-form', 'master', 'a4578bca-5f4a-4c03-97e9-a096e8dde096', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('2d13243f-ec21-44ef-8764-f1e0633af29d', NULL, 'direct-grant-validate-username', 'master', '248672a8-7d9f-49c5-a5fd-c38f07e839aa', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('6599d478-6e61-4eb0-bc4f-5f00859fa2ba', NULL, 'direct-grant-validate-password', 'master', '248672a8-7d9f-49c5-a5fd-c38f07e839aa', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('db59934f-8c52-4b81-bf3a-425a7b4bdc31', NULL, NULL, 'master', '248672a8-7d9f-49c5-a5fd-c38f07e839aa', 1, 30, true, '775f5b04-bf2a-4ff7-a0d7-598bca8c0cf9', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('e16dee67-76de-4c20-ac1c-788f28017d55', NULL, 'conditional-user-configured', 'master', '775f5b04-bf2a-4ff7-a0d7-598bca8c0cf9', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('2b6aec51-4d63-44f1-b997-01bfc48198ff', NULL, 'direct-grant-validate-otp', 'master', '775f5b04-bf2a-4ff7-a0d7-598bca8c0cf9', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('a57da0f8-58ba-4da3-b058-c9918b3901aa', NULL, 'registration-page-form', 'master', '325a1657-2e72-4b01-91b9-6730e9b4670c', 0, 10, true, '205780bc-5a26-4e8e-af81-fb28eafb719e', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('54270b42-882d-4a42-ba9a-6dce7ce0cd4a', NULL, 'registration-user-creation', 'master', '205780bc-5a26-4e8e-af81-fb28eafb719e', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('92d52abd-e70e-4dcb-a9c3-dc28ecff72b9', NULL, 'registration-password-action', 'master', '205780bc-5a26-4e8e-af81-fb28eafb719e', 0, 50, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('6f3dbdcc-4e2d-4eac-b752-d7b915eb8179', NULL, 'registration-recaptcha-action', 'master', '205780bc-5a26-4e8e-af81-fb28eafb719e', 3, 60, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('84de6a27-1164-4d70-ae56-19540a3d8d0d', NULL, 'reset-credentials-choose-user', 'master', '6b86461b-2933-464e-9163-c455a9246c6b', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('3220b5b7-f11d-44b3-aa1b-378a6c8ab4d6', NULL, 'reset-credential-email', 'master', '6b86461b-2933-464e-9163-c455a9246c6b', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('7146e44d-2ac7-4bb2-8930-e2cc5d60529e', NULL, 'reset-password', 'master', '6b86461b-2933-464e-9163-c455a9246c6b', 0, 30, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('4b13c1f3-94cd-464e-bec2-49758539933d', NULL, NULL, 'master', '6b86461b-2933-464e-9163-c455a9246c6b', 1, 40, true, '59e1a4ae-8517-4786-8557-2a476f7f4c63', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('b887074a-36b8-4ef5-9076-e861cec6cfe4', NULL, 'conditional-user-configured', 'master', '59e1a4ae-8517-4786-8557-2a476f7f4c63', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('4d62a58a-2d13-4857-982c-bff1797c2b4b', NULL, 'reset-otp', 'master', '59e1a4ae-8517-4786-8557-2a476f7f4c63', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('e5997ad9-1824-431d-9590-b8fb362db04f', NULL, 'client-secret', 'master', 'd6fa5c47-cdaa-4442-aa68-a8ab1370b953', 2, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('36de6fc8-46d2-40f6-9097-ed0fb8e8b6c4', NULL, 'client-jwt', 'master', 'd6fa5c47-cdaa-4442-aa68-a8ab1370b953', 2, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('766afd04-41e3-474f-81b1-0fca0a411327', NULL, 'client-secret-jwt', 'master', 'd6fa5c47-cdaa-4442-aa68-a8ab1370b953', 2, 30, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('e9e33a55-bbb4-449f-9d97-a2d1ad1ce9a3', NULL, 'client-x509', 'master', 'd6fa5c47-cdaa-4442-aa68-a8ab1370b953', 2, 40, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('de7f2d0a-f620-478d-b11d-c6da72f96378', NULL, 'idp-review-profile', 'master', 'e2034074-1b98-46ad-8d9f-5a96b770b7db', 0, 10, false, NULL, 'd85be5e9-a26c-49a6-920e-5a21e2781253');
INSERT INTO keycloak.authentication_execution VALUES ('159039fe-689c-4ea2-8d09-d20ea6934c53', NULL, NULL, 'master', 'e2034074-1b98-46ad-8d9f-5a96b770b7db', 0, 20, true, '6402d9fd-30f7-4c3b-92fd-2631c0921703', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('300ec065-e7ca-4add-a5ca-d0250dcf2ff2', NULL, 'idp-create-user-if-unique', 'master', '6402d9fd-30f7-4c3b-92fd-2631c0921703', 2, 10, false, NULL, 'd468d3af-1d8a-4ff1-a47e-10cc291cba54');
INSERT INTO keycloak.authentication_execution VALUES ('1b72f6de-6917-45be-88f6-337a2232bec1', NULL, NULL, 'master', '6402d9fd-30f7-4c3b-92fd-2631c0921703', 2, 20, true, 'a05f1f41-d37f-4538-9096-5f4e900cb9de', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('fd4ce4c3-9bbf-4936-b31b-b4b40ce2ee00', NULL, 'idp-confirm-link', 'master', 'a05f1f41-d37f-4538-9096-5f4e900cb9de', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('d1894c34-8335-40a8-a44c-213ae8e32715', NULL, NULL, 'master', 'a05f1f41-d37f-4538-9096-5f4e900cb9de', 0, 20, true, 'f4815436-1479-4974-b28b-f28e5c183ec6', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('b799111d-c414-4671-9217-812234348743', NULL, 'idp-email-verification', 'master', 'f4815436-1479-4974-b28b-f28e5c183ec6', 2, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('24e8e106-2bc7-40ce-97d3-824903988a37', NULL, NULL, 'master', 'f4815436-1479-4974-b28b-f28e5c183ec6', 2, 20, true, '6a6c2c90-337b-49c0-94d0-c52ae348a58d', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('32b86c32-723d-45a2-b301-0eeca1dfe267', NULL, 'idp-username-password-form', 'master', '6a6c2c90-337b-49c0-94d0-c52ae348a58d', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('150d66e0-7440-45fe-8b98-c3da36cb0f85', NULL, NULL, 'master', '6a6c2c90-337b-49c0-94d0-c52ae348a58d', 1, 20, true, '38f0f27a-0779-4d51-9984-294d9b9ab25b', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('6db854f6-b39f-4ac5-a34f-dbffbdacd759', NULL, 'conditional-user-configured', 'master', '38f0f27a-0779-4d51-9984-294d9b9ab25b', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('0610ef0d-4fcb-443d-b48b-dbcd4ac588ad', NULL, 'auth-otp-form', 'master', '38f0f27a-0779-4d51-9984-294d9b9ab25b', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('eed124f1-bebf-4f90-83f2-e8d0e1e79771', NULL, 'http-basic-authenticator', 'master', '263ee6cf-0f8c-4bda-a185-7f6c49216ce2', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('285ba2f4-0c89-4609-8342-4e760f53c506', NULL, 'docker-http-basic-authenticator', 'master', 'f73308e6-119d-4811-98b0-96001c76a237', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('f5a5036f-7e6d-4965-9c26-3a8c1ba82623', NULL, 'idp-email-verification', 'appcket', '8f4308e3-f4fd-4f89-bb44-4548ba6ead8e', 2, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('6533eab5-7d36-4df1-a212-3025f9191344', NULL, NULL, 'appcket', '8f4308e3-f4fd-4f89-bb44-4548ba6ead8e', 2, 20, true, 'ddcbbfba-068d-4b50-8d7d-4a2cae15e397', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('ae8b2385-9be6-46ae-9d75-f5189b4622b5', NULL, 'conditional-user-configured', 'appcket', '0f110d3a-bf0f-449f-9459-eebd80a0131c', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('7b0ddf5a-04f6-42c5-b3bf-d0ae9ae4922d', NULL, 'auth-otp-form', 'appcket', '0f110d3a-bf0f-449f-9459-eebd80a0131c', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('254bcf96-412b-4512-925c-2f7c99cb710e', NULL, 'conditional-user-configured', 'appcket', '0c01cf35-faa5-4cf2-838c-f623855996ad', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('90d68125-51d6-4989-afcb-9031683357cb', NULL, 'direct-grant-validate-otp', 'appcket', '0c01cf35-faa5-4cf2-838c-f623855996ad', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('e50d5f47-19cf-47af-b540-05719d0dd2c5', NULL, 'conditional-user-configured', 'appcket', 'a711d21f-53f4-42fd-8405-2533f08595c8', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('b8ecf364-296f-449f-87d4-eca4178eb143', NULL, 'auth-otp-form', 'appcket', 'a711d21f-53f4-42fd-8405-2533f08595c8', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('16eb1d2d-5512-4b00-9ac8-1b88dd8e5ee4', NULL, 'idp-confirm-link', 'appcket', '4e36f1b7-ea53-44dd-a649-ace855554089', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('eb19c4e8-a7db-4e21-9f55-5c7eafb5ab16', NULL, NULL, 'appcket', '4e36f1b7-ea53-44dd-a649-ace855554089', 0, 20, true, '8f4308e3-f4fd-4f89-bb44-4548ba6ead8e', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('445d28f8-dcbb-4866-b3b7-4a9926d01727', NULL, 'conditional-user-configured', 'appcket', '85b9b91a-8fd1-4f9a-ba62-aad3975b14ba', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('869d1acb-48ec-45d2-8907-b2d172ef48c7', NULL, 'reset-otp', 'appcket', '85b9b91a-8fd1-4f9a-ba62-aad3975b14ba', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('0c958502-b4b9-45fa-8a88-9de08196561f', NULL, 'idp-create-user-if-unique', 'appcket', 'a1de16b6-4004-45d6-9e91-e3669b202279', 2, 10, false, NULL, '4a2b656a-f7b1-481d-a001-8e6cf4e8e5a4');
INSERT INTO keycloak.authentication_execution VALUES ('6f915454-561d-4835-85c3-a12051b2f7c9', NULL, NULL, 'appcket', 'a1de16b6-4004-45d6-9e91-e3669b202279', 2, 20, true, '4e36f1b7-ea53-44dd-a649-ace855554089', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('b6727209-1211-4acf-8ff6-0c093fa77e84', NULL, 'idp-username-password-form', 'appcket', 'ddcbbfba-068d-4b50-8d7d-4a2cae15e397', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('2e34bbc6-71ac-41d5-8657-4cbae0579f5e', NULL, NULL, 'appcket', 'ddcbbfba-068d-4b50-8d7d-4a2cae15e397', 1, 20, true, 'a711d21f-53f4-42fd-8405-2533f08595c8', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('3a501cb6-5d07-44c9-8969-2044ebc67ec5', NULL, 'auth-cookie', 'appcket', '7f4f19c4-2902-4a20-a1a2-1d33f3ac4462', 2, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('727d6a2b-b5fa-4e31-8216-2cbbfe356cfe', NULL, 'auth-spnego', 'appcket', '7f4f19c4-2902-4a20-a1a2-1d33f3ac4462', 3, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('e852a3db-9300-44d5-ba41-d1cefb5111cb', NULL, 'identity-provider-redirector', 'appcket', '7f4f19c4-2902-4a20-a1a2-1d33f3ac4462', 2, 25, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('250b27a7-4dfc-489d-bcaf-20051c4ddac9', NULL, NULL, 'appcket', '7f4f19c4-2902-4a20-a1a2-1d33f3ac4462', 2, 30, true, '6e38b38e-b183-4109-a547-e76e2dc3af01', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('f3715daa-84bd-4f08-b9f2-f02b5c836810', NULL, 'client-secret', 'appcket', 'ef540b37-c348-4bbc-af48-e33fa3af64b5', 2, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('bd2344c3-bb77-4072-bfb3-dd53599fcd9c', NULL, 'client-jwt', 'appcket', 'ef540b37-c348-4bbc-af48-e33fa3af64b5', 2, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('59001620-6111-4c06-8e35-5e0b144c4a3e', NULL, 'client-secret-jwt', 'appcket', 'ef540b37-c348-4bbc-af48-e33fa3af64b5', 2, 30, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('bc78534f-e83a-4a84-9c2f-d1f47840e46f', NULL, 'client-x509', 'appcket', 'ef540b37-c348-4bbc-af48-e33fa3af64b5', 2, 40, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('9e03b0b8-234c-4d69-8bee-554cfd7812c6', NULL, 'direct-grant-validate-username', 'appcket', '4435715e-0f08-4968-8e51-910b9f4d5510', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('a1f6e3a4-3730-4ad1-a2b9-3c5e4a7b45f0', NULL, 'direct-grant-validate-password', 'appcket', '4435715e-0f08-4968-8e51-910b9f4d5510', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('c32e58c7-786e-42a6-a224-753d1276f908', NULL, NULL, 'appcket', '4435715e-0f08-4968-8e51-910b9f4d5510', 1, 30, true, '0c01cf35-faa5-4cf2-838c-f623855996ad', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('56d8c951-f5a0-4d3c-bfb8-75d6a8130367', NULL, 'docker-http-basic-authenticator', 'appcket', 'be0a0252-f255-4c8d-b1fc-1b6353480b76', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('395b947d-9d0d-4754-8d57-f79ac2522281', NULL, 'idp-review-profile', 'appcket', '75e40d46-468a-4b78-9a55-c0aa4ba5041d', 0, 10, false, NULL, 'f640f8af-b3dd-46cf-9477-5797fef539c3');
INSERT INTO keycloak.authentication_execution VALUES ('7701f00e-f12a-47b0-8381-7aa3a4a38d11', NULL, NULL, 'appcket', '75e40d46-468a-4b78-9a55-c0aa4ba5041d', 0, 20, true, 'a1de16b6-4004-45d6-9e91-e3669b202279', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('548402b3-ad06-4470-a9d3-b8aace7b5688', NULL, 'auth-username-password-form', 'appcket', '6e38b38e-b183-4109-a547-e76e2dc3af01', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('039dd499-ee16-4428-9832-8cff07f49455', NULL, NULL, 'appcket', '6e38b38e-b183-4109-a547-e76e2dc3af01', 1, 20, true, '0f110d3a-bf0f-449f-9459-eebd80a0131c', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('290585e7-7d89-45a4-83ee-e98faba84cec', NULL, 'registration-page-form', 'appcket', '491c5d7e-1f7d-4487-a3f8-a58251755d7f', 0, 10, true, '425f82a8-a308-4b15-ab7f-1ffdc4ac5cff', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('e7b0c19e-6bcd-4d92-904a-b5d51716e773', NULL, 'registration-user-creation', 'appcket', '425f82a8-a308-4b15-ab7f-1ffdc4ac5cff', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('050fd9b7-fa4c-43e5-848f-97df83523db5', NULL, 'registration-password-action', 'appcket', '425f82a8-a308-4b15-ab7f-1ffdc4ac5cff', 0, 50, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('7c75b604-2830-4283-842c-fdadefb1b839', NULL, 'registration-recaptcha-action', 'appcket', '425f82a8-a308-4b15-ab7f-1ffdc4ac5cff', 3, 60, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('a482556e-0424-4dec-95cf-e1ca91018a8e', NULL, 'reset-credentials-choose-user', 'appcket', '69cfb673-d269-406b-acf2-b657e1fa75bd', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('961b0904-ce74-4fc4-924a-889a21889ce4', NULL, 'reset-credential-email', 'appcket', '69cfb673-d269-406b-acf2-b657e1fa75bd', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('84839ea8-2f70-4462-b9e1-5b7dd520a1bc', NULL, 'reset-password', 'appcket', '69cfb673-d269-406b-acf2-b657e1fa75bd', 0, 30, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('1742d1fe-7793-4dc6-b73f-c9817036a141', NULL, NULL, 'appcket', '69cfb673-d269-406b-acf2-b657e1fa75bd', 1, 40, true, '85b9b91a-8fd1-4f9a-ba62-aad3975b14ba', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('c41b89ba-26b8-402a-a57d-1a6d4ba76512', NULL, 'http-basic-authenticator', 'appcket', 'd2ca8abd-5613-4600-a4a1-95f82460168e', 0, 10, false, NULL, NULL);


--
-- TOC entry 4173 (class 0 OID 16403)
-- Dependencies: 220
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.authentication_flow VALUES ('a6de927c-b820-4668-a693-eae52d3d3767', 'browser', 'browser based authentication', 'master', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('adf61130-eb23-45fe-80bc-acadc595cf94', 'forms', 'Username, password, otp and other auth forms.', 'master', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('a4578bca-5f4a-4c03-97e9-a096e8dde096', 'Browser - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'master', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('248672a8-7d9f-49c5-a5fd-c38f07e839aa', 'direct grant', 'OpenID Connect Resource Owner Grant', 'master', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('775f5b04-bf2a-4ff7-a0d7-598bca8c0cf9', 'Direct Grant - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'master', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('325a1657-2e72-4b01-91b9-6730e9b4670c', 'registration', 'registration flow', 'master', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('205780bc-5a26-4e8e-af81-fb28eafb719e', 'registration form', 'registration form', 'master', 'form-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('6b86461b-2933-464e-9163-c455a9246c6b', 'reset credentials', 'Reset credentials for a user if they forgot their password or something', 'master', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('59e1a4ae-8517-4786-8557-2a476f7f4c63', 'Reset - Conditional OTP', 'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.', 'master', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('d6fa5c47-cdaa-4442-aa68-a8ab1370b953', 'clients', 'Base authentication for clients', 'master', 'client-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('e2034074-1b98-46ad-8d9f-5a96b770b7db', 'first broker login', 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account', 'master', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('6402d9fd-30f7-4c3b-92fd-2631c0921703', 'User creation or linking', 'Flow for the existing/non-existing user alternatives', 'master', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('a05f1f41-d37f-4538-9096-5f4e900cb9de', 'Handle Existing Account', 'Handle what to do if there is existing account with same email/username like authenticated identity provider', 'master', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('f4815436-1479-4974-b28b-f28e5c183ec6', 'Account verification options', 'Method with which to verity the existing account', 'master', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('6a6c2c90-337b-49c0-94d0-c52ae348a58d', 'Verify Existing Account by Re-authentication', 'Reauthentication of existing account', 'master', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('38f0f27a-0779-4d51-9984-294d9b9ab25b', 'First broker login - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'master', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('263ee6cf-0f8c-4bda-a185-7f6c49216ce2', 'saml ecp', 'SAML ECP Profile Authentication Flow', 'master', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('f73308e6-119d-4811-98b0-96001c76a237', 'docker auth', 'Used by Docker clients to authenticate against the IDP', 'master', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('8f4308e3-f4fd-4f89-bb44-4548ba6ead8e', 'Account verification options', 'Method with which to verity the existing account', 'appcket', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('0f110d3a-bf0f-449f-9459-eebd80a0131c', 'Browser - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'appcket', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('0c01cf35-faa5-4cf2-838c-f623855996ad', 'Direct Grant - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'appcket', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('a711d21f-53f4-42fd-8405-2533f08595c8', 'First broker login - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'appcket', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('4e36f1b7-ea53-44dd-a649-ace855554089', 'Handle Existing Account', 'Handle what to do if there is existing account with same email/username like authenticated identity provider', 'appcket', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('85b9b91a-8fd1-4f9a-ba62-aad3975b14ba', 'Reset - Conditional OTP', 'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.', 'appcket', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('a1de16b6-4004-45d6-9e91-e3669b202279', 'User creation or linking', 'Flow for the existing/non-existing user alternatives', 'appcket', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('ddcbbfba-068d-4b50-8d7d-4a2cae15e397', 'Verify Existing Account by Re-authentication', 'Reauthentication of existing account', 'appcket', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('7f4f19c4-2902-4a20-a1a2-1d33f3ac4462', 'browser', 'browser based authentication', 'appcket', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('ef540b37-c348-4bbc-af48-e33fa3af64b5', 'clients', 'Base authentication for clients', 'appcket', 'client-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('4435715e-0f08-4968-8e51-910b9f4d5510', 'direct grant', 'OpenID Connect Resource Owner Grant', 'appcket', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('be0a0252-f255-4c8d-b1fc-1b6353480b76', 'docker auth', 'Used by Docker clients to authenticate against the IDP', 'appcket', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('75e40d46-468a-4b78-9a55-c0aa4ba5041d', 'first broker login', 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account', 'appcket', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('6e38b38e-b183-4109-a547-e76e2dc3af01', 'forms', 'Username, password, otp and other auth forms.', 'appcket', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('491c5d7e-1f7d-4487-a3f8-a58251755d7f', 'registration', 'registration flow', 'appcket', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('425f82a8-a308-4b15-ab7f-1ffdc4ac5cff', 'registration form', 'registration form', 'appcket', 'form-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('69cfb673-d269-406b-acf2-b657e1fa75bd', 'reset credentials', 'Reset credentials for a user if they forgot their password or something', 'appcket', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('d2ca8abd-5613-4600-a4a1-95f82460168e', 'saml ecp', 'SAML ECP Profile Authentication Flow', 'appcket', 'basic-flow', true, true);


--
-- TOC entry 4174 (class 0 OID 16411)
-- Dependencies: 221
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.authenticator_config VALUES ('d85be5e9-a26c-49a6-920e-5a21e2781253', 'review profile config', 'master');
INSERT INTO keycloak.authenticator_config VALUES ('d468d3af-1d8a-4ff1-a47e-10cc291cba54', 'create unique user config', 'master');
INSERT INTO keycloak.authenticator_config VALUES ('4a2b656a-f7b1-481d-a001-8e6cf4e8e5a4', 'create unique user config', 'appcket');
INSERT INTO keycloak.authenticator_config VALUES ('f640f8af-b3dd-46cf-9477-5797fef539c3', 'review profile config', 'appcket');


--
-- TOC entry 4175 (class 0 OID 16414)
-- Dependencies: 222
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.authenticator_config_entry VALUES ('d468d3af-1d8a-4ff1-a47e-10cc291cba54', 'false', 'require.password.update.after.registration');
INSERT INTO keycloak.authenticator_config_entry VALUES ('d85be5e9-a26c-49a6-920e-5a21e2781253', 'missing', 'update.profile.on.first.login');
INSERT INTO keycloak.authenticator_config_entry VALUES ('4a2b656a-f7b1-481d-a001-8e6cf4e8e5a4', 'false', 'require.password.update.after.registration');
INSERT INTO keycloak.authenticator_config_entry VALUES ('f640f8af-b3dd-46cf-9477-5797fef539c3', 'missing', 'update.profile.on.first.login');


--
-- TOC entry 4176 (class 0 OID 16419)
-- Dependencies: 223
-- Data for Name: broker_link; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4177 (class 0 OID 16424)
-- Dependencies: 224
-- Data for Name: client; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.client VALUES ('aa546da1-d04d-4783-8c48-085c049d6f90', true, false, 'master-realm', 0, false, NULL, NULL, true, NULL, false, 'master', NULL, 0, false, false, 'master Realm', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client VALUES ('605fa94d-21d1-4569-8fa7-6bbb229b19f0', true, false, 'account', 0, true, NULL, '/realms/master/account/', false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_account}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client VALUES ('235e5d2b-515a-422c-b23c-6d9c3abddfa5', true, false, 'account-console', 0, true, NULL, '/realms/master/account/', false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_account-console}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client VALUES ('6b0c8bef-0c61-487f-ac1d-dc77f3f97278', true, false, 'broker', 0, false, NULL, NULL, true, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_broker}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client VALUES ('dc634090-4b2a-41e1-b8bc-35ea7cfc1102', true, false, 'appcket-realm', 0, false, NULL, NULL, true, NULL, false, 'master', NULL, 0, false, false, 'appcket Realm', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client VALUES ('e801cbf0-541f-4466-80e1-fcce640df2a8', true, false, 'account', 0, false, '**********', '/realms/appcket/account/', false, NULL, false, 'appcket', 'openid-connect', 0, false, false, '${client_account}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client VALUES ('26f802c3-b7af-4e78-b785-40493ae2483a', true, false, 'account-console', 0, true, '**********', '/realms/appcket/account/', false, NULL, false, 'appcket', 'openid-connect', 0, false, false, '${client_account-console}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', true, true, 'appcket_app', 0, true, NULL, '/', false, 'https://app.appcket.localhost', false, 'appcket', 'openid-connect', -1, false, false, 'Appcket App', false, 'client-secret', 'https://app.appcket.localhost', NULL, NULL, true, false, true, false);
INSERT INTO keycloak.client VALUES ('70da96f3-abee-4ade-a7f3-d22e04437a0a', true, false, 'broker', 0, false, '**********', NULL, false, NULL, false, 'appcket', 'openid-connect', 0, false, false, '${client_broker}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client VALUES ('5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, false, 'realm-management', 0, false, '**********', NULL, true, NULL, false, 'appcket', 'openid-connect', 0, false, false, '${client_realm-management}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', true, true, 'appcket_api', 0, false, '1SMHqsPrhtoxlMPLRYcHP39uJL16oGG1', NULL, false, 'https://api.appcket.localhost', false, 'appcket', 'openid-connect', -1, false, false, 'Appcket API', true, 'client-secret', 'https://api.appcket.localhost', NULL, NULL, true, false, true, false);
INSERT INTO keycloak.client VALUES ('01818753-ed45-4903-93e9-8ebffc711cd8', true, true, 'security-admin-console', 0, true, NULL, '/admin/master/console/', false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_security-admin-console}', false, 'client-secret', '${authAdminUrl}', NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client VALUES ('bfd838d0-4aef-44ac-8947-978c45bb4f26', true, true, 'admin-cli', 0, true, NULL, NULL, false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_admin-cli}', false, 'client-secret', NULL, NULL, NULL, false, false, true, false);
INSERT INTO keycloak.client VALUES ('4dd4c360-d5b9-4730-8091-78b394cea334', true, true, 'security-admin-console', 0, true, '**********', '/admin/appcket/console/', false, NULL, false, 'appcket', 'openid-connect', 0, false, false, '${client_security-admin-console}', false, 'client-secret', '${authAdminUrl}', NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client VALUES ('544076b9-bf22-4731-8d85-2ddc0edbd41e', true, true, 'admin-cli', 0, true, '**********', NULL, false, NULL, false, 'appcket', 'openid-connect', 0, false, false, '${client_admin-cli}', false, 'client-secret', NULL, NULL, NULL, false, false, true, false);


--
-- TOC entry 4178 (class 0 OID 16442)
-- Dependencies: 225
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.client_attributes VALUES ('235e5d2b-515a-422c-b23c-6d9c3abddfa5', 'pkce.code.challenge.method', 'S256');
INSERT INTO keycloak.client_attributes VALUES ('01818753-ed45-4903-93e9-8ebffc711cd8', 'pkce.code.challenge.method', 'S256');
INSERT INTO keycloak.client_attributes VALUES ('26f802c3-b7af-4e78-b785-40493ae2483a', 'pkce.code.challenge.method', 'S256');
INSERT INTO keycloak.client_attributes VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'saml.assertion.signature', 'false');
INSERT INTO keycloak.client_attributes VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'access.token.lifespan', '28800');
INSERT INTO keycloak.client_attributes VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'saml.force.post.binding', 'false');
INSERT INTO keycloak.client_attributes VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'saml.multivalued.roles', 'false');
INSERT INTO keycloak.client_attributes VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'saml.encrypt', 'false');
INSERT INTO keycloak.client_attributes VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'saml.server.signature', 'false');
INSERT INTO keycloak.client_attributes VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'saml.server.signature.keyinfo.ext', 'false');
INSERT INTO keycloak.client_attributes VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'exclude.session.state.from.auth.response', 'false');
INSERT INTO keycloak.client_attributes VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'saml_force_name_id_format', 'false');
INSERT INTO keycloak.client_attributes VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'saml.client.signature', 'false');
INSERT INTO keycloak.client_attributes VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'tls.client.certificate.bound.access.tokens', 'false');
INSERT INTO keycloak.client_attributes VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'saml.authnstatement', 'false');
INSERT INTO keycloak.client_attributes VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'display.on.consent.screen', 'false');
INSERT INTO keycloak.client_attributes VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'saml.onetimeuse.condition', 'false');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'id.token.as.detached.signature', 'false');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'saml.assertion.signature', 'false');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'saml.force.post.binding', 'false');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'saml.multivalued.roles', 'false');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'saml.encrypt', 'false');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'oauth2.device.authorization.grant.enabled', 'false');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'backchannel.logout.revoke.offline.tokens', 'false');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'saml.server.signature', 'false');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'saml.server.signature.keyinfo.ext', 'false');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'use.refresh.tokens', 'true');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'exclude.session.state.from.auth.response', 'false');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'oidc.ciba.grant.enabled', 'false');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'saml.artifact.binding', 'false');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'backchannel.logout.session.required', 'false');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'client_credentials.use_refresh_token', 'false');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'saml_force_name_id_format', 'false');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'require.pushed.authorization.requests', 'false');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'saml.client.signature', 'false');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'tls.client.certificate.bound.access.tokens', 'false');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'saml.authnstatement', 'false');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'display.on.consent.screen', 'false');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'saml.onetimeuse.condition', 'false');
INSERT INTO keycloak.client_attributes VALUES ('4dd4c360-d5b9-4730-8091-78b394cea334', 'pkce.code.challenge.method', 'S256');
INSERT INTO keycloak.client_attributes VALUES ('235e5d2b-515a-422c-b23c-6d9c3abddfa5', 'post.logout.redirect.uris', '+');
INSERT INTO keycloak.client_attributes VALUES ('26f802c3-b7af-4e78-b785-40493ae2483a', 'post.logout.redirect.uris', '+');
INSERT INTO keycloak.client_attributes VALUES ('01818753-ed45-4903-93e9-8ebffc711cd8', 'post.logout.redirect.uris', '+');
INSERT INTO keycloak.client_attributes VALUES ('605fa94d-21d1-4569-8fa7-6bbb229b19f0', 'post.logout.redirect.uris', '+');
INSERT INTO keycloak.client_attributes VALUES ('4dd4c360-d5b9-4730-8091-78b394cea334', 'post.logout.redirect.uris', '+');
INSERT INTO keycloak.client_attributes VALUES ('e801cbf0-541f-4466-80e1-fcce640df2a8', 'post.logout.redirect.uris', '+');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'post.logout.redirect.uris', '+');
INSERT INTO keycloak.client_attributes VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'post.logout.redirect.uris', '+');
INSERT INTO keycloak.client_attributes VALUES ('01818753-ed45-4903-93e9-8ebffc711cd8', 'client.use.lightweight.access.token.enabled', 'true');
INSERT INTO keycloak.client_attributes VALUES ('bfd838d0-4aef-44ac-8947-978c45bb4f26', 'client.use.lightweight.access.token.enabled', 'true');
INSERT INTO keycloak.client_attributes VALUES ('4dd4c360-d5b9-4730-8091-78b394cea334', 'client.use.lightweight.access.token.enabled', 'true');
INSERT INTO keycloak.client_attributes VALUES ('544076b9-bf22-4731-8d85-2ddc0edbd41e', 'client.use.lightweight.access.token.enabled', 'true');


--
-- TOC entry 4179 (class 0 OID 16447)
-- Dependencies: 226
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.client_auth_flow_bindings VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', '7f4f19c4-2902-4a20-a1a2-1d33f3ac4462', 'browser');
INSERT INTO keycloak.client_auth_flow_bindings VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', '4435715e-0f08-4968-8e51-910b9f4d5510', 'direct_grant');


--
-- TOC entry 4180 (class 0 OID 16450)
-- Dependencies: 227
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4181 (class 0 OID 16453)
-- Dependencies: 228
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4182 (class 0 OID 16456)
-- Dependencies: 229
-- Data for Name: client_scope; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.client_scope VALUES ('440221db-a2d2-46ae-afec-db28e31b82c6', 'offline_access', 'master', 'OpenID Connect built-in scope: offline_access', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('eec3ffac-3981-4e3a-ab1c-b10634335b7b', 'role_list', 'master', 'SAML role list', 'saml');
INSERT INTO keycloak.client_scope VALUES ('64962ee9-4308-44c8-b93d-20f335fb7fe4', 'profile', 'master', 'OpenID Connect built-in scope: profile', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('b5725526-2c78-46cb-9941-ec0445725c4e', 'email', 'master', 'OpenID Connect built-in scope: email', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('8788d929-9c56-44e2-b500-cac7c9cdbbf7', 'address', 'master', 'OpenID Connect built-in scope: address', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('2414f4d3-cfb3-49ae-ad70-7c4388c14f52', 'phone', 'master', 'OpenID Connect built-in scope: phone', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('374759fc-935f-4c93-9bef-57573aafba31', 'roles', 'master', 'OpenID Connect scope for add user roles to the access token', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('e374cda1-44a0-4d7e-a214-e401a11d4673', 'web-origins', 'master', 'OpenID Connect scope for add allowed web origins to the access token', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('e816fcd5-0b78-422e-8fc0-0ea150b1daf0', 'microprofile-jwt', 'master', 'Microprofile - JWT built-in scope', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('bed9e481-a783-4f6c-bd5a-f79f5d189ee6', 'role_list', 'appcket', 'SAML role list', 'saml');
INSERT INTO keycloak.client_scope VALUES ('2b5c02f3-e7a9-4455-a505-9fef19838927', 'roles', 'appcket', 'OpenID Connect scope for add user roles to the access token', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('b2414a14-1f25-4d4b-9162-de66eeb6652d', 'address', 'appcket', 'OpenID Connect built-in scope: address', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('52312b11-3e69-46f2-93f2-b1e168214598', 'web-origins', 'appcket', 'OpenID Connect scope for add allowed web origins to the access token', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('1ddb5c58-3c5b-43bc-ae48-ba8947a6c108', 'offline_access', 'appcket', 'OpenID Connect built-in scope: offline_access', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('63984129-44c9-4bd1-97d1-da0df3407112', 'email', 'appcket', 'OpenID Connect built-in scope: email', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('a15b2f14-004d-47f8-b137-7bca43fc8b30', 'microprofile-jwt', 'appcket', 'Microprofile - JWT built-in scope', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('aee86bba-572b-4335-8f5b-c9969c70cbce', 'profile', 'appcket', 'OpenID Connect built-in scope: profile', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('4709e0fb-184a-4b47-a804-ae1556e53a73', 'phone', 'appcket', 'OpenID Connect built-in scope: phone', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('f2af3385-b007-4e90-b783-54eaa0aac86d', 'acr', 'master', 'OpenID Connect scope for add acr (authentication context class reference) to the token', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('c03824d3-cc18-4529-90cd-968ab5d3653d', 'acr', 'appcket', 'OpenID Connect scope for add acr (authentication context class reference) to the token', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('d43481d5-5c2a-4407-bf8f-ce49bdc5ceff', 'basic', 'master', 'OpenID Connect scope for add all basic claims to the token', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('a8ddb608-a41f-4ff6-bb20-14237bc37572', 'basic', 'appcket', 'OpenID Connect scope for add all basic claims to the token', 'openid-connect');


--
-- TOC entry 4183 (class 0 OID 16461)
-- Dependencies: 230
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.client_scope_attributes VALUES ('440221db-a2d2-46ae-afec-db28e31b82c6', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('440221db-a2d2-46ae-afec-db28e31b82c6', '${offlineAccessScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('eec3ffac-3981-4e3a-ab1c-b10634335b7b', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('eec3ffac-3981-4e3a-ab1c-b10634335b7b', '${samlRoleListScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('64962ee9-4308-44c8-b93d-20f335fb7fe4', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('64962ee9-4308-44c8-b93d-20f335fb7fe4', '${profileScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('64962ee9-4308-44c8-b93d-20f335fb7fe4', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes VALUES ('b5725526-2c78-46cb-9941-ec0445725c4e', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('b5725526-2c78-46cb-9941-ec0445725c4e', '${emailScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('b5725526-2c78-46cb-9941-ec0445725c4e', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes VALUES ('8788d929-9c56-44e2-b500-cac7c9cdbbf7', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('8788d929-9c56-44e2-b500-cac7c9cdbbf7', '${addressScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('8788d929-9c56-44e2-b500-cac7c9cdbbf7', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes VALUES ('2414f4d3-cfb3-49ae-ad70-7c4388c14f52', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('2414f4d3-cfb3-49ae-ad70-7c4388c14f52', '${phoneScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('2414f4d3-cfb3-49ae-ad70-7c4388c14f52', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes VALUES ('374759fc-935f-4c93-9bef-57573aafba31', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('374759fc-935f-4c93-9bef-57573aafba31', '${rolesScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('374759fc-935f-4c93-9bef-57573aafba31', 'false', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes VALUES ('e374cda1-44a0-4d7e-a214-e401a11d4673', 'false', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('e374cda1-44a0-4d7e-a214-e401a11d4673', '', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('e374cda1-44a0-4d7e-a214-e401a11d4673', 'false', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes VALUES ('e816fcd5-0b78-422e-8fc0-0ea150b1daf0', 'false', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('e816fcd5-0b78-422e-8fc0-0ea150b1daf0', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes VALUES ('bed9e481-a783-4f6c-bd5a-f79f5d189ee6', '${samlRoleListScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('bed9e481-a783-4f6c-bd5a-f79f5d189ee6', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('2b5c02f3-e7a9-4455-a505-9fef19838927', 'false', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes VALUES ('2b5c02f3-e7a9-4455-a505-9fef19838927', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('2b5c02f3-e7a9-4455-a505-9fef19838927', '${rolesScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('b2414a14-1f25-4d4b-9162-de66eeb6652d', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes VALUES ('b2414a14-1f25-4d4b-9162-de66eeb6652d', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('b2414a14-1f25-4d4b-9162-de66eeb6652d', '${addressScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('52312b11-3e69-46f2-93f2-b1e168214598', 'false', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes VALUES ('52312b11-3e69-46f2-93f2-b1e168214598', 'false', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('52312b11-3e69-46f2-93f2-b1e168214598', '', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('1ddb5c58-3c5b-43bc-ae48-ba8947a6c108', '${offlineAccessScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('1ddb5c58-3c5b-43bc-ae48-ba8947a6c108', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('63984129-44c9-4bd1-97d1-da0df3407112', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes VALUES ('63984129-44c9-4bd1-97d1-da0df3407112', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('63984129-44c9-4bd1-97d1-da0df3407112', '${emailScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('a15b2f14-004d-47f8-b137-7bca43fc8b30', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes VALUES ('a15b2f14-004d-47f8-b137-7bca43fc8b30', 'false', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('aee86bba-572b-4335-8f5b-c9969c70cbce', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes VALUES ('aee86bba-572b-4335-8f5b-c9969c70cbce', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('aee86bba-572b-4335-8f5b-c9969c70cbce', '${profileScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('4709e0fb-184a-4b47-a804-ae1556e53a73', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes VALUES ('4709e0fb-184a-4b47-a804-ae1556e53a73', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('4709e0fb-184a-4b47-a804-ae1556e53a73', '${phoneScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('f2af3385-b007-4e90-b783-54eaa0aac86d', 'false', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('f2af3385-b007-4e90-b783-54eaa0aac86d', 'false', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes VALUES ('c03824d3-cc18-4529-90cd-968ab5d3653d', 'false', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('c03824d3-cc18-4529-90cd-968ab5d3653d', 'false', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes VALUES ('d43481d5-5c2a-4407-bf8f-ce49bdc5ceff', 'false', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('d43481d5-5c2a-4407-bf8f-ce49bdc5ceff', 'false', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes VALUES ('a8ddb608-a41f-4ff6-bb20-14237bc37572', 'false', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('a8ddb608-a41f-4ff6-bb20-14237bc37572', 'false', 'include.in.token.scope');


--
-- TOC entry 4184 (class 0 OID 16466)
-- Dependencies: 231
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.client_scope_client VALUES ('605fa94d-21d1-4569-8fa7-6bbb229b19f0', '374759fc-935f-4c93-9bef-57573aafba31', true);
INSERT INTO keycloak.client_scope_client VALUES ('605fa94d-21d1-4569-8fa7-6bbb229b19f0', 'b5725526-2c78-46cb-9941-ec0445725c4e', true);
INSERT INTO keycloak.client_scope_client VALUES ('605fa94d-21d1-4569-8fa7-6bbb229b19f0', 'e374cda1-44a0-4d7e-a214-e401a11d4673', true);
INSERT INTO keycloak.client_scope_client VALUES ('605fa94d-21d1-4569-8fa7-6bbb229b19f0', '64962ee9-4308-44c8-b93d-20f335fb7fe4', true);
INSERT INTO keycloak.client_scope_client VALUES ('605fa94d-21d1-4569-8fa7-6bbb229b19f0', 'e816fcd5-0b78-422e-8fc0-0ea150b1daf0', false);
INSERT INTO keycloak.client_scope_client VALUES ('605fa94d-21d1-4569-8fa7-6bbb229b19f0', '8788d929-9c56-44e2-b500-cac7c9cdbbf7', false);
INSERT INTO keycloak.client_scope_client VALUES ('605fa94d-21d1-4569-8fa7-6bbb229b19f0', '440221db-a2d2-46ae-afec-db28e31b82c6', false);
INSERT INTO keycloak.client_scope_client VALUES ('605fa94d-21d1-4569-8fa7-6bbb229b19f0', '2414f4d3-cfb3-49ae-ad70-7c4388c14f52', false);
INSERT INTO keycloak.client_scope_client VALUES ('235e5d2b-515a-422c-b23c-6d9c3abddfa5', '374759fc-935f-4c93-9bef-57573aafba31', true);
INSERT INTO keycloak.client_scope_client VALUES ('235e5d2b-515a-422c-b23c-6d9c3abddfa5', 'b5725526-2c78-46cb-9941-ec0445725c4e', true);
INSERT INTO keycloak.client_scope_client VALUES ('235e5d2b-515a-422c-b23c-6d9c3abddfa5', 'e374cda1-44a0-4d7e-a214-e401a11d4673', true);
INSERT INTO keycloak.client_scope_client VALUES ('235e5d2b-515a-422c-b23c-6d9c3abddfa5', '64962ee9-4308-44c8-b93d-20f335fb7fe4', true);
INSERT INTO keycloak.client_scope_client VALUES ('235e5d2b-515a-422c-b23c-6d9c3abddfa5', 'e816fcd5-0b78-422e-8fc0-0ea150b1daf0', false);
INSERT INTO keycloak.client_scope_client VALUES ('235e5d2b-515a-422c-b23c-6d9c3abddfa5', '8788d929-9c56-44e2-b500-cac7c9cdbbf7', false);
INSERT INTO keycloak.client_scope_client VALUES ('235e5d2b-515a-422c-b23c-6d9c3abddfa5', '440221db-a2d2-46ae-afec-db28e31b82c6', false);
INSERT INTO keycloak.client_scope_client VALUES ('235e5d2b-515a-422c-b23c-6d9c3abddfa5', '2414f4d3-cfb3-49ae-ad70-7c4388c14f52', false);
INSERT INTO keycloak.client_scope_client VALUES ('bfd838d0-4aef-44ac-8947-978c45bb4f26', '374759fc-935f-4c93-9bef-57573aafba31', true);
INSERT INTO keycloak.client_scope_client VALUES ('bfd838d0-4aef-44ac-8947-978c45bb4f26', 'b5725526-2c78-46cb-9941-ec0445725c4e', true);
INSERT INTO keycloak.client_scope_client VALUES ('bfd838d0-4aef-44ac-8947-978c45bb4f26', 'e374cda1-44a0-4d7e-a214-e401a11d4673', true);
INSERT INTO keycloak.client_scope_client VALUES ('bfd838d0-4aef-44ac-8947-978c45bb4f26', '64962ee9-4308-44c8-b93d-20f335fb7fe4', true);
INSERT INTO keycloak.client_scope_client VALUES ('bfd838d0-4aef-44ac-8947-978c45bb4f26', 'e816fcd5-0b78-422e-8fc0-0ea150b1daf0', false);
INSERT INTO keycloak.client_scope_client VALUES ('bfd838d0-4aef-44ac-8947-978c45bb4f26', '8788d929-9c56-44e2-b500-cac7c9cdbbf7', false);
INSERT INTO keycloak.client_scope_client VALUES ('bfd838d0-4aef-44ac-8947-978c45bb4f26', '440221db-a2d2-46ae-afec-db28e31b82c6', false);
INSERT INTO keycloak.client_scope_client VALUES ('bfd838d0-4aef-44ac-8947-978c45bb4f26', '2414f4d3-cfb3-49ae-ad70-7c4388c14f52', false);
INSERT INTO keycloak.client_scope_client VALUES ('6b0c8bef-0c61-487f-ac1d-dc77f3f97278', '374759fc-935f-4c93-9bef-57573aafba31', true);
INSERT INTO keycloak.client_scope_client VALUES ('6b0c8bef-0c61-487f-ac1d-dc77f3f97278', 'b5725526-2c78-46cb-9941-ec0445725c4e', true);
INSERT INTO keycloak.client_scope_client VALUES ('6b0c8bef-0c61-487f-ac1d-dc77f3f97278', 'e374cda1-44a0-4d7e-a214-e401a11d4673', true);
INSERT INTO keycloak.client_scope_client VALUES ('6b0c8bef-0c61-487f-ac1d-dc77f3f97278', '64962ee9-4308-44c8-b93d-20f335fb7fe4', true);
INSERT INTO keycloak.client_scope_client VALUES ('6b0c8bef-0c61-487f-ac1d-dc77f3f97278', 'e816fcd5-0b78-422e-8fc0-0ea150b1daf0', false);
INSERT INTO keycloak.client_scope_client VALUES ('6b0c8bef-0c61-487f-ac1d-dc77f3f97278', '8788d929-9c56-44e2-b500-cac7c9cdbbf7', false);
INSERT INTO keycloak.client_scope_client VALUES ('6b0c8bef-0c61-487f-ac1d-dc77f3f97278', '440221db-a2d2-46ae-afec-db28e31b82c6', false);
INSERT INTO keycloak.client_scope_client VALUES ('6b0c8bef-0c61-487f-ac1d-dc77f3f97278', '2414f4d3-cfb3-49ae-ad70-7c4388c14f52', false);
INSERT INTO keycloak.client_scope_client VALUES ('aa546da1-d04d-4783-8c48-085c049d6f90', '374759fc-935f-4c93-9bef-57573aafba31', true);
INSERT INTO keycloak.client_scope_client VALUES ('aa546da1-d04d-4783-8c48-085c049d6f90', 'b5725526-2c78-46cb-9941-ec0445725c4e', true);
INSERT INTO keycloak.client_scope_client VALUES ('aa546da1-d04d-4783-8c48-085c049d6f90', 'e374cda1-44a0-4d7e-a214-e401a11d4673', true);
INSERT INTO keycloak.client_scope_client VALUES ('aa546da1-d04d-4783-8c48-085c049d6f90', '64962ee9-4308-44c8-b93d-20f335fb7fe4', true);
INSERT INTO keycloak.client_scope_client VALUES ('aa546da1-d04d-4783-8c48-085c049d6f90', 'e816fcd5-0b78-422e-8fc0-0ea150b1daf0', false);
INSERT INTO keycloak.client_scope_client VALUES ('aa546da1-d04d-4783-8c48-085c049d6f90', '8788d929-9c56-44e2-b500-cac7c9cdbbf7', false);
INSERT INTO keycloak.client_scope_client VALUES ('aa546da1-d04d-4783-8c48-085c049d6f90', '440221db-a2d2-46ae-afec-db28e31b82c6', false);
INSERT INTO keycloak.client_scope_client VALUES ('aa546da1-d04d-4783-8c48-085c049d6f90', '2414f4d3-cfb3-49ae-ad70-7c4388c14f52', false);
INSERT INTO keycloak.client_scope_client VALUES ('01818753-ed45-4903-93e9-8ebffc711cd8', '374759fc-935f-4c93-9bef-57573aafba31', true);
INSERT INTO keycloak.client_scope_client VALUES ('01818753-ed45-4903-93e9-8ebffc711cd8', 'b5725526-2c78-46cb-9941-ec0445725c4e', true);
INSERT INTO keycloak.client_scope_client VALUES ('01818753-ed45-4903-93e9-8ebffc711cd8', 'e374cda1-44a0-4d7e-a214-e401a11d4673', true);
INSERT INTO keycloak.client_scope_client VALUES ('01818753-ed45-4903-93e9-8ebffc711cd8', '64962ee9-4308-44c8-b93d-20f335fb7fe4', true);
INSERT INTO keycloak.client_scope_client VALUES ('01818753-ed45-4903-93e9-8ebffc711cd8', 'e816fcd5-0b78-422e-8fc0-0ea150b1daf0', false);
INSERT INTO keycloak.client_scope_client VALUES ('01818753-ed45-4903-93e9-8ebffc711cd8', '8788d929-9c56-44e2-b500-cac7c9cdbbf7', false);
INSERT INTO keycloak.client_scope_client VALUES ('01818753-ed45-4903-93e9-8ebffc711cd8', '440221db-a2d2-46ae-afec-db28e31b82c6', false);
INSERT INTO keycloak.client_scope_client VALUES ('01818753-ed45-4903-93e9-8ebffc711cd8', '2414f4d3-cfb3-49ae-ad70-7c4388c14f52', false);
INSERT INTO keycloak.client_scope_client VALUES ('e801cbf0-541f-4466-80e1-fcce640df2a8', '52312b11-3e69-46f2-93f2-b1e168214598', true);
INSERT INTO keycloak.client_scope_client VALUES ('e801cbf0-541f-4466-80e1-fcce640df2a8', '2b5c02f3-e7a9-4455-a505-9fef19838927', true);
INSERT INTO keycloak.client_scope_client VALUES ('e801cbf0-541f-4466-80e1-fcce640df2a8', 'aee86bba-572b-4335-8f5b-c9969c70cbce', true);
INSERT INTO keycloak.client_scope_client VALUES ('e801cbf0-541f-4466-80e1-fcce640df2a8', '63984129-44c9-4bd1-97d1-da0df3407112', true);
INSERT INTO keycloak.client_scope_client VALUES ('e801cbf0-541f-4466-80e1-fcce640df2a8', 'b2414a14-1f25-4d4b-9162-de66eeb6652d', false);
INSERT INTO keycloak.client_scope_client VALUES ('e801cbf0-541f-4466-80e1-fcce640df2a8', '4709e0fb-184a-4b47-a804-ae1556e53a73', false);
INSERT INTO keycloak.client_scope_client VALUES ('e801cbf0-541f-4466-80e1-fcce640df2a8', '1ddb5c58-3c5b-43bc-ae48-ba8947a6c108', false);
INSERT INTO keycloak.client_scope_client VALUES ('e801cbf0-541f-4466-80e1-fcce640df2a8', 'a15b2f14-004d-47f8-b137-7bca43fc8b30', false);
INSERT INTO keycloak.client_scope_client VALUES ('26f802c3-b7af-4e78-b785-40493ae2483a', '52312b11-3e69-46f2-93f2-b1e168214598', true);
INSERT INTO keycloak.client_scope_client VALUES ('26f802c3-b7af-4e78-b785-40493ae2483a', '2b5c02f3-e7a9-4455-a505-9fef19838927', true);
INSERT INTO keycloak.client_scope_client VALUES ('26f802c3-b7af-4e78-b785-40493ae2483a', 'aee86bba-572b-4335-8f5b-c9969c70cbce', true);
INSERT INTO keycloak.client_scope_client VALUES ('26f802c3-b7af-4e78-b785-40493ae2483a', '63984129-44c9-4bd1-97d1-da0df3407112', true);
INSERT INTO keycloak.client_scope_client VALUES ('26f802c3-b7af-4e78-b785-40493ae2483a', 'b2414a14-1f25-4d4b-9162-de66eeb6652d', false);
INSERT INTO keycloak.client_scope_client VALUES ('26f802c3-b7af-4e78-b785-40493ae2483a', '4709e0fb-184a-4b47-a804-ae1556e53a73', false);
INSERT INTO keycloak.client_scope_client VALUES ('26f802c3-b7af-4e78-b785-40493ae2483a', '1ddb5c58-3c5b-43bc-ae48-ba8947a6c108', false);
INSERT INTO keycloak.client_scope_client VALUES ('26f802c3-b7af-4e78-b785-40493ae2483a', 'a15b2f14-004d-47f8-b137-7bca43fc8b30', false);
INSERT INTO keycloak.client_scope_client VALUES ('544076b9-bf22-4731-8d85-2ddc0edbd41e', '52312b11-3e69-46f2-93f2-b1e168214598', true);
INSERT INTO keycloak.client_scope_client VALUES ('544076b9-bf22-4731-8d85-2ddc0edbd41e', '2b5c02f3-e7a9-4455-a505-9fef19838927', true);
INSERT INTO keycloak.client_scope_client VALUES ('544076b9-bf22-4731-8d85-2ddc0edbd41e', 'aee86bba-572b-4335-8f5b-c9969c70cbce', true);
INSERT INTO keycloak.client_scope_client VALUES ('544076b9-bf22-4731-8d85-2ddc0edbd41e', '63984129-44c9-4bd1-97d1-da0df3407112', true);
INSERT INTO keycloak.client_scope_client VALUES ('544076b9-bf22-4731-8d85-2ddc0edbd41e', 'b2414a14-1f25-4d4b-9162-de66eeb6652d', false);
INSERT INTO keycloak.client_scope_client VALUES ('544076b9-bf22-4731-8d85-2ddc0edbd41e', '4709e0fb-184a-4b47-a804-ae1556e53a73', false);
INSERT INTO keycloak.client_scope_client VALUES ('544076b9-bf22-4731-8d85-2ddc0edbd41e', '1ddb5c58-3c5b-43bc-ae48-ba8947a6c108', false);
INSERT INTO keycloak.client_scope_client VALUES ('544076b9-bf22-4731-8d85-2ddc0edbd41e', 'a15b2f14-004d-47f8-b137-7bca43fc8b30', false);
INSERT INTO keycloak.client_scope_client VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', '52312b11-3e69-46f2-93f2-b1e168214598', true);
INSERT INTO keycloak.client_scope_client VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', '2b5c02f3-e7a9-4455-a505-9fef19838927', true);
INSERT INTO keycloak.client_scope_client VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'aee86bba-572b-4335-8f5b-c9969c70cbce', true);
INSERT INTO keycloak.client_scope_client VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', '63984129-44c9-4bd1-97d1-da0df3407112', true);
INSERT INTO keycloak.client_scope_client VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'b2414a14-1f25-4d4b-9162-de66eeb6652d', false);
INSERT INTO keycloak.client_scope_client VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', '4709e0fb-184a-4b47-a804-ae1556e53a73', false);
INSERT INTO keycloak.client_scope_client VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', '1ddb5c58-3c5b-43bc-ae48-ba8947a6c108', false);
INSERT INTO keycloak.client_scope_client VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'a15b2f14-004d-47f8-b137-7bca43fc8b30', false);
INSERT INTO keycloak.client_scope_client VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', '52312b11-3e69-46f2-93f2-b1e168214598', true);
INSERT INTO keycloak.client_scope_client VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', '2b5c02f3-e7a9-4455-a505-9fef19838927', true);
INSERT INTO keycloak.client_scope_client VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'aee86bba-572b-4335-8f5b-c9969c70cbce', true);
INSERT INTO keycloak.client_scope_client VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', '63984129-44c9-4bd1-97d1-da0df3407112', true);
INSERT INTO keycloak.client_scope_client VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'b2414a14-1f25-4d4b-9162-de66eeb6652d', false);
INSERT INTO keycloak.client_scope_client VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', '4709e0fb-184a-4b47-a804-ae1556e53a73', false);
INSERT INTO keycloak.client_scope_client VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', '1ddb5c58-3c5b-43bc-ae48-ba8947a6c108', false);
INSERT INTO keycloak.client_scope_client VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'a15b2f14-004d-47f8-b137-7bca43fc8b30', false);
INSERT INTO keycloak.client_scope_client VALUES ('70da96f3-abee-4ade-a7f3-d22e04437a0a', '52312b11-3e69-46f2-93f2-b1e168214598', true);
INSERT INTO keycloak.client_scope_client VALUES ('70da96f3-abee-4ade-a7f3-d22e04437a0a', '2b5c02f3-e7a9-4455-a505-9fef19838927', true);
INSERT INTO keycloak.client_scope_client VALUES ('70da96f3-abee-4ade-a7f3-d22e04437a0a', 'aee86bba-572b-4335-8f5b-c9969c70cbce', true);
INSERT INTO keycloak.client_scope_client VALUES ('70da96f3-abee-4ade-a7f3-d22e04437a0a', '63984129-44c9-4bd1-97d1-da0df3407112', true);
INSERT INTO keycloak.client_scope_client VALUES ('70da96f3-abee-4ade-a7f3-d22e04437a0a', 'b2414a14-1f25-4d4b-9162-de66eeb6652d', false);
INSERT INTO keycloak.client_scope_client VALUES ('70da96f3-abee-4ade-a7f3-d22e04437a0a', '4709e0fb-184a-4b47-a804-ae1556e53a73', false);
INSERT INTO keycloak.client_scope_client VALUES ('70da96f3-abee-4ade-a7f3-d22e04437a0a', '1ddb5c58-3c5b-43bc-ae48-ba8947a6c108', false);
INSERT INTO keycloak.client_scope_client VALUES ('70da96f3-abee-4ade-a7f3-d22e04437a0a', 'a15b2f14-004d-47f8-b137-7bca43fc8b30', false);
INSERT INTO keycloak.client_scope_client VALUES ('5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', '52312b11-3e69-46f2-93f2-b1e168214598', true);
INSERT INTO keycloak.client_scope_client VALUES ('5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', '2b5c02f3-e7a9-4455-a505-9fef19838927', true);
INSERT INTO keycloak.client_scope_client VALUES ('5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', 'aee86bba-572b-4335-8f5b-c9969c70cbce', true);
INSERT INTO keycloak.client_scope_client VALUES ('5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', '63984129-44c9-4bd1-97d1-da0df3407112', true);
INSERT INTO keycloak.client_scope_client VALUES ('5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', 'b2414a14-1f25-4d4b-9162-de66eeb6652d', false);
INSERT INTO keycloak.client_scope_client VALUES ('5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', '4709e0fb-184a-4b47-a804-ae1556e53a73', false);
INSERT INTO keycloak.client_scope_client VALUES ('5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', '1ddb5c58-3c5b-43bc-ae48-ba8947a6c108', false);
INSERT INTO keycloak.client_scope_client VALUES ('5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', 'a15b2f14-004d-47f8-b137-7bca43fc8b30', false);
INSERT INTO keycloak.client_scope_client VALUES ('4dd4c360-d5b9-4730-8091-78b394cea334', '52312b11-3e69-46f2-93f2-b1e168214598', true);
INSERT INTO keycloak.client_scope_client VALUES ('4dd4c360-d5b9-4730-8091-78b394cea334', '2b5c02f3-e7a9-4455-a505-9fef19838927', true);
INSERT INTO keycloak.client_scope_client VALUES ('4dd4c360-d5b9-4730-8091-78b394cea334', 'aee86bba-572b-4335-8f5b-c9969c70cbce', true);
INSERT INTO keycloak.client_scope_client VALUES ('4dd4c360-d5b9-4730-8091-78b394cea334', '63984129-44c9-4bd1-97d1-da0df3407112', true);
INSERT INTO keycloak.client_scope_client VALUES ('4dd4c360-d5b9-4730-8091-78b394cea334', 'b2414a14-1f25-4d4b-9162-de66eeb6652d', false);
INSERT INTO keycloak.client_scope_client VALUES ('4dd4c360-d5b9-4730-8091-78b394cea334', '4709e0fb-184a-4b47-a804-ae1556e53a73', false);
INSERT INTO keycloak.client_scope_client VALUES ('4dd4c360-d5b9-4730-8091-78b394cea334', '1ddb5c58-3c5b-43bc-ae48-ba8947a6c108', false);
INSERT INTO keycloak.client_scope_client VALUES ('4dd4c360-d5b9-4730-8091-78b394cea334', 'a15b2f14-004d-47f8-b137-7bca43fc8b30', false);
INSERT INTO keycloak.client_scope_client VALUES ('605fa94d-21d1-4569-8fa7-6bbb229b19f0', 'd43481d5-5c2a-4407-bf8f-ce49bdc5ceff', true);
INSERT INTO keycloak.client_scope_client VALUES ('235e5d2b-515a-422c-b23c-6d9c3abddfa5', 'd43481d5-5c2a-4407-bf8f-ce49bdc5ceff', true);
INSERT INTO keycloak.client_scope_client VALUES ('01818753-ed45-4903-93e9-8ebffc711cd8', 'd43481d5-5c2a-4407-bf8f-ce49bdc5ceff', true);
INSERT INTO keycloak.client_scope_client VALUES ('bfd838d0-4aef-44ac-8947-978c45bb4f26', 'd43481d5-5c2a-4407-bf8f-ce49bdc5ceff', true);
INSERT INTO keycloak.client_scope_client VALUES ('e801cbf0-541f-4466-80e1-fcce640df2a8', 'a8ddb608-a41f-4ff6-bb20-14237bc37572', true);
INSERT INTO keycloak.client_scope_client VALUES ('26f802c3-b7af-4e78-b785-40493ae2483a', 'a8ddb608-a41f-4ff6-bb20-14237bc37572', true);
INSERT INTO keycloak.client_scope_client VALUES ('544076b9-bf22-4731-8d85-2ddc0edbd41e', 'a8ddb608-a41f-4ff6-bb20-14237bc37572', true);
INSERT INTO keycloak.client_scope_client VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'a8ddb608-a41f-4ff6-bb20-14237bc37572', true);
INSERT INTO keycloak.client_scope_client VALUES ('70da96f3-abee-4ade-a7f3-d22e04437a0a', 'a8ddb608-a41f-4ff6-bb20-14237bc37572', true);
INSERT INTO keycloak.client_scope_client VALUES ('4dd4c360-d5b9-4730-8091-78b394cea334', 'a8ddb608-a41f-4ff6-bb20-14237bc37572', true);
INSERT INTO keycloak.client_scope_client VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'a8ddb608-a41f-4ff6-bb20-14237bc37572', true);


--
-- TOC entry 4185 (class 0 OID 16472)
-- Dependencies: 232
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.client_scope_role_mapping VALUES ('440221db-a2d2-46ae-afec-db28e31b82c6', '785200ab-20dc-47c4-bffa-af0007c06dc9');
INSERT INTO keycloak.client_scope_role_mapping VALUES ('1ddb5c58-3c5b-43bc-ae48-ba8947a6c108', '241f95cd-d0a8-4b5e-b7d3-657f078175bb');


--
-- TOC entry 4186 (class 0 OID 16499)
-- Dependencies: 233
-- Data for Name: component; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.component VALUES ('9cb95e77-16a3-4a15-ae01-80ee03c0c6e6', 'Trusted Hosts', 'master', 'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO keycloak.component VALUES ('b9e9aee2-f356-46bc-9c4c-3a44555188c6', 'Consent Required', 'master', 'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO keycloak.component VALUES ('1a42053f-3790-4d2d-b270-b62ecebc13ac', 'Full Scope Disabled', 'master', 'scope', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO keycloak.component VALUES ('d71969bd-93fc-418a-804a-55ab814bc456', 'Max Clients Limit', 'master', 'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO keycloak.component VALUES ('7d98d77f-8e37-40c0-bb43-faa1b5e2a178', 'Allowed Protocol Mapper Types', 'master', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO keycloak.component VALUES ('db07b8e7-5827-497d-b9bb-10d93c1481f3', 'Allowed Client Scopes', 'master', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO keycloak.component VALUES ('c2d75626-cb73-4661-9068-cca43853e776', 'Allowed Protocol Mapper Types', 'master', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'authenticated');
INSERT INTO keycloak.component VALUES ('8b0fb5d7-5c37-4c8f-b243-28a6d7591734', 'Allowed Client Scopes', 'master', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'authenticated');
INSERT INTO keycloak.component VALUES ('ca854d80-a5e5-44cf-8e2f-5dab3e2be5fd', 'rsa-generated', 'master', 'rsa-generated', 'org.keycloak.keys.KeyProvider', 'master', NULL);
INSERT INTO keycloak.component VALUES ('ffb778b2-5918-410b-a935-7920afe037bf', 'rsa-enc-generated', 'master', 'rsa-enc-generated', 'org.keycloak.keys.KeyProvider', 'master', NULL);
INSERT INTO keycloak.component VALUES ('d607301a-f3e2-4466-af91-2c7e61b85be4', 'hmac-generated', 'master', 'hmac-generated', 'org.keycloak.keys.KeyProvider', 'master', NULL);
INSERT INTO keycloak.component VALUES ('519005ab-1cf5-43c7-a359-10aaca8f4dce', 'aes-generated', 'master', 'aes-generated', 'org.keycloak.keys.KeyProvider', 'master', NULL);
INSERT INTO keycloak.component VALUES ('9d162216-7427-47be-8a91-2114ed2be8ce', 'Full Scope Disabled', 'appcket', 'scope', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'appcket', 'anonymous');
INSERT INTO keycloak.component VALUES ('671f0403-0277-438b-a5fc-c120cebbde3a', 'Allowed Client Scopes', 'appcket', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'appcket', 'anonymous');
INSERT INTO keycloak.component VALUES ('e9c854d5-dea2-4325-a960-8dfed513e4fd', 'Max Clients Limit', 'appcket', 'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'appcket', 'anonymous');
INSERT INTO keycloak.component VALUES ('9465ec8f-999e-487d-8244-d3727e8d66a2', 'Allowed Protocol Mapper Types', 'appcket', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'appcket', 'authenticated');
INSERT INTO keycloak.component VALUES ('4b1d8e10-0855-424a-bf28-20c71714157c', 'Trusted Hosts', 'appcket', 'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'appcket', 'anonymous');
INSERT INTO keycloak.component VALUES ('1de94ce5-d4ce-4f1b-a20d-3ac17113b2c9', 'Allowed Protocol Mapper Types', 'appcket', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'appcket', 'anonymous');
INSERT INTO keycloak.component VALUES ('0926bc49-92db-4bdb-a535-d257e43d2307', 'Allowed Client Scopes', 'appcket', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'appcket', 'authenticated');
INSERT INTO keycloak.component VALUES ('86ce733f-bf1b-4000-9dad-3749a613cf21', 'Consent Required', 'appcket', 'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'appcket', 'anonymous');
INSERT INTO keycloak.component VALUES ('d121dddd-c8d1-422f-8048-aab3bfb3555d', 'rsa-generated', 'appcket', 'rsa-generated', 'org.keycloak.keys.KeyProvider', 'appcket', NULL);
INSERT INTO keycloak.component VALUES ('7ec14649-b2ce-47b1-a10a-064b6903c573', 'hmac-generated', 'appcket', 'hmac-generated', 'org.keycloak.keys.KeyProvider', 'appcket', NULL);
INSERT INTO keycloak.component VALUES ('dc5145c3-7f57-40ac-a57b-90d37eccb35e', 'aes-generated', 'appcket', 'aes-generated', 'org.keycloak.keys.KeyProvider', 'appcket', NULL);
INSERT INTO keycloak.component VALUES ('dd37419c-ca65-4c17-8881-7e2d793d9392', NULL, 'master', 'declarative-user-profile', 'org.keycloak.userprofile.UserProfileProvider', 'master', NULL);
INSERT INTO keycloak.component VALUES ('95cf4402-b463-45f1-8257-fe39a8f0b83a', 'hmac-generated-hs512', 'master', 'hmac-generated', 'org.keycloak.keys.KeyProvider', 'master', NULL);
INSERT INTO keycloak.component VALUES ('4646ebf8-b5b7-4a8d-b40e-0cfb15f04f46', NULL, 'appcket', 'declarative-user-profile', 'org.keycloak.userprofile.UserProfileProvider', 'appcket', NULL);
INSERT INTO keycloak.component VALUES ('2615902d-b72c-4452-9e40-98717da107c2', 'hmac-generated-hs512', 'appcket', 'hmac-generated', 'org.keycloak.keys.KeyProvider', 'appcket', NULL);


--
-- TOC entry 4187 (class 0 OID 16504)
-- Dependencies: 234
-- Data for Name: component_config; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.component_config VALUES ('437d9fca-a804-4b49-b9ab-8440a7d18445', 'db07b8e7-5827-497d-b9bb-10d93c1481f3', 'allow-default-scopes', 'true');
INSERT INTO keycloak.component_config VALUES ('45564945-34a1-4ab7-9e26-07e1755baf77', '8b0fb5d7-5c37-4c8f-b243-28a6d7591734', 'allow-default-scopes', 'true');
INSERT INTO keycloak.component_config VALUES ('c2c45f41-79ef-4657-815e-046d687f5c47', 'd71969bd-93fc-418a-804a-55ab814bc456', 'max-clients', '200');
INSERT INTO keycloak.component_config VALUES ('85d9ad67-c059-4351-9d76-dda9f28dc8fe', '9cb95e77-16a3-4a15-ae01-80ee03c0c6e6', 'host-sending-registration-request-must-match', 'true');
INSERT INTO keycloak.component_config VALUES ('3c77a74c-74d7-4ef9-bde7-7e410aaa4204', '9cb95e77-16a3-4a15-ae01-80ee03c0c6e6', 'client-uris-must-match', 'true');
INSERT INTO keycloak.component_config VALUES ('929d8164-6f98-446d-a797-4c72f52e0c59', 'c2d75626-cb73-4661-9068-cca43853e776', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO keycloak.component_config VALUES ('dc047de4-a438-4632-adca-bfc8f8de7930', 'c2d75626-cb73-4661-9068-cca43853e776', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO keycloak.component_config VALUES ('ca834ca0-5f4a-4c91-bb72-7b51a326e49c', 'c2d75626-cb73-4661-9068-cca43853e776', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO keycloak.component_config VALUES ('25f9f057-2e14-43db-9af1-5ee55776833e', 'c2d75626-cb73-4661-9068-cca43853e776', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO keycloak.component_config VALUES ('cf9fec84-63b5-413c-b1f8-cf9d9507da19', 'c2d75626-cb73-4661-9068-cca43853e776', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO keycloak.component_config VALUES ('94360166-f6e5-442b-8c6a-5913c25c9ec2', 'c2d75626-cb73-4661-9068-cca43853e776', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO keycloak.component_config VALUES ('d9e1ebcb-334d-4eaa-978a-15aeda019868', 'c2d75626-cb73-4661-9068-cca43853e776', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO keycloak.component_config VALUES ('c0d7a310-416f-4730-97c5-c28e4ddaa201', 'c2d75626-cb73-4661-9068-cca43853e776', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO keycloak.component_config VALUES ('85979ba2-e5cb-444f-a644-76ab9fa1e06f', '7d98d77f-8e37-40c0-bb43-faa1b5e2a178', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO keycloak.component_config VALUES ('f90e18e6-01e5-4f84-b3be-de9111cb7f56', '7d98d77f-8e37-40c0-bb43-faa1b5e2a178', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO keycloak.component_config VALUES ('53826907-6974-4fe0-b05e-cd29dae38d90', '7d98d77f-8e37-40c0-bb43-faa1b5e2a178', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO keycloak.component_config VALUES ('46c8d00a-7fbb-40f1-b2ed-65e695adf5f2', '7d98d77f-8e37-40c0-bb43-faa1b5e2a178', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO keycloak.component_config VALUES ('801bbef8-10cc-4b5e-8b10-cc63184a837c', '7d98d77f-8e37-40c0-bb43-faa1b5e2a178', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO keycloak.component_config VALUES ('05d94850-d8c3-4abe-9bcc-fe5a60a4a5e9', '7d98d77f-8e37-40c0-bb43-faa1b5e2a178', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO keycloak.component_config VALUES ('45dd9cb2-fc42-4d59-8782-b773221daccc', '7d98d77f-8e37-40c0-bb43-faa1b5e2a178', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO keycloak.component_config VALUES ('ca3fbbd2-ad4a-4d44-b31a-2f8278a0bfac', '7d98d77f-8e37-40c0-bb43-faa1b5e2a178', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO keycloak.component_config VALUES ('af6a74d8-6f91-46e0-ad6c-b3f91b909f10', 'ca854d80-a5e5-44cf-8e2f-5dab3e2be5fd', 'certificate', 'MIICmzCCAYMCBgF/FPhLPzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIwMjIwMDIyOTUwWhcNMzIwMjIwMDIzMTMwWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCLbPXaECJtE+Ip2oEvnV2YSz88nUVRI4G7x0v7Ji7oLtTAGDPN8vP+dOXIxQL57Nidrx9czMV1TYZ6Yk5mKWzjysCB/0acD/5DzEfDnj9/CG/2lM1K6qnBccRqSQPgE2QHaXjbIfGKxuji0tddY4pC/i7ZV1O6m8uEjriluTAoK3nJ0JLawMDbDIVA2gxnfe7jIN+8Mq8C4Dc8asq1pCyffwgYg5WUDg+CfiH6+hIObaZYWhXI7WMg641UMltrgD8zA50JlYQ0GL/kdYD3LgjMeYXs+xY/VpM6b+wFNx8aUMIC7RhwXWDmuXOIcuAwZ9upVsVo88RAwsXizknCoL21AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAD9ZvAPqTO1khicDI1g3Kx78jl1D/r2P7bnIEe3+sCyIEzzMs6gkjjUOFZ3oXGPj1AP1cEzV6Bn+8SoE1X68luEncMaWNfVv1fjose+d0Np6xNKMkC/xhPqjenm7nVkbcVfQFPho+xDU/U4kIKGFYM0i+zRySV1kDcwOriOSC0uAK2jKSqBbz0pD2TBQ7fbxxk5lIxSbvD6pkoIMdwu4IT0GnrfaQ9s8S/H7BOpS+80CBJGZIfhcarj9wdiT34qw76wMDLtCr1FQl3relcbPkf60rm14L016WDVpgqm1oNuPsZEeSwq4TlfoCBPKM0u87VEF0h4W5GVCeltv1Lga9EY=');
INSERT INTO keycloak.component_config VALUES ('fe498abb-e311-4428-9ca5-9847c3ebc4c3', 'ca854d80-a5e5-44cf-8e2f-5dab3e2be5fd', 'priority', '100');
INSERT INTO keycloak.component_config VALUES ('f90be08a-a349-4b1b-bf05-2f3986807e23', '671f0403-0277-438b-a5fc-c120cebbde3a', 'allow-default-scopes', 'true');
INSERT INTO keycloak.component_config VALUES ('942f980d-a147-4ce8-ba8e-d0cd97737d3e', 'd121dddd-c8d1-422f-8048-aab3bfb3555d', 'priority', '100');
INSERT INTO keycloak.component_config VALUES ('53e71147-59d3-42ae-adca-77377ad6009e', '1de94ce5-d4ce-4f1b-a20d-3ac17113b2c9', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO keycloak.component_config VALUES ('52f18ac7-675f-4a2d-a850-114ab4a2fb52', '1de94ce5-d4ce-4f1b-a20d-3ac17113b2c9', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO keycloak.component_config VALUES ('919f3a00-8300-48f1-b870-5ff1bf316ec7', '1de94ce5-d4ce-4f1b-a20d-3ac17113b2c9', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO keycloak.component_config VALUES ('f966f914-dc38-442f-b061-d7a045fb2366', '1de94ce5-d4ce-4f1b-a20d-3ac17113b2c9', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO keycloak.component_config VALUES ('59ebd983-d002-42ab-9c91-efd3536ccfcc', '1de94ce5-d4ce-4f1b-a20d-3ac17113b2c9', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO keycloak.component_config VALUES ('fa126899-62fc-491a-bb01-0a5289eb46b3', 'ca854d80-a5e5-44cf-8e2f-5dab3e2be5fd', 'privateKey', 'MIIEogIBAAKCAQEAi2z12hAibRPiKdqBL51dmEs/PJ1FUSOBu8dL+yYu6C7UwBgzzfLz/nTlyMUC+ezYna8fXMzFdU2GemJOZils48rAgf9GnA/+Q8xHw54/fwhv9pTNSuqpwXHEakkD4BNkB2l42yHxisbo4tLXXWOKQv4u2VdTupvLhI64pbkwKCt5ydCS2sDA2wyFQNoMZ33u4yDfvDKvAuA3PGrKtaQsn38IGIOVlA4Pgn4h+voSDm2mWFoVyO1jIOuNVDJba4A/MwOdCZWENBi/5HWA9y4IzHmF7PsWP1aTOm/sBTcfGlDCAu0YcF1g5rlziHLgMGfbqVbFaPPEQMLF4s5JwqC9tQIDAQABAoIBAGC4vfUArGEvIf4W7vexG3TC/qN2Ftgq4Zz6rOMVogTAOCbqo0WD/W/QeHfG9EGc5Mi+6+rcwz6VAW11NR36Luf3h4SnKryo+6Lc3AwAg9wEZmeQ4rnOAOWJntB8xotz6DicGpMqAP5c7sIrseu/WfMPkkCELDmQSqcyuzV8OsQiHry/YRovMnVnClf+gK3CbUtjbmXnBQxsGAvWEB91uHcvzAaM43VnXwda8NEUGF9CgyVkGhaJnKfknMcp/ZK+KuTn5kWBAd+O6cx27F2Rk/Nvvn0v9fHPY8osu4qJ++MEiaJXFUfaIXB20W2oEhy8rzGlEuMQXY6ON7X2l+//HyECgYEAv3Jdr9GXi2NB708MLtZFFiLZT+PHPnRV9BwnIghPBB+GwLpWjZ2OQvpiL/14d3bhj5c3ZhVcu09c4/bJwMCficzwu1wPbR2D0WbEeXZvyHe+Wl+Pwb1I7GfqOokRfAHQLOtc0JNsOHP6vYNNg5aTjzLyeR+zAfV/HiRR0z4OI9cCgYEAunAlGnq4ypdn2E29VGBUN8RI27JHnGmvfZjR2UvdJ4a5sOBbAyzPPHrPL1I2GPlTxF1ch3W9gQZjy8Jdc3NE59VpzbyeVCsS1EzETfm//+LVGyw3pNx6F6fFIb7I8KNJ3p1NkZxCJQKT0ONDLxOkZFi6IaBPTjcEX98E91Bp+VMCgYATNDetoUqgUs6UYMuKDzhS5iACYYjk/Op6WDCcu1Shxz/PKWHxRrK0iUU8JyLkaOpravHFrbLlnypkO6c1TJ00R3iGcs+hVGqaoMJopLbF1y0jB572AjTEchAO2x0D4XKubtWano8mgovOYtNttbcLkEK+X62nLqcXsPD8TadBdQKBgFkk1hjbJRB5ZIXgZe66QIqJp+ykSelX/zkmoPAtfgkwOgmAvQO/oTdh4T7XKFa4oHz7xwpeGcZfr8f1n4lcTE4tlPFyhqHoFpC8RACkslE/vHXJprGFWjuFVJTWDG5DJUb0H+rHtDjOCq+Oesk/sxLn+deqN0FGvSi6Ej3OjV1RAoGAY9OPejhna7l01XZ++wpT/uH9zbL9+xQHDNnq4qI5devKvMTc75OKSZVa0dKxUlo4NnJeNSg4+lo9tG0PsForA8adiRqO37ZuiRnIZinjG45JpidTpSZsK+jzL9FwdjrHNDSLw60WHt+0ER7OUfXE5GpoUZVV/7cOpayslvlCUas=');
INSERT INTO keycloak.component_config VALUES ('d5d3d928-f88b-4e9f-a802-edfa0283b2b7', 'ca854d80-a5e5-44cf-8e2f-5dab3e2be5fd', 'keyUse', 'SIG');
INSERT INTO keycloak.component_config VALUES ('5abbf65b-dc61-46b1-90a6-c3b25a76d753', '519005ab-1cf5-43c7-a359-10aaca8f4dce', 'priority', '100');
INSERT INTO keycloak.component_config VALUES ('ddf13bf4-26b5-422f-9e0e-bf1fce63d522', '519005ab-1cf5-43c7-a359-10aaca8f4dce', 'kid', '4955311f-55c9-4d79-a022-7495b5e02f9a');
INSERT INTO keycloak.component_config VALUES ('c15bad31-2dd5-46e2-8523-1f69675c5a83', '519005ab-1cf5-43c7-a359-10aaca8f4dce', 'secret', 'wSUQUhaQd7ajGjBPrezvOA');
INSERT INTO keycloak.component_config VALUES ('8cde4248-9220-434f-8d96-3b3f3b6b9391', 'd607301a-f3e2-4466-af91-2c7e61b85be4', 'kid', 'd67531b5-58c1-458b-a1aa-5153cb9e842d');
INSERT INTO keycloak.component_config VALUES ('2c9cc983-b3f7-45de-a2fb-1f51b4f5be0b', 'd607301a-f3e2-4466-af91-2c7e61b85be4', 'secret', 'ego1bVzJdOcphZjuznc89bGwe7P6Ud7j0_3YSE8eQW8a48zawSPN8W3_3hFBSHjELuYM4EZvdQNmLzwFmUeGnQ');
INSERT INTO keycloak.component_config VALUES ('cfb86fc6-73b8-47c1-9df2-5b76985c8045', 'd607301a-f3e2-4466-af91-2c7e61b85be4', 'priority', '100');
INSERT INTO keycloak.component_config VALUES ('01a915eb-c722-47cf-9c7c-0bcc3a44adcb', 'd607301a-f3e2-4466-af91-2c7e61b85be4', 'algorithm', 'HS256');
INSERT INTO keycloak.component_config VALUES ('378ab15a-bad4-41e8-b5dd-7d2e6fe14219', '9465ec8f-999e-487d-8244-d3727e8d66a2', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO keycloak.component_config VALUES ('6593ca29-0599-41c3-8043-3e857aa11a05', '9465ec8f-999e-487d-8244-d3727e8d66a2', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO keycloak.component_config VALUES ('2f38790b-de25-41f0-82cc-5637d69a7ce3', '4b1d8e10-0855-424a-bf28-20c71714157c', 'client-uris-must-match', 'true');
INSERT INTO keycloak.component_config VALUES ('e4956d7f-e694-4113-a694-f246d563e682', '4b1d8e10-0855-424a-bf28-20c71714157c', 'host-sending-registration-request-must-match', 'true');
INSERT INTO keycloak.component_config VALUES ('62a77d4a-fd23-4aa1-8048-725fe4e2b66e', '1de94ce5-d4ce-4f1b-a20d-3ac17113b2c9', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO keycloak.component_config VALUES ('57377c3a-1377-4fdb-a10f-a81c93b4fc4e', '1de94ce5-d4ce-4f1b-a20d-3ac17113b2c9', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO keycloak.component_config VALUES ('e5a8dc1a-8d23-485b-9932-bcb8baee1100', 'ffb778b2-5918-410b-a935-7920afe037bf', 'privateKey', 'MIIEogIBAAKCAQEAi28GxHOzqhYSVBQsXqNNe2zIA19H5qRNmLHJwLDANabGqCGmKyntuAUXbgBRr2dyUNTYkisIPwWZYeOgPPCJlTYeUjoGbTPaNLEV4Srylmu7ks2HdF/9E+mEdmV1lLMtAEE9ZhjK8/byMXYt67Xkx7xyaJ2G7bposNFN2ltBs2sjyznu7TGF0Wzfi8bxjHIDSQQC3kMDuOU6oMk7aeq3ex8N9CtNP0qMR0Jw/ZtGXDA6gJaqWzxGB1Pay4biE1m8CX5tPWWS/s8Z+VGW3isftfrTto0FVm2nBrUj0RTlZuRqwPIn7ql58fd+BO1irQ/Xh7BWkLsllldDDYb4hWMu2QIDAQABAoIBAC5xzylE+QWg0H4dMiJb9wUz2PP2mvaiqA5CuldrCLtWUDnU64rZLovrdkB37r2kkZmHLJSTrO2BKfRHZCqoXMvM+RCer2FUskx26DjWm3OrcxGVUJddGem2ER928FGV1VmOYatOetwE1+vN18H6FrjJdrqOLlGllBXBwlMHrrzaZv6rHlTCebmpsm4CRTSCbVo/0Ot1N6RRmDsOtRjqJTkAbf/8TXm5jCu0kY/6geUr78k4pYdIa5nMY8Ux7leeOnQvQ0ELs9KpmwwBwEGlq4TcZf1bjNkpjALFrZqaVXPn7Co2/dJ9dXd6hhB1xE/xanCujo08O8R/zMlUYqXWDmECgYEAzew3bMrjCEj+bznNi8H3l7TockfaRUpqOTRXOWDeoS/xPPC5WIA6RqmPQe/C20cqu0eUAQgsUlZbww0S3O1n6Kkymf6w1+zR1SUXCvPP+eEPGgRYrl6iDuY5y/c4AmvTzjnNcy5kzwRTcrQ5e2J7Yp/DATxnBz7e0UfAaKpvYsUCgYEArVeD0l8W/hseh68OBdrmeWiQPAtlWoXrgf2XRkRxCAUsR7uIIFjQ1Iee/5+uaenGOvtGRTlJeWBVodiDmVXsvD7mrMDdP768BfoY9RcPZrj89D10vewoUUTKzQAR8Fi/UbVJh0GmEo9zJeaHVPcoSFGfVZ0A0l2e2NDnC8KNTQUCgYAkVCorDVgkXAxXPxFeOKgfoZDoqHh/hPNciDljLA3azgR3RdjNHkIpuTxG26+608FcLPKVhAWduRKTRLkxNMkCKOd+d4pnbaZPPi3khsMISIZLhrzGdneMvV0w+Lpu4usJFPWD/olWZGL8d4M0m1k9OwZCL4/VnWfd8BSn4nmoKQKBgF0/YdtuadkCT7cf9YQy0J7pIAYc/0XmGt3PxGv5b3CoD7z65ey4uoZJ+r96cAHrz0Z1W8TrX1oa95Xb+lcnQPW3RLIUAjFDcrQoaPqXkCJrSzA8SyvL+ZhWUF5dNkk8BJd41XgcWbFMV95Al/aeCp50wij1D7caw9PQ9Sl/XDHdAoGAR/QbIoCVq5NloMy9SquqO3ZKmn6KzYkS3toLSuiLwSSgM77VUZbBBii4sOeoOAq2M3zbFwwnvIZuvu+7Q6tVzOysWlRU4I3xZtZz8oPOhKJLI9AlHe91JoSi3+gb22G5EPECvRxIZWWJoUHCNwObDkqNZZ96nJZ3zWf5Ln3sGjA=');
INSERT INTO keycloak.component_config VALUES ('8579a1f1-fb38-482f-98fb-56bc0a71e8ad', 'ffb778b2-5918-410b-a935-7920afe037bf', 'certificate', 'MIICmzCCAYMCBgF/FPhMCTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIwMjIwMDIyOTUxWhcNMzIwMjIwMDIzMTMxWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCLbwbEc7OqFhJUFCxeo017bMgDX0fmpE2YscnAsMA1psaoIaYrKe24BRduAFGvZ3JQ1NiSKwg/BZlh46A88ImVNh5SOgZtM9o0sRXhKvKWa7uSzYd0X/0T6YR2ZXWUsy0AQT1mGMrz9vIxdi3rteTHvHJonYbtumiw0U3aW0GzayPLOe7tMYXRbN+LxvGMcgNJBALeQwO45TqgyTtp6rd7Hw30K00/SoxHQnD9m0ZcMDqAlqpbPEYHU9rLhuITWbwJfm09ZZL+zxn5UZbeKx+1+tO2jQVWbacGtSPRFOVm5GrA8ifuqXnx934E7WKtD9eHsFaQuyWWV0MNhviFYy7ZAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAE10GefwQFkhpy1iiE9ANDme2hSnheiN7OYgCXOnSflr8kEHfAUXtYTZV6C64VMmyw/gHP3dg7ck2zyOCpWBppnewGq3TsFgEAXFFBLuuIRFdYR3COjyNUt5JAnldCdtFhaUWOHCJE6F028BsxUMq2y1XpMhdR/QiV4p0Wzk8D+RKIg/NHaj9ULktpUjq4Rv7ljOmhzZ9mswE8ZMZSa5KasPKVl9m94Fy5glTYoNGuYdX1ud5A0OSoLWc6+pZyo3Iig56RBuTEp1Mzs7gTaw7FImIvNTZ0ULeNDw3Mh/RqPG/Cu4iOj2Zqti5WMoTL/jjPPy1riFR1j9XZRHDH+26to=');
INSERT INTO keycloak.component_config VALUES ('5ef47b87-5524-4778-9aa9-dcaa9314013d', 'ffb778b2-5918-410b-a935-7920afe037bf', 'priority', '100');
INSERT INTO keycloak.component_config VALUES ('5cdc2219-2d5c-49e7-b29c-dd4c6947fbe6', 'ffb778b2-5918-410b-a935-7920afe037bf', 'algorithm', 'RSA-OAEP');
INSERT INTO keycloak.component_config VALUES ('ccb5411c-cc6f-4ab3-8f43-b8fd949049a1', 'ffb778b2-5918-410b-a935-7920afe037bf', 'keyUse', 'ENC');
INSERT INTO keycloak.component_config VALUES ('fb5f5d06-eb72-41a4-9a55-cfc6b382aab3', 'd121dddd-c8d1-422f-8048-aab3bfb3555d', 'privateKey', 'MIIEpAIBAAKCAQEAwVYWh7Jl6T9eyWNMfMX4L10KQu6Ulr0qqkEYKtw3GsOHOTRp0Q0C8OIN2HEwSV0/Fc00ToKIsyK6TC0PgSsWIZqQDTDyJ3rVENFck1rmsayBFVf53dcTcE6g/zA/TTrb2wD0k1FgLS66Irv/4+eYQITXC/LRmllpYTB2IVacZEhD7N5WXl70j7vxPsPerRGweDWHiTaGGTAZP83NEO7Hyec6Ko89nuyewsGr2ZnMrzTxgV9vurZ9QL6yGIs635RaM4Xf9ZCDK9gEVCU1X1nfALNr/0UiFheFJ9tTWhiqWXUbasD4dQd5lpuX8Ihw1pzSsFAIe/G9gOgqDH92v14JNQIDAQABAoIBACgO+U4Wda01dyNNEs0Li9fsdDLYEiuFeHCcWjCPPk+qUbtVk9M/2eslO28sTK/2xRp0UTEvNLnBKU6dS4gc8FH4H37MNHBfsAPzDTZu8DvCHWDZwKjpZlqvwAX/7i3HU0R2Vzaq9r2F4AVQZL3I/6/mllQgdLOBcSc1DlTsCC1yuyF4Pqdsh+QM144JBWzYCy6XE0jH+RI0seNuf6jgUCtPY3N3F9ATUFRj+ThRUoSH0q/+xMquvFJK2tvw3DPZx1exOjSL58ed0EjcAwcrKnBUJkymm9/G7yAVNxZFLl9iY8nbZONNwJPsrSy+oZcUGt0mbq0u7cHrJpxVnxL14cUCgYEA9Badn3XTO57LD+ffGHLd61Ks7B3NqqqAwOxI8HHsKqLAlQzoQYScja58i68GoFpmivLuwlmpIOpwprcrwPVA/ucYXdIyVj8pyAkGVfKH/S5Ef1uNAz/Q/387SRYEZb5v+3DD56m1yWanKA/1z8m5i6D/5KzI9AGKFIU717HrVicCgYEAysVt3T32r7YWiVGaoxaszbZuHxujpHk6XNRjal34F98y4oWJ9x9c5dFk3KsaGshA3qax5H7novCSm9B1P5JlslUSBLc+8wl+v2HLc7Kb0fUmFbRPr4+7hf9qkiC04V+Z2aH2TWRtnHk68atzHro+WxOWRmRnffoLGoi2H+Fou0MCgYA60AQ0uuAlunI1J+qCapL8M5SE4/19RM33Lje478o2z7ZVc6G2v6w1GzjZM1gGZSHWEwjifVYaH0L7eKErQizh/m7JlG8ahuebUklbhi+sGmzYvwdwI/1IwrBXQN3YYhV7YUVi2Wp616gpKAdThMiXUzi1McjNul056oxrwWvx+wKBgQDGkc7EEXEpo4SwVwS7X3I8RcHTnuqDH+Cila8BtCJHpmEbabCxG7qKqKNAYiK/RYoZQF8HJ6vJahP4mIypg8EpgZuSmK0BrjO8UZW+qJNladAxAxHiGDyIvZbsoTDhYBC3Cp+8LHQW/rVVgxPKbJKx+B16s8qRmLMU+fp4f/JjJwKBgQDuXyz12MZb+CG1VszP6JPAgRpeDOFqxzkUs7xXtkjqDaD7AMkPUGRiLNZ2uIzR3zYnIvAIMvfq9gM22rSkxfbfJRyNI2xp5pGxnH5PaF/YahwblSE7tHWZ8ORj0sZRcx+o1cZnAjq7mWTWbxVOvTWqQ0sxOw5M9VKg0UqjzjmxgQ==');
INSERT INTO keycloak.component_config VALUES ('4779b29f-27f3-442c-83bb-757df34c191c', 'd121dddd-c8d1-422f-8048-aab3bfb3555d', 'certificate', 'MIICnTCCAYUCBgF/FPoj8jANBgkqhkiG9w0BAQsFADASMRAwDgYDVQQDDAdhcHBja2V0MB4XDTIyMDIyMDAyMzE1MVoXDTMyMDIyMDAyMzMzMVowEjEQMA4GA1UEAwwHYXBwY2tldDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMFWFoeyZek/XsljTHzF+C9dCkLulJa9KqpBGCrcNxrDhzk0adENAvDiDdhxMEldPxXNNE6CiLMiukwtD4ErFiGakA0w8id61RDRXJNa5rGsgRVX+d3XE3BOoP8wP00629sA9JNRYC0uuiK7/+PnmECE1wvy0ZpZaWEwdiFWnGRIQ+zeVl5e9I+78T7D3q0RsHg1h4k2hhkwGT/NzRDux8nnOiqPPZ7snsLBq9mZzK808YFfb7q2fUC+shiLOt+UWjOF3/WQgyvYBFQlNV9Z3wCza/9FIhYXhSfbU1oYqll1G2rA+HUHeZabl/CIcNac0rBQCHvxvYDoKgx/dr9eCTUCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEADRiEmMZEWiYv3gxyNpH/GAVg6ZHYOFhv23el8dAhRlTw7Hrtjgn2k+jqhRCaSvCgvYJ57EqEvLJdPZ7qUklGXOix7XKEGTbUwJ2tnyddwJFSC9fWTtkr45hQM/HfFXB3oCNr/qVOmyczyN2k54cHE3mv5OOAmeF4IBNEoJR6qSJW2749Ze+ciAssXeHuxy9BdVM/tiaEoz6Fw11FxYk5ECdZA15sbNxPXyG0s61vVwZ2thrLsBBi7SXmSy8b62Nji5vvUBkQ8Q1+hZ29FUwJlr+VKpALvpTGpNrl4bb4+U5yZfUMA60PnvmGXtt0cOogQFsX9BwqCdsD2JP5q9Y2Fw==');
INSERT INTO keycloak.component_config VALUES ('5de22ea2-592e-4a10-a32a-93e6448e038a', '7ec14649-b2ce-47b1-a10a-064b6903c573', 'priority', '100');
INSERT INTO keycloak.component_config VALUES ('e30c2f7d-efa2-4f36-b653-3762a81d1656', '7ec14649-b2ce-47b1-a10a-064b6903c573', 'algorithm', 'HS256');
INSERT INTO keycloak.component_config VALUES ('fb516178-65ce-4066-969b-f59845a3983e', '7ec14649-b2ce-47b1-a10a-064b6903c573', 'secret', '4SXLHb2zUtCw25shJvRVjgRSs-FqpFnkAAUTR7gmjfwyGFvUp7aIY156WFI8SexOKLa73L-EsHLwvkkmvDyN6g');
INSERT INTO keycloak.component_config VALUES ('cfa4ea20-cd2b-4857-87a1-256caf32ecc1', '7ec14649-b2ce-47b1-a10a-064b6903c573', 'kid', '7b9a08dc-ca4d-4108-ac58-72e4c7947e2d');
INSERT INTO keycloak.component_config VALUES ('1fa6bf91-0cbd-4fbc-a178-c841308d374e', 'dc5145c3-7f57-40ac-a57b-90d37eccb35e', 'secret', 'I_USmhG50UHlhtJn2S4N0w');
INSERT INTO keycloak.component_config VALUES ('f8546b3a-6eac-4c35-ac5b-c23b5f325760', 'dc5145c3-7f57-40ac-a57b-90d37eccb35e', 'priority', '100');
INSERT INTO keycloak.component_config VALUES ('51106ec5-89ec-4b5b-b786-c45545706fc5', 'dc5145c3-7f57-40ac-a57b-90d37eccb35e', 'kid', '68a5bc87-5587-46ee-b701-266e83e7fea1');
INSERT INTO keycloak.component_config VALUES ('8442306d-21f6-427a-a6f1-40c41de81254', 'e9c854d5-dea2-4325-a960-8dfed513e4fd', 'max-clients', '200');
INSERT INTO keycloak.component_config VALUES ('3842680b-c80b-4685-98cf-5269867cb6f7', '9465ec8f-999e-487d-8244-d3727e8d66a2', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO keycloak.component_config VALUES ('0d577e9a-3f8c-42bb-95ff-449064679449', '9465ec8f-999e-487d-8244-d3727e8d66a2', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO keycloak.component_config VALUES ('87500bc8-4d31-4431-a533-e689243ec10e', '9465ec8f-999e-487d-8244-d3727e8d66a2', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO keycloak.component_config VALUES ('4addc9f8-b0c1-4bab-9e68-6cb07dba3c72', '9465ec8f-999e-487d-8244-d3727e8d66a2', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO keycloak.component_config VALUES ('3285555b-6659-4756-a2da-2511e34efefb', '9465ec8f-999e-487d-8244-d3727e8d66a2', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO keycloak.component_config VALUES ('62ee3977-20f9-4a28-a11d-b1570cb06fda', '9465ec8f-999e-487d-8244-d3727e8d66a2', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO keycloak.component_config VALUES ('96b0fa6c-1a1c-4a7b-8939-f054d6392bb1', '1de94ce5-d4ce-4f1b-a20d-3ac17113b2c9', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO keycloak.component_config VALUES ('47934d46-3e06-480b-92f0-ef9bcc3800bc', '0926bc49-92db-4bdb-a535-d257e43d2307', 'allow-default-scopes', 'true');
INSERT INTO keycloak.component_config VALUES ('d32b2731-27d8-40dc-b7c2-0ae9e41cb048', '95cf4402-b463-45f1-8257-fe39a8f0b83a', 'priority', '100');
INSERT INTO keycloak.component_config VALUES ('4f227745-742c-466f-8072-0a2b389abe78', '95cf4402-b463-45f1-8257-fe39a8f0b83a', 'kid', '5b3fce51-facf-40f4-a35a-3d17cb5cf7b3');
INSERT INTO keycloak.component_config VALUES ('4cd03f56-12f4-41d9-aae8-89548e421a75', '95cf4402-b463-45f1-8257-fe39a8f0b83a', 'algorithm', 'HS512');
INSERT INTO keycloak.component_config VALUES ('7dedffd1-6561-43c9-852b-152637c60bcc', '95cf4402-b463-45f1-8257-fe39a8f0b83a', 'secret', '3PSea1QiDzkP5DU3Nm8QN6eXfOlBtFQhn9o5UAg6zbb0TZu9l4KyTLxehN9TKOSkxC7LBVFeF3b6u61n01Q1Fpw9rH3l1GVi-BcCB9EiYd_8gYynUlKFle45qzMQ833FhHKeILTU4c7xrYTBpnlIQZLsl5nyuFozf5GMmxwZ0lM');
INSERT INTO keycloak.component_config VALUES ('8e11fe8c-078b-4119-9800-280219d325c8', 'dd37419c-ca65-4c17-8881-7e2d793d9392', 'kc.user.profile.config', '{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}],"unmanagedAttributePolicy":"ENABLED"}');
INSERT INTO keycloak.component_config VALUES ('104e15fc-fb51-4991-b0e4-b99acbaa597e', '2615902d-b72c-4452-9e40-98717da107c2', 'secret', 'ZK-M3plfsFWSsBXMnRhhuz6TMz731nbdFTMv0w99jE3ZH9dK_txQL7_SQSJ_ea2OlxblElAvJgD9OzxhOxKFrGcIlhdEg1e5UlcoVwO8nK5RcRImTDY5l1QR9f664XBlT1UtQERVl8Hfyx1A99G5eja4_4hQTvaSm1JLzLN73zQ');
INSERT INTO keycloak.component_config VALUES ('10b74a5a-726c-42d2-8d5f-4d7e4fcb26f6', '2615902d-b72c-4452-9e40-98717da107c2', 'kid', '8d4daf46-cf72-4203-844a-cfad1d3cd34b');
INSERT INTO keycloak.component_config VALUES ('699874d6-ae1e-4b37-b5ed-81c273f97bb2', '2615902d-b72c-4452-9e40-98717da107c2', 'priority', '100');
INSERT INTO keycloak.component_config VALUES ('cd9239c8-a2e8-41bb-8ceb-10ee282c01c9', '2615902d-b72c-4452-9e40-98717da107c2', 'algorithm', 'HS512');
INSERT INTO keycloak.component_config VALUES ('fc313e1f-1a35-4854-91d7-9a73911b2ec1', '4646ebf8-b5b7-4a8d-b40e-0cfb15f04f46', 'kc.user.profile.config', '{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}],"unmanagedAttributePolicy":"ENABLED"}');


--
-- TOC entry 4188 (class 0 OID 16509)
-- Dependencies: 235
-- Data for Name: composite_role; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', 'c6aadeb4-1712-4277-93bb-6b4833d14162');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', '27d9784d-6069-4079-8693-f94356e6b69e');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', 'a740fdeb-528b-4cae-b7ce-689f07ee1d4f');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', '3bd13113-1bc6-4e28-b06b-b1bebdf15953');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', 'dab5525c-db4d-4d94-a779-d626ef6c1a9c');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', 'c08af820-26b4-42f9-8631-06d743752203');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', 'dfab7ab1-2ee0-4dd8-b48e-7d39cbb5f463');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', '01b4c4ec-5cd5-4a39-b111-881a4452ca2f');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', '6739aa33-dc7c-408c-bad9-d4ec7214809e');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', '86316296-77f3-4392-bfa8-b70c3cb305d4');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', '5f65cfe4-0531-4be3-baee-0534d5ce4850');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', '423a5bcc-7cc0-4b3f-9068-acac57ed2838');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', '1cc0c756-121a-40ef-b810-f86431741277');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', '3b011373-630a-4e34-b151-39c32af091bc');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', 'd1d83dd3-a5ba-47c6-8c4b-0d8be136ebe1');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', '69a60d7e-d17a-480c-a254-175050e871cf');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', '6ce12b7c-3c90-40f0-b566-2694376803ea');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', 'ea4f8f4d-3313-4584-9b34-4312904cf888');
INSERT INTO keycloak.composite_role VALUES ('3bd13113-1bc6-4e28-b06b-b1bebdf15953', 'ea4f8f4d-3313-4584-9b34-4312904cf888');
INSERT INTO keycloak.composite_role VALUES ('3bd13113-1bc6-4e28-b06b-b1bebdf15953', 'd1d83dd3-a5ba-47c6-8c4b-0d8be136ebe1');
INSERT INTO keycloak.composite_role VALUES ('9644cff1-6824-4dab-9916-dd71201b120b', 'f0ade632-d051-4f0d-9229-62b823903a17');
INSERT INTO keycloak.composite_role VALUES ('dab5525c-db4d-4d94-a779-d626ef6c1a9c', '69a60d7e-d17a-480c-a254-175050e871cf');
INSERT INTO keycloak.composite_role VALUES ('9644cff1-6824-4dab-9916-dd71201b120b', '7a145737-e946-4bff-9c5b-d9c974fe64b3');
INSERT INTO keycloak.composite_role VALUES ('7a145737-e946-4bff-9c5b-d9c974fe64b3', '8ec28b5d-0037-4231-94d8-b493ee336ca2');
INSERT INTO keycloak.composite_role VALUES ('369a56f3-8739-4007-979c-6f9cf190d3ce', '1d8a45b6-c838-4ca3-a0fe-44da0ba58dbe');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', '7a5de334-6418-4186-83ab-630c04fef790');
INSERT INTO keycloak.composite_role VALUES ('9644cff1-6824-4dab-9916-dd71201b120b', '785200ab-20dc-47c4-bffa-af0007c06dc9');
INSERT INTO keycloak.composite_role VALUES ('9644cff1-6824-4dab-9916-dd71201b120b', 'a7789203-7db0-4bcf-aee1-c47aea130273');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', '2ae1deef-cb36-494a-b238-d4ae1b145be9');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', 'fea5b979-6e50-4adb-a02a-40d67de24b42');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', '7a5836c9-d5c7-4649-8a0a-38dd60ece9c0');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', '79d5386d-ffcc-4829-95e9-045dc597a23b');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', '30d1bca6-7b99-4209-91d8-1b7c549fd963');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', '36f7c456-d64d-4f3c-bf46-44cc622b2918');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', '46c26134-a647-4263-9a44-ebef5de6074e');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', 'b546db53-47ec-42a3-af5c-0680bec9d12f');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', '33ad5e4b-1bf4-43c2-8271-b64096075197');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', '157a58db-0f8c-4536-ab90-781b1c7003ed');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', 'ef0847c7-74fa-4b34-8994-9c4b28c1bb02');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', '337ea090-4a28-4c3d-8124-d068c7e89097');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', '326774d6-9646-4c8b-ab63-a86a0d1f600a');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', 'c88623da-69e9-42bb-a7e2-870268a83240');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', 'd456669e-a882-44c7-b83e-dc86f3332b78');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', '18057d22-9169-4c7a-a4b8-313b51277530');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', '62a07952-f0de-41aa-bd8a-c45b72bc865d');
INSERT INTO keycloak.composite_role VALUES ('79d5386d-ffcc-4829-95e9-045dc597a23b', 'd456669e-a882-44c7-b83e-dc86f3332b78');
INSERT INTO keycloak.composite_role VALUES ('7a5836c9-d5c7-4649-8a0a-38dd60ece9c0', '62a07952-f0de-41aa-bd8a-c45b72bc865d');
INSERT INTO keycloak.composite_role VALUES ('7a5836c9-d5c7-4649-8a0a-38dd60ece9c0', 'c88623da-69e9-42bb-a7e2-870268a83240');
INSERT INTO keycloak.composite_role VALUES ('1b55f720-894d-4d89-b37d-358e5eb29309', '934d2eb7-4ffa-406f-b8a9-155460dd9872');
INSERT INTO keycloak.composite_role VALUES ('32ff242f-83ed-4e5b-90d4-a5a75227b94b', 'd95fec18-c1e8-4720-b180-f88f8813e7a0');
INSERT INTO keycloak.composite_role VALUES ('32ff242f-83ed-4e5b-90d4-a5a75227b94b', '3164e832-b3b2-40d1-a50b-3bfb997d4e46');
INSERT INTO keycloak.composite_role VALUES ('32ff242f-83ed-4e5b-90d4-a5a75227b94b', '3a011ec6-1589-42f2-a9ae-e3e8daffb290');
INSERT INTO keycloak.composite_role VALUES ('32ff242f-83ed-4e5b-90d4-a5a75227b94b', '14183e37-4d0d-4f80-89a9-d979c7676d6a');
INSERT INTO keycloak.composite_role VALUES ('32ff242f-83ed-4e5b-90d4-a5a75227b94b', '934d2eb7-4ffa-406f-b8a9-155460dd9872');
INSERT INTO keycloak.composite_role VALUES ('32ff242f-83ed-4e5b-90d4-a5a75227b94b', 'de050d33-3f79-4b6d-9f0f-33ed806b0cf8');
INSERT INTO keycloak.composite_role VALUES ('32ff242f-83ed-4e5b-90d4-a5a75227b94b', 'e532fe1f-14b2-42a5-af86-9b523e2fe992');
INSERT INTO keycloak.composite_role VALUES ('32ff242f-83ed-4e5b-90d4-a5a75227b94b', 'a1516493-c8b5-4001-a15a-d2b4a53964cc');
INSERT INTO keycloak.composite_role VALUES ('32ff242f-83ed-4e5b-90d4-a5a75227b94b', '2387902b-b5e8-4810-814a-820bfc0bf070');
INSERT INTO keycloak.composite_role VALUES ('32ff242f-83ed-4e5b-90d4-a5a75227b94b', '561557b4-e7d0-4401-9b18-25893c663078');
INSERT INTO keycloak.composite_role VALUES ('32ff242f-83ed-4e5b-90d4-a5a75227b94b', 'c8c99201-43cb-4987-9100-34b135c13cd0');
INSERT INTO keycloak.composite_role VALUES ('32ff242f-83ed-4e5b-90d4-a5a75227b94b', 'd0202d84-e5c0-4558-b385-c04149655885');
INSERT INTO keycloak.composite_role VALUES ('32ff242f-83ed-4e5b-90d4-a5a75227b94b', 'b8f4990b-326a-4cd5-81d1-fc0603561b68');
INSERT INTO keycloak.composite_role VALUES ('32ff242f-83ed-4e5b-90d4-a5a75227b94b', '7fed08ed-9110-4022-8550-433f0fc5054f');
INSERT INTO keycloak.composite_role VALUES ('32ff242f-83ed-4e5b-90d4-a5a75227b94b', '6309e6a4-e13e-419b-8d06-476b6fad7177');
INSERT INTO keycloak.composite_role VALUES ('32ff242f-83ed-4e5b-90d4-a5a75227b94b', 'd303d692-a116-48ec-9d15-e3449ca00f10');
INSERT INTO keycloak.composite_role VALUES ('32ff242f-83ed-4e5b-90d4-a5a75227b94b', '3fda9186-3fda-413f-900b-43b487d08732');
INSERT INTO keycloak.composite_role VALUES ('32ff242f-83ed-4e5b-90d4-a5a75227b94b', '3b234c85-7863-4077-ba73-5c39796c4476');
INSERT INTO keycloak.composite_role VALUES ('395df0fe-9ce6-4af3-9d3f-a76b64e2c6b1', 'c187fe98-fbc1-4601-a0b8-c463193e8494');
INSERT INTO keycloak.composite_role VALUES ('3a3efbeb-83dc-4f82-b78d-f00e954d7d40', '558648c2-b53b-4dfd-906f-d30b67967ecd');
INSERT INTO keycloak.composite_role VALUES ('3a3efbeb-83dc-4f82-b78d-f00e954d7d40', '395df0fe-9ce6-4af3-9d3f-a76b64e2c6b1');
INSERT INTO keycloak.composite_role VALUES ('3a3efbeb-83dc-4f82-b78d-f00e954d7d40', 'f82082f8-ce8f-4514-a0df-08b916e08db3');
INSERT INTO keycloak.composite_role VALUES ('3a3efbeb-83dc-4f82-b78d-f00e954d7d40', '241f95cd-d0a8-4b5e-b7d3-657f078175bb');
INSERT INTO keycloak.composite_role VALUES ('3a3efbeb-83dc-4f82-b78d-f00e954d7d40', 'eee97160-4b67-4071-84f4-099bbcd704af');
INSERT INTO keycloak.composite_role VALUES ('4be9e535-34e3-4ebc-8591-1f575899d346', '750a3b3a-0cbc-47dd-b3e5-0de2a88b8a82');
INSERT INTO keycloak.composite_role VALUES ('934d2eb7-4ffa-406f-b8a9-155460dd9872', '14183e37-4d0d-4f80-89a9-d979c7676d6a');
INSERT INTO keycloak.composite_role VALUES ('934d2eb7-4ffa-406f-b8a9-155460dd9872', '3fda9186-3fda-413f-900b-43b487d08732');
INSERT INTO keycloak.composite_role VALUES ('97caa102-e9d8-44de-94a1-74e5ea7bccb5', '934d2eb7-4ffa-406f-b8a9-155460dd9872');
INSERT INTO keycloak.composite_role VALUES ('a1234e9b-ccf4-43c2-8c5a-f8d5964d9e22', 'f82082f8-ce8f-4514-a0df-08b916e08db3');
INSERT INTO keycloak.composite_role VALUES ('a1234e9b-ccf4-43c2-8c5a-f8d5964d9e22', '934d2eb7-4ffa-406f-b8a9-155460dd9872');
INSERT INTO keycloak.composite_role VALUES ('d0202d84-e5c0-4558-b385-c04149655885', 'a1516493-c8b5-4001-a15a-d2b4a53964cc');
INSERT INTO keycloak.composite_role VALUES ('eee97160-4b67-4071-84f4-099bbcd704af', '934d2eb7-4ffa-406f-b8a9-155460dd9872');
INSERT INTO keycloak.composite_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', 'cbd7ba23-5f0a-4ec5-a795-25ecebc54a79');


--
-- TOC entry 4189 (class 0 OID 16512)
-- Dependencies: 236
-- Data for Name: credential; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.credential VALUES ('16c6dd96-ab0a-4db4-8b44-91e7e990e255', NULL, 'password', '83d2fae6-76d9-497c-bbf6-f177785e6195', 1645339374406, NULL, '{"value":"Um345AmXLsp0iq9EfpOz7faesppvoRTKeaaAErgowNM=","salt":"vRC/vRO2OMFUTJwzQkwURg==","additionalParameters":{}}', '{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}', 10);
INSERT INTO keycloak.credential VALUES ('d0b228b2-b743-4851-952c-b8e213eb4507', NULL, 'password', '7e2e3888-b370-4309-b82c-403b6871a390', 1645339392136, NULL, '{"value":"p8Dog//gZWmwKBkZ417CXDTHWM11TZyFClb0Oj9btS0=","salt":"yDRkD+B47JOj9SZuKZyzsQ==","additionalParameters":{}}', '{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}', 10);
INSERT INTO keycloak.credential VALUES ('bc89d0ee-57fd-4f08-8ae5-7b4cd446ab7b', NULL, 'password', 'c83ccc8c-2c1f-4a7a-9506-eaf235a284e9', 1645339358068, NULL, '{"value":"KeJK1wigxM3gAYqCfk0284BmpJYHcCSCtD1HZitWc7U=","salt":"IIoJ+h3niCnlfPNGczpFOw==","additionalParameters":{}}', '{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}', 10);
INSERT INTO keycloak.credential VALUES ('33ba8296-df38-46a8-b8ab-72b2f316db43', NULL, 'password', 'dc59cd47-1a7e-4ca2-96b8-96df2bfe9b12', 1645324291713, NULL, '{"value":"de9CAdtB3v2128dqwdFZ+OT6/LVFg0qEBAS/7T9Tka0=","salt":"E7b+oTPwaWypAOihDOdQVA==","additionalParameters":{}}', '{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}', 10);
INSERT INTO keycloak.credential VALUES ('0e881b5d-b6ca-476c-abbc-3ad965594a94', NULL, 'password', 'de3127bc-dbe6-4775-9334-2f873f413d23', 1645339453331, NULL, '{"value":"La8jLnDb2a07GTdGT03ZGr9oWtWhzinWhucX362tBq0=","salt":"n2Rzz0HcCBhyZQc+0ueF1g==","additionalParameters":{}}', '{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}', 10);
INSERT INTO keycloak.credential VALUES ('3ea2ae5a-5278-4f38-a91d-5a5ca660c263', NULL, 'password', 'ba3b17f0-2698-4455-b150-0dcfbf9fdcd8', 1645339408658, NULL, '{"value":"BzmIVeiVgyf/p5Dm7yqP3DqkIwBq2fVF1e24gz4rcHY=","salt":"JVTDrocanWV3vNpbbx3LBA==","additionalParameters":{}}', '{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}', 10);


--
-- TOC entry 4190 (class 0 OID 16517)
-- Dependencies: 237
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.databasechangelog VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/db2-jpa-changelog-1.0.0.Final.xml', '2022-02-20 02:29:10.932074', 2, 'MARK_RAN', '9:828775b1596a07d1200ba1d49e5e3941', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/db2-jpa-changelog-1.0.0.Final.xml', '2022-02-20 02:29:10.932074', 2, 'MARK_RAN', '9:828775b1596a07d1200ba1d49e5e3941', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.6.1_from15', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-02-20 02:29:12.025994', 14, 'EXECUTED', '8:d80ec4ab6dbfe573550ff72396c7e910', 'addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.4.0.xml', '2022-02-20 02:29:11.941244', 11, 'EXECUTED', '9:6122efe5f090e41a85c0f1c9e52cbb62', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.6.1', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-02-20 02:29:12.038376', 17, 'EXECUTED', '8:d41d8cd98f00b204e9800998ecf8427e', 'empty', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.4.0.xml', '2022-02-20 02:29:11.941244', 11, 'EXECUTED', '9:6122efe5f090e41a85c0f1c9e52cbb62', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.4.0.xml', '2022-02-20 02:29:11.94605', 12, 'MARK_RAN', '9:e1ff28bf7568451453f844c5d54bb0b5', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.4.0.xml', '2022-02-20 02:29:11.94605', 12, 'MARK_RAN', '9:e1ff28bf7568451453f844c5d54bb0b5', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.4.0.xml', '2022-02-20 02:29:11.94605', 12, 'MARK_RAN', '9:e1ff28bf7568451453f844c5d54bb0b5', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.9.1', 'keycloak', 'META-INF/jpa-changelog-1.9.1.xml', '2022-02-20 02:29:12.336743', 24, 'EXECUTED', '8:90cff506fedb06141ffc1c71c4a1214c', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.9.1', 'keycloak', 'META-INF/db2-jpa-changelog-1.9.1.xml', '2022-02-20 02:29:12.341091', 25, 'MARK_RAN', '8:11a788aed4961d6d29c427c063af828c', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.9.2', 'keycloak', 'META-INF/jpa-changelog-1.9.2.xml', '2022-02-20 02:29:12.3975', 26, 'EXECUTED', '9:fc576660fc016ae53d2d4778d84d86d0', 'createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-2.5.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.5.1.xml', '2022-02-20 02:29:12.521759', 28, 'EXECUTED', '8:d1bf991a6163c0acbfe664b615314505', 'update tableName=RESOURCE_SERVER_POLICY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.2.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.2.0.xml', '2022-02-20 02:29:12.653927', 30, 'EXECUTED', '9:a7022af5267f019d020edfe316ef4371', 'addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.Final', 'keycloak', 'META-INF/jpa-changelog-1.2.0.Final.xml', '2022-02-20 02:29:11.468415', 9, 'EXECUTED', '9:9d05c7be10cdb873f8bcb41bc3a8ab23', 'update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.8.0-2', 'keycloak', 'META-INF/jpa-changelog-1.8.0.xml', '2022-02-20 02:29:12.276411', 20, 'EXECUTED', '9:f91ddca9b19743db60e3057679810e6c', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0-unicode-other-dbs', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-20 02:29:12.765543', 35, 'EXECUTED', '9:33d72168746f81f98ae3a1e8e0ca3554', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.2.0-fix', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2022-02-20 02:29:12.802507', 40, 'MARK_RAN', '9:938f894c032f5430f2b0fafb1a243462', 'addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.2.0-fix-offline-sessions', 'hmlnarik', 'META-INF/jpa-changelog-3.2.0.xml', '2022-02-20 02:29:12.815019', 42, 'EXECUTED', '8:ab91cf9cee415867ade0e2df9651a947', 'customChange', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.2.0-fixed', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2022-02-20 02:29:13.072876', 43, 'EXECUTED', '9:59a64800e3c0d09b825f8a3b444fa8f4', 'addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-20 02:29:13.104878', 47, 'MARK_RAN', '8:7be68b71d2f5b94b8df2e824f2860fa2', 'dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.2-KEYCLOAK-5172', 'mkanis@redhat.com', 'META-INF/jpa-changelog-3.4.2.xml', '2022-02-20 02:29:13.394921', 54, 'EXECUTED', '9:9156214268f09d970cdf0e1564d866af', 'update tableName=CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.0.0-KEYCLOAK-6228', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-02-20 02:29:13.519511', 57, 'EXECUTED', '9:079899dade9c1e683f26b2aa9ca6ff04', 'dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.2', 'keycloak', 'META-INF/jpa-changelog-3.4.2.xml', '2022-02-20 02:29:13.384287', 53, 'EXECUTED', '8:2e12e06e45498406db72d5b3da5bbc76', 'update tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-4.0.0.CR1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.CR1.xml', '2022-02-20 02:29:13.903113', 59, 'EXECUTED', '9:b55738ad889860c625ba2bf483495a04', 'createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-4.2.0.Final-KEYCLOAK-9944', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2022-02-20 02:29:13.964713', 62, 'EXECUTED', '9:9968206fca46eecc1f51db9c024bfe56', 'addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-4.2.0.Final-KEYCLOAK-9944', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2022-02-20 02:29:13.964713', 62, 'EXECUTED', '9:9968206fca46eecc1f51db9c024bfe56', 'addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.7.0-KEYCLOAK-7275', 'keycloak', 'META-INF/jpa-changelog-4.7.0.xml', '2022-02-20 02:29:14.109164', 69, 'EXECUTED', '9:f53177f137e1c46b6a88c59ec1cb5218', 'renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-updating-credential-data-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-20 02:29:14.19905', 74, 'MARK_RAN', '9:14706f286953fc9a25286dbd8fb30d97', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.9.1', 'keycloak', 'META-INF/db2-jpa-changelog-1.9.1.xml', '2022-02-20 02:29:12.341091', 25, 'MARK_RAN', '8:11a788aed4961d6d29c427c063af828c', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.4.0.xml', '2022-02-20 02:29:12.69774', 32, 'EXECUTED', '9:eac4ffb2a14795e5dc7b426063e54d88', 'customChange', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-3.4.1.xml', '2022-02-20 02:29:13.374939', 52, 'EXECUTED', '9:5a6bb36cbefb6a9d6928452c0852af2d', 'modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-updating-credential-data-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-20 02:29:14.19905', 74, 'MARK_RAN', '9:14706f286953fc9a25286dbd8fb30d97', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.0-drop-constraints-for-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-02-20 02:29:14.276103', 78, 'MARK_RAN', '8:2d8ed5aaaeffd0cb004c046b4a903ac5', 'dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-add-not-null-constraint', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-20 02:29:14.334313', 83, 'EXECUTED', '8:3fb99bcad86a0229783123ac52f7609c', 'addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-updating-credential-data-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-20 02:29:14.19905', 74, 'MARK_RAN', '9:14706f286953fc9a25286dbd8fb30d97', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2022-02-20 02:29:14.370745', 87, 'EXECUTED', '8:e3fb1e698e0471487f51af1ed80fe3ac', 'dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.0-recreate-constraints-after-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-02-20 02:29:14.311647', 80, 'MARK_RAN', '9:077cba51999515f4d3e7ad5619ab592c', 'addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.0-recreate-constraints-after-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-02-20 02:29:14.311647', 80, 'MARK_RAN', '9:077cba51999515f4d3e7ad5619ab592c', 'addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.0-recreate-constraints-after-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-02-20 02:29:14.311647', 80, 'MARK_RAN', '9:077cba51999515f4d3e7ad5619ab592c', 'addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-11019', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.486305', 97, 'EXECUTED', '8:75f3e372df18d38c62734eebb986b960', 'createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-add-index-to-client.client_id', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-20 02:29:14.321938', 81, 'EXECUTED', '9:be969f08a163bf47c6b9e9ead8ac2afb', 'createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.4.0.xml', '2022-02-20 02:29:12.69774', 32, 'EXECUTED', '9:eac4ffb2a14795e5dc7b426063e54d88', 'customChange', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-credential-cleanup-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-20 02:29:14.251421', 75, 'EXECUTED', '9:2b9cc12779be32c5b40e2e67711a218b', 'dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('default-roles-cleanup', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.407746', 90, 'EXECUTED', '9:67ac3241df9a8582d591c5ed87125f39', 'dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.3.0', 'keycloak', 'META-INF/jpa-changelog-3.3.0.xml', '2022-02-20 02:29:13.081867', 44, 'EXECUTED', '9:d48d6da5c6ccf667807f633fe489ce88', 'addColumn tableName=USER_ENTITY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('map-remove-ri-13.0.0', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.433817', 92, 'EXECUTED', '9:d9be619d94af5a2f5d07b9f003543b91', 'dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('17.0.0-9562', 'keycloak', 'META-INF/jpa-changelog-17.0.0.xml', '2022-02-20 02:29:14.568829', 105, 'EXECUTED', '9:a6272f0576727dd8cad2522335f5d99e', 'createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('20.0.0-12964-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2022-11-11 14:02:11.497503', 108, 'EXECUTED', '8:05c99fc610845ef66ee812b7921af0ef', 'createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE', '', NULL, '4.8.0', NULL, NULL, '8175330925');
INSERT INTO keycloak.databasechangelog VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/db2-jpa-changelog-1.0.0.Final.xml', '2022-02-20 02:29:10.932074', 2, 'MARK_RAN', '9:828775b1596a07d1200ba1d49e5e3941', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.4.0.xml', '2022-02-20 02:29:11.941244', 11, 'EXECUTED', '9:6122efe5f090e41a85c0f1c9e52cbb62', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.4.0.xml', '2022-02-20 02:29:11.94605', 12, 'MARK_RAN', '9:e1ff28bf7568451453f844c5d54bb0b5', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.9.2', 'keycloak', 'META-INF/jpa-changelog-1.9.2.xml', '2022-02-20 02:29:12.3975', 26, 'EXECUTED', '9:fc576660fc016ae53d2d4778d84d86d0', 'createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-add-index-to-client.client_id', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-20 02:29:14.321938', 81, 'EXECUTED', '9:be969f08a163bf47c6b9e9ead8ac2afb', 'createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.6.1_from15', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-02-20 02:29:12.025994', 14, 'EXECUTED', '8:d80ec4ab6dbfe573550ff72396c7e910', 'addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-add-index-to-client.client_id', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-20 02:29:14.321938', 81, 'EXECUTED', '9:be969f08a163bf47c6b9e9ead8ac2afb', 'createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.6.1', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-02-20 02:29:12.038376', 17, 'EXECUTED', '8:d41d8cd98f00b204e9800998ecf8427e', 'empty', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-add-index-to-client.client_id', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-20 02:29:14.321938', 81, 'EXECUTED', '9:be969f08a163bf47c6b9e9ead8ac2afb', 'createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-11.0.0.xml', '2022-02-20 02:29:14.35694', 86, 'EXECUTED', '9:71c5969e6cdd8d7b6f47cebc86d37627', 'dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('13.0.0-KEYCLOAK-17992-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.456396', 95, 'MARK_RAN', '9:8bd711fd0330f4fe980494ca43ab1139', 'addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.525316', 101, 'MARK_RAN', '9:d3d977031d431db16e2c181ce49d73e9', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.6.1', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-02-20 02:29:12.038376', 17, 'EXECUTED', '9:d41d8cd98f00b204e9800998ecf8427e', 'empty', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.9.1', 'keycloak', 'META-INF/jpa-changelog-1.9.1.xml', '2022-02-20 02:29:12.336743', 24, 'EXECUTED', '8:90cff506fedb06141ffc1c71c4a1214c', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.3.0', 'keycloak', 'META-INF/jpa-changelog-3.3.0.xml', '2022-02-20 02:29:13.081867', 44, 'EXECUTED', '9:d48d6da5c6ccf667807f633fe489ce88', 'addColumn tableName=USER_ENTITY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.Final', 'keycloak', 'META-INF/jpa-changelog-1.2.0.Final.xml', '2022-02-20 02:29:11.468415', 9, 'EXECUTED', '9:9d05c7be10cdb873f8bcb41bc3a8ab23', 'update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.8.0-2', 'keycloak', 'META-INF/jpa-changelog-1.8.0.xml', '2022-02-20 02:29:12.276411', 20, 'EXECUTED', '9:f91ddca9b19743db60e3057679810e6c', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('20.0.0-12964-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2022-11-11 14:02:11.636169', 109, 'MARK_RAN', '9:1a6fcaa85e20bdeae0a9ce49b41946a5', 'createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE', '', NULL, '4.8.0', NULL, NULL, '8175330925');
INSERT INTO keycloak.databasechangelog VALUES ('2.2.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.2.0.xml', '2022-02-20 02:29:12.653927', 30, 'EXECUTED', '9:a7022af5267f019d020edfe316ef4371', 'addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-2.5.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.5.1.xml', '2022-02-20 02:29:12.521759', 28, 'EXECUTED', '8:d1bf991a6163c0acbfe664b615314505', 'update tableName=RESOURCE_SERVER_POLICY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0-unicode-other-dbs', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-20 02:29:12.765543', 35, 'EXECUTED', '9:33d72168746f81f98ae3a1e8e0ca3554', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.2.0-fix', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2022-02-20 02:29:12.802507', 40, 'MARK_RAN', '9:938f894c032f5430f2b0fafb1a243462', 'addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.2.0-fixed', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2022-02-20 02:29:13.072876', 43, 'EXECUTED', '9:59a64800e3c0d09b825f8a3b444fa8f4', 'addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.2-KEYCLOAK-5172', 'mkanis@redhat.com', 'META-INF/jpa-changelog-3.4.2.xml', '2022-02-20 02:29:13.394921', 54, 'EXECUTED', '9:9156214268f09d970cdf0e1564d866af', 'update tableName=CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.2.0-fix-offline-sessions', 'hmlnarik', 'META-INF/jpa-changelog-3.2.0.xml', '2022-02-20 02:29:12.815019', 42, 'EXECUTED', '8:ab91cf9cee415867ade0e2df9651a947', 'customChange', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.0.0-KEYCLOAK-6228', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-02-20 02:29:13.519511', 57, 'EXECUTED', '9:079899dade9c1e683f26b2aa9ca6ff04', 'dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-20 02:29:13.104878', 47, 'MARK_RAN', '8:7be68b71d2f5b94b8df2e824f2860fa2', 'dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-4.0.0.CR1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.CR1.xml', '2022-02-20 02:29:13.903113', 59, 'EXECUTED', '9:b55738ad889860c625ba2bf483495a04', 'createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('18.0.15-30992-index-consent', 'keycloak', 'META-INF/jpa-changelog-18.0.15.xml', '2024-08-19 13:57:49.112299', 126, 'EXECUTED', '9:80071ede7a05604b1f4906f3bf3b00f0', 'createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE', '', NULL, '4.25.1', NULL, NULL, '4075868511');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.2', 'keycloak', 'META-INF/jpa-changelog-3.4.2.xml', '2022-02-20 02:29:13.384287', 53, 'EXECUTED', '8:2e12e06e45498406db72d5b3da5bbc76', 'update tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('client-attributes-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2022-11-11 14:02:11.676052', 110, 'EXECUTED', '9:3f332e13e90739ed0c35b0b25b7822ca', 'addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.8.0', NULL, NULL, '8175330925');
INSERT INTO keycloak.databasechangelog VALUES ('client-attributes-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2022-11-11 14:02:11.676052', 110, 'EXECUTED', '9:3f332e13e90739ed0c35b0b25b7822ca', 'addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.8.0', NULL, NULL, '8175330925');
INSERT INTO keycloak.databasechangelog VALUES ('1.8.0-2', 'keycloak', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2022-02-20 02:29:12.283956', 22, 'MARK_RAN', '9:f91ddca9b19743db60e3057679810e6c', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.4.0.xml', '2022-02-20 02:29:12.69774', 32, 'EXECUTED', '9:eac4ffb2a14795e5dc7b426063e54d88', 'customChange', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-3.4.1.xml', '2022-02-20 02:29:13.374939', 52, 'EXECUTED', '9:5a6bb36cbefb6a9d6928452c0852af2d', 'modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-4.2.0.Final-KEYCLOAK-9944', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2022-02-20 02:29:13.964713', 62, 'EXECUTED', '9:9968206fca46eecc1f51db9c024bfe56', 'addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.7.0-KEYCLOAK-7275', 'keycloak', 'META-INF/jpa-changelog-4.7.0.xml', '2022-02-20 02:29:14.109164', 69, 'EXECUTED', '9:f53177f137e1c46b6a88c59ec1cb5218', 'renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-updating-credential-data-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-20 02:29:14.19905', 74, 'MARK_RAN', '9:14706f286953fc9a25286dbd8fb30d97', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.0-recreate-constraints-after-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-02-20 02:29:14.311647', 80, 'MARK_RAN', '9:077cba51999515f4d3e7ad5619ab592c', 'addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-add-index-to-client.client_id', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-20 02:29:14.321938', 81, 'EXECUTED', '9:be969f08a163bf47c6b9e9ead8ac2afb', 'createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-11.0.0.xml', '2022-02-20 02:29:14.35694', 86, 'EXECUTED', '9:71c5969e6cdd8d7b6f47cebc86d37627', 'dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.0-drop-constraints-for-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-02-20 02:29:14.276103', 78, 'MARK_RAN', '8:2d8ed5aaaeffd0cb004c046b4a903ac5', 'dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-add-not-null-constraint', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-20 02:29:14.334313', 83, 'EXECUTED', '8:3fb99bcad86a0229783123ac52f7609c', 'addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('13.0.0-KEYCLOAK-17992-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.456396', 95, 'MARK_RAN', '9:8bd711fd0330f4fe980494ca43ab1139', 'addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2022-02-20 02:29:14.370745', 87, 'EXECUTED', '8:e3fb1e698e0471487f51af1ed80fe3ac', 'dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('client-attributes-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2022-11-11 14:02:11.676052', 110, 'EXECUTED', '9:3f332e13e90739ed0c35b0b25b7822ca', 'addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.8.0', NULL, NULL, '8175330925');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-credential-cleanup-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-20 02:29:14.251421', 75, 'EXECUTED', '9:2b9cc12779be32c5b40e2e67711a218b', 'dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('default-roles-cleanup', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.407746', 90, 'EXECUTED', '9:67ac3241df9a8582d591c5ed87125f39', 'dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('map-remove-ri-13.0.0', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.433817', 92, 'EXECUTED', '9:d9be619d94af5a2f5d07b9f003543b91', 'dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-11019', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.486305', 97, 'EXECUTED', '8:75f3e372df18d38c62734eebb986b960', 'createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.525316', 101, 'MARK_RAN', '9:d3d977031d431db16e2c181ce49d73e9', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('client-attributes-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2022-11-11 14:02:11.676052', 110, 'EXECUTED', '9:3f332e13e90739ed0c35b0b25b7822ca', 'addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.8.0', NULL, NULL, '8175330925');
INSERT INTO keycloak.databasechangelog VALUES ('25.0.0-28265-tables', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2024-08-19 13:57:49.207808', 127, 'EXECUTED', '9:deda2df035df23388af95bbd36c17cef', 'addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION', '', NULL, '4.25.1', NULL, NULL, '4075868511');
INSERT INTO keycloak.databasechangelog VALUES ('20.0.0-12964-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2022-11-11 14:02:11.497503', 108, 'EXECUTED', '8:05c99fc610845ef66ee812b7921af0ef', 'createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE', '', NULL, '4.8.0', NULL, NULL, '8175330925');
INSERT INTO keycloak.databasechangelog VALUES ('25.0.0-28265-index-creation', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2024-08-19 13:57:49.245772', 128, 'EXECUTED', '9:3e96709818458ae49f3c679ae58d263a', 'createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION', '', NULL, '4.25.1', NULL, NULL, '4075868511');
INSERT INTO keycloak.databasechangelog VALUES ('25.0.0-28265-index-cleanup', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2024-08-19 13:57:49.279776', 129, 'EXECUTED', '9:8c0cfa341a0474385b324f5c4b2dfcc1', 'dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION; dropIndex ...', '', NULL, '4.25.1', NULL, NULL, '4075868511');
INSERT INTO keycloak.databasechangelog VALUES ('22.0.0-17484', 'keycloak', 'META-INF/jpa-changelog-22.0.0.xml', '2023-09-18 12:13:36.801706', 114, 'EXECUTED', '8:4c3d4e8b142a66fcdf21b89a4dd33301', 'customChange', '', NULL, '4.20.0', NULL, NULL, '5039214870');
INSERT INTO keycloak.databasechangelog VALUES ('25.0.0-28265-index-2-mysql', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2024-08-19 13:57:49.286189', 130, 'MARK_RAN', '9:b7ef76036d3126bb83c2423bf4d449d6', 'createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION', '', NULL, '4.25.1', NULL, NULL, '4075868511');
INSERT INTO keycloak.databasechangelog VALUES ('22.0.0-17484', 'keycloak', 'META-INF/jpa-changelog-22.0.0.xml', '2023-09-18 12:13:36.801706', 114, 'EXECUTED', '8:4c3d4e8b142a66fcdf21b89a4dd33301', 'customChange', '', NULL, '4.20.0', NULL, NULL, '5039214870');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-revert', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.510542', 99, 'MARK_RAN', '9:04baaf56c116ed19951cbc2cca584022', 'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('KEYCLOAK-17267-add-index-to-user-attributes', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.535183', 102, 'EXECUTED', '9:0b305d8d1277f3a89a0a53a659ad274c', 'createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('15.0.0-KEYCLOAK-18467', 'keycloak', 'META-INF/jpa-changelog-15.0.0.xml', '2022-02-20 02:29:14.558209', 104, 'EXECUTED', '9:47a760639ac597360a8219f5b768b4de', 'addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('15.0.0-KEYCLOAK-18467', 'keycloak', 'META-INF/jpa-changelog-15.0.0.xml', '2022-02-20 02:29:14.558209', 104, 'EXECUTED', '9:47a760639ac597360a8219f5b768b4de', 'addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('15.0.0-KEYCLOAK-18467', 'keycloak', 'META-INF/jpa-changelog-15.0.0.xml', '2022-02-20 02:29:14.558209', 104, 'EXECUTED', '9:47a760639ac597360a8219f5b768b4de', 'addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('15.0.0-KEYCLOAK-18467', 'keycloak', 'META-INF/jpa-changelog-15.0.0.xml', '2022-02-20 02:29:14.558209', 104, 'EXECUTED', '9:47a760639ac597360a8219f5b768b4de', 'addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('17.0.0-9562', 'keycloak', 'META-INF/jpa-changelog-17.0.0.xml', '2022-02-20 02:29:14.568829', 105, 'EXECUTED', '9:a6272f0576727dd8cad2522335f5d99e', 'createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('15.0.0-KEYCLOAK-18467', 'keycloak', 'META-INF/jpa-changelog-15.0.0.xml', '2022-02-20 02:29:14.558209', 104, 'EXECUTED', '9:47a760639ac597360a8219f5b768b4de', 'addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('15.0.0-KEYCLOAK-18467', 'keycloak', 'META-INF/jpa-changelog-15.0.0.xml', '2022-02-20 02:29:14.558209', 104, 'EXECUTED', '9:47a760639ac597360a8219f5b768b4de', 'addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.0.0.Final.xml', '2022-02-20 02:29:10.911069', 1, 'EXECUTED', '9:6f1016664e21e16d26517a4418f5e3df', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-20 02:29:12.70932', 33, 'EXECUTED', '9:54937c05672568c4c64fc9524c1e9462', 'customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('20.0.0-12964-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2022-11-11 14:02:11.636169', 109, 'MARK_RAN', '9:1a6fcaa85e20bdeae0a9ce49b41946a5', 'createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE', '', NULL, '4.8.0', NULL, NULL, '8175330925');
INSERT INTO keycloak.databasechangelog VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.0.0.Final.xml', '2022-02-20 02:29:10.911069', 1, 'EXECUTED', '9:6f1016664e21e16d26517a4418f5e3df', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.0.0.Final.xml', '2022-02-20 02:29:10.911069', 1, 'EXECUTED', '9:6f1016664e21e16d26517a4418f5e3df', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.0.0.Final.xml', '2022-02-20 02:29:10.911069', 1, 'EXECUTED', '9:6f1016664e21e16d26517a4418f5e3df', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.0.0.Final.xml', '2022-02-20 02:29:10.911069', 1, 'EXECUTED', '9:6f1016664e21e16d26517a4418f5e3df', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.1.0.Beta1', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Beta1.xml', '2022-02-20 02:29:11.03107', 3, 'EXECUTED', '9:5f090e44a7d595883c1fb61f4b41fd38', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.1.0.Beta1', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Beta1.xml', '2022-02-20 02:29:11.03107', 3, 'EXECUTED', '9:5f090e44a7d595883c1fb61f4b41fd38', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.1.0.Beta1', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Beta1.xml', '2022-02-20 02:29:11.03107', 3, 'EXECUTED', '9:5f090e44a7d595883c1fb61f4b41fd38', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.1.0.Beta1', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Beta1.xml', '2022-02-20 02:29:11.03107', 3, 'EXECUTED', '9:5f090e44a7d595883c1fb61f4b41fd38', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.1.0.Beta1', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Beta1.xml', '2022-02-20 02:29:11.03107', 3, 'EXECUTED', '9:5f090e44a7d595883c1fb61f4b41fd38', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/jpa-changelog-1.2.0.Beta1.xml', '2022-02-20 02:29:11.284894', 5, 'EXECUTED', '9:b68ce996c655922dbcd2fe6b6ae72686', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/jpa-changelog-1.2.0.Beta1.xml', '2022-02-20 02:29:11.284894', 5, 'EXECUTED', '9:b68ce996c655922dbcd2fe6b6ae72686', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/jpa-changelog-1.2.0.Beta1.xml', '2022-02-20 02:29:11.284894', 5, 'EXECUTED', '9:b68ce996c655922dbcd2fe6b6ae72686', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/jpa-changelog-1.2.0.Beta1.xml', '2022-02-20 02:29:11.284894', 5, 'EXECUTED', '9:b68ce996c655922dbcd2fe6b6ae72686', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/jpa-changelog-1.2.0.Beta1.xml', '2022-02-20 02:29:11.284894', 5, 'EXECUTED', '9:b68ce996c655922dbcd2fe6b6ae72686', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/jpa-changelog-1.2.0.Beta1.xml', '2022-02-20 02:29:11.284894', 5, 'EXECUTED', '9:b68ce996c655922dbcd2fe6b6ae72686', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.2.0.CR1.xml', '2022-02-20 02:29:11.453462', 7, 'EXECUTED', '9:765afebbe21cf5bbca048e632df38336', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.2.0.CR1.xml', '2022-02-20 02:29:11.453462', 7, 'EXECUTED', '9:765afebbe21cf5bbca048e632df38336', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('19.0.0-10135', 'keycloak', 'META-INF/jpa-changelog-19.0.0.xml', '2022-10-18 01:21:07.50842', 107, 'EXECUTED', '9:9518e495fdd22f78ad6425cc30630221', 'customChange', '', NULL, '4.8.0', NULL, NULL, '6056067286');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.2.0.CR1.xml', '2022-02-20 02:29:11.453462', 7, 'EXECUTED', '9:765afebbe21cf5bbca048e632df38336', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.2.0.CR1.xml', '2022-02-20 02:29:11.453462', 7, 'EXECUTED', '9:765afebbe21cf5bbca048e632df38336', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.2.0.CR1.xml', '2022-02-20 02:29:11.453462', 7, 'EXECUTED', '9:765afebbe21cf5bbca048e632df38336', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.2.0.CR1.xml', '2022-02-20 02:29:11.453462', 7, 'EXECUTED', '9:765afebbe21cf5bbca048e632df38336', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.CR1.xml', '2022-02-20 02:29:11.458362', 8, 'MARK_RAN', '9:db4a145ba11a6fdaefb397f6dbf829a1', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.CR1.xml', '2022-02-20 02:29:11.458362', 8, 'MARK_RAN', '9:db4a145ba11a6fdaefb397f6dbf829a1', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.CR1.xml', '2022-02-20 02:29:11.458362', 8, 'MARK_RAN', '9:db4a145ba11a6fdaefb397f6dbf829a1', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.CR1.xml', '2022-02-20 02:29:11.458362', 8, 'MARK_RAN', '9:db4a145ba11a6fdaefb397f6dbf829a1', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.CR1.xml', '2022-02-20 02:29:11.458362', 8, 'MARK_RAN', '9:db4a145ba11a6fdaefb397f6dbf829a1', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.CR1.xml', '2022-02-20 02:29:11.458362', 8, 'MARK_RAN', '9:db4a145ba11a6fdaefb397f6dbf829a1', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.3.0.xml', '2022-02-20 02:29:11.835242', 10, 'EXECUTED', '9:18593702353128d53111f9b1ff0b82b8', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.3.0.xml', '2022-02-20 02:29:11.835242', 10, 'EXECUTED', '9:18593702353128d53111f9b1ff0b82b8', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.3.0.xml', '2022-02-20 02:29:11.835242', 10, 'EXECUTED', '9:18593702353128d53111f9b1ff0b82b8', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.3.0.xml', '2022-02-20 02:29:11.835242', 10, 'EXECUTED', '9:18593702353128d53111f9b1ff0b82b8', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.3.0.xml', '2022-02-20 02:29:11.835242', 10, 'EXECUTED', '9:18593702353128d53111f9b1ff0b82b8', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.3.0.xml', '2022-02-20 02:29:11.835242', 10, 'EXECUTED', '9:18593702353128d53111f9b1ff0b82b8', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.5.0.xml', '2022-02-20 02:29:11.992545', 13, 'EXECUTED', '9:7af32cd8957fbc069f796b61217483fd', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.5.0.xml', '2022-02-20 02:29:11.992545', 13, 'EXECUTED', '9:7af32cd8957fbc069f796b61217483fd', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('19.0.0-10135', 'keycloak', 'META-INF/jpa-changelog-19.0.0.xml', '2022-10-18 01:21:07.50842', 107, 'EXECUTED', '9:9518e495fdd22f78ad6425cc30630221', 'customChange', '', NULL, '4.8.0', NULL, NULL, '6056067286');
INSERT INTO keycloak.databasechangelog VALUES ('19.0.0-10135', 'keycloak', 'META-INF/jpa-changelog-19.0.0.xml', '2022-10-18 01:21:07.50842', 107, 'EXECUTED', '9:9518e495fdd22f78ad6425cc30630221', 'customChange', '', NULL, '4.8.0', NULL, NULL, '6056067286');
INSERT INTO keycloak.databasechangelog VALUES ('1.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.5.0.xml', '2022-02-20 02:29:11.992545', 13, 'EXECUTED', '9:7af32cd8957fbc069f796b61217483fd', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.5.0.xml', '2022-02-20 02:29:11.992545', 13, 'EXECUTED', '9:7af32cd8957fbc069f796b61217483fd', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.5.0.xml', '2022-02-20 02:29:11.992545', 13, 'EXECUTED', '9:7af32cd8957fbc069f796b61217483fd', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.5.0.xml', '2022-02-20 02:29:11.992545', 13, 'EXECUTED', '9:7af32cd8957fbc069f796b61217483fd', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.6.1_from16', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-02-20 02:29:12.03411', 16, 'MARK_RAN', '9:f8dadc9284440469dcf71e25ca6ab99b', 'dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.6.1_from16', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-02-20 02:29:12.03411', 16, 'MARK_RAN', '9:f8dadc9284440469dcf71e25ca6ab99b', 'dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.6.1_from16', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-02-20 02:29:12.03411', 16, 'MARK_RAN', '9:f8dadc9284440469dcf71e25ca6ab99b', 'dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.6.1_from16', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-02-20 02:29:12.03411', 16, 'MARK_RAN', '9:f8dadc9284440469dcf71e25ca6ab99b', 'dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.6.1_from16', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-02-20 02:29:12.03411', 16, 'MARK_RAN', '9:f8dadc9284440469dcf71e25ca6ab99b', 'dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.6.1_from16', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-02-20 02:29:12.03411', 16, 'MARK_RAN', '9:f8dadc9284440469dcf71e25ca6ab99b', 'dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.8.0.xml', '2022-02-20 02:29:12.267911', 19, 'EXECUTED', '9:8ac2fb5dd030b24c0570a763ed75ed20', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.8.0.xml', '2022-02-20 02:29:12.267911', 19, 'EXECUTED', '9:8ac2fb5dd030b24c0570a763ed75ed20', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.8.0.xml', '2022-02-20 02:29:12.267911', 19, 'EXECUTED', '9:8ac2fb5dd030b24c0570a763ed75ed20', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.8.0.xml', '2022-02-20 02:29:12.267911', 19, 'EXECUTED', '9:8ac2fb5dd030b24c0570a763ed75ed20', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.8.0.xml', '2022-02-20 02:29:12.267911', 19, 'EXECUTED', '9:8ac2fb5dd030b24c0570a763ed75ed20', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.8.0.xml', '2022-02-20 02:29:12.267911', 19, 'EXECUTED', '9:8ac2fb5dd030b24c0570a763ed75ed20', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.8.0-2', 'keycloak', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2022-02-20 02:29:12.283956', 22, 'MARK_RAN', '9:f91ddca9b19743db60e3057679810e6c', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.8.0-2', 'keycloak', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2022-02-20 02:29:12.283956', 22, 'MARK_RAN', '9:f91ddca9b19743db60e3057679810e6c', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.8.0-2', 'keycloak', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2022-02-20 02:29:12.283956', 22, 'MARK_RAN', '9:f91ddca9b19743db60e3057679810e6c', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.8.0-2', 'keycloak', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2022-02-20 02:29:12.283956', 22, 'MARK_RAN', '9:f91ddca9b19743db60e3057679810e6c', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('19.0.0-10135', 'keycloak', 'META-INF/jpa-changelog-19.0.0.xml', '2022-10-18 01:21:07.50842', 107, 'EXECUTED', '9:9518e495fdd22f78ad6425cc30630221', 'customChange', '', NULL, '4.8.0', NULL, NULL, '6056067286');
INSERT INTO keycloak.databasechangelog VALUES ('1.8.0-2', 'keycloak', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2022-02-20 02:29:12.283956', 22, 'MARK_RAN', '9:f91ddca9b19743db60e3057679810e6c', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.3.0', 'keycloak', 'META-INF/jpa-changelog-3.3.0.xml', '2022-02-20 02:29:13.081867', 44, 'EXECUTED', '9:d48d6da5c6ccf667807f633fe489ce88', 'addColumn tableName=USER_ENTITY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-20 02:29:12.70932', 33, 'EXECUTED', '9:54937c05672568c4c64fc9524c1e9462', 'customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-20 02:29:12.70932', 33, 'EXECUTED', '9:54937c05672568c4c64fc9524c1e9462', 'customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-20 02:29:12.70932', 33, 'EXECUTED', '9:54937c05672568c4c64fc9524c1e9462', 'customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-20 02:29:12.70932', 33, 'EXECUTED', '9:54937c05672568c4c64fc9524c1e9462', 'customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-20 02:29:12.70932', 33, 'EXECUTED', '9:54937c05672568c4c64fc9524c1e9462', 'customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0-unicode-oracle', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-20 02:29:12.713384', 34, 'MARK_RAN', '9:3a32bace77c84d7678d035a7f5a8084e', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0-unicode-oracle', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-20 02:29:12.713384', 34, 'MARK_RAN', '9:3a32bace77c84d7678d035a7f5a8084e', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0-unicode-oracle', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-20 02:29:12.713384', 34, 'MARK_RAN', '9:3a32bace77c84d7678d035a7f5a8084e', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0-unicode-oracle', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-20 02:29:12.713384', 34, 'MARK_RAN', '9:3a32bace77c84d7678d035a7f5a8084e', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0-unicode-oracle', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-20 02:29:12.713384', 34, 'MARK_RAN', '9:3a32bace77c84d7678d035a7f5a8084e', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0-unicode-oracle', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-20 02:29:12.713384', 34, 'MARK_RAN', '9:3a32bace77c84d7678d035a7f5a8084e', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0-unique-group-names', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-20 02:29:12.783855', 37, 'EXECUTED', '9:8dcac7bdf7378e7d823cdfddebf72fda', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0-unique-group-names', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-20 02:29:12.783855', 37, 'EXECUTED', '9:8dcac7bdf7378e7d823cdfddebf72fda', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0-unique-group-names', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-20 02:29:12.783855', 37, 'EXECUTED', '9:8dcac7bdf7378e7d823cdfddebf72fda', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0-unique-group-names', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-20 02:29:12.783855', 37, 'EXECUTED', '9:8dcac7bdf7378e7d823cdfddebf72fda', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0-unique-group-names', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-20 02:29:12.783855', 37, 'EXECUTED', '9:8dcac7bdf7378e7d823cdfddebf72fda', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0-unique-group-names', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-20 02:29:12.783855', 37, 'EXECUTED', '9:8dcac7bdf7378e7d823cdfddebf72fda', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.1', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.1.xml', '2022-02-20 02:29:12.791434', 38, 'EXECUTED', '9:a2b870802540cb3faa72098db5388af3', 'addColumn tableName=FED_USER_CONSENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.1', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.1.xml', '2022-02-20 02:29:12.791434', 38, 'EXECUTED', '9:a2b870802540cb3faa72098db5388af3', 'addColumn tableName=FED_USER_CONSENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.1', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.1.xml', '2022-02-20 02:29:12.791434', 38, 'EXECUTED', '9:a2b870802540cb3faa72098db5388af3', 'addColumn tableName=FED_USER_CONSENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.1', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.1.xml', '2022-02-20 02:29:12.791434', 38, 'EXECUTED', '9:a2b870802540cb3faa72098db5388af3', 'addColumn tableName=FED_USER_CONSENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.1', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.1.xml', '2022-02-20 02:29:12.791434', 38, 'EXECUTED', '9:a2b870802540cb3faa72098db5388af3', 'addColumn tableName=FED_USER_CONSENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.1', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.1.xml', '2022-02-20 02:29:12.791434', 38, 'EXECUTED', '9:a2b870802540cb3faa72098db5388af3', 'addColumn tableName=FED_USER_CONSENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.0.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-3.0.0.xml', '2022-02-20 02:29:12.798777', 39, 'EXECUTED', '9:132a67499ba24bcc54fb5cbdcfe7e4c0', 'addColumn tableName=IDENTITY_PROVIDER', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.0.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-3.0.0.xml', '2022-02-20 02:29:12.798777', 39, 'EXECUTED', '9:132a67499ba24bcc54fb5cbdcfe7e4c0', 'addColumn tableName=IDENTITY_PROVIDER', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.0.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-3.0.0.xml', '2022-02-20 02:29:12.798777', 39, 'EXECUTED', '9:132a67499ba24bcc54fb5cbdcfe7e4c0', 'addColumn tableName=IDENTITY_PROVIDER', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.0.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-3.0.0.xml', '2022-02-20 02:29:12.798777', 39, 'EXECUTED', '9:132a67499ba24bcc54fb5cbdcfe7e4c0', 'addColumn tableName=IDENTITY_PROVIDER', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.0.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-3.0.0.xml', '2022-02-20 02:29:12.798777', 39, 'EXECUTED', '9:132a67499ba24bcc54fb5cbdcfe7e4c0', 'addColumn tableName=IDENTITY_PROVIDER', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.0.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-3.0.0.xml', '2022-02-20 02:29:12.798777', 39, 'EXECUTED', '9:132a67499ba24bcc54fb5cbdcfe7e4c0', 'addColumn tableName=IDENTITY_PROVIDER', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.3.0', 'keycloak', 'META-INF/jpa-changelog-3.3.0.xml', '2022-02-20 02:29:13.081867', 44, 'EXECUTED', '9:d48d6da5c6ccf667807f633fe489ce88', 'addColumn tableName=USER_ENTITY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.3.0', 'keycloak', 'META-INF/jpa-changelog-3.3.0.xml', '2022-02-20 02:29:13.081867', 44, 'EXECUTED', '9:d48d6da5c6ccf667807f633fe489ce88', 'addColumn tableName=USER_ENTITY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.3.0', 'keycloak', 'META-INF/jpa-changelog-3.3.0.xml', '2022-02-20 02:29:13.081867', 44, 'EXECUTED', '9:d48d6da5c6ccf667807f633fe489ce88', 'addColumn tableName=USER_ENTITY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-20 02:29:13.192976', 48, 'EXECUTED', '9:bdc99e567b3398bac83263d375aad143', 'addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-20 02:29:13.192976', 48, 'EXECUTED', '9:bdc99e567b3398bac83263d375aad143', 'addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-20 02:29:13.192976', 48, 'EXECUTED', '9:bdc99e567b3398bac83263d375aad143', 'addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-20 02:29:13.192976', 48, 'EXECUTED', '9:bdc99e567b3398bac83263d375aad143', 'addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-20 02:29:13.192976', 48, 'EXECUTED', '9:bdc99e567b3398bac83263d375aad143', 'addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-20 02:29:13.192976', 48, 'EXECUTED', '9:bdc99e567b3398bac83263d375aad143', 'addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authn-3.4.0.CR1-refresh-token-max-reuse', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-20 02:29:13.201294', 49, 'EXECUTED', '9:d198654156881c46bfba39abd7769e69', 'addColumn tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authn-3.4.0.CR1-refresh-token-max-reuse', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-20 02:29:13.201294', 49, 'EXECUTED', '9:d198654156881c46bfba39abd7769e69', 'addColumn tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authn-3.4.0.CR1-refresh-token-max-reuse', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-20 02:29:13.201294', 49, 'EXECUTED', '9:d198654156881c46bfba39abd7769e69', 'addColumn tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authn-3.4.0.CR1-refresh-token-max-reuse', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-20 02:29:13.201294', 49, 'EXECUTED', '9:d198654156881c46bfba39abd7769e69', 'addColumn tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authn-3.4.0.CR1-refresh-token-max-reuse', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-20 02:29:13.201294', 49, 'EXECUTED', '9:d198654156881c46bfba39abd7769e69', 'addColumn tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authn-3.4.0.CR1-refresh-token-max-reuse', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-20 02:29:13.201294', 49, 'EXECUTED', '9:d198654156881c46bfba39abd7769e69', 'addColumn tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.0.0-KEYCLOAK-5579-fixed', 'mposolda@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-02-20 02:29:13.83071', 58, 'EXECUTED', '9:139b79bcbbfe903bb1c2d2a4dbf001d9', 'dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.0.0-KEYCLOAK-5579-fixed', 'mposolda@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-02-20 02:29:13.83071', 58, 'EXECUTED', '9:139b79bcbbfe903bb1c2d2a4dbf001d9', 'dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.0.0-KEYCLOAK-5579-fixed', 'mposolda@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-02-20 02:29:13.83071', 58, 'EXECUTED', '9:139b79bcbbfe903bb1c2d2a4dbf001d9', 'dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('19.0.0-10135', 'keycloak', 'META-INF/jpa-changelog-19.0.0.xml', '2022-10-18 01:21:07.50842', 107, 'EXECUTED', '9:9518e495fdd22f78ad6425cc30630221', 'customChange', '', NULL, '4.8.0', NULL, NULL, '6056067286');
INSERT INTO keycloak.databasechangelog VALUES ('4.0.0-KEYCLOAK-5579-fixed', 'mposolda@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-02-20 02:29:13.83071', 58, 'EXECUTED', '9:139b79bcbbfe903bb1c2d2a4dbf001d9', 'dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.0.0-KEYCLOAK-5579-fixed', 'mposolda@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-02-20 02:29:13.83071', 58, 'EXECUTED', '9:139b79bcbbfe903bb1c2d2a4dbf001d9', 'dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.0.0-KEYCLOAK-5579-fixed', 'mposolda@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-02-20 02:29:13.83071', 58, 'EXECUTED', '9:139b79bcbbfe903bb1c2d2a4dbf001d9', 'dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.0-always-display-client', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-02-20 02:29:14.272162', 77, 'EXECUTED', '9:6335e5c94e83a2639ccd68dd24e2e5ad', 'addColumn tableName=CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-4.0.0.Beta3', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.Beta3.xml', '2022-02-20 02:29:13.922883', 60, 'EXECUTED', '9:e0057eac39aa8fc8e09ac6cfa4ae15fe', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-4.0.0.Beta3', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.Beta3.xml', '2022-02-20 02:29:13.922883', 60, 'EXECUTED', '9:e0057eac39aa8fc8e09ac6cfa4ae15fe', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-4.0.0.Beta3', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.Beta3.xml', '2022-02-20 02:29:13.922883', 60, 'EXECUTED', '9:e0057eac39aa8fc8e09ac6cfa4ae15fe', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-4.0.0.Beta3', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.Beta3.xml', '2022-02-20 02:29:13.922883', 60, 'EXECUTED', '9:e0057eac39aa8fc8e09ac6cfa4ae15fe', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-4.0.0.Beta3', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.Beta3.xml', '2022-02-20 02:29:13.922883', 60, 'EXECUTED', '9:e0057eac39aa8fc8e09ac6cfa4ae15fe', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-4.0.0.Beta3', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.Beta3.xml', '2022-02-20 02:29:13.922883', 60, 'EXECUTED', '9:e0057eac39aa8fc8e09ac6cfa4ae15fe', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.2.0-KEYCLOAK-6313', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.2.0.xml', '2022-02-20 02:29:13.976221', 63, 'EXECUTED', '9:92143a6daea0a3f3b8f598c97ce55c3d', 'addColumn tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.2.0-KEYCLOAK-6313', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.2.0.xml', '2022-02-20 02:29:13.976221', 63, 'EXECUTED', '9:92143a6daea0a3f3b8f598c97ce55c3d', 'addColumn tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.2.0-KEYCLOAK-6313', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.2.0.xml', '2022-02-20 02:29:13.976221', 63, 'EXECUTED', '9:92143a6daea0a3f3b8f598c97ce55c3d', 'addColumn tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.2.0-KEYCLOAK-6313', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.2.0.xml', '2022-02-20 02:29:13.976221', 63, 'EXECUTED', '9:92143a6daea0a3f3b8f598c97ce55c3d', 'addColumn tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.2.0-KEYCLOAK-6313', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.2.0.xml', '2022-02-20 02:29:13.976221', 63, 'EXECUTED', '9:92143a6daea0a3f3b8f598c97ce55c3d', 'addColumn tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.2.0-KEYCLOAK-6313', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.2.0.xml', '2022-02-20 02:29:13.976221', 63, 'EXECUTED', '9:92143a6daea0a3f3b8f598c97ce55c3d', 'addColumn tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.3.0-KEYCLOAK-7984', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.3.0.xml', '2022-02-20 02:29:13.986568', 64, 'EXECUTED', '9:82bab26a27195d889fb0429003b18f40', 'update tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.3.0-KEYCLOAK-7984', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.3.0.xml', '2022-02-20 02:29:13.986568', 64, 'EXECUTED', '9:82bab26a27195d889fb0429003b18f40', 'update tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.3.0-KEYCLOAK-7984', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.3.0.xml', '2022-02-20 02:29:13.986568', 64, 'EXECUTED', '9:82bab26a27195d889fb0429003b18f40', 'update tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.3.0-KEYCLOAK-7984', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.3.0.xml', '2022-02-20 02:29:13.986568', 64, 'EXECUTED', '9:82bab26a27195d889fb0429003b18f40', 'update tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.3.0-KEYCLOAK-7984', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.3.0.xml', '2022-02-20 02:29:13.986568', 64, 'EXECUTED', '9:82bab26a27195d889fb0429003b18f40', 'update tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.3.0-KEYCLOAK-7984', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.3.0.xml', '2022-02-20 02:29:13.986568', 64, 'EXECUTED', '9:82bab26a27195d889fb0429003b18f40', 'update tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.6.1', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-02-20 02:29:12.038376', 17, 'EXECUTED', '9:d41d8cd98f00b204e9800998ecf8427e', 'empty', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.6.0-KEYCLOAK-8377', 'keycloak', 'META-INF/jpa-changelog-4.6.0.xml', '2022-02-20 02:29:14.045569', 66, 'EXECUTED', '9:5c1f475536118dbdc38d5d7977950cc0', 'createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.6.0-KEYCLOAK-8377', 'keycloak', 'META-INF/jpa-changelog-4.6.0.xml', '2022-02-20 02:29:14.045569', 66, 'EXECUTED', '9:5c1f475536118dbdc38d5d7977950cc0', 'createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('19.0.0-10135', 'keycloak', 'META-INF/jpa-changelog-19.0.0.xml', '2022-10-18 01:21:07.50842', 107, 'EXECUTED', '9:9518e495fdd22f78ad6425cc30630221', 'customChange', '', NULL, '4.8.0', NULL, NULL, '6056067286');
INSERT INTO keycloak.databasechangelog VALUES ('4.6.0-KEYCLOAK-8377', 'keycloak', 'META-INF/jpa-changelog-4.6.0.xml', '2022-02-20 02:29:14.045569', 66, 'EXECUTED', '9:5c1f475536118dbdc38d5d7977950cc0', 'createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.6.0-KEYCLOAK-8377', 'keycloak', 'META-INF/jpa-changelog-4.6.0.xml', '2022-02-20 02:29:14.045569', 66, 'EXECUTED', '9:5c1f475536118dbdc38d5d7977950cc0', 'createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.6.0-KEYCLOAK-8377', 'keycloak', 'META-INF/jpa-changelog-4.6.0.xml', '2022-02-20 02:29:14.045569', 66, 'EXECUTED', '9:5c1f475536118dbdc38d5d7977950cc0', 'createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.6.0-KEYCLOAK-8377', 'keycloak', 'META-INF/jpa-changelog-4.6.0.xml', '2022-02-20 02:29:14.045569', 66, 'EXECUTED', '9:5c1f475536118dbdc38d5d7977950cc0', 'createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.7.0-KEYCLOAK-1267', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.7.0.xml', '2022-02-20 02:29:14.076821', 68, 'EXECUTED', '9:88e0bfdda924690d6f4e430c53447dd5', 'addColumn tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.7.0-KEYCLOAK-1267', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.7.0.xml', '2022-02-20 02:29:14.076821', 68, 'EXECUTED', '9:88e0bfdda924690d6f4e430c53447dd5', 'addColumn tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.7.0-KEYCLOAK-1267', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.7.0.xml', '2022-02-20 02:29:14.076821', 68, 'EXECUTED', '9:88e0bfdda924690d6f4e430c53447dd5', 'addColumn tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.7.0-KEYCLOAK-1267', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.7.0.xml', '2022-02-20 02:29:14.076821', 68, 'EXECUTED', '9:88e0bfdda924690d6f4e430c53447dd5', 'addColumn tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.7.0-KEYCLOAK-1267', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.7.0.xml', '2022-02-20 02:29:14.076821', 68, 'EXECUTED', '9:88e0bfdda924690d6f4e430c53447dd5', 'addColumn tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.7.0-KEYCLOAK-1267', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.7.0.xml', '2022-02-20 02:29:14.076821', 68, 'EXECUTED', '9:88e0bfdda924690d6f4e430c53447dd5', 'addColumn tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-7.0.0-KEYCLOAK-10443', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-7.0.0.xml', '2022-02-20 02:29:14.147179', 71, 'EXECUTED', '9:fd4ade7b90c3b67fae0bfcfcb42dfb5f', 'addColumn tableName=RESOURCE_SERVER', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-7.0.0-KEYCLOAK-10443', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-7.0.0.xml', '2022-02-20 02:29:14.147179', 71, 'EXECUTED', '9:fd4ade7b90c3b67fae0bfcfcb42dfb5f', 'addColumn tableName=RESOURCE_SERVER', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-7.0.0-KEYCLOAK-10443', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-7.0.0.xml', '2022-02-20 02:29:14.147179', 71, 'EXECUTED', '9:fd4ade7b90c3b67fae0bfcfcb42dfb5f', 'addColumn tableName=RESOURCE_SERVER', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-7.0.0-KEYCLOAK-10443', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-7.0.0.xml', '2022-02-20 02:29:14.147179', 71, 'EXECUTED', '9:fd4ade7b90c3b67fae0bfcfcb42dfb5f', 'addColumn tableName=RESOURCE_SERVER', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-7.0.0-KEYCLOAK-10443', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-7.0.0.xml', '2022-02-20 02:29:14.147179', 71, 'EXECUTED', '9:fd4ade7b90c3b67fae0bfcfcb42dfb5f', 'addColumn tableName=RESOURCE_SERVER', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-7.0.0-KEYCLOAK-10443', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-7.0.0.xml', '2022-02-20 02:29:14.147179', 71, 'EXECUTED', '9:fd4ade7b90c3b67fae0bfcfcb42dfb5f', 'addColumn tableName=RESOURCE_SERVER', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-adding-credential-columns', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-20 02:29:14.169136', 72, 'EXECUTED', '9:aa072ad090bbba210d8f18781b8cebf4', 'addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-adding-credential-columns', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-20 02:29:14.169136', 72, 'EXECUTED', '9:aa072ad090bbba210d8f18781b8cebf4', 'addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-adding-credential-columns', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-20 02:29:14.169136', 72, 'EXECUTED', '9:aa072ad090bbba210d8f18781b8cebf4', 'addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-adding-credential-columns', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-20 02:29:14.169136', 72, 'EXECUTED', '9:aa072ad090bbba210d8f18781b8cebf4', 'addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-adding-credential-columns', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-20 02:29:14.169136', 72, 'EXECUTED', '9:aa072ad090bbba210d8f18781b8cebf4', 'addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-adding-credential-columns', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-20 02:29:14.169136', 72, 'EXECUTED', '9:aa072ad090bbba210d8f18781b8cebf4', 'addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-updating-credential-data-not-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-20 02:29:14.192481', 73, 'EXECUTED', '9:1ae6be29bab7c2aa376f6983b932be37', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-updating-credential-data-not-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-20 02:29:14.192481', 73, 'EXECUTED', '9:1ae6be29bab7c2aa376f6983b932be37', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-updating-credential-data-not-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-20 02:29:14.192481', 73, 'EXECUTED', '9:1ae6be29bab7c2aa376f6983b932be37', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-updating-credential-data-not-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-20 02:29:14.192481', 73, 'EXECUTED', '9:1ae6be29bab7c2aa376f6983b932be37', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-updating-credential-data-not-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-20 02:29:14.192481', 73, 'EXECUTED', '9:1ae6be29bab7c2aa376f6983b932be37', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-updating-credential-data-not-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-20 02:29:14.192481', 73, 'EXECUTED', '9:1ae6be29bab7c2aa376f6983b932be37', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.0-always-display-client', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-02-20 02:29:14.272162', 77, 'EXECUTED', '9:6335e5c94e83a2639ccd68dd24e2e5ad', 'addColumn tableName=CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.0-always-display-client', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-02-20 02:29:14.272162', 77, 'EXECUTED', '9:6335e5c94e83a2639ccd68dd24e2e5ad', 'addColumn tableName=CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.0-always-display-client', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-02-20 02:29:14.272162', 77, 'EXECUTED', '9:6335e5c94e83a2639ccd68dd24e2e5ad', 'addColumn tableName=CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.0-always-display-client', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-02-20 02:29:14.272162', 77, 'EXECUTED', '9:6335e5c94e83a2639ccd68dd24e2e5ad', 'addColumn tableName=CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.0-always-display-client', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-02-20 02:29:14.272162', 77, 'EXECUTED', '9:6335e5c94e83a2639ccd68dd24e2e5ad', 'addColumn tableName=CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.0-increase-column-size-federated-fk', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-02-20 02:29:14.30686', 79, 'EXECUTED', '9:d5bc15a64117ccad481ce8792d4c608f', 'modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.0-increase-column-size-federated-fk', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-02-20 02:29:14.30686', 79, 'EXECUTED', '9:d5bc15a64117ccad481ce8792d4c608f', 'modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.0-increase-column-size-federated-fk', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-02-20 02:29:14.30686', 79, 'EXECUTED', '9:d5bc15a64117ccad481ce8792d4c608f', 'modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.0-increase-column-size-federated-fk', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-02-20 02:29:14.30686', 79, 'EXECUTED', '9:d5bc15a64117ccad481ce8792d4c608f', 'modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.0-increase-column-size-federated-fk', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-02-20 02:29:14.30686', 79, 'EXECUTED', '9:d5bc15a64117ccad481ce8792d4c608f', 'modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.0-increase-column-size-federated-fk', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-02-20 02:29:14.30686', 79, 'EXECUTED', '9:d5bc15a64117ccad481ce8792d4c608f', 'modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-20 02:29:14.325752', 82, 'MARK_RAN', '9:6d3bb4408ba5a72f39bd8a0b301ec6e3', 'dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-20 02:29:14.325752', 82, 'MARK_RAN', '9:6d3bb4408ba5a72f39bd8a0b301ec6e3', 'dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-20 02:29:14.325752', 82, 'MARK_RAN', '9:6d3bb4408ba5a72f39bd8a0b301ec6e3', 'dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-20 02:29:14.325752', 82, 'MARK_RAN', '9:6d3bb4408ba5a72f39bd8a0b301ec6e3', 'dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-20 02:29:14.325752', 82, 'MARK_RAN', '9:6d3bb4408ba5a72f39bd8a0b301ec6e3', 'dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-20 02:29:14.325752', 82, 'MARK_RAN', '9:6d3bb4408ba5a72f39bd8a0b301ec6e3', 'dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-20 02:29:14.338063', 84, 'MARK_RAN', '9:8dcac7bdf7378e7d823cdfddebf72fda', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-20 02:29:14.338063', 84, 'MARK_RAN', '9:8dcac7bdf7378e7d823cdfddebf72fda', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-20 02:29:14.338063', 84, 'MARK_RAN', '9:8dcac7bdf7378e7d823cdfddebf72fda', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-20 02:29:14.338063', 84, 'MARK_RAN', '9:8dcac7bdf7378e7d823cdfddebf72fda', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-20 02:29:14.338063', 84, 'MARK_RAN', '9:8dcac7bdf7378e7d823cdfddebf72fda', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-20 02:29:14.338063', 84, 'MARK_RAN', '9:8dcac7bdf7378e7d823cdfddebf72fda', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('12.1.0-add-realm-localization-table', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2022-02-20 02:29:14.385933', 88, 'EXECUTED', '9:fffabce2bc01e1a8f5110d5278500065', 'createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('12.1.0-add-realm-localization-table', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2022-02-20 02:29:14.385933', 88, 'EXECUTED', '9:fffabce2bc01e1a8f5110d5278500065', 'createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('12.1.0-add-realm-localization-table', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2022-02-20 02:29:14.385933', 88, 'EXECUTED', '9:fffabce2bc01e1a8f5110d5278500065', 'createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('12.1.0-add-realm-localization-table', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2022-02-20 02:29:14.385933', 88, 'EXECUTED', '9:fffabce2bc01e1a8f5110d5278500065', 'createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('12.1.0-add-realm-localization-table', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2022-02-20 02:29:14.385933', 88, 'EXECUTED', '9:fffabce2bc01e1a8f5110d5278500065', 'createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('12.1.0-add-realm-localization-table', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2022-02-20 02:29:14.385933', 88, 'EXECUTED', '9:fffabce2bc01e1a8f5110d5278500065', 'createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('default-roles', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.396507', 89, 'EXECUTED', '9:fa8a5b5445e3857f4b010bafb5009957', 'addColumn tableName=REALM; customChange', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('default-roles', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.396507', 89, 'EXECUTED', '9:fa8a5b5445e3857f4b010bafb5009957', 'addColumn tableName=REALM; customChange', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('default-roles', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.396507', 89, 'EXECUTED', '9:fa8a5b5445e3857f4b010bafb5009957', 'addColumn tableName=REALM; customChange', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('default-roles', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.396507', 89, 'EXECUTED', '9:fa8a5b5445e3857f4b010bafb5009957', 'addColumn tableName=REALM; customChange', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('default-roles', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.396507', 89, 'EXECUTED', '9:fa8a5b5445e3857f4b010bafb5009957', 'addColumn tableName=REALM; customChange', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('default-roles', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.396507', 89, 'EXECUTED', '9:fa8a5b5445e3857f4b010bafb5009957', 'addColumn tableName=REALM; customChange', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('13.0.0-KEYCLOAK-17992-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.437946', 93, 'MARK_RAN', '9:544d201116a0fcc5a5da0925fbbc3bde', 'dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('13.0.0-KEYCLOAK-17992-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.437946', 93, 'MARK_RAN', '9:544d201116a0fcc5a5da0925fbbc3bde', 'dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('13.0.0-KEYCLOAK-17992-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.437946', 93, 'MARK_RAN', '9:544d201116a0fcc5a5da0925fbbc3bde', 'dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('13.0.0-KEYCLOAK-17992-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.437946', 93, 'MARK_RAN', '9:544d201116a0fcc5a5da0925fbbc3bde', 'dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('13.0.0-KEYCLOAK-17992-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.437946', 93, 'MARK_RAN', '9:544d201116a0fcc5a5da0925fbbc3bde', 'dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('13.0.0-KEYCLOAK-17992-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.437946', 93, 'MARK_RAN', '9:544d201116a0fcc5a5da0925fbbc3bde', 'dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-revert', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.510542', 99, 'MARK_RAN', '9:04baaf56c116ed19951cbc2cca584022', 'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-revert', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.510542', 99, 'MARK_RAN', '9:04baaf56c116ed19951cbc2cca584022', 'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-revert', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.510542', 99, 'MARK_RAN', '9:04baaf56c116ed19951cbc2cca584022', 'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-revert', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.510542', 99, 'MARK_RAN', '9:04baaf56c116ed19951cbc2cca584022', 'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-revert', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.510542', 99, 'MARK_RAN', '9:04baaf56c116ed19951cbc2cca584022', 'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('KEYCLOAK-17267-add-index-to-user-attributes', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.535183', 102, 'EXECUTED', '9:0b305d8d1277f3a89a0a53a659ad274c', 'createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('KEYCLOAK-17267-add-index-to-user-attributes', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.535183', 102, 'EXECUTED', '9:0b305d8d1277f3a89a0a53a659ad274c', 'createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('KEYCLOAK-17267-add-index-to-user-attributes', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.535183', 102, 'EXECUTED', '9:0b305d8d1277f3a89a0a53a659ad274c', 'createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('25.0.0-28265-index-2-not-mysql', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2024-08-19 13:57:49.303517', 131, 'EXECUTED', '9:23396cf51ab8bc1ae6f0cac7f9f6fcf7', 'createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION', '', NULL, '4.25.1', NULL, NULL, '4075868511');
INSERT INTO keycloak.databasechangelog VALUES ('KEYCLOAK-17267-add-index-to-user-attributes', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.535183', 102, 'EXECUTED', '9:0b305d8d1277f3a89a0a53a659ad274c', 'createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.0.0.Final.xml', '2022-02-20 02:29:10.911069', 1, 'EXECUTED', '9:6f1016664e21e16d26517a4418f5e3df', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.1.0.Beta1', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Beta1.xml', '2022-02-20 02:29:11.03107', 3, 'EXECUTED', '9:5f090e44a7d595883c1fb61f4b41fd38', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('22.0.0-17484', 'keycloak', 'META-INF/jpa-changelog-22.0.0.xml', '2023-09-18 12:13:36.801706', 114, 'EXECUTED', '8:4c3d4e8b142a66fcdf21b89a4dd33301', 'customChange', '', NULL, '4.20.0', NULL, NULL, '5039214870');
INSERT INTO keycloak.databasechangelog VALUES ('authz-2.5.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.5.1.xml', '2022-02-20 02:29:12.521759', 28, 'EXECUTED', '9:44bae577f551b3738740281eceb4ea70', 'update tableName=RESOURCE_SERVER_POLICY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/db2-jpa-changelog-1.0.0.Final.xml', '2022-02-20 02:29:10.932074', 2, 'MARK_RAN', '9:828775b1596a07d1200ba1d49e5e3941', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/db2-jpa-changelog-1.0.0.Final.xml', '2022-02-20 02:29:10.932074', 2, 'MARK_RAN', '9:828775b1596a07d1200ba1d49e5e3941', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/db2-jpa-changelog-1.0.0.Final.xml', '2022-02-20 02:29:10.932074', 2, 'MARK_RAN', '9:828775b1596a07d1200ba1d49e5e3941', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.4.0.xml', '2022-02-20 02:29:11.941244', 11, 'EXECUTED', '9:6122efe5f090e41a85c0f1c9e52cbb62', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.4.0.xml', '2022-02-20 02:29:11.941244', 11, 'EXECUTED', '9:6122efe5f090e41a85c0f1c9e52cbb62', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.4.0.xml', '2022-02-20 02:29:11.941244', 11, 'EXECUTED', '9:6122efe5f090e41a85c0f1c9e52cbb62', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.Final', 'keycloak', 'META-INF/jpa-changelog-1.2.0.Final.xml', '2022-02-20 02:29:11.468415', 9, 'EXECUTED', '9:9d05c7be10cdb873f8bcb41bc3a8ab23', 'update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.Final', 'keycloak', 'META-INF/jpa-changelog-1.2.0.Final.xml', '2022-02-20 02:29:11.468415', 9, 'EXECUTED', '9:9d05c7be10cdb873f8bcb41bc3a8ab23', 'update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.Final', 'keycloak', 'META-INF/jpa-changelog-1.2.0.Final.xml', '2022-02-20 02:29:11.468415', 9, 'EXECUTED', '9:9d05c7be10cdb873f8bcb41bc3a8ab23', 'update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.Final', 'keycloak', 'META-INF/jpa-changelog-1.2.0.Final.xml', '2022-02-20 02:29:11.468415', 9, 'EXECUTED', '9:9d05c7be10cdb873f8bcb41bc3a8ab23', 'update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.4.0.xml', '2022-02-20 02:29:12.69774', 32, 'EXECUTED', '9:eac4ffb2a14795e5dc7b426063e54d88', 'customChange', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.6.1_from15', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-02-20 02:29:12.025994', 14, 'EXECUTED', '9:6005e15e84714cd83226bf7879f54190', 'addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.6.1_from15', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-02-20 02:29:12.025994', 14, 'EXECUTED', '9:6005e15e84714cd83226bf7879f54190', 'addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.6.1_from15', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-02-20 02:29:12.025994', 14, 'EXECUTED', '9:6005e15e84714cd83226bf7879f54190', 'addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.6.1_from15', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-02-20 02:29:12.025994', 14, 'EXECUTED', '9:6005e15e84714cd83226bf7879f54190', 'addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.4.0.xml', '2022-02-20 02:29:11.94605', 12, 'MARK_RAN', '9:e1ff28bf7568451453f844c5d54bb0b5', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.4.0.xml', '2022-02-20 02:29:11.94605', 12, 'MARK_RAN', '9:e1ff28bf7568451453f844c5d54bb0b5', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('25.0.0-org', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2024-08-19 13:57:49.390114', 132, 'EXECUTED', '9:5c859965c2c9b9c72136c360649af157', 'createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN', '', NULL, '4.25.1', NULL, NULL, '4075868511');
INSERT INTO keycloak.databasechangelog VALUES ('1.6.1', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-02-20 02:29:12.038376', 17, 'EXECUTED', '9:d41d8cd98f00b204e9800998ecf8427e', 'empty', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.6.1', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-02-20 02:29:12.038376', 17, 'EXECUTED', '9:d41d8cd98f00b204e9800998ecf8427e', 'empty', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('unique-consentuser', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2024-08-19 13:57:49.476782', 133, 'EXECUTED', '9:5857626a2ea8767e9a6c66bf3a2cb32f', 'customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...', '', NULL, '4.25.1', NULL, NULL, '4075868511');
INSERT INTO keycloak.databasechangelog VALUES ('unique-consentuser-mysql', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2024-08-19 13:57:49.484636', 134, 'MARK_RAN', '9:b79478aad5adaa1bc428e31563f55e8e', 'customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...', '', NULL, '4.25.1', NULL, NULL, '4075868511');
INSERT INTO keycloak.databasechangelog VALUES ('25.0.0-28861-index-creation', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2024-08-19 13:57:49.530299', 135, 'EXECUTED', '9:b9acb58ac958d9ada0fe12a5d4794ab1', 'createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET', '', NULL, '4.25.1', NULL, NULL, '4075868511');
INSERT INTO keycloak.databasechangelog VALUES ('1.8.0-2', 'keycloak', 'META-INF/jpa-changelog-1.8.0.xml', '2022-02-20 02:29:12.276411', 20, 'EXECUTED', '9:f91ddca9b19743db60e3057679810e6c', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.8.0-2', 'keycloak', 'META-INF/jpa-changelog-1.8.0.xml', '2022-02-20 02:29:12.276411', 20, 'EXECUTED', '9:f91ddca9b19743db60e3057679810e6c', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.8.0-2', 'keycloak', 'META-INF/jpa-changelog-1.8.0.xml', '2022-02-20 02:29:12.276411', 20, 'EXECUTED', '9:f91ddca9b19743db60e3057679810e6c', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.8.0-2', 'keycloak', 'META-INF/jpa-changelog-1.8.0.xml', '2022-02-20 02:29:12.276411', 20, 'EXECUTED', '9:f91ddca9b19743db60e3057679810e6c', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.4.0.xml', '2022-02-20 02:29:12.69774', 32, 'EXECUTED', '9:eac4ffb2a14795e5dc7b426063e54d88', 'customChange', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.9.2', 'keycloak', 'META-INF/jpa-changelog-1.9.2.xml', '2022-02-20 02:29:12.3975', 26, 'EXECUTED', '9:fc576660fc016ae53d2d4778d84d86d0', 'createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.9.2', 'keycloak', 'META-INF/jpa-changelog-1.9.2.xml', '2022-02-20 02:29:12.3975', 26, 'EXECUTED', '9:fc576660fc016ae53d2d4778d84d86d0', 'createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.9.2', 'keycloak', 'META-INF/jpa-changelog-1.9.2.xml', '2022-02-20 02:29:12.3975', 26, 'EXECUTED', '9:fc576660fc016ae53d2d4778d84d86d0', 'createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.9.2', 'keycloak', 'META-INF/jpa-changelog-1.9.2.xml', '2022-02-20 02:29:12.3975', 26, 'EXECUTED', '9:fc576660fc016ae53d2d4778d84d86d0', 'createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('map-remove-ri-13.0.0', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.433817', 92, 'EXECUTED', '9:d9be619d94af5a2f5d07b9f003543b91', 'dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.9.1', 'keycloak', 'META-INF/jpa-changelog-1.9.1.xml', '2022-02-20 02:29:12.336743', 24, 'EXECUTED', '9:c9999da42f543575ab790e76439a2679', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.9.1', 'keycloak', 'META-INF/jpa-changelog-1.9.1.xml', '2022-02-20 02:29:12.336743', 24, 'EXECUTED', '9:c9999da42f543575ab790e76439a2679', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.9.1', 'keycloak', 'META-INF/jpa-changelog-1.9.1.xml', '2022-02-20 02:29:12.336743', 24, 'EXECUTED', '9:c9999da42f543575ab790e76439a2679', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.9.1', 'keycloak', 'META-INF/jpa-changelog-1.9.1.xml', '2022-02-20 02:29:12.336743', 24, 'EXECUTED', '9:c9999da42f543575ab790e76439a2679', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.9.1', 'keycloak', 'META-INF/db2-jpa-changelog-1.9.1.xml', '2022-02-20 02:29:12.341091', 25, 'MARK_RAN', '9:0d6c65c6f58732d81569e77b10ba301d', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.9.1', 'keycloak', 'META-INF/db2-jpa-changelog-1.9.1.xml', '2022-02-20 02:29:12.341091', 25, 'MARK_RAN', '9:0d6c65c6f58732d81569e77b10ba301d', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.9.1', 'keycloak', 'META-INF/db2-jpa-changelog-1.9.1.xml', '2022-02-20 02:29:12.341091', 25, 'MARK_RAN', '9:0d6c65c6f58732d81569e77b10ba301d', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.9.1', 'keycloak', 'META-INF/db2-jpa-changelog-1.9.1.xml', '2022-02-20 02:29:12.341091', 25, 'MARK_RAN', '9:0d6c65c6f58732d81569e77b10ba301d', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('map-remove-ri-13.0.0', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.433817', 92, 'EXECUTED', '9:d9be619d94af5a2f5d07b9f003543b91', 'dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('26.0.0-org-alias', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2024-11-09 16:41:20.333744', 136, 'EXECUTED', '9:6ef7d63e4412b3c2d66ed179159886a4', 'addColumn tableName=ORG; update tableName=ORG; addNotNullConstraint columnName=ALIAS, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_ALIAS, tableName=ORG', '', NULL, '4.29.1', NULL, NULL, '1084079126');
INSERT INTO keycloak.databasechangelog VALUES ('26.0.0-org-group', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2024-11-09 16:41:20.540448', 137, 'EXECUTED', '9:da8e8087d80ef2ace4f89d8c5b9ca223', 'addColumn tableName=KEYCLOAK_GROUP; update tableName=KEYCLOAK_GROUP; addNotNullConstraint columnName=TYPE, tableName=KEYCLOAK_GROUP; customChange', '', NULL, '4.29.1', NULL, NULL, '1084079126');
INSERT INTO keycloak.databasechangelog VALUES ('26.0.0-org-indexes', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2024-11-09 16:41:21.279702', 138, 'EXECUTED', '9:79b05dcd610a8c7f25ec05135eec0857', 'createIndex indexName=IDX_ORG_DOMAIN_ORG_ID, tableName=ORG_DOMAIN', '', NULL, '4.29.1', NULL, NULL, '1084079126');
INSERT INTO keycloak.databasechangelog VALUES ('26.0.0-org-group-membership', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2024-11-09 16:41:21.457245', 139, 'EXECUTED', '9:a6ace2ce583a421d89b01ba2a28dc2d4', 'addColumn tableName=USER_GROUP_MEMBERSHIP; update tableName=USER_GROUP_MEMBERSHIP; addNotNullConstraint columnName=MEMBERSHIP_TYPE, tableName=USER_GROUP_MEMBERSHIP', '', NULL, '4.29.1', NULL, NULL, '1084079126');
INSERT INTO keycloak.databasechangelog VALUES ('authz-2.5.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.5.1.xml', '2022-02-20 02:29:12.521759', 28, 'EXECUTED', '9:44bae577f551b3738740281eceb4ea70', 'update tableName=RESOURCE_SERVER_POLICY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-2.5.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.5.1.xml', '2022-02-20 02:29:12.521759', 28, 'EXECUTED', '9:44bae577f551b3738740281eceb4ea70', 'update tableName=RESOURCE_SERVER_POLICY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-2.5.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.5.1.xml', '2022-02-20 02:29:12.521759', 28, 'EXECUTED', '9:44bae577f551b3738740281eceb4ea70', 'update tableName=RESOURCE_SERVER_POLICY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.2.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.2.0.xml', '2022-02-20 02:29:12.653927', 30, 'EXECUTED', '9:a7022af5267f019d020edfe316ef4371', 'addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.2.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.2.0.xml', '2022-02-20 02:29:12.653927', 30, 'EXECUTED', '9:a7022af5267f019d020edfe316ef4371', 'addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.2.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.2.0.xml', '2022-02-20 02:29:12.653927', 30, 'EXECUTED', '9:a7022af5267f019d020edfe316ef4371', 'addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.2.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.2.0.xml', '2022-02-20 02:29:12.653927', 30, 'EXECUTED', '9:a7022af5267f019d020edfe316ef4371', 'addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0-unicode-other-dbs', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-20 02:29:12.765543', 35, 'EXECUTED', '9:33d72168746f81f98ae3a1e8e0ca3554', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0-unicode-other-dbs', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-20 02:29:12.765543', 35, 'EXECUTED', '9:33d72168746f81f98ae3a1e8e0ca3554', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0-unicode-other-dbs', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-20 02:29:12.765543', 35, 'EXECUTED', '9:33d72168746f81f98ae3a1e8e0ca3554', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0-unicode-other-dbs', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-20 02:29:12.765543', 35, 'EXECUTED', '9:33d72168746f81f98ae3a1e8e0ca3554', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.4.0.xml', '2022-02-20 02:29:12.69774', 32, 'EXECUTED', '9:eac4ffb2a14795e5dc7b426063e54d88', 'customChange', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('31296-persist-revoked-access-tokens', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2024-11-09 16:41:21.540693', 140, 'EXECUTED', '9:64ef94489d42a358e8304b0e245f0ed4', 'createTable tableName=REVOKED_TOKEN; addPrimaryKey constraintName=CONSTRAINT_RT, tableName=REVOKED_TOKEN', '', NULL, '4.29.1', NULL, NULL, '1084079126');
INSERT INTO keycloak.databasechangelog VALUES ('31725-index-persist-revoked-access-tokens', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2024-11-09 16:41:22.019532', 141, 'EXECUTED', '9:b994246ec2bf7c94da881e1d28782c7b', 'createIndex indexName=IDX_REV_TOKEN_ON_EXPIRE, tableName=REVOKED_TOKEN', '', NULL, '4.29.1', NULL, NULL, '1084079126');
INSERT INTO keycloak.databasechangelog VALUES ('26.0.0-idps-for-login', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2024-11-09 16:41:22.583371', 142, 'EXECUTED', '9:51f5fffadf986983d4bd59582c6c1604', 'addColumn tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_REALM_ORG, tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER; customChange', '', NULL, '4.29.1', NULL, NULL, '1084079126');
INSERT INTO keycloak.databasechangelog VALUES ('26.0.0-32583-drop-redundant-index-on-client-session', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2024-11-09 16:41:22.724898', 143, 'EXECUTED', '9:24972d83bf27317a055d234187bb4af9', 'dropIndex indexName=IDX_US_SESS_ID_ON_CL_SESS, tableName=OFFLINE_CLIENT_SESSION', '', NULL, '4.29.1', NULL, NULL, '1084079126');
INSERT INTO keycloak.databasechangelog VALUES ('26.0.0.32582-remove-tables-user-session-user-session-note-and-client-session', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2024-11-09 16:41:22.77496', 144, 'EXECUTED', '9:febdc0f47f2ed241c59e60f58c3ceea5', 'dropTable tableName=CLIENT_SESSION_ROLE; dropTable tableName=CLIENT_SESSION_NOTE; dropTable tableName=CLIENT_SESSION_PROT_MAPPER; dropTable tableName=CLIENT_SESSION_AUTH_STATUS; dropTable tableName=CLIENT_USER_SESSION_NOTE; dropTable tableName=CLI...', '', NULL, '4.29.1', NULL, NULL, '1084079126');
INSERT INTO keycloak.databasechangelog VALUES ('26.0.0-33201-org-redirect-url', 'keycloak', 'META-INF/jpa-changelog-26.0.0.xml', '2024-11-09 16:41:22.799521', 145, 'EXECUTED', '9:4d0e22b0ac68ebe9794fa9cb752ea660', 'addColumn tableName=ORG', '', NULL, '4.29.1', NULL, NULL, '1084079126');
INSERT INTO keycloak.databasechangelog VALUES ('3.2.0-fix', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2022-02-20 02:29:12.802507', 40, 'MARK_RAN', '9:938f894c032f5430f2b0fafb1a243462', 'addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.2.0-fix', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2022-02-20 02:29:12.802507', 40, 'MARK_RAN', '9:938f894c032f5430f2b0fafb1a243462', 'addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.2.0-fix', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2022-02-20 02:29:12.802507', 40, 'MARK_RAN', '9:938f894c032f5430f2b0fafb1a243462', 'addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.2.0-fix', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2022-02-20 02:29:12.802507', 40, 'MARK_RAN', '9:938f894c032f5430f2b0fafb1a243462', 'addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.2.0-fixed', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2022-02-20 02:29:13.072876', 43, 'EXECUTED', '9:59a64800e3c0d09b825f8a3b444fa8f4', 'addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.2.0-fixed', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2022-02-20 02:29:13.072876', 43, 'EXECUTED', '9:59a64800e3c0d09b825f8a3b444fa8f4', 'addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.2.0-fixed', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2022-02-20 02:29:13.072876', 43, 'EXECUTED', '9:59a64800e3c0d09b825f8a3b444fa8f4', 'addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.2.0-fix-offline-sessions', 'hmlnarik', 'META-INF/jpa-changelog-3.2.0.xml', '2022-02-20 02:29:12.815019', 42, 'EXECUTED', '9:fc86359c079781adc577c5a217e4d04c', 'customChange', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.2.0-fix-offline-sessions', 'hmlnarik', 'META-INF/jpa-changelog-3.2.0.xml', '2022-02-20 02:29:12.815019', 42, 'EXECUTED', '9:fc86359c079781adc577c5a217e4d04c', 'customChange', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.2.0-fix-offline-sessions', 'hmlnarik', 'META-INF/jpa-changelog-3.2.0.xml', '2022-02-20 02:29:12.815019', 42, 'EXECUTED', '9:fc86359c079781adc577c5a217e4d04c', 'customChange', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.2.0-fix-offline-sessions', 'hmlnarik', 'META-INF/jpa-changelog-3.2.0.xml', '2022-02-20 02:29:12.815019', 42, 'EXECUTED', '9:fc86359c079781adc577c5a217e4d04c', 'customChange', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.2.0-fixed', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2022-02-20 02:29:13.072876', 43, 'EXECUTED', '9:59a64800e3c0d09b825f8a3b444fa8f4', 'addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.2-KEYCLOAK-5172', 'mkanis@redhat.com', 'META-INF/jpa-changelog-3.4.2.xml', '2022-02-20 02:29:13.394921', 54, 'EXECUTED', '9:9156214268f09d970cdf0e1564d866af', 'update tableName=CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-20 02:29:13.104878', 47, 'MARK_RAN', '9:51abbacd7b416c50c4421a8cabf7927e', 'dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-20 02:29:13.104878', 47, 'MARK_RAN', '9:51abbacd7b416c50c4421a8cabf7927e', 'dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-20 02:29:13.104878', 47, 'MARK_RAN', '9:51abbacd7b416c50c4421a8cabf7927e', 'dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-20 02:29:13.104878', 47, 'MARK_RAN', '9:51abbacd7b416c50c4421a8cabf7927e', 'dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.2-KEYCLOAK-5172', 'mkanis@redhat.com', 'META-INF/jpa-changelog-3.4.2.xml', '2022-02-20 02:29:13.394921', 54, 'EXECUTED', '9:9156214268f09d970cdf0e1564d866af', 'update tableName=CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.2-KEYCLOAK-5172', 'mkanis@redhat.com', 'META-INF/jpa-changelog-3.4.2.xml', '2022-02-20 02:29:13.394921', 54, 'EXECUTED', '9:9156214268f09d970cdf0e1564d866af', 'update tableName=CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.2-KEYCLOAK-5172', 'mkanis@redhat.com', 'META-INF/jpa-changelog-3.4.2.xml', '2022-02-20 02:29:13.394921', 54, 'EXECUTED', '9:9156214268f09d970cdf0e1564d866af', 'update tableName=CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-3.4.1.xml', '2022-02-20 02:29:13.374939', 52, 'EXECUTED', '9:5a6bb36cbefb6a9d6928452c0852af2d', 'modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-3.4.1.xml', '2022-02-20 02:29:13.374939', 52, 'EXECUTED', '9:5a6bb36cbefb6a9d6928452c0852af2d', 'modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-3.4.1.xml', '2022-02-20 02:29:13.374939', 52, 'EXECUTED', '9:5a6bb36cbefb6a9d6928452c0852af2d', 'modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-3.4.1.xml', '2022-02-20 02:29:13.374939', 52, 'EXECUTED', '9:5a6bb36cbefb6a9d6928452c0852af2d', 'modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.2', 'keycloak', 'META-INF/jpa-changelog-3.4.2.xml', '2022-02-20 02:29:13.384287', 53, 'EXECUTED', '9:8f23e334dbc59f82e0a328373ca6ced0', 'update tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.2', 'keycloak', 'META-INF/jpa-changelog-3.4.2.xml', '2022-02-20 02:29:13.384287', 53, 'EXECUTED', '9:8f23e334dbc59f82e0a328373ca6ced0', 'update tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.2', 'keycloak', 'META-INF/jpa-changelog-3.4.2.xml', '2022-02-20 02:29:13.384287', 53, 'EXECUTED', '9:8f23e334dbc59f82e0a328373ca6ced0', 'update tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.2', 'keycloak', 'META-INF/jpa-changelog-3.4.2.xml', '2022-02-20 02:29:13.384287', 53, 'EXECUTED', '9:8f23e334dbc59f82e0a328373ca6ced0', 'update tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.0.0-KEYCLOAK-6228', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-02-20 02:29:13.519511', 57, 'EXECUTED', '9:079899dade9c1e683f26b2aa9ca6ff04', 'dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.0.0-KEYCLOAK-6228', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-02-20 02:29:13.519511', 57, 'EXECUTED', '9:079899dade9c1e683f26b2aa9ca6ff04', 'dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.0.0-KEYCLOAK-6228', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-02-20 02:29:13.519511', 57, 'EXECUTED', '9:079899dade9c1e683f26b2aa9ca6ff04', 'dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.0.0-KEYCLOAK-6228', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-02-20 02:29:13.519511', 57, 'EXECUTED', '9:079899dade9c1e683f26b2aa9ca6ff04', 'dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-4.0.0.CR1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.CR1.xml', '2022-02-20 02:29:13.903113', 59, 'EXECUTED', '9:b55738ad889860c625ba2bf483495a04', 'createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-4.0.0.CR1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.CR1.xml', '2022-02-20 02:29:13.903113', 59, 'EXECUTED', '9:b55738ad889860c625ba2bf483495a04', 'createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-4.0.0.CR1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.CR1.xml', '2022-02-20 02:29:13.903113', 59, 'EXECUTED', '9:b55738ad889860c625ba2bf483495a04', 'createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-4.0.0.CR1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.CR1.xml', '2022-02-20 02:29:13.903113', 59, 'EXECUTED', '9:b55738ad889860c625ba2bf483495a04', 'createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-4.2.0.Final-KEYCLOAK-9944', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2022-02-20 02:29:13.964713', 62, 'EXECUTED', '9:9968206fca46eecc1f51db9c024bfe56', 'addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-4.2.0.Final-KEYCLOAK-9944', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2022-02-20 02:29:13.964713', 62, 'EXECUTED', '9:9968206fca46eecc1f51db9c024bfe56', 'addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-4.2.0.Final-KEYCLOAK-9944', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2022-02-20 02:29:13.964713', 62, 'EXECUTED', '9:9968206fca46eecc1f51db9c024bfe56', 'addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.7.0-KEYCLOAK-7275', 'keycloak', 'META-INF/jpa-changelog-4.7.0.xml', '2022-02-20 02:29:14.109164', 69, 'EXECUTED', '9:f53177f137e1c46b6a88c59ec1cb5218', 'renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.7.0-KEYCLOAK-7275', 'keycloak', 'META-INF/jpa-changelog-4.7.0.xml', '2022-02-20 02:29:14.109164', 69, 'EXECUTED', '9:f53177f137e1c46b6a88c59ec1cb5218', 'renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.7.0-KEYCLOAK-7275', 'keycloak', 'META-INF/jpa-changelog-4.7.0.xml', '2022-02-20 02:29:14.109164', 69, 'EXECUTED', '9:f53177f137e1c46b6a88c59ec1cb5218', 'renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.7.0-KEYCLOAK-7275', 'keycloak', 'META-INF/jpa-changelog-4.7.0.xml', '2022-02-20 02:29:14.109164', 69, 'EXECUTED', '9:f53177f137e1c46b6a88c59ec1cb5218', 'renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-updating-credential-data-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-20 02:29:14.19905', 74, 'MARK_RAN', '9:14706f286953fc9a25286dbd8fb30d97', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-updating-credential-data-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-20 02:29:14.19905', 74, 'MARK_RAN', '9:14706f286953fc9a25286dbd8fb30d97', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-credential-cleanup-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-20 02:29:14.251421', 75, 'EXECUTED', '9:2b9cc12779be32c5b40e2e67711a218b', 'dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-add-not-null-constraint', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-20 02:29:14.334313', 83, 'EXECUTED', '9:966bda61e46bebf3cc39518fbed52fa7', 'addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.0-recreate-constraints-after-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-02-20 02:29:14.311647', 80, 'MARK_RAN', '9:077cba51999515f4d3e7ad5619ab592c', 'addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.0-recreate-constraints-after-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-02-20 02:29:14.311647', 80, 'MARK_RAN', '9:077cba51999515f4d3e7ad5619ab592c', 'addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-add-index-to-client.client_id', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-20 02:29:14.321938', 81, 'EXECUTED', '9:be969f08a163bf47c6b9e9ead8ac2afb', 'createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-credential-cleanup-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-20 02:29:14.251421', 75, 'EXECUTED', '9:2b9cc12779be32c5b40e2e67711a218b', 'dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.0-drop-constraints-for-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-02-20 02:29:14.276103', 78, 'MARK_RAN', '9:6bdb5658951e028bfe16fa0a8228b530', 'dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.0-drop-constraints-for-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-02-20 02:29:14.276103', 78, 'MARK_RAN', '9:6bdb5658951e028bfe16fa0a8228b530', 'dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.0-drop-constraints-for-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-02-20 02:29:14.276103', 78, 'MARK_RAN', '9:6bdb5658951e028bfe16fa0a8228b530', 'dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.0-drop-constraints-for-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-02-20 02:29:14.276103', 78, 'MARK_RAN', '9:6bdb5658951e028bfe16fa0a8228b530', 'dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-add-not-null-constraint', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-20 02:29:14.334313', 83, 'EXECUTED', '9:966bda61e46bebf3cc39518fbed52fa7', 'addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-add-not-null-constraint', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-20 02:29:14.334313', 83, 'EXECUTED', '9:966bda61e46bebf3cc39518fbed52fa7', 'addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-add-not-null-constraint', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-20 02:29:14.334313', 83, 'EXECUTED', '9:966bda61e46bebf3cc39518fbed52fa7', 'addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-credential-cleanup-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-20 02:29:14.251421', 75, 'EXECUTED', '9:2b9cc12779be32c5b40e2e67711a218b', 'dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-credential-cleanup-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-20 02:29:14.251421', 75, 'EXECUTED', '9:2b9cc12779be32c5b40e2e67711a218b', 'dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-11.0.0.xml', '2022-02-20 02:29:14.35694', 86, 'EXECUTED', '9:71c5969e6cdd8d7b6f47cebc86d37627', 'dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-11.0.0.xml', '2022-02-20 02:29:14.35694', 86, 'EXECUTED', '9:71c5969e6cdd8d7b6f47cebc86d37627', 'dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-11.0.0.xml', '2022-02-20 02:29:14.35694', 86, 'EXECUTED', '9:71c5969e6cdd8d7b6f47cebc86d37627', 'dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-11.0.0.xml', '2022-02-20 02:29:14.35694', 86, 'EXECUTED', '9:71c5969e6cdd8d7b6f47cebc86d37627', 'dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2022-02-20 02:29:14.370745', 87, 'EXECUTED', '9:a9ba7d47f065f041b7da856a81762021', 'dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2022-02-20 02:29:14.370745', 87, 'EXECUTED', '9:a9ba7d47f065f041b7da856a81762021', 'dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2022-02-20 02:29:14.370745', 87, 'EXECUTED', '9:a9ba7d47f065f041b7da856a81762021', 'dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2022-02-20 02:29:14.370745', 87, 'EXECUTED', '9:a9ba7d47f065f041b7da856a81762021', 'dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('default-roles-cleanup', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.407746', 90, 'EXECUTED', '9:67ac3241df9a8582d591c5ed87125f39', 'dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('default-roles-cleanup', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.407746', 90, 'EXECUTED', '9:67ac3241df9a8582d591c5ed87125f39', 'dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('default-roles-cleanup', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.407746', 90, 'EXECUTED', '9:67ac3241df9a8582d591c5ed87125f39', 'dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('default-roles-cleanup', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.407746', 90, 'EXECUTED', '9:67ac3241df9a8582d591c5ed87125f39', 'dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('map-remove-ri-13.0.0', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.433817', 92, 'EXECUTED', '9:d9be619d94af5a2f5d07b9f003543b91', 'dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('map-remove-ri-13.0.0', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.433817', 92, 'EXECUTED', '9:d9be619d94af5a2f5d07b9f003543b91', 'dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('13.0.0-KEYCLOAK-17992-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.456396', 95, 'MARK_RAN', '9:8bd711fd0330f4fe980494ca43ab1139', 'addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('13.0.0-KEYCLOAK-17992-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.456396', 95, 'MARK_RAN', '9:8bd711fd0330f4fe980494ca43ab1139', 'addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('13.0.0-KEYCLOAK-17992-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.456396', 95, 'MARK_RAN', '9:8bd711fd0330f4fe980494ca43ab1139', 'addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('13.0.0-KEYCLOAK-17992-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.456396', 95, 'MARK_RAN', '9:8bd711fd0330f4fe980494ca43ab1139', 'addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-11019', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.486305', 97, 'EXECUTED', '9:24fb8611e97f29989bea412aa38d12b7', 'createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-11019', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.486305', 97, 'EXECUTED', '9:24fb8611e97f29989bea412aa38d12b7', 'createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-11019', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.486305', 97, 'EXECUTED', '9:24fb8611e97f29989bea412aa38d12b7', 'createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-11019', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.486305', 97, 'EXECUTED', '9:24fb8611e97f29989bea412aa38d12b7', 'createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.525316', 101, 'MARK_RAN', '9:d3d977031d431db16e2c181ce49d73e9', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.525316', 101, 'MARK_RAN', '9:d3d977031d431db16e2c181ce49d73e9', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.525316', 101, 'MARK_RAN', '9:d3d977031d431db16e2c181ce49d73e9', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.525316', 101, 'MARK_RAN', '9:d3d977031d431db16e2c181ce49d73e9', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('client-attributes-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2022-11-11 14:02:11.676052', 110, 'EXECUTED', '9:3f332e13e90739ed0c35b0b25b7822ca', 'addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.8.0', NULL, NULL, '8175330925');
INSERT INTO keycloak.databasechangelog VALUES ('client-attributes-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2022-11-11 14:02:11.676052', 110, 'EXECUTED', '9:3f332e13e90739ed0c35b0b25b7822ca', 'addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.8.0', NULL, NULL, '8175330925');
INSERT INTO keycloak.databasechangelog VALUES ('17.0.0-9562', 'keycloak', 'META-INF/jpa-changelog-17.0.0.xml', '2022-02-20 02:29:14.568829', 105, 'EXECUTED', '9:a6272f0576727dd8cad2522335f5d99e', 'createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('17.0.0-9562', 'keycloak', 'META-INF/jpa-changelog-17.0.0.xml', '2022-02-20 02:29:14.568829', 105, 'EXECUTED', '9:a6272f0576727dd8cad2522335f5d99e', 'createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('17.0.0-9562', 'keycloak', 'META-INF/jpa-changelog-17.0.0.xml', '2022-02-20 02:29:14.568829', 105, 'EXECUTED', '9:a6272f0576727dd8cad2522335f5d99e', 'createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('20.0.0-12964-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2022-11-11 14:02:11.497503', 108, 'EXECUTED', '9:e5f243877199fd96bcc842f27a1656ac', 'createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE', '', NULL, '4.8.0', NULL, NULL, '8175330925');
INSERT INTO keycloak.databasechangelog VALUES ('20.0.0-12964-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2022-11-11 14:02:11.497503', 108, 'EXECUTED', '9:e5f243877199fd96bcc842f27a1656ac', 'createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE', '', NULL, '4.8.0', NULL, NULL, '8175330925');
INSERT INTO keycloak.databasechangelog VALUES ('20.0.0-12964-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2022-11-11 14:02:11.497503', 108, 'EXECUTED', '9:e5f243877199fd96bcc842f27a1656ac', 'createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE', '', NULL, '4.8.0', NULL, NULL, '8175330925');
INSERT INTO keycloak.databasechangelog VALUES ('20.0.0-12964-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2022-11-11 14:02:11.497503', 108, 'EXECUTED', '9:e5f243877199fd96bcc842f27a1656ac', 'createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE', '', NULL, '4.8.0', NULL, NULL, '8175330925');
INSERT INTO keycloak.databasechangelog VALUES ('17.0.0-9562', 'keycloak', 'META-INF/jpa-changelog-17.0.0.xml', '2022-02-20 02:29:14.568829', 105, 'EXECUTED', '9:a6272f0576727dd8cad2522335f5d99e', 'createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('20.0.0-12964-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2022-11-11 14:02:11.636169', 109, 'MARK_RAN', '9:1a6fcaa85e20bdeae0a9ce49b41946a5', 'createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE', '', NULL, '4.8.0', NULL, NULL, '8175330925');
INSERT INTO keycloak.databasechangelog VALUES ('20.0.0-12964-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2022-11-11 14:02:11.636169', 109, 'MARK_RAN', '9:1a6fcaa85e20bdeae0a9ce49b41946a5', 'createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE', '', NULL, '4.8.0', NULL, NULL, '8175330925');
INSERT INTO keycloak.databasechangelog VALUES ('20.0.0-12964-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2022-11-11 14:02:11.636169', 109, 'MARK_RAN', '9:1a6fcaa85e20bdeae0a9ce49b41946a5', 'createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE', '', NULL, '4.8.0', NULL, NULL, '8175330925');
INSERT INTO keycloak.databasechangelog VALUES ('20.0.0-12964-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2022-11-11 14:02:11.636169', 109, 'MARK_RAN', '9:1a6fcaa85e20bdeae0a9ce49b41946a5', 'createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE', '', NULL, '4.8.0', NULL, NULL, '8175330925');
INSERT INTO keycloak.databasechangelog VALUES ('22.0.0-17484-updated', 'keycloak', 'META-INF/jpa-changelog-22.0.0.xml', '2023-11-22 16:52:56.74277', 115, 'MARK_RAN', '9:90af0bfd30cafc17b9f4d6eccd92b8b3', 'customChange', '', NULL, '4.23.2', NULL, NULL, '0671975585');
INSERT INTO keycloak.databasechangelog VALUES ('22.0.5-24031', 'keycloak', 'META-INF/jpa-changelog-22.0.0.xml', '2023-11-22 16:52:56.780001', 116, 'EXECUTED', '9:a60d2d7b315ec2d3eba9e2f145f9df28', 'customChange', '', NULL, '4.23.2', NULL, NULL, '0671975585');
INSERT INTO keycloak.databasechangelog VALUES ('KEYCLOAK-17267-add-index-to-user-attributes', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.535183', 102, 'EXECUTED', '9:0b305d8d1277f3a89a0a53a659ad274c', 'createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('23.0.0-12062', 'keycloak', 'META-INF/jpa-changelog-23.0.0.xml', '2024-02-16 17:19:38.246671', 117, 'EXECUTED', '9:2168fbe728fec46ae9baf15bf80927b8', 'addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG', '', NULL, '4.23.2', NULL, NULL, '8017576885');
INSERT INTO keycloak.databasechangelog VALUES ('23.0.0-17258', 'keycloak', 'META-INF/jpa-changelog-23.0.0.xml', '2024-02-16 17:19:38.286769', 118, 'EXECUTED', '9:36506d679a83bbfda85a27ea1864dca8', 'addColumn tableName=EVENT_ENTITY', '', NULL, '4.23.2', NULL, NULL, '8017576885');
INSERT INTO keycloak.databasechangelog VALUES ('1.1.0.Final', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Final.xml', '2022-02-20 02:29:11.039898', 4, 'EXECUTED', '9:c07e577387a3d2c04d1adc9aaad8730e', 'renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.1.0.Final', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Final.xml', '2022-02-20 02:29:11.039898', 4, 'EXECUTED', '9:c07e577387a3d2c04d1adc9aaad8730e', 'renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.1.0.Final', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Final.xml', '2022-02-20 02:29:11.039898', 4, 'EXECUTED', '9:c07e577387a3d2c04d1adc9aaad8730e', 'renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.1.0.Final', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Final.xml', '2022-02-20 02:29:11.039898', 4, 'EXECUTED', '9:c07e577387a3d2c04d1adc9aaad8730e', 'renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.1.0.Final', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Final.xml', '2022-02-20 02:29:11.039898', 4, 'EXECUTED', '9:c07e577387a3d2c04d1adc9aaad8730e', 'renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.1.0.Final', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Final.xml', '2022-02-20 02:29:11.039898', 4, 'EXECUTED', '9:c07e577387a3d2c04d1adc9aaad8730e', 'renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.Beta1.xml', '2022-02-20 02:29:11.290958', 6, 'MARK_RAN', '9:543b5c9989f024fe35c6f6c5a97de88e', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.Beta1.xml', '2022-02-20 02:29:11.290958', 6, 'MARK_RAN', '9:543b5c9989f024fe35c6f6c5a97de88e', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.Beta1.xml', '2022-02-20 02:29:11.290958', 6, 'MARK_RAN', '9:543b5c9989f024fe35c6f6c5a97de88e', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('18.0.0-10625-IDX_ADMIN_EVENT_TIME', 'keycloak', 'META-INF/jpa-changelog-18.0.0.xml', '2022-04-21 18:59:49.897065', 106, 'EXECUTED', '9:015479dbd691d9cc8669282f4828c41d', 'createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY', '', NULL, '4.8.0', NULL, NULL, '0567589704');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.Beta1.xml', '2022-02-20 02:29:11.290958', 6, 'MARK_RAN', '9:543b5c9989f024fe35c6f6c5a97de88e', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.Beta1.xml', '2022-02-20 02:29:11.290958', 6, 'MARK_RAN', '9:543b5c9989f024fe35c6f6c5a97de88e', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.Beta1.xml', '2022-02-20 02:29:11.290958', 6, 'MARK_RAN', '9:543b5c9989f024fe35c6f6c5a97de88e', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.6.1_from16-pre', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-02-20 02:29:12.029892', 15, 'MARK_RAN', '9:bf656f5a2b055d07f314431cae76f06c', 'delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.6.1_from16-pre', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-02-20 02:29:12.029892', 15, 'MARK_RAN', '9:bf656f5a2b055d07f314431cae76f06c', 'delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.6.1_from16-pre', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-02-20 02:29:12.029892', 15, 'MARK_RAN', '9:bf656f5a2b055d07f314431cae76f06c', 'delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.6.1_from16-pre', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-02-20 02:29:12.029892', 15, 'MARK_RAN', '9:bf656f5a2b055d07f314431cae76f06c', 'delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.6.1_from16-pre', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-02-20 02:29:12.029892', 15, 'MARK_RAN', '9:bf656f5a2b055d07f314431cae76f06c', 'delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.6.1_from16-pre', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-02-20 02:29:12.029892', 15, 'MARK_RAN', '9:bf656f5a2b055d07f314431cae76f06c', 'delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.7.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.7.0.xml', '2022-02-20 02:29:12.18049', 18, 'EXECUTED', '9:3368ff0be4c2855ee2dd9ca813b38d8e', 'createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.7.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.7.0.xml', '2022-02-20 02:29:12.18049', 18, 'EXECUTED', '9:3368ff0be4c2855ee2dd9ca813b38d8e', 'createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.7.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.7.0.xml', '2022-02-20 02:29:12.18049', 18, 'EXECUTED', '9:3368ff0be4c2855ee2dd9ca813b38d8e', 'createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.7.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.7.0.xml', '2022-02-20 02:29:12.18049', 18, 'EXECUTED', '9:3368ff0be4c2855ee2dd9ca813b38d8e', 'createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.7.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.7.0.xml', '2022-02-20 02:29:12.18049', 18, 'EXECUTED', '9:3368ff0be4c2855ee2dd9ca813b38d8e', 'createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.7.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.7.0.xml', '2022-02-20 02:29:12.18049', 18, 'EXECUTED', '9:3368ff0be4c2855ee2dd9ca813b38d8e', 'createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2022-02-20 02:29:12.280049', 21, 'MARK_RAN', '9:831e82914316dc8a57dc09d755f23c51', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2022-02-20 02:29:12.280049', 21, 'MARK_RAN', '9:831e82914316dc8a57dc09d755f23c51', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2022-02-20 02:29:12.280049', 21, 'MARK_RAN', '9:831e82914316dc8a57dc09d755f23c51', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2022-02-20 02:29:12.280049', 21, 'MARK_RAN', '9:831e82914316dc8a57dc09d755f23c51', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2022-02-20 02:29:12.280049', 21, 'MARK_RAN', '9:831e82914316dc8a57dc09d755f23c51', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2022-02-20 02:29:12.280049', 21, 'MARK_RAN', '9:831e82914316dc8a57dc09d755f23c51', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.9.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.9.0.xml', '2022-02-20 02:29:12.325986', 23, 'EXECUTED', '9:bc3d0f9e823a69dc21e23e94c7a94bb1', 'update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.9.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.9.0.xml', '2022-02-20 02:29:12.325986', 23, 'EXECUTED', '9:bc3d0f9e823a69dc21e23e94c7a94bb1', 'update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.9.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.9.0.xml', '2022-02-20 02:29:12.325986', 23, 'EXECUTED', '9:bc3d0f9e823a69dc21e23e94c7a94bb1', 'update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.9.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.9.0.xml', '2022-02-20 02:29:12.325986', 23, 'EXECUTED', '9:bc3d0f9e823a69dc21e23e94c7a94bb1', 'update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.9.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.9.0.xml', '2022-02-20 02:29:12.325986', 23, 'EXECUTED', '9:bc3d0f9e823a69dc21e23e94c7a94bb1', 'update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('1.9.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.9.0.xml', '2022-02-20 02:29:12.325986', 23, 'EXECUTED', '9:bc3d0f9e823a69dc21e23e94c7a94bb1', 'update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-2.0.0', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.0.0.xml', '2022-02-20 02:29:12.515529', 27, 'EXECUTED', '9:43ed6b0da89ff77206289e87eaa9c024', 'createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-2.0.0', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.0.0.xml', '2022-02-20 02:29:12.515529', 27, 'EXECUTED', '9:43ed6b0da89ff77206289e87eaa9c024', 'createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-2.0.0', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.0.0.xml', '2022-02-20 02:29:12.515529', 27, 'EXECUTED', '9:43ed6b0da89ff77206289e87eaa9c024', 'createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-2.0.0', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.0.0.xml', '2022-02-20 02:29:12.515529', 27, 'EXECUTED', '9:43ed6b0da89ff77206289e87eaa9c024', 'createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-2.0.0', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.0.0.xml', '2022-02-20 02:29:12.515529', 27, 'EXECUTED', '9:43ed6b0da89ff77206289e87eaa9c024', 'createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-2.0.0', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.0.0.xml', '2022-02-20 02:29:12.515529', 27, 'EXECUTED', '9:43ed6b0da89ff77206289e87eaa9c024', 'createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.1.0-KEYCLOAK-5461', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.1.0.xml', '2022-02-20 02:29:12.626896', 29, 'EXECUTED', '9:bd88e1f833df0420b01e114533aee5e8', 'createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.1.0-KEYCLOAK-5461', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.1.0.xml', '2022-02-20 02:29:12.626896', 29, 'EXECUTED', '9:bd88e1f833df0420b01e114533aee5e8', 'createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.1.0-KEYCLOAK-5461', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.1.0.xml', '2022-02-20 02:29:12.626896', 29, 'EXECUTED', '9:bd88e1f833df0420b01e114533aee5e8', 'createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.1.0-KEYCLOAK-5461', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.1.0.xml', '2022-02-20 02:29:12.626896', 29, 'EXECUTED', '9:bd88e1f833df0420b01e114533aee5e8', 'createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.1.0-KEYCLOAK-5461', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.1.0.xml', '2022-02-20 02:29:12.626896', 29, 'EXECUTED', '9:bd88e1f833df0420b01e114533aee5e8', 'createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.1.0-KEYCLOAK-5461', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.1.0.xml', '2022-02-20 02:29:12.626896', 29, 'EXECUTED', '9:bd88e1f833df0420b01e114533aee5e8', 'createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.0.0-KEYCLOAK-6335', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-02-20 02:29:13.41667', 55, 'EXECUTED', '9:db806613b1ed154826c02610b7dbdf74', 'createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.3.0.xml', '2022-02-20 02:29:12.688851', 31, 'EXECUTED', '9:fc155c394040654d6a79227e56f5e25a', 'createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.3.0.xml', '2022-02-20 02:29:12.688851', 31, 'EXECUTED', '9:fc155c394040654d6a79227e56f5e25a', 'createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.3.0.xml', '2022-02-20 02:29:12.688851', 31, 'EXECUTED', '9:fc155c394040654d6a79227e56f5e25a', 'createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.3.0.xml', '2022-02-20 02:29:12.688851', 31, 'EXECUTED', '9:fc155c394040654d6a79227e56f5e25a', 'createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.3.0.xml', '2022-02-20 02:29:12.688851', 31, 'EXECUTED', '9:fc155c394040654d6a79227e56f5e25a', 'createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.3.0.xml', '2022-02-20 02:29:12.688851', 31, 'EXECUTED', '9:fc155c394040654d6a79227e56f5e25a', 'createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0-duplicate-email-support', 'slawomir@dabek.name', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-20 02:29:12.774018', 36, 'EXECUTED', '9:61b6d3d7a4c0e0024b0c839da283da0c', 'addColumn tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0-duplicate-email-support', 'slawomir@dabek.name', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-20 02:29:12.774018', 36, 'EXECUTED', '9:61b6d3d7a4c0e0024b0c839da283da0c', 'addColumn tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0-duplicate-email-support', 'slawomir@dabek.name', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-20 02:29:12.774018', 36, 'EXECUTED', '9:61b6d3d7a4c0e0024b0c839da283da0c', 'addColumn tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0-duplicate-email-support', 'slawomir@dabek.name', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-20 02:29:12.774018', 36, 'EXECUTED', '9:61b6d3d7a4c0e0024b0c839da283da0c', 'addColumn tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0-duplicate-email-support', 'slawomir@dabek.name', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-20 02:29:12.774018', 36, 'EXECUTED', '9:61b6d3d7a4c0e0024b0c839da283da0c', 'addColumn tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0-duplicate-email-support', 'slawomir@dabek.name', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-20 02:29:12.774018', 36, 'EXECUTED', '9:61b6d3d7a4c0e0024b0c839da283da0c', 'addColumn tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.2.0-fix-with-keycloak-5416', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2022-02-20 02:29:12.806542', 41, 'MARK_RAN', '9:845c332ff1874dc5d35974b0babf3006', 'dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.2.0-fix-with-keycloak-5416', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2022-02-20 02:29:12.806542', 41, 'MARK_RAN', '9:845c332ff1874dc5d35974b0babf3006', 'dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.2.0-fix-with-keycloak-5416', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2022-02-20 02:29:12.806542', 41, 'MARK_RAN', '9:845c332ff1874dc5d35974b0babf3006', 'dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.2.0-fix-with-keycloak-5416', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2022-02-20 02:29:12.806542', 41, 'MARK_RAN', '9:845c332ff1874dc5d35974b0babf3006', 'dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.2.0-fix-with-keycloak-5416', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2022-02-20 02:29:12.806542', 41, 'MARK_RAN', '9:845c332ff1874dc5d35974b0babf3006', 'dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.2.0-fix-with-keycloak-5416', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2022-02-20 02:29:12.806542', 41, 'MARK_RAN', '9:845c332ff1874dc5d35974b0babf3006', 'dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part1', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-20 02:29:13.092584', 45, 'EXECUTED', '9:dde36f7973e80d71fceee683bc5d2951', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part1', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-20 02:29:13.092584', 45, 'EXECUTED', '9:dde36f7973e80d71fceee683bc5d2951', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part1', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-20 02:29:13.092584', 45, 'EXECUTED', '9:dde36f7973e80d71fceee683bc5d2951', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part1', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-20 02:29:13.092584', 45, 'EXECUTED', '9:dde36f7973e80d71fceee683bc5d2951', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part1', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-20 02:29:13.092584', 45, 'EXECUTED', '9:dde36f7973e80d71fceee683bc5d2951', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part1', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-20 02:29:13.092584', 45, 'EXECUTED', '9:dde36f7973e80d71fceee683bc5d2951', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-20 02:29:13.100966', 46, 'EXECUTED', '9:b855e9b0a406b34fa323235a0cf4f640', 'customChange', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-20 02:29:13.100966', 46, 'EXECUTED', '9:b855e9b0a406b34fa323235a0cf4f640', 'customChange', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-20 02:29:13.100966', 46, 'EXECUTED', '9:b855e9b0a406b34fa323235a0cf4f640', 'customChange', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-20 02:29:13.100966', 46, 'EXECUTED', '9:b855e9b0a406b34fa323235a0cf4f640', 'customChange', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-20 02:29:13.100966', 46, 'EXECUTED', '9:b855e9b0a406b34fa323235a0cf4f640', 'customChange', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-20 02:29:13.100966', 46, 'EXECUTED', '9:b855e9b0a406b34fa323235a0cf4f640', 'customChange', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.0', 'keycloak', 'META-INF/jpa-changelog-3.4.0.xml', '2022-02-20 02:29:13.281623', 50, 'EXECUTED', '9:cfdd8736332ccdd72c5256ccb42335db', 'addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.0', 'keycloak', 'META-INF/jpa-changelog-3.4.0.xml', '2022-02-20 02:29:13.281623', 50, 'EXECUTED', '9:cfdd8736332ccdd72c5256ccb42335db', 'addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.0', 'keycloak', 'META-INF/jpa-changelog-3.4.0.xml', '2022-02-20 02:29:13.281623', 50, 'EXECUTED', '9:cfdd8736332ccdd72c5256ccb42335db', 'addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.0', 'keycloak', 'META-INF/jpa-changelog-3.4.0.xml', '2022-02-20 02:29:13.281623', 50, 'EXECUTED', '9:cfdd8736332ccdd72c5256ccb42335db', 'addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.0', 'keycloak', 'META-INF/jpa-changelog-3.4.0.xml', '2022-02-20 02:29:13.281623', 50, 'EXECUTED', '9:cfdd8736332ccdd72c5256ccb42335db', 'addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.0', 'keycloak', 'META-INF/jpa-changelog-3.4.0.xml', '2022-02-20 02:29:13.281623', 50, 'EXECUTED', '9:cfdd8736332ccdd72c5256ccb42335db', 'addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.0-KEYCLOAK-5230', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-3.4.0.xml', '2022-02-20 02:29:13.36239', 51, 'EXECUTED', '9:7c84de3d9bd84d7f077607c1a4dcb714', 'createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.0-KEYCLOAK-5230', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-3.4.0.xml', '2022-02-20 02:29:13.36239', 51, 'EXECUTED', '9:7c84de3d9bd84d7f077607c1a4dcb714', 'createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.0-KEYCLOAK-5230', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-3.4.0.xml', '2022-02-20 02:29:13.36239', 51, 'EXECUTED', '9:7c84de3d9bd84d7f077607c1a4dcb714', 'createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.0-KEYCLOAK-5230', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-3.4.0.xml', '2022-02-20 02:29:13.36239', 51, 'EXECUTED', '9:7c84de3d9bd84d7f077607c1a4dcb714', 'createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.0-KEYCLOAK-5230', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-3.4.0.xml', '2022-02-20 02:29:13.36239', 51, 'EXECUTED', '9:7c84de3d9bd84d7f077607c1a4dcb714', 'createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.0-KEYCLOAK-5230', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-3.4.0.xml', '2022-02-20 02:29:13.36239', 51, 'EXECUTED', '9:7c84de3d9bd84d7f077607c1a4dcb714', 'createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.0.0-KEYCLOAK-6335', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-02-20 02:29:13.41667', 55, 'EXECUTED', '9:db806613b1ed154826c02610b7dbdf74', 'createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.0.0-KEYCLOAK-6335', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-02-20 02:29:13.41667', 55, 'EXECUTED', '9:db806613b1ed154826c02610b7dbdf74', 'createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.0.0-KEYCLOAK-6335', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-02-20 02:29:13.41667', 55, 'EXECUTED', '9:db806613b1ed154826c02610b7dbdf74', 'createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.0.0-KEYCLOAK-6335', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-02-20 02:29:13.41667', 55, 'EXECUTED', '9:db806613b1ed154826c02610b7dbdf74', 'createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.0.0-KEYCLOAK-6335', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-02-20 02:29:13.41667', 55, 'EXECUTED', '9:db806613b1ed154826c02610b7dbdf74', 'createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.0.0-CLEANUP-UNUSED-TABLE', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-02-20 02:29:13.443408', 56, 'EXECUTED', '9:229a041fb72d5beac76bb94a5fa709de', 'dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.0.0-CLEANUP-UNUSED-TABLE', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-02-20 02:29:13.443408', 56, 'EXECUTED', '9:229a041fb72d5beac76bb94a5fa709de', 'dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.0.0-CLEANUP-UNUSED-TABLE', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-02-20 02:29:13.443408', 56, 'EXECUTED', '9:229a041fb72d5beac76bb94a5fa709de', 'dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.0.0-CLEANUP-UNUSED-TABLE', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-02-20 02:29:13.443408', 56, 'EXECUTED', '9:229a041fb72d5beac76bb94a5fa709de', 'dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.0.0-CLEANUP-UNUSED-TABLE', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-02-20 02:29:13.443408', 56, 'EXECUTED', '9:229a041fb72d5beac76bb94a5fa709de', 'dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.0.0-CLEANUP-UNUSED-TABLE', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-02-20 02:29:13.443408', 56, 'EXECUTED', '9:229a041fb72d5beac76bb94a5fa709de', 'dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-4.2.0.Final', 'mhajas@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2022-02-20 02:29:13.948466', 61, 'EXECUTED', '9:42a33806f3a0443fe0e7feeec821326c', 'createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-4.2.0.Final', 'mhajas@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2022-02-20 02:29:13.948466', 61, 'EXECUTED', '9:42a33806f3a0443fe0e7feeec821326c', 'createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-4.2.0.Final', 'mhajas@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2022-02-20 02:29:13.948466', 61, 'EXECUTED', '9:42a33806f3a0443fe0e7feeec821326c', 'createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-4.2.0.Final', 'mhajas@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2022-02-20 02:29:13.948466', 61, 'EXECUTED', '9:42a33806f3a0443fe0e7feeec821326c', 'createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-4.2.0.Final', 'mhajas@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2022-02-20 02:29:13.948466', 61, 'EXECUTED', '9:42a33806f3a0443fe0e7feeec821326c', 'createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('authz-4.2.0.Final', 'mhajas@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2022-02-20 02:29:13.948466', 61, 'EXECUTED', '9:42a33806f3a0443fe0e7feeec821326c', 'createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.6.0-KEYCLOAK-7950', 'psilva@redhat.com', 'META-INF/jpa-changelog-4.6.0.xml', '2022-02-20 02:29:14.003508', 65, 'EXECUTED', '9:e590c88ddc0b38b0ae4249bbfcb5abc3', 'update tableName=RESOURCE_SERVER_RESOURCE', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.6.0-KEYCLOAK-7950', 'psilva@redhat.com', 'META-INF/jpa-changelog-4.6.0.xml', '2022-02-20 02:29:14.003508', 65, 'EXECUTED', '9:e590c88ddc0b38b0ae4249bbfcb5abc3', 'update tableName=RESOURCE_SERVER_RESOURCE', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.6.0-KEYCLOAK-7950', 'psilva@redhat.com', 'META-INF/jpa-changelog-4.6.0.xml', '2022-02-20 02:29:14.003508', 65, 'EXECUTED', '9:e590c88ddc0b38b0ae4249bbfcb5abc3', 'update tableName=RESOURCE_SERVER_RESOURCE', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.6.0-KEYCLOAK-7950', 'psilva@redhat.com', 'META-INF/jpa-changelog-4.6.0.xml', '2022-02-20 02:29:14.003508', 65, 'EXECUTED', '9:e590c88ddc0b38b0ae4249bbfcb5abc3', 'update tableName=RESOURCE_SERVER_RESOURCE', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.6.0-KEYCLOAK-7950', 'psilva@redhat.com', 'META-INF/jpa-changelog-4.6.0.xml', '2022-02-20 02:29:14.003508', 65, 'EXECUTED', '9:e590c88ddc0b38b0ae4249bbfcb5abc3', 'update tableName=RESOURCE_SERVER_RESOURCE', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.6.0-KEYCLOAK-7950', 'psilva@redhat.com', 'META-INF/jpa-changelog-4.6.0.xml', '2022-02-20 02:29:14.003508', 65, 'EXECUTED', '9:e590c88ddc0b38b0ae4249bbfcb5abc3', 'update tableName=RESOURCE_SERVER_RESOURCE', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.6.0-KEYCLOAK-8555', 'gideonray@gmail.com', 'META-INF/jpa-changelog-4.6.0.xml', '2022-02-20 02:29:14.0617', 67, 'EXECUTED', '9:e7c9f5f9c4d67ccbbcc215440c718a17', 'createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.6.0-KEYCLOAK-8555', 'gideonray@gmail.com', 'META-INF/jpa-changelog-4.6.0.xml', '2022-02-20 02:29:14.0617', 67, 'EXECUTED', '9:e7c9f5f9c4d67ccbbcc215440c718a17', 'createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.6.0-KEYCLOAK-8555', 'gideonray@gmail.com', 'META-INF/jpa-changelog-4.6.0.xml', '2022-02-20 02:29:14.0617', 67, 'EXECUTED', '9:e7c9f5f9c4d67ccbbcc215440c718a17', 'createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.6.0-KEYCLOAK-8555', 'gideonray@gmail.com', 'META-INF/jpa-changelog-4.6.0.xml', '2022-02-20 02:29:14.0617', 67, 'EXECUTED', '9:e7c9f5f9c4d67ccbbcc215440c718a17', 'createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.6.0-KEYCLOAK-8555', 'gideonray@gmail.com', 'META-INF/jpa-changelog-4.6.0.xml', '2022-02-20 02:29:14.0617', 67, 'EXECUTED', '9:e7c9f5f9c4d67ccbbcc215440c718a17', 'createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.6.0-KEYCLOAK-8555', 'gideonray@gmail.com', 'META-INF/jpa-changelog-4.6.0.xml', '2022-02-20 02:29:14.0617', 67, 'EXECUTED', '9:e7c9f5f9c4d67ccbbcc215440c718a17', 'createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.8.0-KEYCLOAK-8835', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.8.0.xml', '2022-02-20 02:29:14.133737', 70, 'EXECUTED', '9:a74d33da4dc42a37ec27121580d1459f', 'addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.8.0-KEYCLOAK-8835', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.8.0.xml', '2022-02-20 02:29:14.133737', 70, 'EXECUTED', '9:a74d33da4dc42a37ec27121580d1459f', 'addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.8.0-KEYCLOAK-8835', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.8.0.xml', '2022-02-20 02:29:14.133737', 70, 'EXECUTED', '9:a74d33da4dc42a37ec27121580d1459f', 'addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.8.0-KEYCLOAK-8835', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.8.0.xml', '2022-02-20 02:29:14.133737', 70, 'EXECUTED', '9:a74d33da4dc42a37ec27121580d1459f', 'addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.8.0-KEYCLOAK-8835', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.8.0.xml', '2022-02-20 02:29:14.133737', 70, 'EXECUTED', '9:a74d33da4dc42a37ec27121580d1459f', 'addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('4.8.0-KEYCLOAK-8835', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.8.0.xml', '2022-02-20 02:29:14.133737', 70, 'EXECUTED', '9:a74d33da4dc42a37ec27121580d1459f', 'addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-resource-tag-support', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-20 02:29:14.264378', 76, 'EXECUTED', '9:91fa186ce7a5af127a2d7a91ee083cc5', 'addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-resource-tag-support', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-20 02:29:14.264378', 76, 'EXECUTED', '9:91fa186ce7a5af127a2d7a91ee083cc5', 'addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-resource-tag-support', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-20 02:29:14.264378', 76, 'EXECUTED', '9:91fa186ce7a5af127a2d7a91ee083cc5', 'addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-resource-tag-support', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-20 02:29:14.264378', 76, 'EXECUTED', '9:91fa186ce7a5af127a2d7a91ee083cc5', 'addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-resource-tag-support', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-20 02:29:14.264378', 76, 'EXECUTED', '9:91fa186ce7a5af127a2d7a91ee083cc5', 'addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-resource-tag-support', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-20 02:29:14.264378', 76, 'EXECUTED', '9:91fa186ce7a5af127a2d7a91ee083cc5', 'addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-add-index-to-events', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-20 02:29:14.347299', 85, 'EXECUTED', '9:7d93d602352a30c0c317e6a609b56599', 'createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-add-index-to-events', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-20 02:29:14.347299', 85, 'EXECUTED', '9:7d93d602352a30c0c317e6a609b56599', 'createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-add-index-to-events', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-20 02:29:14.347299', 85, 'EXECUTED', '9:7d93d602352a30c0c317e6a609b56599', 'createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-add-index-to-events', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-20 02:29:14.347299', 85, 'EXECUTED', '9:7d93d602352a30c0c317e6a609b56599', 'createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-add-index-to-events', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-20 02:29:14.347299', 85, 'EXECUTED', '9:7d93d602352a30c0c317e6a609b56599', 'createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-add-index-to-events', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-20 02:29:14.347299', 85, 'EXECUTED', '9:7d93d602352a30c0c317e6a609b56599', 'createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('13.0.0-KEYCLOAK-16844', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.418061', 91, 'EXECUTED', '9:ad1194d66c937e3ffc82386c050ba089', 'createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('13.0.0-KEYCLOAK-16844', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.418061', 91, 'EXECUTED', '9:ad1194d66c937e3ffc82386c050ba089', 'createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('13.0.0-KEYCLOAK-16844', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.418061', 91, 'EXECUTED', '9:ad1194d66c937e3ffc82386c050ba089', 'createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('13.0.0-KEYCLOAK-16844', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.418061', 91, 'EXECUTED', '9:ad1194d66c937e3ffc82386c050ba089', 'createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('13.0.0-KEYCLOAK-16844', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.418061', 91, 'EXECUTED', '9:ad1194d66c937e3ffc82386c050ba089', 'createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('13.0.0-KEYCLOAK-16844', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.418061', 91, 'EXECUTED', '9:ad1194d66c937e3ffc82386c050ba089', 'createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('13.0.0-increase-column-size-federated', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.452084', 94, 'EXECUTED', '9:43c0c1055b6761b4b3e89de76d612ccf', 'modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('13.0.0-increase-column-size-federated', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.452084', 94, 'EXECUTED', '9:43c0c1055b6761b4b3e89de76d612ccf', 'modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('13.0.0-increase-column-size-federated', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.452084', 94, 'EXECUTED', '9:43c0c1055b6761b4b3e89de76d612ccf', 'modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('13.0.0-increase-column-size-federated', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.452084', 94, 'EXECUTED', '9:43c0c1055b6761b4b3e89de76d612ccf', 'modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('13.0.0-increase-column-size-federated', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.452084', 94, 'EXECUTED', '9:43c0c1055b6761b4b3e89de76d612ccf', 'modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('13.0.0-increase-column-size-federated', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.452084', 94, 'EXECUTED', '9:43c0c1055b6761b4b3e89de76d612ccf', 'modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('json-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.467229', 96, 'EXECUTED', '9:e07d2bc0970c348bb06fb63b1f82ddbf', 'addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('json-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.467229', 96, 'EXECUTED', '9:e07d2bc0970c348bb06fb63b1f82ddbf', 'addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('json-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.467229', 96, 'EXECUTED', '9:e07d2bc0970c348bb06fb63b1f82ddbf', 'addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('json-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.467229', 96, 'EXECUTED', '9:e07d2bc0970c348bb06fb63b1f82ddbf', 'addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('json-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.467229', 96, 'EXECUTED', '9:e07d2bc0970c348bb06fb63b1f82ddbf', 'addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('json-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-20 02:29:14.467229', 96, 'EXECUTED', '9:e07d2bc0970c348bb06fb63b1f82ddbf', 'addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.490554', 98, 'MARK_RAN', '9:259f89014ce2506ee84740cbf7163aa7', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.490554', 98, 'MARK_RAN', '9:259f89014ce2506ee84740cbf7163aa7', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.490554', 98, 'MARK_RAN', '9:259f89014ce2506ee84740cbf7163aa7', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.490554', 98, 'MARK_RAN', '9:259f89014ce2506ee84740cbf7163aa7', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.490554', 98, 'MARK_RAN', '9:259f89014ce2506ee84740cbf7163aa7', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.490554', 98, 'MARK_RAN', '9:259f89014ce2506ee84740cbf7163aa7', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.521329', 100, 'EXECUTED', '9:60ca84a0f8c94ec8c3504a5a3bc88ee8', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.521329', 100, 'EXECUTED', '9:60ca84a0f8c94ec8c3504a5a3bc88ee8', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.521329', 100, 'EXECUTED', '9:60ca84a0f8c94ec8c3504a5a3bc88ee8', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.521329', 100, 'EXECUTED', '9:60ca84a0f8c94ec8c3504a5a3bc88ee8', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.521329', 100, 'EXECUTED', '9:60ca84a0f8c94ec8c3504a5a3bc88ee8', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.521329', 100, 'EXECUTED', '9:60ca84a0f8c94ec8c3504a5a3bc88ee8', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('KEYCLOAK-18146-add-saml-art-binding-identifier', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.54442', 103, 'EXECUTED', '9:2c374ad2cdfe20e2905a84c8fac48460', 'customChange', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('KEYCLOAK-18146-add-saml-art-binding-identifier', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.54442', 103, 'EXECUTED', '9:2c374ad2cdfe20e2905a84c8fac48460', 'customChange', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('KEYCLOAK-18146-add-saml-art-binding-identifier', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.54442', 103, 'EXECUTED', '9:2c374ad2cdfe20e2905a84c8fac48460', 'customChange', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('KEYCLOAK-18146-add-saml-art-binding-identifier', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.54442', 103, 'EXECUTED', '9:2c374ad2cdfe20e2905a84c8fac48460', 'customChange', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('KEYCLOAK-18146-add-saml-art-binding-identifier', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.54442', 103, 'EXECUTED', '9:2c374ad2cdfe20e2905a84c8fac48460', 'customChange', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('KEYCLOAK-18146-add-saml-art-binding-identifier', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-20 02:29:14.54442', 103, 'EXECUTED', '9:2c374ad2cdfe20e2905a84c8fac48460', 'customChange', '', NULL, '4.6.2', NULL, NULL, '5324150155');
INSERT INTO keycloak.databasechangelog VALUES ('18.0.0-10625-IDX_ADMIN_EVENT_TIME', 'keycloak', 'META-INF/jpa-changelog-18.0.0.xml', '2022-04-21 18:59:49.897065', 106, 'EXECUTED', '9:015479dbd691d9cc8669282f4828c41d', 'createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY', '', NULL, '4.8.0', NULL, NULL, '0567589704');
INSERT INTO keycloak.databasechangelog VALUES ('18.0.0-10625-IDX_ADMIN_EVENT_TIME', 'keycloak', 'META-INF/jpa-changelog-18.0.0.xml', '2022-04-21 18:59:49.897065', 106, 'EXECUTED', '9:015479dbd691d9cc8669282f4828c41d', 'createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY', '', NULL, '4.8.0', NULL, NULL, '0567589704');
INSERT INTO keycloak.databasechangelog VALUES ('18.0.0-10625-IDX_ADMIN_EVENT_TIME', 'keycloak', 'META-INF/jpa-changelog-18.0.0.xml', '2022-04-21 18:59:49.897065', 106, 'EXECUTED', '9:015479dbd691d9cc8669282f4828c41d', 'createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY', '', NULL, '4.8.0', NULL, NULL, '0567589704');
INSERT INTO keycloak.databasechangelog VALUES ('18.0.0-10625-IDX_ADMIN_EVENT_TIME', 'keycloak', 'META-INF/jpa-changelog-18.0.0.xml', '2022-04-21 18:59:49.897065', 106, 'EXECUTED', '9:015479dbd691d9cc8669282f4828c41d', 'createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY', '', NULL, '4.8.0', NULL, NULL, '0567589704');
INSERT INTO keycloak.databasechangelog VALUES ('18.0.0-10625-IDX_ADMIN_EVENT_TIME', 'keycloak', 'META-INF/jpa-changelog-18.0.0.xml', '2022-04-21 18:59:49.897065', 106, 'EXECUTED', '9:015479dbd691d9cc8669282f4828c41d', 'createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY', '', NULL, '4.8.0', NULL, NULL, '0567589704');
INSERT INTO keycloak.databasechangelog VALUES ('21.0.2-17277', 'keycloak', 'META-INF/jpa-changelog-21.0.2.xml', '2023-06-06 12:59:40.957031', 111, 'EXECUTED', '9:7ee1f7a3fb8f5588f171fb9a6ab623c0', 'customChange', '', NULL, '4.16.1', NULL, NULL, '6056380611');
INSERT INTO keycloak.databasechangelog VALUES ('21.0.2-17277', 'keycloak', 'META-INF/jpa-changelog-21.0.2.xml', '2023-06-10 12:59:40.957031', 111, 'EXECUTED', '9:7ee1f7a3fb8f5588f171fb9a6ab623c0', 'customChange', '', NULL, '4.16.1', NULL, NULL, '6056380611');
INSERT INTO keycloak.databasechangelog VALUES ('21.0.2-17277', 'keycloak', 'META-INF/jpa-changelog-21.0.2.xml', '2023-06-10 12:59:40.957031', 111, 'EXECUTED', '9:7ee1f7a3fb8f5588f171fb9a6ab623c0', 'customChange', '', NULL, '4.16.1', NULL, NULL, '6056380611');
INSERT INTO keycloak.databasechangelog VALUES ('21.0.2-17277', 'keycloak', 'META-INF/jpa-changelog-21.0.2.xml', '2023-06-06 12:59:40.957031', 111, 'EXECUTED', '9:7ee1f7a3fb8f5588f171fb9a6ab623c0', 'customChange', '', NULL, '4.16.1', NULL, NULL, '6056380611');
INSERT INTO keycloak.databasechangelog VALUES ('21.0.2-17277', 'keycloak', 'META-INF/jpa-changelog-21.0.2.xml', '2023-06-06 12:59:40.957031', 111, 'EXECUTED', '9:7ee1f7a3fb8f5588f171fb9a6ab623c0', 'customChange', '', NULL, '4.16.1', NULL, NULL, '6056380611');
INSERT INTO keycloak.databasechangelog VALUES ('21.0.2-17277', 'keycloak', 'META-INF/jpa-changelog-21.0.2.xml', '2023-06-10 12:59:40.957031', 111, 'EXECUTED', '9:7ee1f7a3fb8f5588f171fb9a6ab623c0', 'customChange', '', NULL, '4.16.1', NULL, NULL, '6056380611');
INSERT INTO keycloak.databasechangelog VALUES ('21.1.0-19404', 'keycloak', 'META-INF/jpa-changelog-21.1.0.xml', '2023-06-06 12:59:41.059862', 112, 'EXECUTED', '9:3d7e830b52f33676b9d64f7f2b2ea634', 'modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER', '', NULL, '4.16.1', NULL, NULL, '6056380611');
INSERT INTO keycloak.databasechangelog VALUES ('21.1.0-19404', 'keycloak', 'META-INF/jpa-changelog-21.1.0.xml', '2023-06-10 12:59:41.059862', 112, 'EXECUTED', '9:3d7e830b52f33676b9d64f7f2b2ea634', 'modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER', '', NULL, '4.16.1', NULL, NULL, '6056380611');
INSERT INTO keycloak.databasechangelog VALUES ('21.1.0-19404', 'keycloak', 'META-INF/jpa-changelog-21.1.0.xml', '2023-06-06 12:59:41.059862', 112, 'EXECUTED', '9:3d7e830b52f33676b9d64f7f2b2ea634', 'modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER', '', NULL, '4.16.1', NULL, NULL, '6056380611');
INSERT INTO keycloak.databasechangelog VALUES ('21.1.0-19404', 'keycloak', 'META-INF/jpa-changelog-21.1.0.xml', '2023-06-10 12:59:41.059862', 112, 'EXECUTED', '9:3d7e830b52f33676b9d64f7f2b2ea634', 'modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER', '', NULL, '4.16.1', NULL, NULL, '6056380611');
INSERT INTO keycloak.databasechangelog VALUES ('21.1.0-19404', 'keycloak', 'META-INF/jpa-changelog-21.1.0.xml', '2023-06-06 12:59:41.059862', 112, 'EXECUTED', '9:3d7e830b52f33676b9d64f7f2b2ea634', 'modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER', '', NULL, '4.16.1', NULL, NULL, '6056380611');
INSERT INTO keycloak.databasechangelog VALUES ('21.1.0-19404', 'keycloak', 'META-INF/jpa-changelog-21.1.0.xml', '2023-06-10 12:59:41.059862', 112, 'EXECUTED', '9:3d7e830b52f33676b9d64f7f2b2ea634', 'modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER', '', NULL, '4.16.1', NULL, NULL, '6056380611');
INSERT INTO keycloak.databasechangelog VALUES ('21.1.0-19404-2', 'keycloak', 'META-INF/jpa-changelog-21.1.0.xml', '2023-06-06 12:59:41.066543', 113, 'MARK_RAN', '9:627d032e3ef2c06c0e1f73d2ae25c26c', 'addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...', '', NULL, '4.16.1', NULL, NULL, '6056380611');
INSERT INTO keycloak.databasechangelog VALUES ('21.1.0-19404-2', 'keycloak', 'META-INF/jpa-changelog-21.1.0.xml', '2023-06-10 12:59:41.066543', 113, 'MARK_RAN', '9:627d032e3ef2c06c0e1f73d2ae25c26c', 'addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...', '', NULL, '4.16.1', NULL, NULL, '6056380611');
INSERT INTO keycloak.databasechangelog VALUES ('21.1.0-19404-2', 'keycloak', 'META-INF/jpa-changelog-21.1.0.xml', '2023-06-06 12:59:41.066543', 113, 'MARK_RAN', '9:627d032e3ef2c06c0e1f73d2ae25c26c', 'addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...', '', NULL, '4.16.1', NULL, NULL, '6056380611');
INSERT INTO keycloak.databasechangelog VALUES ('21.1.0-19404-2', 'keycloak', 'META-INF/jpa-changelog-21.1.0.xml', '2023-06-10 12:59:41.066543', 113, 'MARK_RAN', '9:627d032e3ef2c06c0e1f73d2ae25c26c', 'addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...', '', NULL, '4.16.1', NULL, NULL, '6056380611');
INSERT INTO keycloak.databasechangelog VALUES ('21.1.0-19404-2', 'keycloak', 'META-INF/jpa-changelog-21.1.0.xml', '2023-06-06 12:59:41.066543', 113, 'MARK_RAN', '9:627d032e3ef2c06c0e1f73d2ae25c26c', 'addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...', '', NULL, '4.16.1', NULL, NULL, '6056380611');
INSERT INTO keycloak.databasechangelog VALUES ('21.1.0-19404-2', 'keycloak', 'META-INF/jpa-changelog-21.1.0.xml', '2023-06-10 12:59:41.066543', 113, 'MARK_RAN', '9:627d032e3ef2c06c0e1f73d2ae25c26c', 'addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...', '', NULL, '4.16.1', NULL, NULL, '6056380611');
INSERT INTO keycloak.databasechangelog VALUES ('24.0.0-9758', 'keycloak', 'META-INF/jpa-changelog-24.0.0.xml', '2024-04-18 19:53:03.471266', 119, 'EXECUTED', '9:502c557a5189f600f0f445a9b49ebbce', 'addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...', '', NULL, '4.25.1', NULL, NULL, '3469982647');
INSERT INTO keycloak.databasechangelog VALUES ('24.0.0-9758-2', 'keycloak', 'META-INF/jpa-changelog-24.0.0.xml', '2024-04-18 19:53:03.587507', 120, 'EXECUTED', '9:bf0fdee10afdf597a987adbf291db7b2', 'customChange', '', NULL, '4.25.1', NULL, NULL, '3469982647');
INSERT INTO keycloak.databasechangelog VALUES ('24.0.0-26618-drop-index-if-present', 'keycloak', 'META-INF/jpa-changelog-24.0.0.xml', '2024-04-18 19:53:03.617295', 121, 'MARK_RAN', '9:04baaf56c116ed19951cbc2cca584022', 'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.25.1', NULL, NULL, '3469982647');
INSERT INTO keycloak.databasechangelog VALUES ('24.0.0-26618-reindex', 'keycloak', 'META-INF/jpa-changelog-24.0.0.xml', '2024-04-18 19:53:03.646328', 122, 'EXECUTED', '9:08707c0f0db1cef6b352db03a60edc7f', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.25.1', NULL, NULL, '3469982647');
INSERT INTO keycloak.databasechangelog VALUES ('24.0.2-27228', 'keycloak', 'META-INF/jpa-changelog-24.0.2.xml', '2024-04-18 19:53:03.689024', 123, 'EXECUTED', '9:eaee11f6b8aa25d2cc6a84fb86fc6238', 'customChange', '', NULL, '4.25.1', NULL, NULL, '3469982647');
INSERT INTO keycloak.databasechangelog VALUES ('24.0.2-27967-drop-index-if-present', 'keycloak', 'META-INF/jpa-changelog-24.0.2.xml', '2024-04-18 19:53:03.698723', 124, 'MARK_RAN', '9:04baaf56c116ed19951cbc2cca584022', 'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.25.1', NULL, NULL, '3469982647');
INSERT INTO keycloak.databasechangelog VALUES ('24.0.2-27967-reindex', 'keycloak', 'META-INF/jpa-changelog-24.0.2.xml', '2024-04-18 19:53:03.717085', 125, 'MARK_RAN', '9:d3d977031d431db16e2c181ce49d73e9', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.25.1', NULL, NULL, '3469982647');


--
-- TOC entry 4191 (class 0 OID 16522)
-- Dependencies: 238
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.databasechangeloglock VALUES (1, false, NULL, NULL);
INSERT INTO keycloak.databasechangeloglock VALUES (1000, false, NULL, NULL);
INSERT INTO keycloak.databasechangeloglock VALUES (1001, false, NULL, NULL);


--
-- TOC entry 4192 (class 0 OID 16525)
-- Dependencies: 239
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.default_client_scope VALUES ('master', '440221db-a2d2-46ae-afec-db28e31b82c6', false);
INSERT INTO keycloak.default_client_scope VALUES ('master', 'eec3ffac-3981-4e3a-ab1c-b10634335b7b', true);
INSERT INTO keycloak.default_client_scope VALUES ('master', '64962ee9-4308-44c8-b93d-20f335fb7fe4', true);
INSERT INTO keycloak.default_client_scope VALUES ('master', 'b5725526-2c78-46cb-9941-ec0445725c4e', true);
INSERT INTO keycloak.default_client_scope VALUES ('master', '8788d929-9c56-44e2-b500-cac7c9cdbbf7', false);
INSERT INTO keycloak.default_client_scope VALUES ('master', '2414f4d3-cfb3-49ae-ad70-7c4388c14f52', false);
INSERT INTO keycloak.default_client_scope VALUES ('master', '374759fc-935f-4c93-9bef-57573aafba31', true);
INSERT INTO keycloak.default_client_scope VALUES ('master', 'e374cda1-44a0-4d7e-a214-e401a11d4673', true);
INSERT INTO keycloak.default_client_scope VALUES ('master', 'e816fcd5-0b78-422e-8fc0-0ea150b1daf0', false);
INSERT INTO keycloak.default_client_scope VALUES ('appcket', 'bed9e481-a783-4f6c-bd5a-f79f5d189ee6', true);
INSERT INTO keycloak.default_client_scope VALUES ('appcket', 'aee86bba-572b-4335-8f5b-c9969c70cbce', true);
INSERT INTO keycloak.default_client_scope VALUES ('appcket', '63984129-44c9-4bd1-97d1-da0df3407112', true);
INSERT INTO keycloak.default_client_scope VALUES ('appcket', '2b5c02f3-e7a9-4455-a505-9fef19838927', true);
INSERT INTO keycloak.default_client_scope VALUES ('appcket', '52312b11-3e69-46f2-93f2-b1e168214598', true);
INSERT INTO keycloak.default_client_scope VALUES ('appcket', '1ddb5c58-3c5b-43bc-ae48-ba8947a6c108', false);
INSERT INTO keycloak.default_client_scope VALUES ('appcket', 'b2414a14-1f25-4d4b-9162-de66eeb6652d', false);
INSERT INTO keycloak.default_client_scope VALUES ('appcket', '4709e0fb-184a-4b47-a804-ae1556e53a73', false);
INSERT INTO keycloak.default_client_scope VALUES ('appcket', 'a15b2f14-004d-47f8-b137-7bca43fc8b30', false);
INSERT INTO keycloak.default_client_scope VALUES ('master', 'f2af3385-b007-4e90-b783-54eaa0aac86d', true);
INSERT INTO keycloak.default_client_scope VALUES ('appcket', 'c03824d3-cc18-4529-90cd-968ab5d3653d', true);
INSERT INTO keycloak.default_client_scope VALUES ('master', 'd43481d5-5c2a-4407-bf8f-ce49bdc5ceff', true);
INSERT INTO keycloak.default_client_scope VALUES ('appcket', 'a8ddb608-a41f-4ff6-bb20-14237bc37572', true);


--
-- TOC entry 4193 (class 0 OID 16529)
-- Dependencies: 240
-- Data for Name: event_entity; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.event_entity VALUES ('98bb2d01-1ca4-42a4-b2f0-05e895d60efb', NULL, 'null', 'session_expired', '127.0.0.6', 'appcket', NULL, 1686056784490, 'LOGOUT_ERROR', NULL, NULL);
INSERT INTO keycloak.event_entity VALUES ('30ccb954-db0b-4286-ba2c-59ad955db190', NULL, 'null', 'session_expired', '127.0.0.6', 'appcket', NULL, 1686145253029, 'LOGOUT_ERROR', NULL, NULL);
INSERT INTO keycloak.event_entity VALUES ('c4a53fe3-8eb8-448e-be9b-8e197bb98cb2', NULL, 'null', 'session_expired', '127.0.0.6', 'appcket', NULL, 1686843547658, 'LOGOUT_ERROR', NULL, NULL);
INSERT INTO keycloak.event_entity VALUES ('57b50ead-a7da-4e1f-ac79-155ff6e19776', NULL, 'null', 'session_expired', '127.0.0.6', 'appcket', NULL, 1686968253842, 'LOGOUT_ERROR', NULL, NULL);
INSERT INTO keycloak.event_entity VALUES ('7c2cde8f-97f0-46d1-86b9-7c9c5316200e', NULL, 'null', 'session_expired', '127.0.0.6', 'appcket', NULL, 1687052081167, 'LOGOUT_ERROR', NULL, NULL);
INSERT INTO keycloak.event_entity VALUES ('a4a0d1eb-42f2-46e8-b8b4-6f30946b4638', NULL, 'null', 'session_expired', '127.0.0.6', 'appcket', NULL, 1687211223610, 'LOGOUT_ERROR', NULL, NULL);
INSERT INTO keycloak.event_entity VALUES ('337df77f-7964-4e17-a4d1-4c103145d003', NULL, 'null', 'session_expired', '127.0.0.6', 'appcket', NULL, 1688492259593, 'LOGOUT_ERROR', NULL, NULL);
INSERT INTO keycloak.event_entity VALUES ('d38d8f98-a4f8-4fbe-a6f6-a4f645a208b3', NULL, 'null', 'session_expired', '127.0.0.6', 'appcket', NULL, 1691672338738, 'LOGOUT_ERROR', NULL, NULL);
INSERT INTO keycloak.event_entity VALUES ('294a630f-d3a5-49c2-a7d0-3845182df5e1', NULL, 'null', 'session_expired', '127.0.0.6', 'appcket', NULL, 1694454264463, 'LOGOUT_ERROR', NULL, NULL);
INSERT INTO keycloak.event_entity VALUES ('719c8f33-d022-44e3-bc58-4637acdd12c6', NULL, 'null', 'session_expired', '127.0.0.6', 'appcket', NULL, 1694456344878, 'LOGOUT_ERROR', NULL, NULL);
INSERT INTO keycloak.event_entity VALUES ('c52be9b1-8060-4724-bf44-bc3e4c111396', NULL, 'null', 'session_expired', '127.0.0.6', 'appcket', NULL, 1694471619794, 'LOGOUT_ERROR', NULL, NULL);
INSERT INTO keycloak.event_entity VALUES ('c76585be-1e04-4385-8d47-eba7ef888590', NULL, 'null', 'session_expired', '127.0.0.6', 'appcket', NULL, 1694623777125, 'LOGOUT_ERROR', NULL, NULL);
INSERT INTO keycloak.event_entity VALUES ('d1608e0b-e7de-4d55-84c8-d3ae335079ae', NULL, 'null', 'session_expired', '127.0.0.6', 'appcket', NULL, 1694624091015, 'LOGOUT_ERROR', NULL, NULL);
INSERT INTO keycloak.event_entity VALUES ('becceee3-1e6f-4ae3-ae06-1e7193c9c55a', NULL, 'null', 'session_expired', '127.0.0.6', 'appcket', NULL, 1694624929791, 'LOGOUT_ERROR', NULL, NULL);
INSERT INTO keycloak.event_entity VALUES ('ca36d07b-89c4-4944-8df0-0325ab0e1a42', NULL, 'null', 'session_expired', '127.0.0.6', 'appcket', NULL, 1694644366237, 'LOGOUT_ERROR', NULL, NULL);
INSERT INTO keycloak.event_entity VALUES ('f17a6516-56e1-4bc0-922c-7edbdc218589', NULL, 'null', 'session_expired', '127.0.0.6', 'appcket', NULL, 1694645231971, 'LOGOUT_ERROR', NULL, NULL);
INSERT INTO keycloak.event_entity VALUES ('a6b6f6dc-f205-45e0-a417-5ec067598f5b', NULL, 'null', 'session_expired', '127.0.0.6', 'appcket', NULL, 1694696416172, 'LOGOUT_ERROR', NULL, NULL);


--
-- TOC entry 4194 (class 0 OID 16534)
-- Dependencies: 241
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4195 (class 0 OID 16539)
-- Dependencies: 242
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4196 (class 0 OID 16544)
-- Dependencies: 243
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4197 (class 0 OID 16547)
-- Dependencies: 244
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4198 (class 0 OID 16552)
-- Dependencies: 245
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4199 (class 0 OID 16555)
-- Dependencies: 246
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4200 (class 0 OID 16561)
-- Dependencies: 247
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4201 (class 0 OID 16564)
-- Dependencies: 248
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4202 (class 0 OID 16569)
-- Dependencies: 249
-- Data for Name: federated_user; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4203 (class 0 OID 16574)
-- Dependencies: 250
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4204 (class 0 OID 16580)
-- Dependencies: 251
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4205 (class 0 OID 16583)
-- Dependencies: 252
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4206 (class 0 OID 16594)
-- Dependencies: 253
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4207 (class 0 OID 16599)
-- Dependencies: 254
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4208 (class 0 OID 16604)
-- Dependencies: 255
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4209 (class 0 OID 16609)
-- Dependencies: 256
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4210 (class 0 OID 16612)
-- Dependencies: 257
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.keycloak_role VALUES ('9644cff1-6824-4dab-9916-dd71201b120b', 'master', false, '${role_default-roles}', 'default-roles-master', 'master', NULL, NULL);
INSERT INTO keycloak.keycloak_role VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', 'master', false, '${role_admin}', 'admin', 'master', NULL, NULL);
INSERT INTO keycloak.keycloak_role VALUES ('c6aadeb4-1712-4277-93bb-6b4833d14162', 'master', false, '${role_create-realm}', 'create-realm', 'master', NULL, NULL);
INSERT INTO keycloak.keycloak_role VALUES ('27d9784d-6069-4079-8693-f94356e6b69e', 'aa546da1-d04d-4783-8c48-085c049d6f90', true, '${role_create-client}', 'create-client', 'master', 'aa546da1-d04d-4783-8c48-085c049d6f90', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('a740fdeb-528b-4cae-b7ce-689f07ee1d4f', 'aa546da1-d04d-4783-8c48-085c049d6f90', true, '${role_view-realm}', 'view-realm', 'master', 'aa546da1-d04d-4783-8c48-085c049d6f90', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('3bd13113-1bc6-4e28-b06b-b1bebdf15953', 'aa546da1-d04d-4783-8c48-085c049d6f90', true, '${role_view-users}', 'view-users', 'master', 'aa546da1-d04d-4783-8c48-085c049d6f90', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('dab5525c-db4d-4d94-a779-d626ef6c1a9c', 'aa546da1-d04d-4783-8c48-085c049d6f90', true, '${role_view-clients}', 'view-clients', 'master', 'aa546da1-d04d-4783-8c48-085c049d6f90', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('c08af820-26b4-42f9-8631-06d743752203', 'aa546da1-d04d-4783-8c48-085c049d6f90', true, '${role_view-events}', 'view-events', 'master', 'aa546da1-d04d-4783-8c48-085c049d6f90', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('dfab7ab1-2ee0-4dd8-b48e-7d39cbb5f463', 'aa546da1-d04d-4783-8c48-085c049d6f90', true, '${role_view-identity-providers}', 'view-identity-providers', 'master', 'aa546da1-d04d-4783-8c48-085c049d6f90', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('01b4c4ec-5cd5-4a39-b111-881a4452ca2f', 'aa546da1-d04d-4783-8c48-085c049d6f90', true, '${role_view-authorization}', 'view-authorization', 'master', 'aa546da1-d04d-4783-8c48-085c049d6f90', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('6739aa33-dc7c-408c-bad9-d4ec7214809e', 'aa546da1-d04d-4783-8c48-085c049d6f90', true, '${role_manage-realm}', 'manage-realm', 'master', 'aa546da1-d04d-4783-8c48-085c049d6f90', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('86316296-77f3-4392-bfa8-b70c3cb305d4', 'aa546da1-d04d-4783-8c48-085c049d6f90', true, '${role_manage-users}', 'manage-users', 'master', 'aa546da1-d04d-4783-8c48-085c049d6f90', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('5f65cfe4-0531-4be3-baee-0534d5ce4850', 'aa546da1-d04d-4783-8c48-085c049d6f90', true, '${role_manage-clients}', 'manage-clients', 'master', 'aa546da1-d04d-4783-8c48-085c049d6f90', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('423a5bcc-7cc0-4b3f-9068-acac57ed2838', 'aa546da1-d04d-4783-8c48-085c049d6f90', true, '${role_manage-events}', 'manage-events', 'master', 'aa546da1-d04d-4783-8c48-085c049d6f90', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('1cc0c756-121a-40ef-b810-f86431741277', 'aa546da1-d04d-4783-8c48-085c049d6f90', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'master', 'aa546da1-d04d-4783-8c48-085c049d6f90', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('3b011373-630a-4e34-b151-39c32af091bc', 'aa546da1-d04d-4783-8c48-085c049d6f90', true, '${role_manage-authorization}', 'manage-authorization', 'master', 'aa546da1-d04d-4783-8c48-085c049d6f90', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('d1d83dd3-a5ba-47c6-8c4b-0d8be136ebe1', 'aa546da1-d04d-4783-8c48-085c049d6f90', true, '${role_query-users}', 'query-users', 'master', 'aa546da1-d04d-4783-8c48-085c049d6f90', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('69a60d7e-d17a-480c-a254-175050e871cf', 'aa546da1-d04d-4783-8c48-085c049d6f90', true, '${role_query-clients}', 'query-clients', 'master', 'aa546da1-d04d-4783-8c48-085c049d6f90', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('6ce12b7c-3c90-40f0-b566-2694376803ea', 'aa546da1-d04d-4783-8c48-085c049d6f90', true, '${role_query-realms}', 'query-realms', 'master', 'aa546da1-d04d-4783-8c48-085c049d6f90', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('ea4f8f4d-3313-4584-9b34-4312904cf888', 'aa546da1-d04d-4783-8c48-085c049d6f90', true, '${role_query-groups}', 'query-groups', 'master', 'aa546da1-d04d-4783-8c48-085c049d6f90', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('f0ade632-d051-4f0d-9229-62b823903a17', '605fa94d-21d1-4569-8fa7-6bbb229b19f0', true, '${role_view-profile}', 'view-profile', 'master', '605fa94d-21d1-4569-8fa7-6bbb229b19f0', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('7a145737-e946-4bff-9c5b-d9c974fe64b3', '605fa94d-21d1-4569-8fa7-6bbb229b19f0', true, '${role_manage-account}', 'manage-account', 'master', '605fa94d-21d1-4569-8fa7-6bbb229b19f0', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('8ec28b5d-0037-4231-94d8-b493ee336ca2', '605fa94d-21d1-4569-8fa7-6bbb229b19f0', true, '${role_manage-account-links}', 'manage-account-links', 'master', '605fa94d-21d1-4569-8fa7-6bbb229b19f0', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('34731601-ce3a-4e9c-9cd0-68819c49d6b3', '605fa94d-21d1-4569-8fa7-6bbb229b19f0', true, '${role_view-applications}', 'view-applications', 'master', '605fa94d-21d1-4569-8fa7-6bbb229b19f0', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('1d8a45b6-c838-4ca3-a0fe-44da0ba58dbe', '605fa94d-21d1-4569-8fa7-6bbb229b19f0', true, '${role_view-consent}', 'view-consent', 'master', '605fa94d-21d1-4569-8fa7-6bbb229b19f0', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('369a56f3-8739-4007-979c-6f9cf190d3ce', '605fa94d-21d1-4569-8fa7-6bbb229b19f0', true, '${role_manage-consent}', 'manage-consent', 'master', '605fa94d-21d1-4569-8fa7-6bbb229b19f0', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('dc828144-5aac-447c-84c2-a7f32a02a263', '605fa94d-21d1-4569-8fa7-6bbb229b19f0', true, '${role_delete-account}', 'delete-account', 'master', '605fa94d-21d1-4569-8fa7-6bbb229b19f0', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('5037141a-dd9e-4419-87f1-b920065e678a', '6b0c8bef-0c61-487f-ac1d-dc77f3f97278', true, '${role_read-token}', 'read-token', 'master', '6b0c8bef-0c61-487f-ac1d-dc77f3f97278', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('7a5de334-6418-4186-83ab-630c04fef790', 'aa546da1-d04d-4783-8c48-085c049d6f90', true, '${role_impersonation}', 'impersonation', 'master', 'aa546da1-d04d-4783-8c48-085c049d6f90', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('785200ab-20dc-47c4-bffa-af0007c06dc9', 'master', false, '${role_offline-access}', 'offline_access', 'master', NULL, NULL);
INSERT INTO keycloak.keycloak_role VALUES ('a7789203-7db0-4bcf-aee1-c47aea130273', 'master', false, '${role_uma_authorization}', 'uma_authorization', 'master', NULL, NULL);
INSERT INTO keycloak.keycloak_role VALUES ('3a3efbeb-83dc-4f82-b78d-f00e954d7d40', 'appcket', false, '${role_default-roles}', 'default-roles-appcket', 'appcket', NULL, NULL);
INSERT INTO keycloak.keycloak_role VALUES ('2ae1deef-cb36-494a-b238-d4ae1b145be9', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', true, '${role_create-client}', 'create-client', 'master', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('fea5b979-6e50-4adb-a02a-40d67de24b42', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', true, '${role_view-realm}', 'view-realm', 'master', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('7a5836c9-d5c7-4649-8a0a-38dd60ece9c0', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', true, '${role_view-users}', 'view-users', 'master', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('79d5386d-ffcc-4829-95e9-045dc597a23b', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', true, '${role_view-clients}', 'view-clients', 'master', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('30d1bca6-7b99-4209-91d8-1b7c549fd963', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', true, '${role_view-events}', 'view-events', 'master', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('36f7c456-d64d-4f3c-bf46-44cc622b2918', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', true, '${role_view-identity-providers}', 'view-identity-providers', 'master', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('46c26134-a647-4263-9a44-ebef5de6074e', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', true, '${role_view-authorization}', 'view-authorization', 'master', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('b546db53-47ec-42a3-af5c-0680bec9d12f', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', true, '${role_manage-realm}', 'manage-realm', 'master', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('33ad5e4b-1bf4-43c2-8271-b64096075197', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', true, '${role_manage-users}', 'manage-users', 'master', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('157a58db-0f8c-4536-ab90-781b1c7003ed', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', true, '${role_manage-clients}', 'manage-clients', 'master', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('ef0847c7-74fa-4b34-8994-9c4b28c1bb02', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', true, '${role_manage-events}', 'manage-events', 'master', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('337ea090-4a28-4c3d-8124-d068c7e89097', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'master', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('326774d6-9646-4c8b-ab63-a86a0d1f600a', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', true, '${role_manage-authorization}', 'manage-authorization', 'master', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('c88623da-69e9-42bb-a7e2-870268a83240', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', true, '${role_query-users}', 'query-users', 'master', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('d456669e-a882-44c7-b83e-dc86f3332b78', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', true, '${role_query-clients}', 'query-clients', 'master', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('18057d22-9169-4c7a-a4b8-313b51277530', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', true, '${role_query-realms}', 'query-realms', 'master', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('62a07952-f0de-41aa-bd8a-c45b72bc865d', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', true, '${role_query-groups}', 'query-groups', 'master', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('a1234e9b-ccf4-43c2-8c5a-f8d5964d9e22', 'appcket', false, 'Spectators are people outside the organization who have been invited and have limited ability inside the app. They may only do what managers, captains or teammates allow them to do.', 'Spectator', 'appcket', NULL, NULL);
INSERT INTO keycloak.keycloak_role VALUES ('558648c2-b53b-4dfd-906f-d30b67967ecd', 'appcket', false, '${role_uma_authorization}', 'uma_authorization', 'appcket', NULL, NULL);
INSERT INTO keycloak.keycloak_role VALUES ('241f95cd-d0a8-4b5e-b7d3-657f078175bb', 'appcket', false, '${role_offline-access}', 'offline_access', 'appcket', NULL, NULL);
INSERT INTO keycloak.keycloak_role VALUES ('1b55f720-894d-4d89-b37d-358e5eb29309', 'appcket', false, 'A team leader similar to a football or hockey captain.', 'Captain', 'appcket', NULL, NULL);
INSERT INTO keycloak.keycloak_role VALUES ('eee97160-4b67-4071-84f4-099bbcd704af', 'appcket', false, 'An individual contributor to a team.', 'Teammate', 'appcket', NULL, NULL);
INSERT INTO keycloak.keycloak_role VALUES ('97caa102-e9d8-44de-94a1-74e5ea7bccb5', 'appcket', false, 'A manager is like a baseball team''s manager in that they have more permission and capability across the organization than captains and teammates.', 'Manager', 'appcket', NULL, NULL);
INSERT INTO keycloak.keycloak_role VALUES ('a5654d13-57b2-4a00-8ffa-e4be21c18524', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', true, NULL, 'uma_protection', 'appcket', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('3164e832-b3b2-40d1-a50b-3bfb997d4e46', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('d95fec18-c1e8-4720-b180-f88f8813e7a0', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_manage-realm}', 'manage-realm', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('3a011ec6-1589-42f2-a9ae-e3e8daffb290', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_view-realm}', 'view-realm', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('14183e37-4d0d-4f80-89a9-d979c7676d6a', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_query-users}', 'query-users', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('934d2eb7-4ffa-406f-b8a9-155460dd9872', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_view-users}', 'view-users', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('e532fe1f-14b2-42a5-af86-9b523e2fe992', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_query-realms}', 'query-realms', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('de050d33-3f79-4b6d-9f0f-33ed806b0cf8', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_view-identity-providers}', 'view-identity-providers', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('a1516493-c8b5-4001-a15a-d2b4a53964cc', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_query-clients}', 'query-clients', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('2387902b-b5e8-4810-814a-820bfc0bf070', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_manage-clients}', 'manage-clients', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('561557b4-e7d0-4401-9b18-25893c663078', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_create-client}', 'create-client', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('c8c99201-43cb-4987-9100-34b135c13cd0', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_manage-authorization}', 'manage-authorization', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('6309e6a4-e13e-419b-8d06-476b6fad7177', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_manage-events}', 'manage-events', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('7fed08ed-9110-4022-8550-433f0fc5054f', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_manage-users}', 'manage-users', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('d0202d84-e5c0-4558-b385-c04149655885', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_view-clients}', 'view-clients', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('b8f4990b-326a-4cd5-81d1-fc0603561b68', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_view-events}', 'view-events', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('d303d692-a116-48ec-9d15-e3449ca00f10', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_view-authorization}', 'view-authorization', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('3fda9186-3fda-413f-900b-43b487d08732', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_query-groups}', 'query-groups', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('3b234c85-7863-4077-ba73-5c39796c4476', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_impersonation}', 'impersonation', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('32ff242f-83ed-4e5b-90d4-a5a75227b94b', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_realm-admin}', 'realm-admin', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('a9603702-bbb8-4c3b-baa9-9c8e6fb34c42', '70da96f3-abee-4ade-a7f3-d22e04437a0a', true, '${role_read-token}', 'read-token', 'appcket', '70da96f3-abee-4ade-a7f3-d22e04437a0a', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('750a3b3a-0cbc-47dd-b3e5-0de2a88b8a82', 'e801cbf0-541f-4466-80e1-fcce640df2a8', true, '${role_view-consent}', 'view-consent', 'appcket', 'e801cbf0-541f-4466-80e1-fcce640df2a8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('395df0fe-9ce6-4af3-9d3f-a76b64e2c6b1', 'e801cbf0-541f-4466-80e1-fcce640df2a8', true, '${role_manage-account}', 'manage-account', 'appcket', 'e801cbf0-541f-4466-80e1-fcce640df2a8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('f82082f8-ce8f-4514-a0df-08b916e08db3', 'e801cbf0-541f-4466-80e1-fcce640df2a8', true, '${role_view-profile}', 'view-profile', 'appcket', 'e801cbf0-541f-4466-80e1-fcce640df2a8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('c187fe98-fbc1-4601-a0b8-c463193e8494', 'e801cbf0-541f-4466-80e1-fcce640df2a8', true, '${role_manage-account-links}', 'manage-account-links', 'appcket', 'e801cbf0-541f-4466-80e1-fcce640df2a8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('a7e4209f-1242-4cf6-a548-8e9fb0183623', 'e801cbf0-541f-4466-80e1-fcce640df2a8', true, '${role_view-applications}', 'view-applications', 'appcket', 'e801cbf0-541f-4466-80e1-fcce640df2a8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('4be9e535-34e3-4ebc-8591-1f575899d346', 'e801cbf0-541f-4466-80e1-fcce640df2a8', true, '${role_manage-consent}', 'manage-consent', 'appcket', 'e801cbf0-541f-4466-80e1-fcce640df2a8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('28c9d094-9c20-41ae-a6b8-e76ff29509bf', 'e801cbf0-541f-4466-80e1-fcce640df2a8', true, '${role_delete-account}', 'delete-account', 'appcket', 'e801cbf0-541f-4466-80e1-fcce640df2a8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('cbd7ba23-5f0a-4ec5-a795-25ecebc54a79', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', true, '${role_impersonation}', 'impersonation', 'master', 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('3acee81b-79f3-4223-befe-0fec94a744cf', '605fa94d-21d1-4569-8fa7-6bbb229b19f0', true, '${role_view-groups}', 'view-groups', 'master', '605fa94d-21d1-4569-8fa7-6bbb229b19f0', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('385ea9e2-2f95-4649-871b-b7313d4e9904', 'e801cbf0-541f-4466-80e1-fcce640df2a8', true, '${role_view-groups}', 'view-groups', 'appcket', 'e801cbf0-541f-4466-80e1-fcce640df2a8', NULL);


--
-- TOC entry 4211 (class 0 OID 16618)
-- Dependencies: 258
-- Data for Name: migration_model; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.migration_model VALUES ('8rsjk', '17.0.0', 1645324288);
INSERT INTO keycloak.migration_model VALUES ('zvo02', '17.0.1', 1649123024);
INSERT INTO keycloak.migration_model VALUES ('armx3', '18.0.0', 1650567590);
INSERT INTO keycloak.migration_model VALUES ('3ydir', '19.0.3', 1666056067);
INSERT INTO keycloak.migration_model VALUES ('zgfi9', '20.0.1', 1668175332);
INSERT INTO keycloak.migration_model VALUES ('y5sat', '21.1.1', 1686056382);
INSERT INTO keycloak.migration_model VALUES ('c5qbj', '22.0.3', 1695039219);
INSERT INTO keycloak.migration_model VALUES ('cjyc6', '22.0.5', 1700671976);
INSERT INTO keycloak.migration_model VALUES ('vqrqf', '23.0.6', 1708017580);
INSERT INTO keycloak.migration_model VALUES ('u43pv', '24.0.3', 1713469987);
INSERT INTO keycloak.migration_model VALUES ('jzib1', '25.0.2', 1724075872);
INSERT INTO keycloak.migration_model VALUES ('nbsp0', '26.0.5', 1731084085);


--
-- TOC entry 4212 (class 0 OID 16622)
-- Dependencies: 259
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.offline_client_session VALUES ('ba3680a2-b50f-47eb-b8df-d837528ec67e', '68d063b7-66bc-4e03-8ed0-38694d466ad3', '0', 1731084258, '{"authMethod":"openid-connect","redirectUri":"https://app.appcket.localhost","notes":{"clientId":"68d063b7-66bc-4e03-8ed0-38694d466ad3","scope":"openid","userSessionStartedAt":"1731084258","iss":"https://accounts.appcket.localhost/realms/appcket","startedAt":"1731084258","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","redirect_uri":"https://app.appcket.localhost","state":"1cc019d290c246f9b266bee56d263efe","code_challenge":"amxKFZVT8n_O-mtEa867Q93yqA4V5E9VrTlLql-NWw0"}}', 'local', 'local', 0);


--
-- TOC entry 4213 (class 0 OID 16629)
-- Dependencies: 260
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.offline_user_session VALUES ('ba3680a2-b50f-47eb-b8df-d837528ec67e', 'de3127bc-dbe6-4775-9334-2f873f413d23', 'appcket', 1731084258, '0', '{"ipAddress":"127.0.0.6","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjcuMC4wLjYiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTMwLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1731084258","authenticators-completed":"{\"548402b3-ad06-4470-a9d3-b8aace7b5688\":1731084258}"},"state":"LOGGED_IN"}', 1731084258, NULL, 0);


--
-- TOC entry 4254 (class 0 OID 24582)
-- Dependencies: 313
-- Data for Name: org; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4255 (class 0 OID 24593)
-- Dependencies: 314
-- Data for Name: org_domain; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4214 (class 0 OID 16635)
-- Dependencies: 261
-- Data for Name: policy_config; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.policy_config VALUES ('bfaf527b-4238-46d7-aa48-1d605b7c390f', 'code', '// by default, grants any permission associated with this policy
$evaluation.grant();
');
INSERT INTO keycloak.policy_config VALUES ('f54d2838-ff5a-4259-8560-c50f042375ab', 'roles', '[{"id":"1b55f720-894d-4d89-b37d-358e5eb29309","required":false}]');
INSERT INTO keycloak.policy_config VALUES ('0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7', 'roles', '[{"id":"97caa102-e9d8-44de-94a1-74e5ea7bccb5","required":false}]');
INSERT INTO keycloak.policy_config VALUES ('53667455-8734-49e0-9e11-db6aacce6cbf', 'roles', '[{"id":"eee97160-4b67-4071-84f4-099bbcd704af","required":false}]');
INSERT INTO keycloak.policy_config VALUES ('56cc0301-6b50-4bb1-b870-514669458695', 'roles', '[{"id":"a1234e9b-ccf4-43c2-8c5a-f8d5964d9e22","required":false}]');
INSERT INTO keycloak.policy_config VALUES ('b498b31a-81fa-4a32-b625-71ca3e577dcb', 'defaultResourceType', 'urn:appcket_api:resources:default');


--
-- TOC entry 4215 (class 0 OID 16640)
-- Dependencies: 262
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.protocol_mapper VALUES ('11643044-657a-4558-be3b-d967e1025e4e', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', '235e5d2b-515a-422c-b23c-6d9c3abddfa5', NULL);
INSERT INTO keycloak.protocol_mapper VALUES ('99e897b9-18e3-4d5d-a40d-485291344bbc', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', '01818753-ed45-4903-93e9-8ebffc711cd8', NULL);
INSERT INTO keycloak.protocol_mapper VALUES ('93b5f94c-0c0b-4ff5-a2d5-bed94d84018d', 'role list', 'saml', 'saml-role-list-mapper', NULL, 'eec3ffac-3981-4e3a-ab1c-b10634335b7b');
INSERT INTO keycloak.protocol_mapper VALUES ('5ee2e1c5-6e90-44f3-9590-4ce7555e1c2c', 'full name', 'openid-connect', 'oidc-full-name-mapper', NULL, '64962ee9-4308-44c8-b93d-20f335fb7fe4');
INSERT INTO keycloak.protocol_mapper VALUES ('be6d4a85-e522-464b-99e7-0965596edd9e', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '64962ee9-4308-44c8-b93d-20f335fb7fe4');
INSERT INTO keycloak.protocol_mapper VALUES ('69d797a4-91f4-43a0-bd0a-1f89a6770305', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '64962ee9-4308-44c8-b93d-20f335fb7fe4');
INSERT INTO keycloak.protocol_mapper VALUES ('4b8c37ba-5938-43f3-9bd2-09bcbbdcd72c', 'middle name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '64962ee9-4308-44c8-b93d-20f335fb7fe4');
INSERT INTO keycloak.protocol_mapper VALUES ('937ed2e0-5d5e-45c1-a196-a1d0d5c08228', 'nickname', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '64962ee9-4308-44c8-b93d-20f335fb7fe4');
INSERT INTO keycloak.protocol_mapper VALUES ('cc7b5f04-9f9a-48f0-a00e-d5ec457e4d20', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '64962ee9-4308-44c8-b93d-20f335fb7fe4');
INSERT INTO keycloak.protocol_mapper VALUES ('a1681781-4b4a-403a-ae47-e271fdf2990c', 'profile', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '64962ee9-4308-44c8-b93d-20f335fb7fe4');
INSERT INTO keycloak.protocol_mapper VALUES ('e158043b-21f9-4a90-8deb-069e29ba1f23', 'picture', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '64962ee9-4308-44c8-b93d-20f335fb7fe4');
INSERT INTO keycloak.protocol_mapper VALUES ('543e5f9b-5233-4ba1-8e6f-f0d089ccc279', 'website', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '64962ee9-4308-44c8-b93d-20f335fb7fe4');
INSERT INTO keycloak.protocol_mapper VALUES ('a8cb3b1d-637c-4cc5-9ed5-7f088d1c4131', 'gender', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '64962ee9-4308-44c8-b93d-20f335fb7fe4');
INSERT INTO keycloak.protocol_mapper VALUES ('6b2b97db-f45f-492f-a5c1-ab675544c8a4', 'birthdate', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '64962ee9-4308-44c8-b93d-20f335fb7fe4');
INSERT INTO keycloak.protocol_mapper VALUES ('0a1146c6-2ab4-447c-b0c5-16261447e5d7', 'zoneinfo', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '64962ee9-4308-44c8-b93d-20f335fb7fe4');
INSERT INTO keycloak.protocol_mapper VALUES ('e91765b2-09a8-45d5-a3b4-66910275f854', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '64962ee9-4308-44c8-b93d-20f335fb7fe4');
INSERT INTO keycloak.protocol_mapper VALUES ('ffba7839-c639-4d76-80b3-7a257c305e44', 'updated at', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '64962ee9-4308-44c8-b93d-20f335fb7fe4');
INSERT INTO keycloak.protocol_mapper VALUES ('9d527bef-5f63-4c37-acba-04913528127b', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'b5725526-2c78-46cb-9941-ec0445725c4e');
INSERT INTO keycloak.protocol_mapper VALUES ('9786396f-ffab-4b16-b9ab-0da2d3f11056', 'email verified', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'b5725526-2c78-46cb-9941-ec0445725c4e');
INSERT INTO keycloak.protocol_mapper VALUES ('84b57c49-b019-4536-a54a-f76364c32215', 'address', 'openid-connect', 'oidc-address-mapper', NULL, '8788d929-9c56-44e2-b500-cac7c9cdbbf7');
INSERT INTO keycloak.protocol_mapper VALUES ('be3371a5-b51e-4349-a4ce-d6c234850d7f', 'phone number', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '2414f4d3-cfb3-49ae-ad70-7c4388c14f52');
INSERT INTO keycloak.protocol_mapper VALUES ('6d808d63-40a9-42d5-9bb0-3aa7b425d3ab', 'phone number verified', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '2414f4d3-cfb3-49ae-ad70-7c4388c14f52');
INSERT INTO keycloak.protocol_mapper VALUES ('468735fc-46f4-434b-908f-7c8f865350f0', 'realm roles', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, '374759fc-935f-4c93-9bef-57573aafba31');
INSERT INTO keycloak.protocol_mapper VALUES ('eb096447-b6c7-4b59-ab9e-dafa7eea5012', 'client roles', 'openid-connect', 'oidc-usermodel-client-role-mapper', NULL, '374759fc-935f-4c93-9bef-57573aafba31');
INSERT INTO keycloak.protocol_mapper VALUES ('8831f05d-1103-40c5-9af0-3cc629f2522b', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', NULL, '374759fc-935f-4c93-9bef-57573aafba31');
INSERT INTO keycloak.protocol_mapper VALUES ('3714b5bb-c05a-45eb-b73b-65c6fb1fcbb5', 'allowed web origins', 'openid-connect', 'oidc-allowed-origins-mapper', NULL, 'e374cda1-44a0-4d7e-a214-e401a11d4673');
INSERT INTO keycloak.protocol_mapper VALUES ('22c6ba9b-23e2-40d6-9be6-9aa93b198cba', 'upn', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'e816fcd5-0b78-422e-8fc0-0ea150b1daf0');
INSERT INTO keycloak.protocol_mapper VALUES ('9c4beea4-9e8e-48a1-8842-99345f3ca0c2', 'groups', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, 'e816fcd5-0b78-422e-8fc0-0ea150b1daf0');
INSERT INTO keycloak.protocol_mapper VALUES ('628d5988-9461-4cb4-a16d-30f116e58d4c', 'role list', 'saml', 'saml-role-list-mapper', NULL, 'bed9e481-a783-4f6c-bd5a-f79f5d189ee6');
INSERT INTO keycloak.protocol_mapper VALUES ('ace4e693-1183-4c96-9aea-41ca084b4bbf', 'realm roles', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, '2b5c02f3-e7a9-4455-a505-9fef19838927');
INSERT INTO keycloak.protocol_mapper VALUES ('ae7c93eb-ae11-4b4d-b052-e04b2fc2a9bd', 'client roles', 'openid-connect', 'oidc-usermodel-client-role-mapper', NULL, '2b5c02f3-e7a9-4455-a505-9fef19838927');
INSERT INTO keycloak.protocol_mapper VALUES ('fb1c4748-138f-4389-aff7-59c73380e103', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', NULL, '2b5c02f3-e7a9-4455-a505-9fef19838927');
INSERT INTO keycloak.protocol_mapper VALUES ('d2b100d8-cfd5-4485-a1b6-dd6c9277fa62', 'address', 'openid-connect', 'oidc-address-mapper', NULL, 'b2414a14-1f25-4d4b-9162-de66eeb6652d');
INSERT INTO keycloak.protocol_mapper VALUES ('523594f5-eecb-4f6c-9618-609d78630d9b', 'allowed web origins', 'openid-connect', 'oidc-allowed-origins-mapper', NULL, '52312b11-3e69-46f2-93f2-b1e168214598');
INSERT INTO keycloak.protocol_mapper VALUES ('bd5c32a6-5fca-4f65-a214-916d38aeee13', 'email verified', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '63984129-44c9-4bd1-97d1-da0df3407112');
INSERT INTO keycloak.protocol_mapper VALUES ('dc868b98-c04d-442d-8526-6092c2decf46', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '63984129-44c9-4bd1-97d1-da0df3407112');
INSERT INTO keycloak.protocol_mapper VALUES ('27ad127b-e9e0-4cca-ae70-1889095e68b8', 'upn', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'a15b2f14-004d-47f8-b137-7bca43fc8b30');
INSERT INTO keycloak.protocol_mapper VALUES ('3ede00f8-d88c-4d51-a7bd-fc8266196d86', 'groups', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, 'a15b2f14-004d-47f8-b137-7bca43fc8b30');
INSERT INTO keycloak.protocol_mapper VALUES ('d372c450-4ef9-4359-894c-feb03f732747', 'profile', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'aee86bba-572b-4335-8f5b-c9969c70cbce');
INSERT INTO keycloak.protocol_mapper VALUES ('e2bcdee5-07b1-494b-ba98-64d110d3862f', 'gender', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'aee86bba-572b-4335-8f5b-c9969c70cbce');
INSERT INTO keycloak.protocol_mapper VALUES ('54fe2e8c-ae54-40c0-a58a-65c9c14f953d', 'birthdate', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'aee86bba-572b-4335-8f5b-c9969c70cbce');
INSERT INTO keycloak.protocol_mapper VALUES ('e3d3222b-0a96-4452-89b9-e73addb85a9e', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'aee86bba-572b-4335-8f5b-c9969c70cbce');
INSERT INTO keycloak.protocol_mapper VALUES ('afec02bd-18dc-40ca-9f44-ac75796ca396', 'nickname', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'aee86bba-572b-4335-8f5b-c9969c70cbce');
INSERT INTO keycloak.protocol_mapper VALUES ('bde6d19d-9c17-4e67-9880-453a8f32fb2f', 'zoneinfo', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'aee86bba-572b-4335-8f5b-c9969c70cbce');
INSERT INTO keycloak.protocol_mapper VALUES ('e1dd8224-e8a1-4006-82fe-3096fe8926c5', 'full name', 'openid-connect', 'oidc-full-name-mapper', NULL, 'aee86bba-572b-4335-8f5b-c9969c70cbce');
INSERT INTO keycloak.protocol_mapper VALUES ('cd405c84-96b5-4a5f-ba4c-d842bd6b3347', 'website', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'aee86bba-572b-4335-8f5b-c9969c70cbce');
INSERT INTO keycloak.protocol_mapper VALUES ('bf451083-910a-4e3e-b86c-69c8af9de75c', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'aee86bba-572b-4335-8f5b-c9969c70cbce');
INSERT INTO keycloak.protocol_mapper VALUES ('fe2f8219-6357-4ac4-b46c-83dc91cffe7d', 'middle name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'aee86bba-572b-4335-8f5b-c9969c70cbce');
INSERT INTO keycloak.protocol_mapper VALUES ('fff32738-9b5c-47c8-b379-ee5dc9815d13', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'aee86bba-572b-4335-8f5b-c9969c70cbce');
INSERT INTO keycloak.protocol_mapper VALUES ('fbc68b60-fa5f-40b2-b2bb-e600699f3904', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'aee86bba-572b-4335-8f5b-c9969c70cbce');
INSERT INTO keycloak.protocol_mapper VALUES ('43fc25a2-4e2d-4269-b6b2-4e4587be6e1f', 'picture', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'aee86bba-572b-4335-8f5b-c9969c70cbce');
INSERT INTO keycloak.protocol_mapper VALUES ('82005164-d7d3-40e5-98df-9aa79bf956cf', 'updated at', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'aee86bba-572b-4335-8f5b-c9969c70cbce');
INSERT INTO keycloak.protocol_mapper VALUES ('533d4496-8888-4275-8afa-8d048b7ff283', 'phone number', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '4709e0fb-184a-4b47-a804-ae1556e53a73');
INSERT INTO keycloak.protocol_mapper VALUES ('d00a2308-a8d8-4d72-aa1b-ef2653198a9a', 'phone number verified', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '4709e0fb-184a-4b47-a804-ae1556e53a73');
INSERT INTO keycloak.protocol_mapper VALUES ('ea9bb3c5-eb5c-4fe6-8124-b55fc225d99a', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', '26f802c3-b7af-4e78-b785-40493ae2483a', NULL);
INSERT INTO keycloak.protocol_mapper VALUES ('f55bba66-f14f-4781-9295-981ccef3023d', 'Client ID', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.protocol_mapper VALUES ('cadcd86f-31bb-4bfe-9f09-b155027a8319', 'Client Host', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.protocol_mapper VALUES ('795f38ba-3268-4e2f-a956-ca2ad1a0d3be', 'Client IP Address', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.protocol_mapper VALUES ('9d14a67a-613b-4f8c-a8c4-1d34b23d595c', 'Audience for appcket_app', 'openid-connect', 'oidc-audience-mapper', '68d063b7-66bc-4e03-8ed0-38694d466ad3', NULL);
INSERT INTO keycloak.protocol_mapper VALUES ('f600d7c2-c282-46c4-877f-12e54f486cb6', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', '4dd4c360-d5b9-4730-8091-78b394cea334', NULL);
INSERT INTO keycloak.protocol_mapper VALUES ('487f106e-8394-4353-a39c-64890e759820', 'acr loa level', 'openid-connect', 'oidc-acr-mapper', NULL, 'f2af3385-b007-4e90-b783-54eaa0aac86d');
INSERT INTO keycloak.protocol_mapper VALUES ('2d2a0c1c-6121-41c8-8c22-1625136dcf74', 'acr loa level', 'openid-connect', 'oidc-acr-mapper', NULL, 'c03824d3-cc18-4529-90cd-968ab5d3653d');
INSERT INTO keycloak.protocol_mapper VALUES ('e5f342ac-0e93-49b0-90f0-444a8d66d8d8', 'auth_time', 'openid-connect', 'oidc-usersessionmodel-note-mapper', NULL, 'd43481d5-5c2a-4407-bf8f-ce49bdc5ceff');
INSERT INTO keycloak.protocol_mapper VALUES ('71d52062-7793-47eb-9414-7adba2c51bf4', 'sub', 'openid-connect', 'oidc-sub-mapper', NULL, 'd43481d5-5c2a-4407-bf8f-ce49bdc5ceff');
INSERT INTO keycloak.protocol_mapper VALUES ('396fc5e4-989e-4825-b049-abd01e3e2cfa', 'auth_time', 'openid-connect', 'oidc-usersessionmodel-note-mapper', NULL, 'a8ddb608-a41f-4ff6-bb20-14237bc37572');
INSERT INTO keycloak.protocol_mapper VALUES ('d6250470-c8b3-4e88-858c-53b911cf2047', 'sub', 'openid-connect', 'oidc-sub-mapper', NULL, 'a8ddb608-a41f-4ff6-bb20-14237bc37572');


--
-- TOC entry 4216 (class 0 OID 16645)
-- Dependencies: 263
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.protocol_mapper_config VALUES ('99e897b9-18e3-4d5d-a40d-485291344bbc', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('99e897b9-18e3-4d5d-a40d-485291344bbc', 'locale', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('99e897b9-18e3-4d5d-a40d-485291344bbc', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('99e897b9-18e3-4d5d-a40d-485291344bbc', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('99e897b9-18e3-4d5d-a40d-485291344bbc', 'locale', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('99e897b9-18e3-4d5d-a40d-485291344bbc', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('93b5f94c-0c0b-4ff5-a2d5-bed94d84018d', 'false', 'single');
INSERT INTO keycloak.protocol_mapper_config VALUES ('93b5f94c-0c0b-4ff5-a2d5-bed94d84018d', 'Basic', 'attribute.nameformat');
INSERT INTO keycloak.protocol_mapper_config VALUES ('93b5f94c-0c0b-4ff5-a2d5-bed94d84018d', 'Role', 'attribute.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('0a1146c6-2ab4-447c-b0c5-16261447e5d7', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('0a1146c6-2ab4-447c-b0c5-16261447e5d7', 'zoneinfo', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('0a1146c6-2ab4-447c-b0c5-16261447e5d7', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('0a1146c6-2ab4-447c-b0c5-16261447e5d7', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('0a1146c6-2ab4-447c-b0c5-16261447e5d7', 'zoneinfo', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('0a1146c6-2ab4-447c-b0c5-16261447e5d7', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('4b8c37ba-5938-43f3-9bd2-09bcbbdcd72c', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('4b8c37ba-5938-43f3-9bd2-09bcbbdcd72c', 'middleName', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('4b8c37ba-5938-43f3-9bd2-09bcbbdcd72c', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('4b8c37ba-5938-43f3-9bd2-09bcbbdcd72c', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('4b8c37ba-5938-43f3-9bd2-09bcbbdcd72c', 'middle_name', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('4b8c37ba-5938-43f3-9bd2-09bcbbdcd72c', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('543e5f9b-5233-4ba1-8e6f-f0d089ccc279', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('543e5f9b-5233-4ba1-8e6f-f0d089ccc279', 'website', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('543e5f9b-5233-4ba1-8e6f-f0d089ccc279', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('543e5f9b-5233-4ba1-8e6f-f0d089ccc279', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('543e5f9b-5233-4ba1-8e6f-f0d089ccc279', 'website', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('543e5f9b-5233-4ba1-8e6f-f0d089ccc279', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('5ee2e1c5-6e90-44f3-9590-4ce7555e1c2c', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('5ee2e1c5-6e90-44f3-9590-4ce7555e1c2c', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('5ee2e1c5-6e90-44f3-9590-4ce7555e1c2c', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('69d797a4-91f4-43a0-bd0a-1f89a6770305', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('69d797a4-91f4-43a0-bd0a-1f89a6770305', 'firstName', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('69d797a4-91f4-43a0-bd0a-1f89a6770305', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('69d797a4-91f4-43a0-bd0a-1f89a6770305', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('69d797a4-91f4-43a0-bd0a-1f89a6770305', 'given_name', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('69d797a4-91f4-43a0-bd0a-1f89a6770305', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('6b2b97db-f45f-492f-a5c1-ab675544c8a4', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('6b2b97db-f45f-492f-a5c1-ab675544c8a4', 'birthdate', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('6b2b97db-f45f-492f-a5c1-ab675544c8a4', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('6b2b97db-f45f-492f-a5c1-ab675544c8a4', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('6b2b97db-f45f-492f-a5c1-ab675544c8a4', 'birthdate', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('6b2b97db-f45f-492f-a5c1-ab675544c8a4', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('937ed2e0-5d5e-45c1-a196-a1d0d5c08228', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('937ed2e0-5d5e-45c1-a196-a1d0d5c08228', 'nickname', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('937ed2e0-5d5e-45c1-a196-a1d0d5c08228', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('937ed2e0-5d5e-45c1-a196-a1d0d5c08228', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('937ed2e0-5d5e-45c1-a196-a1d0d5c08228', 'nickname', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('937ed2e0-5d5e-45c1-a196-a1d0d5c08228', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('a1681781-4b4a-403a-ae47-e271fdf2990c', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('a1681781-4b4a-403a-ae47-e271fdf2990c', 'profile', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('a1681781-4b4a-403a-ae47-e271fdf2990c', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('a1681781-4b4a-403a-ae47-e271fdf2990c', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('a1681781-4b4a-403a-ae47-e271fdf2990c', 'profile', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('a1681781-4b4a-403a-ae47-e271fdf2990c', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('a8cb3b1d-637c-4cc5-9ed5-7f088d1c4131', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('a8cb3b1d-637c-4cc5-9ed5-7f088d1c4131', 'gender', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('a8cb3b1d-637c-4cc5-9ed5-7f088d1c4131', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('a8cb3b1d-637c-4cc5-9ed5-7f088d1c4131', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('a8cb3b1d-637c-4cc5-9ed5-7f088d1c4131', 'gender', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('a8cb3b1d-637c-4cc5-9ed5-7f088d1c4131', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('be6d4a85-e522-464b-99e7-0965596edd9e', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('be6d4a85-e522-464b-99e7-0965596edd9e', 'lastName', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('be6d4a85-e522-464b-99e7-0965596edd9e', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('be6d4a85-e522-464b-99e7-0965596edd9e', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('be6d4a85-e522-464b-99e7-0965596edd9e', 'family_name', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('be6d4a85-e522-464b-99e7-0965596edd9e', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('cc7b5f04-9f9a-48f0-a00e-d5ec457e4d20', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('cc7b5f04-9f9a-48f0-a00e-d5ec457e4d20', 'username', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('cc7b5f04-9f9a-48f0-a00e-d5ec457e4d20', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('cc7b5f04-9f9a-48f0-a00e-d5ec457e4d20', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('cc7b5f04-9f9a-48f0-a00e-d5ec457e4d20', 'preferred_username', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('cc7b5f04-9f9a-48f0-a00e-d5ec457e4d20', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e158043b-21f9-4a90-8deb-069e29ba1f23', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e158043b-21f9-4a90-8deb-069e29ba1f23', 'picture', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e158043b-21f9-4a90-8deb-069e29ba1f23', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e158043b-21f9-4a90-8deb-069e29ba1f23', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e158043b-21f9-4a90-8deb-069e29ba1f23', 'picture', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e158043b-21f9-4a90-8deb-069e29ba1f23', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e91765b2-09a8-45d5-a3b4-66910275f854', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e91765b2-09a8-45d5-a3b4-66910275f854', 'locale', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e91765b2-09a8-45d5-a3b4-66910275f854', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e91765b2-09a8-45d5-a3b4-66910275f854', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e91765b2-09a8-45d5-a3b4-66910275f854', 'locale', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e91765b2-09a8-45d5-a3b4-66910275f854', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('ffba7839-c639-4d76-80b3-7a257c305e44', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('ffba7839-c639-4d76-80b3-7a257c305e44', 'updatedAt', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('ffba7839-c639-4d76-80b3-7a257c305e44', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('ffba7839-c639-4d76-80b3-7a257c305e44', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('ffba7839-c639-4d76-80b3-7a257c305e44', 'updated_at', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('ffba7839-c639-4d76-80b3-7a257c305e44', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('9786396f-ffab-4b16-b9ab-0da2d3f11056', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('9786396f-ffab-4b16-b9ab-0da2d3f11056', 'emailVerified', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('9786396f-ffab-4b16-b9ab-0da2d3f11056', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('9786396f-ffab-4b16-b9ab-0da2d3f11056', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('9786396f-ffab-4b16-b9ab-0da2d3f11056', 'email_verified', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('9786396f-ffab-4b16-b9ab-0da2d3f11056', 'boolean', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('9d527bef-5f63-4c37-acba-04913528127b', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('9d527bef-5f63-4c37-acba-04913528127b', 'email', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('9d527bef-5f63-4c37-acba-04913528127b', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('9d527bef-5f63-4c37-acba-04913528127b', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('9d527bef-5f63-4c37-acba-04913528127b', 'email', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('9d527bef-5f63-4c37-acba-04913528127b', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('84b57c49-b019-4536-a54a-f76364c32215', 'formatted', 'user.attribute.formatted');
INSERT INTO keycloak.protocol_mapper_config VALUES ('84b57c49-b019-4536-a54a-f76364c32215', 'country', 'user.attribute.country');
INSERT INTO keycloak.protocol_mapper_config VALUES ('84b57c49-b019-4536-a54a-f76364c32215', 'postal_code', 'user.attribute.postal_code');
INSERT INTO keycloak.protocol_mapper_config VALUES ('84b57c49-b019-4536-a54a-f76364c32215', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('84b57c49-b019-4536-a54a-f76364c32215', 'street', 'user.attribute.street');
INSERT INTO keycloak.protocol_mapper_config VALUES ('84b57c49-b019-4536-a54a-f76364c32215', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('84b57c49-b019-4536-a54a-f76364c32215', 'region', 'user.attribute.region');
INSERT INTO keycloak.protocol_mapper_config VALUES ('84b57c49-b019-4536-a54a-f76364c32215', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('84b57c49-b019-4536-a54a-f76364c32215', 'locality', 'user.attribute.locality');
INSERT INTO keycloak.protocol_mapper_config VALUES ('6d808d63-40a9-42d5-9bb0-3aa7b425d3ab', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('6d808d63-40a9-42d5-9bb0-3aa7b425d3ab', 'phoneNumberVerified', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('6d808d63-40a9-42d5-9bb0-3aa7b425d3ab', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('6d808d63-40a9-42d5-9bb0-3aa7b425d3ab', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('6d808d63-40a9-42d5-9bb0-3aa7b425d3ab', 'phone_number_verified', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('6d808d63-40a9-42d5-9bb0-3aa7b425d3ab', 'boolean', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('be3371a5-b51e-4349-a4ce-d6c234850d7f', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('be3371a5-b51e-4349-a4ce-d6c234850d7f', 'phoneNumber', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('be3371a5-b51e-4349-a4ce-d6c234850d7f', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('be3371a5-b51e-4349-a4ce-d6c234850d7f', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('be3371a5-b51e-4349-a4ce-d6c234850d7f', 'phone_number', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('be3371a5-b51e-4349-a4ce-d6c234850d7f', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('468735fc-46f4-434b-908f-7c8f865350f0', 'true', 'multivalued');
INSERT INTO keycloak.protocol_mapper_config VALUES ('468735fc-46f4-434b-908f-7c8f865350f0', 'foo', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('468735fc-46f4-434b-908f-7c8f865350f0', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('468735fc-46f4-434b-908f-7c8f865350f0', 'realm_access.roles', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('468735fc-46f4-434b-908f-7c8f865350f0', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('eb096447-b6c7-4b59-ab9e-dafa7eea5012', 'true', 'multivalued');
INSERT INTO keycloak.protocol_mapper_config VALUES ('eb096447-b6c7-4b59-ab9e-dafa7eea5012', 'foo', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('eb096447-b6c7-4b59-ab9e-dafa7eea5012', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('eb096447-b6c7-4b59-ab9e-dafa7eea5012', 'resource_access.${client_id}.roles', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('eb096447-b6c7-4b59-ab9e-dafa7eea5012', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('22c6ba9b-23e2-40d6-9be6-9aa93b198cba', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('22c6ba9b-23e2-40d6-9be6-9aa93b198cba', 'username', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('22c6ba9b-23e2-40d6-9be6-9aa93b198cba', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('22c6ba9b-23e2-40d6-9be6-9aa93b198cba', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('22c6ba9b-23e2-40d6-9be6-9aa93b198cba', 'upn', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('22c6ba9b-23e2-40d6-9be6-9aa93b198cba', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('9c4beea4-9e8e-48a1-8842-99345f3ca0c2', 'true', 'multivalued');
INSERT INTO keycloak.protocol_mapper_config VALUES ('9c4beea4-9e8e-48a1-8842-99345f3ca0c2', 'foo', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('9c4beea4-9e8e-48a1-8842-99345f3ca0c2', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('9c4beea4-9e8e-48a1-8842-99345f3ca0c2', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('9c4beea4-9e8e-48a1-8842-99345f3ca0c2', 'groups', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('9c4beea4-9e8e-48a1-8842-99345f3ca0c2', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('628d5988-9461-4cb4-a16d-30f116e58d4c', 'false', 'single');
INSERT INTO keycloak.protocol_mapper_config VALUES ('628d5988-9461-4cb4-a16d-30f116e58d4c', 'Basic', 'attribute.nameformat');
INSERT INTO keycloak.protocol_mapper_config VALUES ('628d5988-9461-4cb4-a16d-30f116e58d4c', 'Role', 'attribute.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('ace4e693-1183-4c96-9aea-41ca084b4bbf', 'foo', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('ace4e693-1183-4c96-9aea-41ca084b4bbf', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('ace4e693-1183-4c96-9aea-41ca084b4bbf', 'realm_access.roles', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('ace4e693-1183-4c96-9aea-41ca084b4bbf', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('ace4e693-1183-4c96-9aea-41ca084b4bbf', 'true', 'multivalued');
INSERT INTO keycloak.protocol_mapper_config VALUES ('ae7c93eb-ae11-4b4d-b052-e04b2fc2a9bd', 'foo', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('ae7c93eb-ae11-4b4d-b052-e04b2fc2a9bd', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('ae7c93eb-ae11-4b4d-b052-e04b2fc2a9bd', 'resource_access.${client_id}.roles', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('ae7c93eb-ae11-4b4d-b052-e04b2fc2a9bd', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('ae7c93eb-ae11-4b4d-b052-e04b2fc2a9bd', 'true', 'multivalued');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d2b100d8-cfd5-4485-a1b6-dd6c9277fa62', 'formatted', 'user.attribute.formatted');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d2b100d8-cfd5-4485-a1b6-dd6c9277fa62', 'country', 'user.attribute.country');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d2b100d8-cfd5-4485-a1b6-dd6c9277fa62', 'postal_code', 'user.attribute.postal_code');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d2b100d8-cfd5-4485-a1b6-dd6c9277fa62', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d2b100d8-cfd5-4485-a1b6-dd6c9277fa62', 'street', 'user.attribute.street');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d2b100d8-cfd5-4485-a1b6-dd6c9277fa62', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d2b100d8-cfd5-4485-a1b6-dd6c9277fa62', 'region', 'user.attribute.region');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d2b100d8-cfd5-4485-a1b6-dd6c9277fa62', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d2b100d8-cfd5-4485-a1b6-dd6c9277fa62', 'locality', 'user.attribute.locality');
INSERT INTO keycloak.protocol_mapper_config VALUES ('bd5c32a6-5fca-4f65-a214-916d38aeee13', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('bd5c32a6-5fca-4f65-a214-916d38aeee13', 'emailVerified', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('bd5c32a6-5fca-4f65-a214-916d38aeee13', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('bd5c32a6-5fca-4f65-a214-916d38aeee13', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('bd5c32a6-5fca-4f65-a214-916d38aeee13', 'email_verified', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('bd5c32a6-5fca-4f65-a214-916d38aeee13', 'boolean', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('dc868b98-c04d-442d-8526-6092c2decf46', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('dc868b98-c04d-442d-8526-6092c2decf46', 'email', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('dc868b98-c04d-442d-8526-6092c2decf46', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('dc868b98-c04d-442d-8526-6092c2decf46', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('dc868b98-c04d-442d-8526-6092c2decf46', 'email', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('dc868b98-c04d-442d-8526-6092c2decf46', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('27ad127b-e9e0-4cca-ae70-1889095e68b8', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('27ad127b-e9e0-4cca-ae70-1889095e68b8', 'username', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('27ad127b-e9e0-4cca-ae70-1889095e68b8', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('27ad127b-e9e0-4cca-ae70-1889095e68b8', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('27ad127b-e9e0-4cca-ae70-1889095e68b8', 'upn', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('27ad127b-e9e0-4cca-ae70-1889095e68b8', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('3ede00f8-d88c-4d51-a7bd-fc8266196d86', 'true', 'multivalued');
INSERT INTO keycloak.protocol_mapper_config VALUES ('3ede00f8-d88c-4d51-a7bd-fc8266196d86', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('3ede00f8-d88c-4d51-a7bd-fc8266196d86', 'foo', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('3ede00f8-d88c-4d51-a7bd-fc8266196d86', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('3ede00f8-d88c-4d51-a7bd-fc8266196d86', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('3ede00f8-d88c-4d51-a7bd-fc8266196d86', 'groups', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('3ede00f8-d88c-4d51-a7bd-fc8266196d86', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('43fc25a2-4e2d-4269-b6b2-4e4587be6e1f', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('43fc25a2-4e2d-4269-b6b2-4e4587be6e1f', 'picture', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('43fc25a2-4e2d-4269-b6b2-4e4587be6e1f', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('43fc25a2-4e2d-4269-b6b2-4e4587be6e1f', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('43fc25a2-4e2d-4269-b6b2-4e4587be6e1f', 'picture', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('43fc25a2-4e2d-4269-b6b2-4e4587be6e1f', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('54fe2e8c-ae54-40c0-a58a-65c9c14f953d', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('54fe2e8c-ae54-40c0-a58a-65c9c14f953d', 'birthdate', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('54fe2e8c-ae54-40c0-a58a-65c9c14f953d', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('54fe2e8c-ae54-40c0-a58a-65c9c14f953d', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('54fe2e8c-ae54-40c0-a58a-65c9c14f953d', 'birthdate', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('54fe2e8c-ae54-40c0-a58a-65c9c14f953d', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('82005164-d7d3-40e5-98df-9aa79bf956cf', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('82005164-d7d3-40e5-98df-9aa79bf956cf', 'updatedAt', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('82005164-d7d3-40e5-98df-9aa79bf956cf', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('82005164-d7d3-40e5-98df-9aa79bf956cf', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('82005164-d7d3-40e5-98df-9aa79bf956cf', 'updated_at', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('82005164-d7d3-40e5-98df-9aa79bf956cf', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('afec02bd-18dc-40ca-9f44-ac75796ca396', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('afec02bd-18dc-40ca-9f44-ac75796ca396', 'nickname', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('afec02bd-18dc-40ca-9f44-ac75796ca396', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('afec02bd-18dc-40ca-9f44-ac75796ca396', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('afec02bd-18dc-40ca-9f44-ac75796ca396', 'nickname', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('afec02bd-18dc-40ca-9f44-ac75796ca396', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('bde6d19d-9c17-4e67-9880-453a8f32fb2f', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('bde6d19d-9c17-4e67-9880-453a8f32fb2f', 'zoneinfo', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('bde6d19d-9c17-4e67-9880-453a8f32fb2f', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('bde6d19d-9c17-4e67-9880-453a8f32fb2f', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('bde6d19d-9c17-4e67-9880-453a8f32fb2f', 'zoneinfo', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('bde6d19d-9c17-4e67-9880-453a8f32fb2f', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('bf451083-910a-4e3e-b86c-69c8af9de75c', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('bf451083-910a-4e3e-b86c-69c8af9de75c', 'firstName', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('bf451083-910a-4e3e-b86c-69c8af9de75c', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('bf451083-910a-4e3e-b86c-69c8af9de75c', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('bf451083-910a-4e3e-b86c-69c8af9de75c', 'given_name', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('bf451083-910a-4e3e-b86c-69c8af9de75c', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('cd405c84-96b5-4a5f-ba4c-d842bd6b3347', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('cd405c84-96b5-4a5f-ba4c-d842bd6b3347', 'website', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('cd405c84-96b5-4a5f-ba4c-d842bd6b3347', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('cd405c84-96b5-4a5f-ba4c-d842bd6b3347', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('cd405c84-96b5-4a5f-ba4c-d842bd6b3347', 'website', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('cd405c84-96b5-4a5f-ba4c-d842bd6b3347', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d372c450-4ef9-4359-894c-feb03f732747', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d372c450-4ef9-4359-894c-feb03f732747', 'profile', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d372c450-4ef9-4359-894c-feb03f732747', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d372c450-4ef9-4359-894c-feb03f732747', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d372c450-4ef9-4359-894c-feb03f732747', 'profile', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d372c450-4ef9-4359-894c-feb03f732747', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e1dd8224-e8a1-4006-82fe-3096fe8926c5', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e1dd8224-e8a1-4006-82fe-3096fe8926c5', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e1dd8224-e8a1-4006-82fe-3096fe8926c5', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e2bcdee5-07b1-494b-ba98-64d110d3862f', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e2bcdee5-07b1-494b-ba98-64d110d3862f', 'gender', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e2bcdee5-07b1-494b-ba98-64d110d3862f', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e2bcdee5-07b1-494b-ba98-64d110d3862f', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e2bcdee5-07b1-494b-ba98-64d110d3862f', 'gender', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e2bcdee5-07b1-494b-ba98-64d110d3862f', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e3d3222b-0a96-4452-89b9-e73addb85a9e', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e3d3222b-0a96-4452-89b9-e73addb85a9e', 'locale', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e3d3222b-0a96-4452-89b9-e73addb85a9e', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e3d3222b-0a96-4452-89b9-e73addb85a9e', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e3d3222b-0a96-4452-89b9-e73addb85a9e', 'locale', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e3d3222b-0a96-4452-89b9-e73addb85a9e', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('fbc68b60-fa5f-40b2-b2bb-e600699f3904', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('fbc68b60-fa5f-40b2-b2bb-e600699f3904', 'lastName', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('fbc68b60-fa5f-40b2-b2bb-e600699f3904', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('fbc68b60-fa5f-40b2-b2bb-e600699f3904', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('fbc68b60-fa5f-40b2-b2bb-e600699f3904', 'family_name', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('fbc68b60-fa5f-40b2-b2bb-e600699f3904', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('fe2f8219-6357-4ac4-b46c-83dc91cffe7d', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('fe2f8219-6357-4ac4-b46c-83dc91cffe7d', 'middleName', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('fe2f8219-6357-4ac4-b46c-83dc91cffe7d', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('fe2f8219-6357-4ac4-b46c-83dc91cffe7d', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('fe2f8219-6357-4ac4-b46c-83dc91cffe7d', 'middle_name', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('fe2f8219-6357-4ac4-b46c-83dc91cffe7d', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('fff32738-9b5c-47c8-b379-ee5dc9815d13', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('fff32738-9b5c-47c8-b379-ee5dc9815d13', 'username', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('fff32738-9b5c-47c8-b379-ee5dc9815d13', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('fff32738-9b5c-47c8-b379-ee5dc9815d13', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('fff32738-9b5c-47c8-b379-ee5dc9815d13', 'preferred_username', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('fff32738-9b5c-47c8-b379-ee5dc9815d13', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('533d4496-8888-4275-8afa-8d048b7ff283', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('533d4496-8888-4275-8afa-8d048b7ff283', 'phoneNumber', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('533d4496-8888-4275-8afa-8d048b7ff283', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('533d4496-8888-4275-8afa-8d048b7ff283', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('533d4496-8888-4275-8afa-8d048b7ff283', 'phone_number', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('533d4496-8888-4275-8afa-8d048b7ff283', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d00a2308-a8d8-4d72-aa1b-ef2653198a9a', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d00a2308-a8d8-4d72-aa1b-ef2653198a9a', 'phoneNumberVerified', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d00a2308-a8d8-4d72-aa1b-ef2653198a9a', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d00a2308-a8d8-4d72-aa1b-ef2653198a9a', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d00a2308-a8d8-4d72-aa1b-ef2653198a9a', 'phone_number_verified', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d00a2308-a8d8-4d72-aa1b-ef2653198a9a', 'boolean', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('795f38ba-3268-4e2f-a956-ca2ad1a0d3be', 'clientAddress', 'user.session.note');
INSERT INTO keycloak.protocol_mapper_config VALUES ('795f38ba-3268-4e2f-a956-ca2ad1a0d3be', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('795f38ba-3268-4e2f-a956-ca2ad1a0d3be', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('795f38ba-3268-4e2f-a956-ca2ad1a0d3be', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('795f38ba-3268-4e2f-a956-ca2ad1a0d3be', 'clientAddress', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('795f38ba-3268-4e2f-a956-ca2ad1a0d3be', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('cadcd86f-31bb-4bfe-9f09-b155027a8319', 'clientHost', 'user.session.note');
INSERT INTO keycloak.protocol_mapper_config VALUES ('cadcd86f-31bb-4bfe-9f09-b155027a8319', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('cadcd86f-31bb-4bfe-9f09-b155027a8319', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('cadcd86f-31bb-4bfe-9f09-b155027a8319', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('cadcd86f-31bb-4bfe-9f09-b155027a8319', 'clientHost', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('cadcd86f-31bb-4bfe-9f09-b155027a8319', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('f55bba66-f14f-4781-9295-981ccef3023d', 'clientId', 'user.session.note');
INSERT INTO keycloak.protocol_mapper_config VALUES ('f55bba66-f14f-4781-9295-981ccef3023d', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('f55bba66-f14f-4781-9295-981ccef3023d', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('f55bba66-f14f-4781-9295-981ccef3023d', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('f55bba66-f14f-4781-9295-981ccef3023d', 'clientId', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('f55bba66-f14f-4781-9295-981ccef3023d', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('9d14a67a-613b-4f8c-a8c4-1d34b23d595c', 'appcket_api', 'included.client.audience');
INSERT INTO keycloak.protocol_mapper_config VALUES ('9d14a67a-613b-4f8c-a8c4-1d34b23d595c', 'false', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('9d14a67a-613b-4f8c-a8c4-1d34b23d595c', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('9d14a67a-613b-4f8c-a8c4-1d34b23d595c', 'false', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('f600d7c2-c282-46c4-877f-12e54f486cb6', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('f600d7c2-c282-46c4-877f-12e54f486cb6', 'locale', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('f600d7c2-c282-46c4-877f-12e54f486cb6', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('f600d7c2-c282-46c4-877f-12e54f486cb6', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('f600d7c2-c282-46c4-877f-12e54f486cb6', 'locale', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('f600d7c2-c282-46c4-877f-12e54f486cb6', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('487f106e-8394-4353-a39c-64890e759820', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('487f106e-8394-4353-a39c-64890e759820', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('2d2a0c1c-6121-41c8-8c22-1625136dcf74', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('2d2a0c1c-6121-41c8-8c22-1625136dcf74', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('71d52062-7793-47eb-9414-7adba2c51bf4', 'true', 'introspection.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('71d52062-7793-47eb-9414-7adba2c51bf4', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e5f342ac-0e93-49b0-90f0-444a8d66d8d8', 'AUTH_TIME', 'user.session.note');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e5f342ac-0e93-49b0-90f0-444a8d66d8d8', 'true', 'introspection.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e5f342ac-0e93-49b0-90f0-444a8d66d8d8', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e5f342ac-0e93-49b0-90f0-444a8d66d8d8', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e5f342ac-0e93-49b0-90f0-444a8d66d8d8', 'auth_time', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e5f342ac-0e93-49b0-90f0-444a8d66d8d8', 'long', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('396fc5e4-989e-4825-b049-abd01e3e2cfa', 'AUTH_TIME', 'user.session.note');
INSERT INTO keycloak.protocol_mapper_config VALUES ('396fc5e4-989e-4825-b049-abd01e3e2cfa', 'true', 'introspection.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('396fc5e4-989e-4825-b049-abd01e3e2cfa', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('396fc5e4-989e-4825-b049-abd01e3e2cfa', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('396fc5e4-989e-4825-b049-abd01e3e2cfa', 'auth_time', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('396fc5e4-989e-4825-b049-abd01e3e2cfa', 'long', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d6250470-c8b3-4e88-858c-53b911cf2047', 'true', 'introspection.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d6250470-c8b3-4e88-858c-53b911cf2047', 'true', 'access.token.claim');


--
-- TOC entry 4217 (class 0 OID 16650)
-- Dependencies: 264
-- Data for Name: realm; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.realm VALUES ('master', 60, 300, 60, NULL, NULL, NULL, true, false, 0, NULL, 'master', 0, NULL, false, false, false, false, 'EXTERNAL', 1800, 36000, false, false, 'aa546da1-d04d-4783-8c48-085c049d6f90', 1800, false, NULL, false, false, false, false, 0, 1, 30, 6, 'HmacSHA1', 'totp', 'a6de927c-b820-4668-a693-eae52d3d3767', '325a1657-2e72-4b01-91b9-6730e9b4670c', '248672a8-7d9f-49c5-a5fd-c38f07e839aa', '6b86461b-2933-464e-9163-c455a9246c6b', 'd6fa5c47-cdaa-4442-aa68-a8ab1370b953', 2592000, false, 900, true, false, 'f73308e6-119d-4811-98b0-96001c76a237', 0, false, 0, 0, '9644cff1-6824-4dab-9916-dd71201b120b');
INSERT INTO keycloak.realm VALUES ('appcket', 60, 300, 172800, 'keycloak.v2', '', '', true, false, 0, '', 'appcket', 0, NULL, false, false, false, false, 'EXTERNAL', 864000, 864000, false, false, 'dc634090-4b2a-41e1-b8bc-35ea7cfc1102', 1800, false, NULL, false, false, false, false, 0, 1, 30, 6, 'HmacSHA1', 'totp', '7f4f19c4-2902-4a20-a1a2-1d33f3ac4462', '491c5d7e-1f7d-4487-a3f8-a58251755d7f', '4435715e-0f08-4968-8e51-910b9f4d5510', '69cfb673-d269-406b-acf2-b657e1fa75bd', 'ef540b37-c348-4bbc-af48-e33fa3af64b5', 36000, false, 2700, true, false, 'be0a0252-f255-4c8d-b1fc-1b6353480b76', 0, false, 0, 0, '3a3efbeb-83dc-4f82-b78d-f00e954d7d40');


--
-- TOC entry 4218 (class 0 OID 16683)
-- Dependencies: 265
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.realm_attribute VALUES ('_browser_header.contentSecurityPolicyReportOnly', 'master', '');
INSERT INTO keycloak.realm_attribute VALUES ('_browser_header.xContentTypeOptions', 'master', 'nosniff');
INSERT INTO keycloak.realm_attribute VALUES ('_browser_header.xRobotsTag', 'master', 'none');
INSERT INTO keycloak.realm_attribute VALUES ('_browser_header.xFrameOptions', 'master', 'SAMEORIGIN');
INSERT INTO keycloak.realm_attribute VALUES ('_browser_header.contentSecurityPolicy', 'master', 'frame-src ''self''; frame-ancestors ''self''; object-src ''none'';');
INSERT INTO keycloak.realm_attribute VALUES ('_browser_header.xXSSProtection', 'master', '1; mode=block');
INSERT INTO keycloak.realm_attribute VALUES ('_browser_header.strictTransportSecurity', 'master', 'max-age=31536000; includeSubDomains');
INSERT INTO keycloak.realm_attribute VALUES ('bruteForceProtected', 'master', 'false');
INSERT INTO keycloak.realm_attribute VALUES ('permanentLockout', 'master', 'false');
INSERT INTO keycloak.realm_attribute VALUES ('maxFailureWaitSeconds', 'master', '900');
INSERT INTO keycloak.realm_attribute VALUES ('minimumQuickLoginWaitSeconds', 'master', '60');
INSERT INTO keycloak.realm_attribute VALUES ('waitIncrementSeconds', 'master', '60');
INSERT INTO keycloak.realm_attribute VALUES ('quickLoginCheckMilliSeconds', 'master', '1000');
INSERT INTO keycloak.realm_attribute VALUES ('maxDeltaTimeSeconds', 'master', '43200');
INSERT INTO keycloak.realm_attribute VALUES ('failureFactor', 'master', '30');
INSERT INTO keycloak.realm_attribute VALUES ('displayName', 'master', 'Keycloak');
INSERT INTO keycloak.realm_attribute VALUES ('displayNameHtml', 'master', '<div class="kc-logo-text"><span>Keycloak</span></div>');
INSERT INTO keycloak.realm_attribute VALUES ('defaultSignatureAlgorithm', 'master', 'RS256');
INSERT INTO keycloak.realm_attribute VALUES ('offlineSessionMaxLifespanEnabled', 'master', 'false');
INSERT INTO keycloak.realm_attribute VALUES ('offlineSessionMaxLifespan', 'master', '5184000');
INSERT INTO keycloak.realm_attribute VALUES ('clientSessionIdleTimeout', 'appcket', '0');
INSERT INTO keycloak.realm_attribute VALUES ('clientSessionMaxLifespan', 'appcket', '0');
INSERT INTO keycloak.realm_attribute VALUES ('clientOfflineSessionIdleTimeout', 'appcket', '0');
INSERT INTO keycloak.realm_attribute VALUES ('clientOfflineSessionMaxLifespan', 'appcket', '0');
INSERT INTO keycloak.realm_attribute VALUES ('oauth2DeviceCodeLifespan', 'appcket', '600');
INSERT INTO keycloak.realm_attribute VALUES ('oauth2DevicePollingInterval', 'appcket', '5');
INSERT INTO keycloak.realm_attribute VALUES ('cibaBackchannelTokenDeliveryMode', 'appcket', 'poll');
INSERT INTO keycloak.realm_attribute VALUES ('cibaExpiresIn', 'appcket', '120');
INSERT INTO keycloak.realm_attribute VALUES ('cibaInterval', 'appcket', '5');
INSERT INTO keycloak.realm_attribute VALUES ('cibaAuthRequestedUserHint', 'appcket', 'login_hint');
INSERT INTO keycloak.realm_attribute VALUES ('parRequestUriLifespan', 'appcket', '60');
INSERT INTO keycloak.realm_attribute VALUES ('actionTokenGeneratedByUserLifespan-verify-email', 'appcket', '');
INSERT INTO keycloak.realm_attribute VALUES ('actionTokenGeneratedByUserLifespan-idp-verify-account-via-email', 'appcket', '');
INSERT INTO keycloak.realm_attribute VALUES ('actionTokenGeneratedByUserLifespan-reset-credentials', 'appcket', '');
INSERT INTO keycloak.realm_attribute VALUES ('actionTokenGeneratedByUserLifespan-execute-actions', 'appcket', '');
INSERT INTO keycloak.realm_attribute VALUES ('bruteForceProtected', 'appcket', 'false');
INSERT INTO keycloak.realm_attribute VALUES ('permanentLockout', 'appcket', 'false');
INSERT INTO keycloak.realm_attribute VALUES ('maxFailureWaitSeconds', 'appcket', '900');
INSERT INTO keycloak.realm_attribute VALUES ('minimumQuickLoginWaitSeconds', 'appcket', '60');
INSERT INTO keycloak.realm_attribute VALUES ('waitIncrementSeconds', 'appcket', '60');
INSERT INTO keycloak.realm_attribute VALUES ('quickLoginCheckMilliSeconds', 'appcket', '1000');
INSERT INTO keycloak.realm_attribute VALUES ('maxDeltaTimeSeconds', 'appcket', '43200');
INSERT INTO keycloak.realm_attribute VALUES ('failureFactor', 'appcket', '30');
INSERT INTO keycloak.realm_attribute VALUES ('actionTokenGeneratedByAdminLifespan', 'appcket', '43200');
INSERT INTO keycloak.realm_attribute VALUES ('actionTokenGeneratedByUserLifespan', 'appcket', '300');
INSERT INTO keycloak.realm_attribute VALUES ('defaultSignatureAlgorithm', 'appcket', 'RS256');
INSERT INTO keycloak.realm_attribute VALUES ('offlineSessionMaxLifespanEnabled', 'appcket', 'false');
INSERT INTO keycloak.realm_attribute VALUES ('offlineSessionMaxLifespan', 'appcket', '5184000');
INSERT INTO keycloak.realm_attribute VALUES ('webAuthnPolicyRpEntityName', 'appcket', 'keycloak');
INSERT INTO keycloak.realm_attribute VALUES ('webAuthnPolicySignatureAlgorithms', 'appcket', 'ES256');
INSERT INTO keycloak.realm_attribute VALUES ('webAuthnPolicyRpId', 'appcket', '');
INSERT INTO keycloak.realm_attribute VALUES ('webAuthnPolicyAttestationConveyancePreference', 'appcket', 'not specified');
INSERT INTO keycloak.realm_attribute VALUES ('webAuthnPolicyAuthenticatorAttachment', 'appcket', 'not specified');
INSERT INTO keycloak.realm_attribute VALUES ('webAuthnPolicyRequireResidentKey', 'appcket', 'not specified');
INSERT INTO keycloak.realm_attribute VALUES ('webAuthnPolicyUserVerificationRequirement', 'appcket', 'not specified');
INSERT INTO keycloak.realm_attribute VALUES ('webAuthnPolicyCreateTimeout', 'appcket', '0');
INSERT INTO keycloak.realm_attribute VALUES ('webAuthnPolicyAvoidSameAuthenticatorRegister', 'appcket', 'false');
INSERT INTO keycloak.realm_attribute VALUES ('webAuthnPolicyRpEntityNamePasswordless', 'appcket', 'keycloak');
INSERT INTO keycloak.realm_attribute VALUES ('webAuthnPolicySignatureAlgorithmsPasswordless', 'appcket', 'ES256');
INSERT INTO keycloak.realm_attribute VALUES ('webAuthnPolicyRpIdPasswordless', 'appcket', '');
INSERT INTO keycloak.realm_attribute VALUES ('webAuthnPolicyAttestationConveyancePreferencePasswordless', 'appcket', 'not specified');
INSERT INTO keycloak.realm_attribute VALUES ('webAuthnPolicyAuthenticatorAttachmentPasswordless', 'appcket', 'not specified');
INSERT INTO keycloak.realm_attribute VALUES ('webAuthnPolicyRequireResidentKeyPasswordless', 'appcket', 'not specified');
INSERT INTO keycloak.realm_attribute VALUES ('webAuthnPolicyUserVerificationRequirementPasswordless', 'appcket', 'not specified');
INSERT INTO keycloak.realm_attribute VALUES ('webAuthnPolicyCreateTimeoutPasswordless', 'appcket', '0');
INSERT INTO keycloak.realm_attribute VALUES ('webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless', 'appcket', 'false');
INSERT INTO keycloak.realm_attribute VALUES ('client-policies.profiles', 'appcket', '{"profiles":[]}');
INSERT INTO keycloak.realm_attribute VALUES ('client-policies.policies', 'appcket', '{"policies":[]}');
INSERT INTO keycloak.realm_attribute VALUES ('_browser_header.contentSecurityPolicyReportOnly', 'appcket', '');
INSERT INTO keycloak.realm_attribute VALUES ('_browser_header.xContentTypeOptions', 'appcket', 'nosniff');
INSERT INTO keycloak.realm_attribute VALUES ('_browser_header.xRobotsTag', 'appcket', 'none');
INSERT INTO keycloak.realm_attribute VALUES ('_browser_header.xFrameOptions', 'appcket', 'ALLOW-FROM https://accounts.appcket.localhost https://accounts.appcket.com');
INSERT INTO keycloak.realm_attribute VALUES ('_browser_header.contentSecurityPolicy', 'appcket', 'frame-src https://accounts.appcket.localhost https://accounts.appcket.com');
INSERT INTO keycloak.realm_attribute VALUES ('_browser_header.xXSSProtection', 'appcket', '1; mode=block');
INSERT INTO keycloak.realm_attribute VALUES ('_browser_header.strictTransportSecurity', 'appcket', 'max-age=31536000; includeSubDomains');
INSERT INTO keycloak.realm_attribute VALUES ('firstBrokerLoginFlowId', 'master', 'e2034074-1b98-46ad-8d9f-5a96b770b7db');
INSERT INTO keycloak.realm_attribute VALUES ('firstBrokerLoginFlowId', 'appcket', '75e40d46-468a-4b78-9a55-c0aa4ba5041d');


--
-- TOC entry 4219 (class 0 OID 16688)
-- Dependencies: 266
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4220 (class 0 OID 16691)
-- Dependencies: 267
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4221 (class 0 OID 16694)
-- Dependencies: 268
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.realm_events_listeners VALUES ('master', 'jboss-logging');
INSERT INTO keycloak.realm_events_listeners VALUES ('appcket', 'jboss-logging');


--
-- TOC entry 4222 (class 0 OID 16697)
-- Dependencies: 269
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4223 (class 0 OID 16702)
-- Dependencies: 270
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.realm_required_credential VALUES ('password', 'password', true, true, 'master');
INSERT INTO keycloak.realm_required_credential VALUES ('password', 'password', true, true, 'appcket');


--
-- TOC entry 4224 (class 0 OID 16709)
-- Dependencies: 271
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4225 (class 0 OID 16714)
-- Dependencies: 272
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4226 (class 0 OID 16717)
-- Dependencies: 273
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.redirect_uris VALUES ('605fa94d-21d1-4569-8fa7-6bbb229b19f0', '/realms/master/account/*');
INSERT INTO keycloak.redirect_uris VALUES ('235e5d2b-515a-422c-b23c-6d9c3abddfa5', '/realms/master/account/*');
INSERT INTO keycloak.redirect_uris VALUES ('01818753-ed45-4903-93e9-8ebffc711cd8', '/admin/master/console/*');
INSERT INTO keycloak.redirect_uris VALUES ('e801cbf0-541f-4466-80e1-fcce640df2a8', '/realms/appcket/account/*');
INSERT INTO keycloak.redirect_uris VALUES ('26f802c3-b7af-4e78-b785-40493ae2483a', '/realms/appcket/account/*');
INSERT INTO keycloak.redirect_uris VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'https://app.appcket.localhost/*');
INSERT INTO keycloak.redirect_uris VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'https://appcket.localhost');
INSERT INTO keycloak.redirect_uris VALUES ('4dd4c360-d5b9-4730-8091-78b394cea334', '/admin/appcket/console/*');
INSERT INTO keycloak.redirect_uris VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'https://api.appcket.localhost/*');
INSERT INTO keycloak.redirect_uris VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'http://api.appcket.localhost/*');


--
-- TOC entry 4227 (class 0 OID 16720)
-- Dependencies: 274
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4228 (class 0 OID 16725)
-- Dependencies: 275
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.required_action_provider VALUES ('15a5bded-aa8d-4b1b-ae5d-5758e6f63389', 'VERIFY_EMAIL', 'Verify Email', 'master', true, false, 'VERIFY_EMAIL', 50);
INSERT INTO keycloak.required_action_provider VALUES ('0685329b-f0b4-4db1-b813-60af4ff048dc', 'UPDATE_PROFILE', 'Update Profile', 'master', true, false, 'UPDATE_PROFILE', 40);
INSERT INTO keycloak.required_action_provider VALUES ('d778df80-8ea9-4792-ba82-520ad463d30b', 'CONFIGURE_TOTP', 'Configure OTP', 'master', true, false, 'CONFIGURE_TOTP', 10);
INSERT INTO keycloak.required_action_provider VALUES ('97b57f2a-b111-448e-962d-10f3cc2b4d67', 'UPDATE_PASSWORD', 'Update Password', 'master', true, false, 'UPDATE_PASSWORD', 30);
INSERT INTO keycloak.required_action_provider VALUES ('ace5f343-d64e-4fa1-a5b7-3e308b340d9c', 'update_user_locale', 'Update User Locale', 'master', true, false, 'update_user_locale', 1000);
INSERT INTO keycloak.required_action_provider VALUES ('239456db-eb66-4501-b50c-1cde8d76ee4e', 'delete_account', 'Delete Account', 'master', false, false, 'delete_account', 60);
INSERT INTO keycloak.required_action_provider VALUES ('af70275b-e78c-4538-bf2c-a70c86688e1e', 'CONFIGURE_TOTP', 'Configure OTP', 'appcket', true, false, 'CONFIGURE_TOTP', 10);
INSERT INTO keycloak.required_action_provider VALUES ('605e330d-b7be-4548-9188-451a5a087a1d', 'UPDATE_PASSWORD', 'Update Password', 'appcket', true, false, 'UPDATE_PASSWORD', 30);
INSERT INTO keycloak.required_action_provider VALUES ('711766b9-3b43-4cd5-8c79-298631352be6', 'UPDATE_PROFILE', 'Update Profile', 'appcket', true, false, 'UPDATE_PROFILE', 40);
INSERT INTO keycloak.required_action_provider VALUES ('9113ff8f-2f3e-4725-aec9-cbd4d3af87a1', 'VERIFY_EMAIL', 'Verify Email', 'appcket', true, false, 'VERIFY_EMAIL', 50);
INSERT INTO keycloak.required_action_provider VALUES ('d8d1bd42-8696-4891-8cff-290f2b819df9', 'delete_account', 'Delete Account', 'appcket', false, false, 'delete_account', 60);
INSERT INTO keycloak.required_action_provider VALUES ('fa887271-4679-447c-9d99-b7bab0ea095b', 'update_user_locale', 'Update User Locale', 'appcket', true, false, 'update_user_locale', 1000);
INSERT INTO keycloak.required_action_provider VALUES ('65fc6f36-4953-4997-9288-4d4d60f1017e', 'TERMS_AND_CONDITIONS', 'Terms and Conditions', 'master', false, false, 'TERMS_AND_CONDITIONS', 20);
INSERT INTO keycloak.required_action_provider VALUES ('74178507-d533-4b25-93f1-1f65de098394', 'TERMS_AND_CONDITIONS', 'Terms and Conditions', 'appcket', false, false, 'TERMS_AND_CONDITIONS', 20);
INSERT INTO keycloak.required_action_provider VALUES ('32e4e87f-d210-4be2-b0fc-ee9faaf44aef', 'delete_credential', 'Delete Credential', 'master', true, false, 'delete_credential', 100);
INSERT INTO keycloak.required_action_provider VALUES ('b39646c6-85ee-49f3-abf3-6c626fd9736b', 'delete_credential', 'Delete Credential', 'appcket', true, false, 'delete_credential', 100);


--
-- TOC entry 4229 (class 0 OID 16732)
-- Dependencies: 276
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4230 (class 0 OID 16738)
-- Dependencies: 277
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.resource_policy VALUES ('d5e429e0-d6c9-40c5-95b4-b56d1ec01cd6', '6338e03e-6909-496e-b52c-1cc62eb5eba6');
INSERT INTO keycloak.resource_policy VALUES ('d5e429e0-d6c9-40c5-95b4-b56d1ec01cd6', '42c43075-9052-4129-bebc-691c56a66dfd');
INSERT INTO keycloak.resource_policy VALUES ('d5e429e0-d6c9-40c5-95b4-b56d1ec01cd6', 'f7b5232d-91c5-4444-b8ca-165d17552a5d');
INSERT INTO keycloak.resource_policy VALUES ('d5e429e0-d6c9-40c5-95b4-b56d1ec01cd6', 'b6033d87-3b1b-4002-8f97-255956c2b506');
INSERT INTO keycloak.resource_policy VALUES ('d2dbc0cc-0a77-4194-b291-4199b719bb3f', '2d99ec81-c6a8-4949-b129-0bc425126832');
INSERT INTO keycloak.resource_policy VALUES ('d2dbc0cc-0a77-4194-b291-4199b719bb3f', '48345f52-292b-474c-acd3-1cc56513aa4f');
INSERT INTO keycloak.resource_policy VALUES ('d2dbc0cc-0a77-4194-b291-4199b719bb3f', '73c7d9cb-5b6a-4a57-a7e1-5e81ec3aa8c2');
INSERT INTO keycloak.resource_policy VALUES ('31e55791-13e5-4d30-a7d8-35864230ab8c', 'beb7d05d-19f7-4690-86e9-13dd49936d71');
INSERT INTO keycloak.resource_policy VALUES ('31e55791-13e5-4d30-a7d8-35864230ab8c', 'f93476a3-2536-4e2c-bcad-212d0859fbe1');
INSERT INTO keycloak.resource_policy VALUES ('31e55791-13e5-4d30-a7d8-35864230ab8c', 'a03337fa-5ad4-42e1-8beb-52afcac74329');
INSERT INTO keycloak.resource_policy VALUES ('31e55791-13e5-4d30-a7d8-35864230ab8c', 'ab1f242c-d8bf-4860-a2b1-4702f367bbd5');
INSERT INTO keycloak.resource_policy VALUES ('c2b44cad-bf85-486a-b96e-45f849b7ae24', '68061593-00a9-46ae-b3a5-b21333100a20');
INSERT INTO keycloak.resource_policy VALUES ('d2dbc0cc-0a77-4194-b291-4199b719bb3f', '7db68186-ebbb-40a8-8dd7-147deddae4ce');
INSERT INTO keycloak.resource_policy VALUES ('c2b44cad-bf85-486a-b96e-45f849b7ae24', '69a3bcf1-89b4-4602-bc26-9d34eb5d9c55');
INSERT INTO keycloak.resource_policy VALUES ('c2b44cad-bf85-486a-b96e-45f849b7ae24', 'df6b4650-ee44-4f35-b5fe-1891afe29334');
INSERT INTO keycloak.resource_policy VALUES ('c2b44cad-bf85-486a-b96e-45f849b7ae24', 'dbc609b4-6662-4067-b552-7ff079e1d7ed');
INSERT INTO keycloak.resource_policy VALUES ('31e55791-13e5-4d30-a7d8-35864230ab8c', 'b1800646-850a-464a-95d9-1102358f3765');
INSERT INTO keycloak.resource_policy VALUES ('c2b44cad-bf85-486a-b96e-45f849b7ae24', '6cdadd37-e036-47ea-8eca-bd1a1ace3f35');
INSERT INTO keycloak.resource_policy VALUES ('d5e429e0-d6c9-40c5-95b4-b56d1ec01cd6', 'ab198044-b3fd-4bf3-b4a1-594d06bfa10e');
INSERT INTO keycloak.resource_policy VALUES ('d2dbc0cc-0a77-4194-b291-4199b719bb3f', '57b884b6-b5b0-4447-95da-94c234fd3892');


--
-- TOC entry 4231 (class 0 OID 16741)
-- Dependencies: 278
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.resource_scope VALUES ('31e55791-13e5-4d30-a7d8-35864230ab8c', '7a452b00-fae1-416f-ad9c-f1c622819c3a');
INSERT INTO keycloak.resource_scope VALUES ('31e55791-13e5-4d30-a7d8-35864230ab8c', '347b3c43-989e-4273-9247-89f233557b7c');
INSERT INTO keycloak.resource_scope VALUES ('31e55791-13e5-4d30-a7d8-35864230ab8c', '58c400a6-61f6-47fd-81ad-67e002198882');
INSERT INTO keycloak.resource_scope VALUES ('31e55791-13e5-4d30-a7d8-35864230ab8c', 'cc04a208-f6d1-446e-bea6-5de03622579a');
INSERT INTO keycloak.resource_scope VALUES ('31e55791-13e5-4d30-a7d8-35864230ab8c', 'e01d7b7d-135f-4e75-886a-b0565bdd8220');
INSERT INTO keycloak.resource_scope VALUES ('c2b44cad-bf85-486a-b96e-45f849b7ae24', '4aef873b-3fbb-4ffb-9736-03b1615e172b');
INSERT INTO keycloak.resource_scope VALUES ('c2b44cad-bf85-486a-b96e-45f849b7ae24', 'bd4a6c23-aba5-4b86-b394-690ee1c3ddc1');
INSERT INTO keycloak.resource_scope VALUES ('c2b44cad-bf85-486a-b96e-45f849b7ae24', '328dd4b0-065d-4a9c-86dc-412b567f7331');
INSERT INTO keycloak.resource_scope VALUES ('c2b44cad-bf85-486a-b96e-45f849b7ae24', '7b62a73c-d6cf-4e6c-9b79-fa02e98c4ecd');
INSERT INTO keycloak.resource_scope VALUES ('c2b44cad-bf85-486a-b96e-45f849b7ae24', 'f99cb36b-35c3-4055-9e53-496b8170a47f');
INSERT INTO keycloak.resource_scope VALUES ('d5e429e0-d6c9-40c5-95b4-b56d1ec01cd6', 'fb335bfa-b1e9-4557-8cc4-a113e9a7f929');
INSERT INTO keycloak.resource_scope VALUES ('d5e429e0-d6c9-40c5-95b4-b56d1ec01cd6', '6ba0e730-65b0-4c13-81c1-ccf1576b3926');
INSERT INTO keycloak.resource_scope VALUES ('d5e429e0-d6c9-40c5-95b4-b56d1ec01cd6', '34d6c370-b0af-41e9-a129-3fd5fc4622f6');
INSERT INTO keycloak.resource_scope VALUES ('d5e429e0-d6c9-40c5-95b4-b56d1ec01cd6', 'cfc355ca-0083-4237-b2a5-b8bba690e9f2');
INSERT INTO keycloak.resource_scope VALUES ('d5e429e0-d6c9-40c5-95b4-b56d1ec01cd6', '93401ef1-ba4c-4320-822b-fac7cb06e179');
INSERT INTO keycloak.resource_scope VALUES ('d2dbc0cc-0a77-4194-b291-4199b719bb3f', '0cad1c5f-c4ca-4bb1-955f-532f0d1e1862');
INSERT INTO keycloak.resource_scope VALUES ('d2dbc0cc-0a77-4194-b291-4199b719bb3f', '2de7d2b4-f1a9-41d9-a34a-07b2f2f35f66');
INSERT INTO keycloak.resource_scope VALUES ('d2dbc0cc-0a77-4194-b291-4199b719bb3f', 'cb74d4a6-b1c6-4643-b97c-25e1a2ada279');
INSERT INTO keycloak.resource_scope VALUES ('d2dbc0cc-0a77-4194-b291-4199b719bb3f', 'e28c708d-3237-486e-a2ac-f716b1b2727f');
INSERT INTO keycloak.resource_scope VALUES ('d2dbc0cc-0a77-4194-b291-4199b719bb3f', 'd00976cc-8876-4c38-a585-5d14671c7db3');


--
-- TOC entry 4232 (class 0 OID 16744)
-- Dependencies: 279
-- Data for Name: resource_server; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.resource_server VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', true, 0, 1);


--
-- TOC entry 4233 (class 0 OID 16749)
-- Dependencies: 280
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4234 (class 0 OID 16754)
-- Dependencies: 281
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.resource_server_policy VALUES ('bfaf527b-4238-46d7-aa48-1d605b7c390f', 'Default Policy', 'A policy that grants access only for users within this realm', 'js', 0, 0, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('f54d2838-ff5a-4259-8560-c50f042375ab', 'Captain Policy', 'Captain role-based policy', 'role', 1, 0, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7', 'Manager Policy', 'Manager role-based policy', 'role', 1, 0, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('53667455-8734-49e0-9e11-db6aacce6cbf', 'Teammate Policy', 'Teammate role-based policy', 'role', 1, 0, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('56cc0301-6b50-4bb1-b870-514669458695', 'Spectator Policy', 'Spectator role-based policy', 'role', 1, 0, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('b498b31a-81fa-4a32-b625-71ca3e577dcb', 'Default Permission', 'A permission that applies to the default resource type', 'resource', 1, 0, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('6338e03e-6909-496e-b52c-1cc62eb5eba6', 'Create Task Permission', NULL, 'scope', 0, 0, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('42c43075-9052-4129-bebc-691c56a66dfd', 'Read Task Permission', NULL, 'scope', 0, 0, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('f7b5232d-91c5-4444-b8ca-165d17552a5d', 'Update Task Permission', NULL, 'scope', 0, 0, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('b6033d87-3b1b-4002-8f97-255956c2b506', 'Delete Task Permission', NULL, 'scope', 0, 0, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('2d99ec81-c6a8-4949-b129-0bc425126832', 'Delete Team Permission', NULL, 'scope', 0, 0, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('48345f52-292b-474c-acd3-1cc56513aa4f', 'Read Team Permission', NULL, 'scope', 0, 0, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('73c7d9cb-5b6a-4a57-a7e1-5e81ec3aa8c2', 'Update Team Permission', NULL, 'scope', 0, 0, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('beb7d05d-19f7-4690-86e9-13dd49936d71', 'Create Organization Permission', NULL, 'scope', 0, 0, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('f93476a3-2536-4e2c-bcad-212d0859fbe1', 'Delete Organization Permission', NULL, 'scope', 0, 0, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('a03337fa-5ad4-42e1-8beb-52afcac74329', 'Read Organization Permission', NULL, 'scope', 0, 0, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('ab1f242c-d8bf-4860-a2b1-4702f367bbd5', 'Update Organization Permission', NULL, 'scope', 0, 0, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('68061593-00a9-46ae-b3a5-b21333100a20', 'Create Project Permission', NULL, 'scope', 0, 0, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('7db68186-ebbb-40a8-8dd7-147deddae4ce', 'Create Team Permission', NULL, 'scope', 0, 0, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('69a3bcf1-89b4-4602-bc26-9d34eb5d9c55', 'Read Project Permission', NULL, 'scope', 0, 0, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('df6b4650-ee44-4f35-b5fe-1891afe29334', 'Update Project Permission', NULL, 'scope', 0, 0, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('dbc609b4-6662-4067-b552-7ff079e1d7ed', 'Delete Project Permission', NULL, 'scope', 0, 0, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('b1800646-850a-464a-95d9-1102358f3765', 'Read Organization History Permission', '', 'scope', 0, 0, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('6cdadd37-e036-47ea-8eca-bd1a1ace3f35', 'Read Project History Permission', '', 'scope', 0, 0, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('ab198044-b3fd-4bf3-b4a1-594d06bfa10e', 'Read Task History Permission', '', 'scope', 0, 0, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('57b884b6-b5b0-4447-95da-94c234fd3892', 'Read Team History Permission', '', 'scope', 0, 0, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);


--
-- TOC entry 4235 (class 0 OID 16759)
-- Dependencies: 282
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.resource_server_resource VALUES ('b59ef162-80d4-43af-9758-9fa0a2fc158a', 'Default Resource', 'urn:appcket_api:resources:default', NULL, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', false, NULL);
INSERT INTO keycloak.resource_server_resource VALUES ('31e55791-13e5-4d30-a7d8-35864230ab8c', 'Organization', NULL, '', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', false, 'Organization');
INSERT INTO keycloak.resource_server_resource VALUES ('c2b44cad-bf85-486a-b96e-45f849b7ae24', 'Project', NULL, '', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', false, 'Project');
INSERT INTO keycloak.resource_server_resource VALUES ('d5e429e0-d6c9-40c5-95b4-b56d1ec01cd6', 'Task', NULL, '', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', false, 'Task');
INSERT INTO keycloak.resource_server_resource VALUES ('d2dbc0cc-0a77-4194-b291-4199b719bb3f', 'Team', NULL, '', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', false, 'Team');


--
-- TOC entry 4236 (class 0 OID 16765)
-- Dependencies: 283
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.resource_server_scope VALUES ('7a452b00-fae1-416f-ad9c-f1c622819c3a', 'organization:create', NULL, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_scope VALUES ('fb335bfa-b1e9-4557-8cc4-a113e9a7f929', 'task:create', NULL, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_scope VALUES ('0cad1c5f-c4ca-4bb1-955f-532f0d1e1862', 'team:create', NULL, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_scope VALUES ('347b3c43-989e-4273-9247-89f233557b7c', 'organization:delete', NULL, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_scope VALUES ('6ba0e730-65b0-4c13-81c1-ccf1576b3926', 'task:delete', NULL, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_scope VALUES ('2de7d2b4-f1a9-41d9-a34a-07b2f2f35f66', 'team:delete', NULL, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_scope VALUES ('58c400a6-61f6-47fd-81ad-67e002198882', 'organization:read', NULL, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_scope VALUES ('34d6c370-b0af-41e9-a129-3fd5fc4622f6', 'task:read', NULL, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_scope VALUES ('cb74d4a6-b1c6-4643-b97c-25e1a2ada279', 'team:read', NULL, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_scope VALUES ('cc04a208-f6d1-446e-bea6-5de03622579a', 'organization:update', NULL, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_scope VALUES ('cfc355ca-0083-4237-b2a5-b8bba690e9f2', 'task:update', NULL, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_scope VALUES ('e28c708d-3237-486e-a2ac-f716b1b2727f', 'team:update', NULL, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_scope VALUES ('4aef873b-3fbb-4ffb-9736-03b1615e172b', 'project:create', NULL, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_scope VALUES ('bd4a6c23-aba5-4b86-b394-690ee1c3ddc1', 'project:read', NULL, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_scope VALUES ('328dd4b0-065d-4a9c-86dc-412b567f7331', 'project:update', NULL, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_scope VALUES ('7b62a73c-d6cf-4e6c-9b79-fa02e98c4ecd', 'project:delete', NULL, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_scope VALUES ('e01d7b7d-135f-4e75-886a-b0565bdd8220', 'organization:read:history', '', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_scope VALUES ('f99cb36b-35c3-4055-9e53-496b8170a47f', 'project:read:history', '', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_scope VALUES ('93401ef1-ba4c-4320-822b-fac7cb06e179', 'task:read:history', '', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_scope VALUES ('d00976cc-8876-4c38-a585-5d14671c7db3', 'team:read:history', '', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);


--
-- TOC entry 4237 (class 0 OID 16770)
-- Dependencies: 284
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.resource_uris VALUES ('b59ef162-80d4-43af-9758-9fa0a2fc158a', '/*');


--
-- TOC entry 4256 (class 0 OID 32773)
-- Dependencies: 315
-- Data for Name: revoked_token; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4238 (class 0 OID 16773)
-- Dependencies: 285
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4239 (class 0 OID 16778)
-- Dependencies: 286
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.scope_mapping VALUES ('235e5d2b-515a-422c-b23c-6d9c3abddfa5', '7a145737-e946-4bff-9c5b-d9c974fe64b3');
INSERT INTO keycloak.scope_mapping VALUES ('26f802c3-b7af-4e78-b785-40493ae2483a', '395df0fe-9ce6-4af3-9d3f-a76b64e2c6b1');
INSERT INTO keycloak.scope_mapping VALUES ('235e5d2b-515a-422c-b23c-6d9c3abddfa5', '3acee81b-79f3-4223-befe-0fec94a744cf');
INSERT INTO keycloak.scope_mapping VALUES ('26f802c3-b7af-4e78-b785-40493ae2483a', '385ea9e2-2f95-4649-871b-b7313d4e9904');


--
-- TOC entry 4240 (class 0 OID 16781)
-- Dependencies: 287
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.scope_policy VALUES ('fb335bfa-b1e9-4557-8cc4-a113e9a7f929', '6338e03e-6909-496e-b52c-1cc62eb5eba6');
INSERT INTO keycloak.scope_policy VALUES ('cfc355ca-0083-4237-b2a5-b8bba690e9f2', 'f7b5232d-91c5-4444-b8ca-165d17552a5d');
INSERT INTO keycloak.scope_policy VALUES ('6ba0e730-65b0-4c13-81c1-ccf1576b3926', 'b6033d87-3b1b-4002-8f97-255956c2b506');
INSERT INTO keycloak.scope_policy VALUES ('2de7d2b4-f1a9-41d9-a34a-07b2f2f35f66', '2d99ec81-c6a8-4949-b129-0bc425126832');
INSERT INTO keycloak.scope_policy VALUES ('cb74d4a6-b1c6-4643-b97c-25e1a2ada279', '48345f52-292b-474c-acd3-1cc56513aa4f');
INSERT INTO keycloak.scope_policy VALUES ('e28c708d-3237-486e-a2ac-f716b1b2727f', '73c7d9cb-5b6a-4a57-a7e1-5e81ec3aa8c2');
INSERT INTO keycloak.scope_policy VALUES ('7a452b00-fae1-416f-ad9c-f1c622819c3a', 'beb7d05d-19f7-4690-86e9-13dd49936d71');
INSERT INTO keycloak.scope_policy VALUES ('347b3c43-989e-4273-9247-89f233557b7c', 'f93476a3-2536-4e2c-bcad-212d0859fbe1');
INSERT INTO keycloak.scope_policy VALUES ('58c400a6-61f6-47fd-81ad-67e002198882', 'a03337fa-5ad4-42e1-8beb-52afcac74329');
INSERT INTO keycloak.scope_policy VALUES ('cc04a208-f6d1-446e-bea6-5de03622579a', 'ab1f242c-d8bf-4860-a2b1-4702f367bbd5');
INSERT INTO keycloak.scope_policy VALUES ('4aef873b-3fbb-4ffb-9736-03b1615e172b', '68061593-00a9-46ae-b3a5-b21333100a20');
INSERT INTO keycloak.scope_policy VALUES ('0cad1c5f-c4ca-4bb1-955f-532f0d1e1862', '7db68186-ebbb-40a8-8dd7-147deddae4ce');
INSERT INTO keycloak.scope_policy VALUES ('bd4a6c23-aba5-4b86-b394-690ee1c3ddc1', '69a3bcf1-89b4-4602-bc26-9d34eb5d9c55');
INSERT INTO keycloak.scope_policy VALUES ('328dd4b0-065d-4a9c-86dc-412b567f7331', 'df6b4650-ee44-4f35-b5fe-1891afe29334');
INSERT INTO keycloak.scope_policy VALUES ('7b62a73c-d6cf-4e6c-9b79-fa02e98c4ecd', 'dbc609b4-6662-4067-b552-7ff079e1d7ed');
INSERT INTO keycloak.scope_policy VALUES ('34d6c370-b0af-41e9-a129-3fd5fc4622f6', '42c43075-9052-4129-bebc-691c56a66dfd');
INSERT INTO keycloak.scope_policy VALUES ('e01d7b7d-135f-4e75-886a-b0565bdd8220', 'b1800646-850a-464a-95d9-1102358f3765');
INSERT INTO keycloak.scope_policy VALUES ('f99cb36b-35c3-4055-9e53-496b8170a47f', '6cdadd37-e036-47ea-8eca-bd1a1ace3f35');
INSERT INTO keycloak.scope_policy VALUES ('93401ef1-ba4c-4320-822b-fac7cb06e179', 'ab198044-b3fd-4bf3-b4a1-594d06bfa10e');
INSERT INTO keycloak.scope_policy VALUES ('d00976cc-8876-4c38-a585-5d14671c7db3', '57b884b6-b5b0-4447-95da-94c234fd3892');


--
-- TOC entry 4241 (class 0 OID 16784)
-- Dependencies: 288
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.user_attribute VALUES ('jobTitle', 'CEO, Vandelay Industries', 'c83ccc8c-2c1f-4a7a-9506-eaf235a284e9', '9b5c4ab3-b16e-4ad4-a2b2-cf2d8fc60e30', NULL, NULL, NULL);
INSERT INTO keycloak.user_attribute VALUES ('jobTitle', 'Regional Director, Manufacturing', '7e2e3888-b370-4309-b82c-403b6871a390', 'ba3efcb4-4e67-49f9-8772-44b0f519a403', NULL, NULL, NULL);
INSERT INTO keycloak.user_attribute VALUES ('jobTitle', 'Assistant Vice President', 'de3127bc-dbe6-4775-9334-2f873f413d23', 'ea15cddd-ab22-43a4-8b27-8f17e52cec52', NULL, NULL, NULL);


--
-- TOC entry 4242 (class 0 OID 16790)
-- Dependencies: 289
-- Data for Name: user_consent; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4243 (class 0 OID 16795)
-- Dependencies: 290
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4244 (class 0 OID 16798)
-- Dependencies: 291
-- Data for Name: user_entity; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.user_entity VALUES ('dc59cd47-1a7e-4ca2-96b8-96df2bfe9b12', NULL, '453736a2-7c80-4294-aecc-4cd65b286213', false, true, NULL, NULL, NULL, 'master', 'admin', 1645324291527, NULL, 0);
INSERT INTO keycloak.user_entity VALUES ('6c15646c-89cb-43ad-aa91-cbdc4bdca430', NULL, '06d93551-dbd0-4a1e-9157-32d036d345ed', false, true, NULL, NULL, NULL, 'appcket', 'service-account-appcket_api', 1588298918111, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', 0);
INSERT INTO keycloak.user_entity VALUES ('de3127bc-dbe6-4775-9334-2f873f413d23', 'ryan@appcket.org', 'ryan@appcket.org', true, true, NULL, 'Ryan', NULL, 'appcket', 'ryan', 1645326069390, NULL, 0);
INSERT INTO keycloak.user_entity VALUES ('c83ccc8c-2c1f-4a7a-9506-eaf235a284e9', 'art@vandelay.com', 'art@vandelay.com', true, true, NULL, 'Art', 'Vandelay', 'appcket', 'art', 1645326637710, NULL, 0);
INSERT INTO keycloak.user_entity VALUES ('7e2e3888-b370-4309-b82c-403b6871a390', 'kel@appcket.org', 'kel@appcket.org', true, true, NULL, 'Kel', 'Varnson', 'appcket', 'kel', 1645327142592, NULL, 0);
INSERT INTO keycloak.user_entity VALUES ('83d2fae6-76d9-497c-bbf6-f177785e6195', 'he@appcket.org', 'he@appcket.org', true, true, NULL, 'Horace', 'Pennypacker', 'appcket', 'he', 1645327257188, NULL, 0);
INSERT INTO keycloak.user_entity VALUES ('ba3b17f0-2698-4455-b150-0dcfbf9fdcd8', 'lloyd@appcket.org', 'lloyd@appcket.org', true, true, NULL, 'Lloyd', 'Braun', 'appcket', 'lloyd', 1645327573137, NULL, 0);


--
-- TOC entry 4245 (class 0 OID 16806)
-- Dependencies: 292
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4246 (class 0 OID 16811)
-- Dependencies: 293
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4247 (class 0 OID 16816)
-- Dependencies: 294
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4248 (class 0 OID 16821)
-- Dependencies: 295
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4249 (class 0 OID 16826)
-- Dependencies: 296
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4250 (class 0 OID 16829)
-- Dependencies: 297
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4251 (class 0 OID 16833)
-- Dependencies: 298
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.user_role_mapping VALUES ('9644cff1-6824-4dab-9916-dd71201b120b', 'dc59cd47-1a7e-4ca2-96b8-96df2bfe9b12');
INSERT INTO keycloak.user_role_mapping VALUES ('1250ac00-2380-4150-81a7-10a0ae105049', 'dc59cd47-1a7e-4ca2-96b8-96df2bfe9b12');
INSERT INTO keycloak.user_role_mapping VALUES ('558648c2-b53b-4dfd-906f-d30b67967ecd', '6c15646c-89cb-43ad-aa91-cbdc4bdca430');
INSERT INTO keycloak.user_role_mapping VALUES ('241f95cd-d0a8-4b5e-b7d3-657f078175bb', '6c15646c-89cb-43ad-aa91-cbdc4bdca430');
INSERT INTO keycloak.user_role_mapping VALUES ('eee97160-4b67-4071-84f4-099bbcd704af', '6c15646c-89cb-43ad-aa91-cbdc4bdca430');
INSERT INTO keycloak.user_role_mapping VALUES ('934d2eb7-4ffa-406f-b8a9-155460dd9872', '6c15646c-89cb-43ad-aa91-cbdc4bdca430');
INSERT INTO keycloak.user_role_mapping VALUES ('a5654d13-57b2-4a00-8ffa-e4be21c18524', '6c15646c-89cb-43ad-aa91-cbdc4bdca430');
INSERT INTO keycloak.user_role_mapping VALUES ('395df0fe-9ce6-4af3-9d3f-a76b64e2c6b1', '6c15646c-89cb-43ad-aa91-cbdc4bdca430');
INSERT INTO keycloak.user_role_mapping VALUES ('f82082f8-ce8f-4514-a0df-08b916e08db3', '6c15646c-89cb-43ad-aa91-cbdc4bdca430');
INSERT INTO keycloak.user_role_mapping VALUES ('2ae1deef-cb36-494a-b238-d4ae1b145be9', 'dc59cd47-1a7e-4ca2-96b8-96df2bfe9b12');
INSERT INTO keycloak.user_role_mapping VALUES ('fea5b979-6e50-4adb-a02a-40d67de24b42', 'dc59cd47-1a7e-4ca2-96b8-96df2bfe9b12');
INSERT INTO keycloak.user_role_mapping VALUES ('7a5836c9-d5c7-4649-8a0a-38dd60ece9c0', 'dc59cd47-1a7e-4ca2-96b8-96df2bfe9b12');
INSERT INTO keycloak.user_role_mapping VALUES ('79d5386d-ffcc-4829-95e9-045dc597a23b', 'dc59cd47-1a7e-4ca2-96b8-96df2bfe9b12');
INSERT INTO keycloak.user_role_mapping VALUES ('30d1bca6-7b99-4209-91d8-1b7c549fd963', 'dc59cd47-1a7e-4ca2-96b8-96df2bfe9b12');
INSERT INTO keycloak.user_role_mapping VALUES ('36f7c456-d64d-4f3c-bf46-44cc622b2918', 'dc59cd47-1a7e-4ca2-96b8-96df2bfe9b12');
INSERT INTO keycloak.user_role_mapping VALUES ('46c26134-a647-4263-9a44-ebef5de6074e', 'dc59cd47-1a7e-4ca2-96b8-96df2bfe9b12');
INSERT INTO keycloak.user_role_mapping VALUES ('b546db53-47ec-42a3-af5c-0680bec9d12f', 'dc59cd47-1a7e-4ca2-96b8-96df2bfe9b12');
INSERT INTO keycloak.user_role_mapping VALUES ('33ad5e4b-1bf4-43c2-8271-b64096075197', 'dc59cd47-1a7e-4ca2-96b8-96df2bfe9b12');
INSERT INTO keycloak.user_role_mapping VALUES ('157a58db-0f8c-4536-ab90-781b1c7003ed', 'dc59cd47-1a7e-4ca2-96b8-96df2bfe9b12');
INSERT INTO keycloak.user_role_mapping VALUES ('ef0847c7-74fa-4b34-8994-9c4b28c1bb02', 'dc59cd47-1a7e-4ca2-96b8-96df2bfe9b12');
INSERT INTO keycloak.user_role_mapping VALUES ('337ea090-4a28-4c3d-8124-d068c7e89097', 'dc59cd47-1a7e-4ca2-96b8-96df2bfe9b12');
INSERT INTO keycloak.user_role_mapping VALUES ('326774d6-9646-4c8b-ab63-a86a0d1f600a', 'dc59cd47-1a7e-4ca2-96b8-96df2bfe9b12');
INSERT INTO keycloak.user_role_mapping VALUES ('c88623da-69e9-42bb-a7e2-870268a83240', 'dc59cd47-1a7e-4ca2-96b8-96df2bfe9b12');
INSERT INTO keycloak.user_role_mapping VALUES ('d456669e-a882-44c7-b83e-dc86f3332b78', 'dc59cd47-1a7e-4ca2-96b8-96df2bfe9b12');
INSERT INTO keycloak.user_role_mapping VALUES ('18057d22-9169-4c7a-a4b8-313b51277530', 'dc59cd47-1a7e-4ca2-96b8-96df2bfe9b12');
INSERT INTO keycloak.user_role_mapping VALUES ('62a07952-f0de-41aa-bd8a-c45b72bc865d', 'dc59cd47-1a7e-4ca2-96b8-96df2bfe9b12');
INSERT INTO keycloak.user_role_mapping VALUES ('3a3efbeb-83dc-4f82-b78d-f00e954d7d40', 'de3127bc-dbe6-4775-9334-2f873f413d23');
INSERT INTO keycloak.user_role_mapping VALUES ('1b55f720-894d-4d89-b37d-358e5eb29309', 'de3127bc-dbe6-4775-9334-2f873f413d23');
INSERT INTO keycloak.user_role_mapping VALUES ('3a3efbeb-83dc-4f82-b78d-f00e954d7d40', 'c83ccc8c-2c1f-4a7a-9506-eaf235a284e9');
INSERT INTO keycloak.user_role_mapping VALUES ('3a3efbeb-83dc-4f82-b78d-f00e954d7d40', '7e2e3888-b370-4309-b82c-403b6871a390');
INSERT INTO keycloak.user_role_mapping VALUES ('3a3efbeb-83dc-4f82-b78d-f00e954d7d40', '83d2fae6-76d9-497c-bbf6-f177785e6195');
INSERT INTO keycloak.user_role_mapping VALUES ('97caa102-e9d8-44de-94a1-74e5ea7bccb5', 'c83ccc8c-2c1f-4a7a-9506-eaf235a284e9');
INSERT INTO keycloak.user_role_mapping VALUES ('a1234e9b-ccf4-43c2-8c5a-f8d5964d9e22', 'ba3b17f0-2698-4455-b150-0dcfbf9fdcd8');
INSERT INTO keycloak.user_role_mapping VALUES ('eee97160-4b67-4071-84f4-099bbcd704af', '7e2e3888-b370-4309-b82c-403b6871a390');
INSERT INTO keycloak.user_role_mapping VALUES ('97caa102-e9d8-44de-94a1-74e5ea7bccb5', '83d2fae6-76d9-497c-bbf6-f177785e6195');


--
-- TOC entry 4252 (class 0 OID 16847)
-- Dependencies: 299
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 4253 (class 0 OID 16852)
-- Dependencies: 300
-- Data for Name: web_origins; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.web_origins VALUES ('01818753-ed45-4903-93e9-8ebffc711cd8', '+');
INSERT INTO keycloak.web_origins VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'https://app.appcket.localhost');
INSERT INTO keycloak.web_origins VALUES ('4dd4c360-d5b9-4730-8091-78b394cea334', '+');
INSERT INTO keycloak.web_origins VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'http://api.appcket.localhost/');
INSERT INTO keycloak.web_origins VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'https://api.appcket.localhost');


--
-- TOC entry 3942 (class 2606 OID 16856)
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- TOC entry 3955 (class 2606 OID 24599)
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- TOC entry 3947 (class 2606 OID 24588)
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- TOC entry 3795 (class 2606 OID 16858)
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- TOC entry 3690 (class 2606 OID 16860)
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- TOC entry 3705 (class 2606 OID 16862)
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- TOC entry 3692 (class 2606 OID 16864)
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- TOC entry 3827 (class 2606 OID 16866)
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- TOC entry 3680 (class 2606 OID 16868)
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3717 (class 2606 OID 16872)
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- TOC entry 3713 (class 2606 OID 16874)
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- TOC entry 3756 (class 2606 OID 16876)
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3736 (class 2606 OID 16878)
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3741 (class 2606 OID 16880)
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- TOC entry 3748 (class 2606 OID 16882)
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- TOC entry 3752 (class 2606 OID 16884)
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3760 (class 2606 OID 16886)
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3768 (class 2606 OID 16888)
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- TOC entry 3829 (class 2606 OID 16890)
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- TOC entry 3832 (class 2606 OID 16892)
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- TOC entry 3835 (class 2606 OID 16894)
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- TOC entry 3844 (class 2606 OID 16896)
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- TOC entry 3777 (class 2606 OID 16898)
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- TOC entry 3687 (class 2606 OID 16900)
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- TOC entry 3733 (class 2606 OID 16902)
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- TOC entry 3764 (class 2606 OID 16904)
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3819 (class 2606 OID 16906)
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- TOC entry 3930 (class 2606 OID 16912)
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- TOC entry 3682 (class 2606 OID 16916)
-- Name: client constraint_7; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- TOC entry 3891 (class 2606 OID 16920)
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- TOC entry 3695 (class 2606 OID 16922)
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- TOC entry 3824 (class 2606 OID 16924)
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- TOC entry 3840 (class 2606 OID 16926)
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- TOC entry 3797 (class 2606 OID 16928)
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- TOC entry 3662 (class 2606 OID 16930)
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- TOC entry 3678 (class 2606 OID 16932)
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- TOC entry 3668 (class 2606 OID 16934)
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- TOC entry 3672 (class 2606 OID 16936)
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- TOC entry 3675 (class 2606 OID 16938)
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- TOC entry 3939 (class 2606 OID 16942)
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3720 (class 2606 OID 16944)
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- TOC entry 3784 (class 2606 OID 16948)
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- TOC entry 3811 (class 2606 OID 16950)
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- TOC entry 3842 (class 2606 OID 16952)
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- TOC entry 3724 (class 2606 OID 16954)
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- TOC entry 3922 (class 2606 OID 16956)
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- TOC entry 3865 (class 2606 OID 16958)
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- TOC entry 3876 (class 2606 OID 16960)
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- TOC entry 3871 (class 2606 OID 16962)
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- TOC entry 3665 (class 2606 OID 16964)
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- TOC entry 3857 (class 2606 OID 16966)
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- TOC entry 3881 (class 2606 OID 16968)
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- TOC entry 3860 (class 2606 OID 16970)
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- TOC entry 3894 (class 2606 OID 16972)
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- TOC entry 3914 (class 2606 OID 16974)
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- TOC entry 3928 (class 2606 OID 16976)
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- TOC entry 3924 (class 2606 OID 16978)
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- TOC entry 3746 (class 2606 OID 16980)
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3910 (class 2606 OID 16982)
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3903 (class 2606 OID 16984)
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- TOC entry 3791 (class 2606 OID 16986)
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- TOC entry 3770 (class 2606 OID 16988)
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3774 (class 2606 OID 16990)
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- TOC entry 3786 (class 2606 OID 16992)
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- TOC entry 3789 (class 2606 OID 16994)
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- TOC entry 3801 (class 2606 OID 16996)
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- TOC entry 3804 (class 2606 OID 16998)
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- TOC entry 3806 (class 2606 OID 17000)
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- TOC entry 3813 (class 2606 OID 17002)
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- TOC entry 3817 (class 2606 OID 17004)
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- TOC entry 3847 (class 2606 OID 17006)
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- TOC entry 3850 (class 2606 OID 17008)
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- TOC entry 3852 (class 2606 OID 17010)
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- TOC entry 3936 (class 2606 OID 17012)
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3886 (class 2606 OID 17014)
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- TOC entry 3888 (class 2606 OID 17016)
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3958 (class 2606 OID 32777)
-- Name: revoked_token constraint_rt; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.revoked_token
    ADD CONSTRAINT constraint_rt PRIMARY KEY (id);


--
-- TOC entry 3897 (class 2606 OID 17018)
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3933 (class 2606 OID 17020)
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3944 (class 2606 OID 17024)
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- TOC entry 3727 (class 2606 OID 17026)
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- TOC entry 3703 (class 2606 OID 17028)
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- TOC entry 3698 (class 2606 OID 17030)
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- TOC entry 3863 (class 2606 OID 17032)
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- TOC entry 3711 (class 2606 OID 17034)
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- TOC entry 3731 (class 2606 OID 17036)
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- TOC entry 3838 (class 2606 OID 17038)
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- TOC entry 3855 (class 2606 OID 17040)
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3793 (class 2606 OID 17042)
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- TOC entry 3782 (class 2606 OID 17044)
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- TOC entry 3685 (class 2606 OID 17046)
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- TOC entry 3700 (class 2606 OID 17048)
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- TOC entry 3918 (class 2606 OID 17050)
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- TOC entry 3906 (class 2606 OID 24603)
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- TOC entry 3879 (class 2606 OID 17052)
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- TOC entry 3869 (class 2606 OID 17054)
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- TOC entry 3874 (class 2606 OID 17056)
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3884 (class 2606 OID 17058)
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3908 (class 2606 OID 24601)
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- TOC entry 3949 (class 2606 OID 32770)
-- Name: org uk_org_alias; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.org
    ADD CONSTRAINT uk_org_alias UNIQUE (realm_id, alias);


--
-- TOC entry 3951 (class 2606 OID 24592)
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- TOC entry 3953 (class 2606 OID 24590)
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- TOC entry 3822 (class 2606 OID 17062)
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- TOC entry 3920 (class 2606 OID 17064)
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- TOC entry 3737 (class 1259 OID 17901)
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX fed_user_attr_long_values ON keycloak.fed_user_attribute USING btree (long_value_hash, name);


--
-- TOC entry 3738 (class 1259 OID 17903)
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX fed_user_attr_long_values_lower_case ON keycloak.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- TOC entry 3663 (class 1259 OID 17065)
-- Name: idx_admin_event_time; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_admin_event_time ON keycloak.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- TOC entry 3666 (class 1259 OID 17066)
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON keycloak.associated_policy USING btree (associated_policy_id);


--
-- TOC entry 3676 (class 1259 OID 17067)
-- Name: idx_auth_config_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_auth_config_realm ON keycloak.authenticator_config USING btree (realm_id);


--
-- TOC entry 3669 (class 1259 OID 17068)
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_auth_exec_flow ON keycloak.authentication_execution USING btree (flow_id);


--
-- TOC entry 3670 (class 1259 OID 17069)
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_auth_exec_realm_flow ON keycloak.authentication_execution USING btree (realm_id, flow_id);


--
-- TOC entry 3673 (class 1259 OID 17070)
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_auth_flow_realm ON keycloak.authentication_flow USING btree (realm_id);


--
-- TOC entry 3706 (class 1259 OID 17071)
-- Name: idx_cl_clscope; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_cl_clscope ON keycloak.client_scope_client USING btree (scope_id);


--
-- TOC entry 3688 (class 1259 OID 17904)
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_client_att_by_name_value ON keycloak.client_attributes USING btree (name, substr(value, 1, 255));


--
-- TOC entry 3683 (class 1259 OID 17072)
-- Name: idx_client_id; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_client_id ON keycloak.client USING btree (client_id);


--
-- TOC entry 3693 (class 1259 OID 17073)
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_client_init_acc_realm ON keycloak.client_initial_access USING btree (realm_id);


--
-- TOC entry 3701 (class 1259 OID 17075)
-- Name: idx_clscope_attrs; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_clscope_attrs ON keycloak.client_scope_attributes USING btree (scope_id);


--
-- TOC entry 3707 (class 1259 OID 17076)
-- Name: idx_clscope_cl; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_clscope_cl ON keycloak.client_scope_client USING btree (client_id);


--
-- TOC entry 3814 (class 1259 OID 17077)
-- Name: idx_clscope_protmap; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_clscope_protmap ON keycloak.protocol_mapper USING btree (client_scope_id);


--
-- TOC entry 3708 (class 1259 OID 17078)
-- Name: idx_clscope_role; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_clscope_role ON keycloak.client_scope_role_mapping USING btree (scope_id);


--
-- TOC entry 3718 (class 1259 OID 17079)
-- Name: idx_compo_config_compo; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_compo_config_compo ON keycloak.component_config USING btree (component_id);


--
-- TOC entry 3714 (class 1259 OID 17080)
-- Name: idx_component_provider_type; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_component_provider_type ON keycloak.component USING btree (provider_type);


--
-- TOC entry 3715 (class 1259 OID 17081)
-- Name: idx_component_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_component_realm ON keycloak.component USING btree (realm_id);


--
-- TOC entry 3721 (class 1259 OID 17082)
-- Name: idx_composite; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_composite ON keycloak.composite_role USING btree (composite);


--
-- TOC entry 3722 (class 1259 OID 17083)
-- Name: idx_composite_child; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_composite_child ON keycloak.composite_role USING btree (child_role);


--
-- TOC entry 3728 (class 1259 OID 17084)
-- Name: idx_defcls_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_defcls_realm ON keycloak.default_client_scope USING btree (realm_id);


--
-- TOC entry 3729 (class 1259 OID 17085)
-- Name: idx_defcls_scope; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_defcls_scope ON keycloak.default_client_scope USING btree (scope_id);


--
-- TOC entry 3734 (class 1259 OID 17086)
-- Name: idx_event_time; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_event_time ON keycloak.event_entity USING btree (realm_id, event_time);


--
-- TOC entry 3765 (class 1259 OID 17087)
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_fedidentity_feduser ON keycloak.federated_identity USING btree (federated_user_id);


--
-- TOC entry 3766 (class 1259 OID 17088)
-- Name: idx_fedidentity_user; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_fedidentity_user ON keycloak.federated_identity USING btree (user_id);


--
-- TOC entry 3739 (class 1259 OID 17089)
-- Name: idx_fu_attribute; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_fu_attribute ON keycloak.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- TOC entry 3742 (class 1259 OID 17090)
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_fu_cnsnt_ext ON keycloak.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- TOC entry 3743 (class 1259 OID 17091)
-- Name: idx_fu_consent; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_fu_consent ON keycloak.fed_user_consent USING btree (user_id, client_id);


--
-- TOC entry 3744 (class 1259 OID 17092)
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_fu_consent_ru ON keycloak.fed_user_consent USING btree (realm_id, user_id);


--
-- TOC entry 3749 (class 1259 OID 17093)
-- Name: idx_fu_credential; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_fu_credential ON keycloak.fed_user_credential USING btree (user_id, type);


--
-- TOC entry 3750 (class 1259 OID 17094)
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_fu_credential_ru ON keycloak.fed_user_credential USING btree (realm_id, user_id);


--
-- TOC entry 3753 (class 1259 OID 17095)
-- Name: idx_fu_group_membership; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_fu_group_membership ON keycloak.fed_user_group_membership USING btree (user_id, group_id);


--
-- TOC entry 3754 (class 1259 OID 17096)
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_fu_group_membership_ru ON keycloak.fed_user_group_membership USING btree (realm_id, user_id);


--
-- TOC entry 3757 (class 1259 OID 17097)
-- Name: idx_fu_required_action; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_fu_required_action ON keycloak.fed_user_required_action USING btree (user_id, required_action);


--
-- TOC entry 3758 (class 1259 OID 17098)
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_fu_required_action_ru ON keycloak.fed_user_required_action USING btree (realm_id, user_id);


--
-- TOC entry 3761 (class 1259 OID 17099)
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_fu_role_mapping ON keycloak.fed_user_role_mapping USING btree (user_id, role_id);


--
-- TOC entry 3762 (class 1259 OID 17100)
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_fu_role_mapping_ru ON keycloak.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- TOC entry 3771 (class 1259 OID 17101)
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_group_att_by_name_value ON keycloak.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- TOC entry 3772 (class 1259 OID 17102)
-- Name: idx_group_attr_group; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_group_attr_group ON keycloak.group_attribute USING btree (group_id);


--
-- TOC entry 3775 (class 1259 OID 17103)
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_group_role_mapp_group ON keycloak.group_role_mapping USING btree (group_id);


--
-- TOC entry 3787 (class 1259 OID 17104)
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_id_prov_mapp_realm ON keycloak.identity_provider_mapper USING btree (realm_id);


--
-- TOC entry 3778 (class 1259 OID 17105)
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_ident_prov_realm ON keycloak.identity_provider USING btree (realm_id);


--
-- TOC entry 3779 (class 1259 OID 32781)
-- Name: idx_idp_for_login; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_idp_for_login ON keycloak.identity_provider USING btree (realm_id, enabled, link_only, hide_on_login, organization_id);


--
-- TOC entry 3780 (class 1259 OID 32780)
-- Name: idx_idp_realm_org; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_idp_realm_org ON keycloak.identity_provider USING btree (realm_id, organization_id);


--
-- TOC entry 3798 (class 1259 OID 17106)
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_keycloak_role_client ON keycloak.keycloak_role USING btree (client);


--
-- TOC entry 3799 (class 1259 OID 17107)
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_keycloak_role_realm ON keycloak.keycloak_role USING btree (realm);


--
-- TOC entry 3807 (class 1259 OID 24581)
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON keycloak.offline_user_session USING btree (broker_session_id, realm_id);


--
-- TOC entry 3808 (class 1259 OID 24580)
-- Name: idx_offline_uss_by_last_session_refresh; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_offline_uss_by_last_session_refresh ON keycloak.offline_user_session USING btree (realm_id, offline_flag, last_session_refresh);


--
-- TOC entry 3809 (class 1259 OID 17109)
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_offline_uss_by_user ON keycloak.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- TOC entry 3956 (class 1259 OID 32772)
-- Name: idx_org_domain_org_id; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_org_domain_org_id ON keycloak.org_domain USING btree (org_id);


--
-- TOC entry 3866 (class 1259 OID 24605)
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_perm_ticket_owner ON keycloak.resource_server_perm_ticket USING btree (owner);


--
-- TOC entry 3867 (class 1259 OID 24604)
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_perm_ticket_requester ON keycloak.resource_server_perm_ticket USING btree (requester);


--
-- TOC entry 3815 (class 1259 OID 17113)
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_protocol_mapper_client ON keycloak.protocol_mapper USING btree (client_id);


--
-- TOC entry 3825 (class 1259 OID 17114)
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_realm_attr_realm ON keycloak.realm_attribute USING btree (realm_id);


--
-- TOC entry 3696 (class 1259 OID 17115)
-- Name: idx_realm_clscope; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_realm_clscope ON keycloak.client_scope USING btree (realm_id);


--
-- TOC entry 3830 (class 1259 OID 17116)
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_realm_def_grp_realm ON keycloak.realm_default_groups USING btree (realm_id);


--
-- TOC entry 3836 (class 1259 OID 17117)
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_realm_evt_list_realm ON keycloak.realm_events_listeners USING btree (realm_id);


--
-- TOC entry 3833 (class 1259 OID 17118)
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_realm_evt_types_realm ON keycloak.realm_enabled_event_types USING btree (realm_id);


--
-- TOC entry 3820 (class 1259 OID 17119)
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_realm_master_adm_cli ON keycloak.realm USING btree (master_admin_client);


--
-- TOC entry 3845 (class 1259 OID 17120)
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_realm_supp_local_realm ON keycloak.realm_supported_locales USING btree (realm_id);


--
-- TOC entry 3848 (class 1259 OID 17121)
-- Name: idx_redir_uri_client; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_redir_uri_client ON keycloak.redirect_uris USING btree (client_id);


--
-- TOC entry 3853 (class 1259 OID 17122)
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_req_act_prov_realm ON keycloak.required_action_provider USING btree (realm_id);


--
-- TOC entry 3858 (class 1259 OID 17123)
-- Name: idx_res_policy_policy; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_res_policy_policy ON keycloak.resource_policy USING btree (policy_id);


--
-- TOC entry 3861 (class 1259 OID 17124)
-- Name: idx_res_scope_scope; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_res_scope_scope ON keycloak.resource_scope USING btree (scope_id);


--
-- TOC entry 3872 (class 1259 OID 17125)
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_res_serv_pol_res_serv ON keycloak.resource_server_policy USING btree (resource_server_id);


--
-- TOC entry 3877 (class 1259 OID 17126)
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_res_srv_res_res_srv ON keycloak.resource_server_resource USING btree (resource_server_id);


--
-- TOC entry 3882 (class 1259 OID 17127)
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_res_srv_scope_res_srv ON keycloak.resource_server_scope USING btree (resource_server_id);


--
-- TOC entry 3959 (class 1259 OID 32778)
-- Name: idx_rev_token_on_expire; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_rev_token_on_expire ON keycloak.revoked_token USING btree (expire);


--
-- TOC entry 3889 (class 1259 OID 17128)
-- Name: idx_role_attribute; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_role_attribute ON keycloak.role_attribute USING btree (role_id);


--
-- TOC entry 3709 (class 1259 OID 17129)
-- Name: idx_role_clscope; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_role_clscope ON keycloak.client_scope_role_mapping USING btree (role_id);


--
-- TOC entry 3892 (class 1259 OID 17130)
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_scope_mapping_role ON keycloak.scope_mapping USING btree (role_id);


--
-- TOC entry 3895 (class 1259 OID 17131)
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_scope_policy_policy ON keycloak.scope_policy USING btree (policy_id);


--
-- TOC entry 3802 (class 1259 OID 17132)
-- Name: idx_update_time; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_update_time ON keycloak.migration_model USING btree (update_time);


--
-- TOC entry 3911 (class 1259 OID 17134)
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_usconsent_clscope ON keycloak.user_consent_client_scope USING btree (user_consent_id);


--
-- TOC entry 3912 (class 1259 OID 24577)
-- Name: idx_usconsent_scope_id; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_usconsent_scope_id ON keycloak.user_consent_client_scope USING btree (scope_id);


--
-- TOC entry 3898 (class 1259 OID 17135)
-- Name: idx_user_attribute; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_user_attribute ON keycloak.user_attribute USING btree (user_id);


--
-- TOC entry 3899 (class 1259 OID 17136)
-- Name: idx_user_attribute_name; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_user_attribute_name ON keycloak.user_attribute USING btree (name, value);


--
-- TOC entry 3904 (class 1259 OID 17137)
-- Name: idx_user_consent; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_user_consent ON keycloak.user_consent USING btree (user_id);


--
-- TOC entry 3725 (class 1259 OID 17138)
-- Name: idx_user_credential; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_user_credential ON keycloak.credential USING btree (user_id);


--
-- TOC entry 3915 (class 1259 OID 17139)
-- Name: idx_user_email; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_user_email ON keycloak.user_entity USING btree (email);


--
-- TOC entry 3934 (class 1259 OID 17140)
-- Name: idx_user_group_mapping; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_user_group_mapping ON keycloak.user_group_membership USING btree (user_id);


--
-- TOC entry 3937 (class 1259 OID 17141)
-- Name: idx_user_reqactions; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_user_reqactions ON keycloak.user_required_action USING btree (user_id);


--
-- TOC entry 3940 (class 1259 OID 17142)
-- Name: idx_user_role_mapping; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_user_role_mapping ON keycloak.user_role_mapping USING btree (user_id);


--
-- TOC entry 3916 (class 1259 OID 17143)
-- Name: idx_user_service_account; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_user_service_account ON keycloak.user_entity USING btree (realm_id, service_account_client_link);


--
-- TOC entry 3925 (class 1259 OID 17144)
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_usr_fed_map_fed_prv ON keycloak.user_federation_mapper USING btree (federation_provider_id);


--
-- TOC entry 3926 (class 1259 OID 17145)
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_usr_fed_map_realm ON keycloak.user_federation_mapper USING btree (realm_id);


--
-- TOC entry 3931 (class 1259 OID 17146)
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_usr_fed_prv_realm ON keycloak.user_federation_provider USING btree (realm_id);


--
-- TOC entry 3945 (class 1259 OID 17147)
-- Name: idx_web_orig_client; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_web_orig_client ON keycloak.web_origins USING btree (client_id);


--
-- TOC entry 3900 (class 1259 OID 17900)
-- Name: user_attr_long_values; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX user_attr_long_values ON keycloak.user_attribute USING btree (long_value_hash, name);


--
-- TOC entry 3901 (class 1259 OID 17902)
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX user_attr_long_values_lower_case ON keycloak.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- TOC entry 3980 (class 2606 OID 17153)
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3966 (class 2606 OID 17158)
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 3977 (class 2606 OID 17163)
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 3968 (class 2606 OID 17168)
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 3996 (class 2606 OID 17188)
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 4022 (class 2606 OID 17193)
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3993 (class 2606 OID 17203)
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3998 (class 2606 OID 17208)
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES keycloak.resource_server_resource(id);


--
-- TOC entry 4015 (class 2606 OID 17213)
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 4024 (class 2606 OID 17218)
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 3984 (class 2606 OID 17223)
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES keycloak.realm(id);


--
-- TOC entry 3994 (class 2606 OID 17228)
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3989 (class 2606 OID 17233)
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3973 (class 2606 OID 17238)
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES keycloak.keycloak_role(id);


--
-- TOC entry 3962 (class 2606 OID 17243)
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES keycloak.authentication_flow(id);


--
-- TOC entry 3963 (class 2606 OID 17248)
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3964 (class 2606 OID 17253)
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3965 (class 2606 OID 17258)
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 4025 (class 2606 OID 17268)
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 3969 (class 2606 OID 17273)
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES keycloak.client_scope(id);


--
-- TOC entry 3970 (class 2606 OID 17278)
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES keycloak.client_scope(id);


--
-- TOC entry 3986 (class 2606 OID 17288)
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES keycloak.client_scope(id);


--
-- TOC entry 3967 (class 2606 OID 17293)
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3972 (class 2606 OID 17298)
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES keycloak.component(id);


--
-- TOC entry 3971 (class 2606 OID 17303)
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3990 (class 2606 OID 17308)
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 4021 (class 2606 OID 17313)
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES keycloak.user_federation_mapper(id);


--
-- TOC entry 4019 (class 2606 OID 17318)
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES keycloak.user_federation_provider(id);


--
-- TOC entry 4020 (class 2606 OID 17323)
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3960 (class 2606 OID 17328)
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- TOC entry 4013 (class 2606 OID 17333)
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- TOC entry 4003 (class 2606 OID 17338)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES keycloak.resource_server(id);


--
-- TOC entry 4008 (class 2606 OID 17343)
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES keycloak.resource_server(id);


--
-- TOC entry 4004 (class 2606 OID 17348)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES keycloak.resource_server_resource(id);


--
-- TOC entry 4005 (class 2606 OID 17353)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES keycloak.resource_server_scope(id);


--
-- TOC entry 3961 (class 2606 OID 17358)
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- TOC entry 4014 (class 2606 OID 17363)
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES keycloak.resource_server_scope(id);


--
-- TOC entry 4006 (class 2606 OID 17368)
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- TOC entry 4007 (class 2606 OID 17373)
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES keycloak.resource_server(id);


--
-- TOC entry 4001 (class 2606 OID 17378)
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES keycloak.resource_server_resource(id);


--
-- TOC entry 3999 (class 2606 OID 17383)
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES keycloak.resource_server_resource(id);


--
-- TOC entry 4000 (class 2606 OID 17388)
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- TOC entry 4002 (class 2606 OID 17393)
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES keycloak.resource_server_scope(id);


--
-- TOC entry 4009 (class 2606 OID 17398)
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES keycloak.resource_server(id);


--
-- TOC entry 3974 (class 2606 OID 17403)
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES keycloak.keycloak_role(id);


--
-- TOC entry 4017 (class 2606 OID 17408)
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES keycloak.user_consent(id);


--
-- TOC entry 4016 (class 2606 OID 17413)
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 3978 (class 2606 OID 17418)
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES keycloak.keycloak_group(id);


--
-- TOC entry 3979 (class 2606 OID 17423)
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES keycloak.keycloak_group(id);


--
-- TOC entry 3991 (class 2606 OID 17428)
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3992 (class 2606 OID 17433)
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3982 (class 2606 OID 17438)
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3983 (class 2606 OID 17443)
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES keycloak.identity_provider_mapper(id);


--
-- TOC entry 4026 (class 2606 OID 17448)
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 4012 (class 2606 OID 17453)
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 3987 (class 2606 OID 17458)
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 3975 (class 2606 OID 17463)
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 3988 (class 2606 OID 17468)
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES keycloak.protocol_mapper(id);


--
-- TOC entry 3976 (class 2606 OID 17473)
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3997 (class 2606 OID 17478)
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 4010 (class 2606 OID 17483)
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES keycloak.resource_server_resource(id);


--
-- TOC entry 4011 (class 2606 OID 17488)
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES keycloak.keycloak_role(id);


--
-- TOC entry 3995 (class 2606 OID 17493)
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 4018 (class 2606 OID 17498)
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES keycloak.user_federation_provider(id);


--
-- TOC entry 4023 (class 2606 OID 17503)
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 3985 (class 2606 OID 17508)
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- TOC entry 3981 (class 2606 OID 17513)
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES keycloak.identity_provider(internal_id);


-- Completed on 2024-11-09 16:31:02 UTC

--
-- PostgreSQL database dump complete
--

