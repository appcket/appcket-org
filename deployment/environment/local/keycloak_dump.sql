--
-- PostgreSQL database dump
--

-- Dumped from database version 13.4 (Debian 13.4-1.pgdg100+1)
-- Dumped by pg_dump version 13.4 (Debian 13.4-1.pgdg100+1)

-- Started on 2022-02-01 24:27:17 UTC

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
-- TOC entry 4 (class 2615 OID 18150)
-- Name: keycloak; Type: SCHEMA; Schema: -; Owner: dbuser
--

CREATE SCHEMA keycloak;


ALTER SCHEMA keycloak OWNER TO dbuser;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 243 (class 1259 OID 18810)
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
-- TOC entry 272 (class 1259 OID 19273)
-- Name: associated_policy; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.associated_policy OWNER TO dbuser;

--
-- TOC entry 246 (class 1259 OID 18828)
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
-- TOC entry 245 (class 1259 OID 18822)
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
-- TOC entry 244 (class 1259 OID 18816)
-- Name: authenticator_config; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE keycloak.authenticator_config OWNER TO dbuser;

--
-- TOC entry 247 (class 1259 OID 18833)
-- Name: authenticator_config_entry; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.authenticator_config_entry OWNER TO dbuser;

--
-- TOC entry 273 (class 1259 OID 19288)
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
-- TOC entry 204 (class 1259 OID 18165)
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
-- TOC entry 227 (class 1259 OID 18539)
-- Name: client_attributes; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.client_attributes OWNER TO dbuser;

--
-- TOC entry 284 (class 1259 OID 19547)
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE keycloak.client_auth_flow_bindings OWNER TO dbuser;

--
-- TOC entry 283 (class 1259 OID 19422)
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
-- TOC entry 229 (class 1259 OID 18551)
-- Name: client_node_registrations; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.client_node_registrations OWNER TO dbuser;

--
-- TOC entry 261 (class 1259 OID 19071)
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
-- TOC entry 262 (class 1259 OID 19086)
-- Name: client_scope_attributes; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.client_scope_attributes OWNER TO dbuser;

--
-- TOC entry 285 (class 1259 OID 19589)
-- Name: client_scope_client; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE keycloak.client_scope_client OWNER TO dbuser;

--
-- TOC entry 263 (class 1259 OID 19092)
-- Name: client_scope_role_mapping; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.client_scope_role_mapping OWNER TO dbuser;

--
-- TOC entry 205 (class 1259 OID 18177)
-- Name: client_session; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE keycloak.client_session OWNER TO dbuser;

--
-- TOC entry 250 (class 1259 OID 18854)
-- Name: client_session_auth_status; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE keycloak.client_session_auth_status OWNER TO dbuser;

--
-- TOC entry 228 (class 1259 OID 18545)
-- Name: client_session_note; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE keycloak.client_session_note OWNER TO dbuser;

--
-- TOC entry 242 (class 1259 OID 18732)
-- Name: client_session_prot_mapper; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE keycloak.client_session_prot_mapper OWNER TO dbuser;

--
-- TOC entry 206 (class 1259 OID 18183)
-- Name: client_session_role; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE keycloak.client_session_role OWNER TO dbuser;

--
-- TOC entry 251 (class 1259 OID 18935)
-- Name: client_user_session_note; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE keycloak.client_user_session_note OWNER TO dbuser;

--
-- TOC entry 281 (class 1259 OID 19338)
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
-- TOC entry 280 (class 1259 OID 19332)
-- Name: component_config; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE keycloak.component_config OWNER TO dbuser;

--
-- TOC entry 207 (class 1259 OID 18186)
-- Name: composite_role; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE keycloak.composite_role OWNER TO dbuser;

--
-- TOC entry 208 (class 1259 OID 18189)
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
-- TOC entry 203 (class 1259 OID 18156)
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
-- TOC entry 202 (class 1259 OID 18151)
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
-- TOC entry 286 (class 1259 OID 19605)
-- Name: default_client_scope; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE keycloak.default_client_scope OWNER TO dbuser;

--
-- TOC entry 209 (class 1259 OID 18195)
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
    user_id character varying(255)
);


ALTER TABLE keycloak.event_entity OWNER TO dbuser;

--
-- TOC entry 274 (class 1259 OID 19294)
-- Name: fed_user_attribute; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE keycloak.fed_user_attribute OWNER TO dbuser;

--
-- TOC entry 275 (class 1259 OID 19300)
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
-- TOC entry 288 (class 1259 OID 19631)
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.fed_user_consent_cl_scope OWNER TO dbuser;

--
-- TOC entry 276 (class 1259 OID 19309)
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
-- TOC entry 277 (class 1259 OID 19319)
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
-- TOC entry 278 (class 1259 OID 19322)
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
-- TOC entry 279 (class 1259 OID 19329)
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
-- TOC entry 232 (class 1259 OID 18589)
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
-- TOC entry 282 (class 1259 OID 19398)
-- Name: federated_user; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.federated_user OWNER TO dbuser;

--
-- TOC entry 258 (class 1259 OID 19008)
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
-- TOC entry 257 (class 1259 OID 19005)
-- Name: group_role_mapping; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.group_role_mapping OWNER TO dbuser;

--
-- TOC entry 233 (class 1259 OID 18595)
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
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE keycloak.identity_provider OWNER TO dbuser;

--
-- TOC entry 234 (class 1259 OID 18605)
-- Name: identity_provider_config; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.identity_provider_config OWNER TO dbuser;

--
-- TOC entry 239 (class 1259 OID 18711)
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
-- TOC entry 240 (class 1259 OID 18717)
-- Name: idp_mapper_config; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.idp_mapper_config OWNER TO dbuser;

--
-- TOC entry 256 (class 1259 OID 19002)
-- Name: keycloak_group; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE keycloak.keycloak_group OWNER TO dbuser;

--
-- TOC entry 210 (class 1259 OID 18204)
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
-- TOC entry 238 (class 1259 OID 18708)
-- Name: migration_model; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE keycloak.migration_model OWNER TO dbuser;

--
-- TOC entry 255 (class 1259 OID 18992)
-- Name: offline_client_session; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE keycloak.offline_client_session OWNER TO dbuser;

--
-- TOC entry 254 (class 1259 OID 18986)
-- Name: offline_user_session; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE keycloak.offline_user_session OWNER TO dbuser;

--
-- TOC entry 268 (class 1259 OID 19215)
-- Name: policy_config; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE keycloak.policy_config OWNER TO dbuser;

--
-- TOC entry 230 (class 1259 OID 18576)
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
-- TOC entry 231 (class 1259 OID 18583)
-- Name: protocol_mapper_config; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.protocol_mapper_config OWNER TO dbuser;

--
-- TOC entry 211 (class 1259 OID 18211)
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
-- TOC entry 212 (class 1259 OID 18229)
-- Name: realm_attribute; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE keycloak.realm_attribute OWNER TO dbuser;

--
-- TOC entry 260 (class 1259 OID 19018)
-- Name: realm_default_groups; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.realm_default_groups OWNER TO dbuser;

--
-- TOC entry 237 (class 1259 OID 18700)
-- Name: realm_enabled_event_types; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE keycloak.realm_enabled_event_types OWNER TO dbuser;

--
-- TOC entry 213 (class 1259 OID 18238)
-- Name: realm_events_listeners; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE keycloak.realm_events_listeners OWNER TO dbuser;

--
-- TOC entry 293 (class 1259 OID 19745)
-- Name: realm_localizations; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE keycloak.realm_localizations OWNER TO dbuser;

--
-- TOC entry 214 (class 1259 OID 18241)
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
-- TOC entry 215 (class 1259 OID 18249)
-- Name: realm_smtp_config; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.realm_smtp_config OWNER TO dbuser;

--
-- TOC entry 235 (class 1259 OID 18615)
-- Name: realm_supported_locales; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE keycloak.realm_supported_locales OWNER TO dbuser;

--
-- TOC entry 216 (class 1259 OID 18261)
-- Name: redirect_uris; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE keycloak.redirect_uris OWNER TO dbuser;

--
-- TOC entry 253 (class 1259 OID 18949)
-- Name: required_action_config; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.required_action_config OWNER TO dbuser;

--
-- TOC entry 252 (class 1259 OID 18941)
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
-- TOC entry 290 (class 1259 OID 19670)
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
-- TOC entry 270 (class 1259 OID 19243)
-- Name: resource_policy; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.resource_policy OWNER TO dbuser;

--
-- TOC entry 269 (class 1259 OID 19228)
-- Name: resource_scope; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.resource_scope OWNER TO dbuser;

--
-- TOC entry 264 (class 1259 OID 19162)
-- Name: resource_server; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE keycloak.resource_server OWNER TO dbuser;

--
-- TOC entry 289 (class 1259 OID 19646)
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
-- TOC entry 267 (class 1259 OID 19200)
-- Name: resource_server_policy; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE keycloak.resource_server_policy OWNER TO dbuser;

--
-- TOC entry 265 (class 1259 OID 19170)
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
-- TOC entry 266 (class 1259 OID 19185)
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
-- TOC entry 291 (class 1259 OID 19689)
-- Name: resource_uris; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE keycloak.resource_uris OWNER TO dbuser;

--
-- TOC entry 292 (class 1259 OID 19699)
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
-- TOC entry 217 (class 1259 OID 18264)
-- Name: scope_mapping; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.scope_mapping OWNER TO dbuser;

--
-- TOC entry 271 (class 1259 OID 19258)
-- Name: scope_policy; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.scope_policy OWNER TO dbuser;

--
-- TOC entry 219 (class 1259 OID 18270)
-- Name: user_attribute; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE keycloak.user_attribute OWNER TO dbuser;

--
-- TOC entry 241 (class 1259 OID 18723)
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
-- TOC entry 287 (class 1259 OID 19621)
-- Name: user_consent_client_scope; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.user_consent_client_scope OWNER TO dbuser;

--
-- TOC entry 220 (class 1259 OID 18276)
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
-- TOC entry 221 (class 1259 OID 18285)
-- Name: user_federation_config; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.user_federation_config OWNER TO dbuser;

--
-- TOC entry 248 (class 1259 OID 18839)
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
-- TOC entry 249 (class 1259 OID 18845)
-- Name: user_federation_mapper_config; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE keycloak.user_federation_mapper_config OWNER TO dbuser;

--
-- TOC entry 222 (class 1259 OID 18291)
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
-- TOC entry 259 (class 1259 OID 19015)
-- Name: user_group_membership; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.user_group_membership OWNER TO dbuser;

--
-- TOC entry 223 (class 1259 OID 18297)
-- Name: user_required_action; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE keycloak.user_required_action OWNER TO dbuser;

--
-- TOC entry 224 (class 1259 OID 18300)
-- Name: user_role_mapping; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE keycloak.user_role_mapping OWNER TO dbuser;

--
-- TOC entry 225 (class 1259 OID 18303)
-- Name: user_session; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE keycloak.user_session OWNER TO dbuser;

--
-- TOC entry 236 (class 1259 OID 18618)
-- Name: user_session_note; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE keycloak.user_session_note OWNER TO dbuser;

--
-- TOC entry 218 (class 1259 OID 18267)
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
-- TOC entry 226 (class 1259 OID 18316)
-- Name: web_origins; Type: TABLE; Schema: keycloak; Owner: dbuser
--

CREATE TABLE keycloak.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE keycloak.web_origins OWNER TO dbuser;

--
-- TOC entry 3866 (class 0 OID 18810)
-- Dependencies: 243
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3895 (class 0 OID 19273)
-- Dependencies: 272
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.associated_policy VALUES ('b498b31a-81fa-4a32-b625-71ca3e577dcb', 'bfaf527b-4238-46d7-aa48-1d605b7c390f');
INSERT INTO keycloak.associated_policy VALUES ('beb7d05d-19f7-4690-86e9-13dd49936d71', 'f54d2838-ff5a-4259-8560-c50f042375ab');
INSERT INTO keycloak.associated_policy VALUES ('beb7d05d-19f7-4690-86e9-13dd49936d71', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');
INSERT INTO keycloak.associated_policy VALUES ('a03337fa-5ad4-42e1-8beb-52afcac74329', 'f54d2838-ff5a-4259-8560-c50f042375ab');
INSERT INTO keycloak.associated_policy VALUES ('a03337fa-5ad4-42e1-8beb-52afcac74329', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');
INSERT INTO keycloak.associated_policy VALUES ('a03337fa-5ad4-42e1-8beb-52afcac74329', '56cc0301-6b50-4bb1-b870-514669458695');
INSERT INTO keycloak.associated_policy VALUES ('a03337fa-5ad4-42e1-8beb-52afcac74329', '53667455-8734-49e0-9e11-db6aacce6cbf');
INSERT INTO keycloak.associated_policy VALUES ('ab1f242c-d8bf-4860-a2b1-4702f367bbd5', 'f54d2838-ff5a-4259-8560-c50f042375ab');
INSERT INTO keycloak.associated_policy VALUES ('ab1f242c-d8bf-4860-a2b1-4702f367bbd5', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');
INSERT INTO keycloak.associated_policy VALUES ('ab1f242c-d8bf-4860-a2b1-4702f367bbd5', '53667455-8734-49e0-9e11-db6aacce6cbf');
INSERT INTO keycloak.associated_policy VALUES ('f93476a3-2536-4e2c-bcad-212d0859fbe1', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');
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
INSERT INTO keycloak.associated_policy VALUES ('7db68186-ebbb-40a8-8dd7-147deddae4ce', 'f54d2838-ff5a-4259-8560-c50f042375ab');
INSERT INTO keycloak.associated_policy VALUES ('7db68186-ebbb-40a8-8dd7-147deddae4ce', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');
INSERT INTO keycloak.associated_policy VALUES ('7db68186-ebbb-40a8-8dd7-147deddae4ce', '53667455-8734-49e0-9e11-db6aacce6cbf');
INSERT INTO keycloak.associated_policy VALUES ('48345f52-292b-474c-acd3-1cc56513aa4f', 'f54d2838-ff5a-4259-8560-c50f042375ab');
INSERT INTO keycloak.associated_policy VALUES ('48345f52-292b-474c-acd3-1cc56513aa4f', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');
INSERT INTO keycloak.associated_policy VALUES ('48345f52-292b-474c-acd3-1cc56513aa4f', '53667455-8734-49e0-9e11-db6aacce6cbf');
INSERT INTO keycloak.associated_policy VALUES ('73c7d9cb-5b6a-4a57-a7e1-5e81ec3aa8c2', 'f54d2838-ff5a-4259-8560-c50f042375ab');
INSERT INTO keycloak.associated_policy VALUES ('73c7d9cb-5b6a-4a57-a7e1-5e81ec3aa8c2', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');
INSERT INTO keycloak.associated_policy VALUES ('73c7d9cb-5b6a-4a57-a7e1-5e81ec3aa8c2', '53667455-8734-49e0-9e11-db6aacce6cbf');
INSERT INTO keycloak.associated_policy VALUES ('2d99ec81-c6a8-4949-b129-0bc425126832', 'f54d2838-ff5a-4259-8560-c50f042375ab');
INSERT INTO keycloak.associated_policy VALUES ('2d99ec81-c6a8-4949-b129-0bc425126832', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');
INSERT INTO keycloak.associated_policy VALUES ('2d99ec81-c6a8-4949-b129-0bc425126832', '53667455-8734-49e0-9e11-db6aacce6cbf');
INSERT INTO keycloak.associated_policy VALUES ('48345f52-292b-474c-acd3-1cc56513aa4f', '56cc0301-6b50-4bb1-b870-514669458695');
INSERT INTO keycloak.associated_policy VALUES ('68061593-00a9-46ae-b3a5-b21333100a20', 'f54d2838-ff5a-4259-8560-c50f042375ab');
INSERT INTO keycloak.associated_policy VALUES ('68061593-00a9-46ae-b3a5-b21333100a20', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');
INSERT INTO keycloak.associated_policy VALUES ('69a3bcf1-89b4-4602-bc26-9d34eb5d9c55', 'f54d2838-ff5a-4259-8560-c50f042375ab');
INSERT INTO keycloak.associated_policy VALUES ('69a3bcf1-89b4-4602-bc26-9d34eb5d9c55', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');
INSERT INTO keycloak.associated_policy VALUES ('69a3bcf1-89b4-4602-bc26-9d34eb5d9c55', '56cc0301-6b50-4bb1-b870-514669458695');
INSERT INTO keycloak.associated_policy VALUES ('69a3bcf1-89b4-4602-bc26-9d34eb5d9c55', '53667455-8734-49e0-9e11-db6aacce6cbf');
INSERT INTO keycloak.associated_policy VALUES ('df6b4650-ee44-4f35-b5fe-1891afe29334', 'f54d2838-ff5a-4259-8560-c50f042375ab');
INSERT INTO keycloak.associated_policy VALUES ('df6b4650-ee44-4f35-b5fe-1891afe29334', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');
INSERT INTO keycloak.associated_policy VALUES ('dbc609b4-6662-4067-b552-7ff079e1d7ed', 'f54d2838-ff5a-4259-8560-c50f042375ab');
INSERT INTO keycloak.associated_policy VALUES ('dbc609b4-6662-4067-b552-7ff079e1d7ed', '0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7');


--
-- TOC entry 3869 (class 0 OID 18828)
-- Dependencies: 246
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.authentication_execution VALUES ('d77a0585-0c93-4402-9a28-09bc3a7a53da', NULL, 'auth-cookie', 'master', '51153253-713c-43b3-8001-9e723e7074a1', 2, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('85a69549-090e-4ee5-ac72-3ccb0612c7cb', NULL, 'auth-spnego', 'master', '51153253-713c-43b3-8001-9e723e7074a1', 3, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('0a494e34-974d-4a27-a654-41e443fd19aa', NULL, 'identity-provider-redirector', 'master', '51153253-713c-43b3-8001-9e723e7074a1', 2, 25, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('3403dd1a-7c68-4c0c-9244-d47f031f0277', NULL, NULL, 'master', '51153253-713c-43b3-8001-9e723e7074a1', 2, 30, true, '4f8d2b1c-a14f-4f29-972c-787fa59a669e', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('398ba1d3-d602-492e-aa57-e5589094d443', NULL, 'auth-username-password-form', 'master', '4f8d2b1c-a14f-4f29-972c-787fa59a669e', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('9c0993ae-aa3b-4115-91e2-c76b158628e4', NULL, NULL, 'master', '4f8d2b1c-a14f-4f29-972c-787fa59a669e', 1, 20, true, '476ba29f-2843-4691-a7ad-889af8d6fa33', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('b3068133-2e5d-4f71-b8c6-6f839917160d', NULL, 'conditional-user-configured', 'master', '476ba29f-2843-4691-a7ad-889af8d6fa33', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('ee846763-7f69-46d3-b198-7128e01ba35e', NULL, 'auth-otp-form', 'master', '476ba29f-2843-4691-a7ad-889af8d6fa33', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('0600c8c0-eab7-49fb-9990-01aed8cc3526', NULL, 'direct-grant-validate-username', 'master', '9a6d37ac-44ed-4e6d-9ab2-5a2b7ae6ce52', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('c71b272a-aa38-4143-a88f-d834061fb2e1', NULL, 'direct-grant-validate-password', 'master', '9a6d37ac-44ed-4e6d-9ab2-5a2b7ae6ce52', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('d05b271c-940c-4584-b85a-95cd9b5d1b0a', NULL, NULL, 'master', '9a6d37ac-44ed-4e6d-9ab2-5a2b7ae6ce52', 1, 30, true, '1d5ca983-5247-41ee-8ed4-5b371bcbc668', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('446907ff-406b-4954-9d19-f575c0a08070', NULL, 'conditional-user-configured', 'master', '1d5ca983-5247-41ee-8ed4-5b371bcbc668', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('eaac912f-8b7a-421e-8cee-7c0494f8dbc7', NULL, 'direct-grant-validate-otp', 'master', '1d5ca983-5247-41ee-8ed4-5b371bcbc668', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('b43c9ca7-f055-45db-80b3-723f4574635a', NULL, 'registration-page-form', 'master', '05228812-ac42-4187-82fd-0dd975978225', 0, 10, true, '585fe2aa-f333-415c-b722-bb24f84a82c7', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('b730a9d7-0734-4138-8d72-18f120232e3c', NULL, 'registration-user-creation', 'master', '585fe2aa-f333-415c-b722-bb24f84a82c7', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('34db150d-2c65-4787-908b-0eba159ef672', NULL, 'registration-profile-action', 'master', '585fe2aa-f333-415c-b722-bb24f84a82c7', 0, 40, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('649143d4-51f9-4624-9f08-a7d908e2dfe0', NULL, 'registration-password-action', 'master', '585fe2aa-f333-415c-b722-bb24f84a82c7', 0, 50, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('fcbe50bb-3a83-485e-80da-f34ed107c5c8', NULL, 'registration-recaptcha-action', 'master', '585fe2aa-f333-415c-b722-bb24f84a82c7', 3, 60, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('7fcb07a8-5b1c-4885-a72e-f9e4560a76a8', NULL, 'reset-credentials-choose-user', 'master', '194d8beb-af77-41de-b5db-3531509e95ba', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('8b256c99-afb3-441a-ba9c-6c5937600a8f', NULL, 'reset-credential-email', 'master', '194d8beb-af77-41de-b5db-3531509e95ba', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('d7e2d1de-b869-44df-aadd-05c2252c340a', NULL, 'reset-password', 'master', '194d8beb-af77-41de-b5db-3531509e95ba', 0, 30, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('a27a37cd-f520-45cf-9d19-46eb0e68a1a4', NULL, NULL, 'master', '194d8beb-af77-41de-b5db-3531509e95ba', 1, 40, true, '345bf2d6-4f81-4733-a3a1-d1c3b9dcac4e', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('9e10e005-3f01-48b1-a9d3-49ae0d901b1c', NULL, 'conditional-user-configured', 'master', '345bf2d6-4f81-4733-a3a1-d1c3b9dcac4e', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('b3458297-3c5e-4af8-a1cf-82435471436d', NULL, 'reset-otp', 'master', '345bf2d6-4f81-4733-a3a1-d1c3b9dcac4e', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('2cb0e9f4-f16c-4c29-875d-8cb591baf2a9', NULL, 'client-secret', 'master', 'c338ee23-cccd-4708-ba1b-b709f6e5a17e', 2, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('f9ce5431-02f9-4435-8c17-ff046aaff3d8', NULL, 'client-jwt', 'master', 'c338ee23-cccd-4708-ba1b-b709f6e5a17e', 2, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('cc3a0b06-7c15-41d3-a060-43ac074b63a2', NULL, 'client-secret-jwt', 'master', 'c338ee23-cccd-4708-ba1b-b709f6e5a17e', 2, 30, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('0c023f3c-1d9c-4321-b4d2-eb0db86588c6', NULL, 'client-x509', 'master', 'c338ee23-cccd-4708-ba1b-b709f6e5a17e', 2, 40, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('a16766cd-5eb5-494a-9883-8b4c54e29735', NULL, 'idp-review-profile', 'master', '8ac9c894-3ddf-4a9c-981c-792574cf5caa', 0, 10, false, NULL, '6f49a1c4-d520-4d59-93ec-2cc634d629b7');
INSERT INTO keycloak.authentication_execution VALUES ('3f70349f-6f01-435d-816b-8a62aec89756', NULL, NULL, 'master', '8ac9c894-3ddf-4a9c-981c-792574cf5caa', 0, 20, true, '9bdf87a4-5db6-44c4-b521-2ad0e99309cb', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('621a3352-d8dc-47f7-b966-535a4658e8a5', NULL, 'idp-create-user-if-unique', 'master', '9bdf87a4-5db6-44c4-b521-2ad0e99309cb', 2, 10, false, NULL, '7bf4a1ae-55af-4da3-9f94-cacdf3777533');
INSERT INTO keycloak.authentication_execution VALUES ('d4be5a86-4eae-4a34-b292-4b8c18745112', NULL, NULL, 'master', '9bdf87a4-5db6-44c4-b521-2ad0e99309cb', 2, 20, true, '6ee479fa-d8b1-4dce-9da5-176749acdbf9', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('546d44ca-d5b0-417e-aed8-08c5a0a10a1e', NULL, 'idp-confirm-link', 'master', '6ee479fa-d8b1-4dce-9da5-176749acdbf9', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('153d8a1c-3f3b-4c45-82cd-41e2d52b7237', NULL, NULL, 'master', '6ee479fa-d8b1-4dce-9da5-176749acdbf9', 0, 20, true, 'd8a24753-4020-46b1-bf4f-86d8bde2745b', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('fb9ef50e-cb48-440f-a273-9a9f49ea5cc5', NULL, 'idp-email-verification', 'master', 'd8a24753-4020-46b1-bf4f-86d8bde2745b', 2, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('e81d2710-83d0-47b1-aceb-b2ee4469984f', NULL, NULL, 'master', 'd8a24753-4020-46b1-bf4f-86d8bde2745b', 2, 20, true, '064cbb45-dceb-420a-aefc-8265b8dc50fc', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('f17ecf7f-b2a9-4f23-876f-b853be496348', NULL, 'idp-username-password-form', 'master', '064cbb45-dceb-420a-aefc-8265b8dc50fc', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('782ad896-3b87-4f1f-8d02-fe89c633a74e', NULL, NULL, 'master', '064cbb45-dceb-420a-aefc-8265b8dc50fc', 1, 20, true, '31e17ad1-798b-4690-9491-3e0a8154185c', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('449913b7-d5eb-4dd7-afe2-451a84fcede3', NULL, 'conditional-user-configured', 'master', '31e17ad1-798b-4690-9491-3e0a8154185c', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('d20bd77c-18f4-4243-8d89-8a3e86754931', NULL, 'auth-otp-form', 'master', '31e17ad1-798b-4690-9491-3e0a8154185c', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('991630fa-cc5a-4753-aba6-cd53cf4cbfe7', NULL, 'http-basic-authenticator', 'master', '4377200d-f73a-4687-8c08-ff77b82b724c', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('865c5347-c7b9-46e2-adbb-13bd2bd5bcf7', NULL, 'docker-http-basic-authenticator', 'master', '3cd617be-4805-4d68-a77b-46e8320511ff', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('9460bdc0-7256-453c-8983-0f1988d5fccf', NULL, 'no-cookie-redirect', 'master', 'ddce3ae2-0153-4fd2-b351-a8311c96a42e', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('988fd03a-3311-4010-b025-f2b0128c2d3a', NULL, NULL, 'master', 'ddce3ae2-0153-4fd2-b351-a8311c96a42e', 0, 20, true, '0d50c2a3-aecf-4020-85cd-63a14dd56e97', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('70d86901-5f75-4746-8a8a-d97afec9a906', NULL, 'basic-auth', 'master', '0d50c2a3-aecf-4020-85cd-63a14dd56e97', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('f0efa6ea-d24a-4f0b-9db2-2c9760bd7456', NULL, 'basic-auth-otp', 'master', '0d50c2a3-aecf-4020-85cd-63a14dd56e97', 3, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('e88b7a9b-7e89-4f27-a786-f98c20d2b9c6', NULL, 'auth-spnego', 'master', '0d50c2a3-aecf-4020-85cd-63a14dd56e97', 3, 30, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('47798141-8bdc-416e-97f2-b7a7deb4eefe', NULL, 'idp-email-verification', 'appcket', 'cf66e0df-ebf2-4f6e-a73e-976e49957ca0', 2, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('b7461715-7699-460a-a8f5-5b69239c81d4', NULL, NULL, 'appcket', 'cf66e0df-ebf2-4f6e-a73e-976e49957ca0', 2, 20, true, '81b759d4-3e24-40fd-9758-c451ea457f04', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('cd72f2e2-b678-40d8-9726-4d93176e5e05', NULL, 'basic-auth', 'appcket', '56001572-3902-4b1b-99e2-500fd1ac92c6', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('e630c636-3094-4381-931e-9a7d79b9d700', NULL, 'basic-auth-otp', 'appcket', '56001572-3902-4b1b-99e2-500fd1ac92c6', 3, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('32926aff-e3ec-4bd6-adc3-79a26112f821', NULL, 'auth-spnego', 'appcket', '56001572-3902-4b1b-99e2-500fd1ac92c6', 3, 30, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('19d4fbb1-c45e-460e-8363-5416a64366ef', NULL, 'conditional-user-configured', 'appcket', 'eefe3ca4-259a-4117-8034-0279fb1ad289', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('780cdac0-0a20-403d-a33e-c4cd731c3012', NULL, 'auth-otp-form', 'appcket', 'eefe3ca4-259a-4117-8034-0279fb1ad289', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('a6692088-300d-4e3f-8f29-4371674454e0', NULL, 'conditional-user-configured', 'appcket', 'e876b6f6-b587-46b4-9984-69e31ecc2eba', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('bb554a65-4257-4e69-b0bb-946e43d4f1ad', NULL, 'direct-grant-validate-otp', 'appcket', 'e876b6f6-b587-46b4-9984-69e31ecc2eba', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('0b7499ae-4bd5-4069-9397-15349feec7ea', NULL, 'conditional-user-configured', 'appcket', 'aaf3c6e6-a5c5-4ed4-a684-ea1b9fae821d', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('0b3a943d-c95c-44a7-8a2e-0c10ef6b96ac', NULL, 'auth-otp-form', 'appcket', 'aaf3c6e6-a5c5-4ed4-a684-ea1b9fae821d', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('513f6a9b-1360-44b6-a03b-d1928df19f86', NULL, 'idp-confirm-link', 'appcket', '2ff71233-7dc4-4bf2-b71b-643480901197', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('e629d6a6-55b7-4296-82c1-ebc81bdbc629', NULL, NULL, 'appcket', '2ff71233-7dc4-4bf2-b71b-643480901197', 0, 20, true, 'cf66e0df-ebf2-4f6e-a73e-976e49957ca0', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('a161a3cd-8726-44f6-8526-2c6555133c04', NULL, 'conditional-user-configured', 'appcket', 'c0124e0d-937c-4fba-9514-1577c2e8897f', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('a2097207-e1e1-4dd7-a06a-910bf19d4a57', NULL, 'reset-otp', 'appcket', 'c0124e0d-937c-4fba-9514-1577c2e8897f', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('c08b137c-c0ad-4cb3-bf4a-4d194dda7158', NULL, 'idp-create-user-if-unique', 'appcket', 'eb6eea0d-4610-443b-885b-93b1717177ac', 2, 10, false, NULL, '96999794-fc18-422f-ba9b-665a6e913352');
INSERT INTO keycloak.authentication_execution VALUES ('8307f212-dde8-4d36-8f31-0081f4dfc4a5', NULL, NULL, 'appcket', 'eb6eea0d-4610-443b-885b-93b1717177ac', 2, 20, true, '2ff71233-7dc4-4bf2-b71b-643480901197', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('63f0c9e9-63dc-44d3-9782-2b6be4ecdba9', NULL, 'idp-username-password-form', 'appcket', '81b759d4-3e24-40fd-9758-c451ea457f04', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('18220f70-2178-4455-9c3b-150a0958d28b', NULL, NULL, 'appcket', '81b759d4-3e24-40fd-9758-c451ea457f04', 1, 20, true, 'aaf3c6e6-a5c5-4ed4-a684-ea1b9fae821d', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('f1659738-fe1b-47ae-b2e7-d6a815737409', NULL, 'auth-cookie', 'appcket', '5f1c9ea0-903e-4bda-8c25-234ece43d563', 2, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('bc95042e-fa82-45c5-8129-eac25d6ba0f9', NULL, 'auth-spnego', 'appcket', '5f1c9ea0-903e-4bda-8c25-234ece43d563', 3, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('85ab7ab6-4d30-4b7c-863e-0ccb53f8d27f', NULL, 'identity-provider-redirector', 'appcket', '5f1c9ea0-903e-4bda-8c25-234ece43d563', 2, 25, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('6e69643e-2339-4b85-a2c9-f13fafdc03a9', NULL, NULL, 'appcket', '5f1c9ea0-903e-4bda-8c25-234ece43d563', 2, 30, true, 'ae5a7c6d-5dbc-46df-8a45-ac57365b0683', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('d8f8f556-0d9b-4084-bce3-ac9110ae51c4', NULL, 'client-secret', 'appcket', 'eff54ebc-cab5-4891-8b1c-fb3cb05c9548', 2, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('42dbb2ea-2e6e-4550-b542-f44d346031a3', NULL, 'client-jwt', 'appcket', 'eff54ebc-cab5-4891-8b1c-fb3cb05c9548', 2, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('9a40063b-0c2c-419b-a1a4-57cbfff8c61a', NULL, 'client-secret-jwt', 'appcket', 'eff54ebc-cab5-4891-8b1c-fb3cb05c9548', 2, 30, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('8b1f2b7d-b0f6-46e4-92cf-15f8b2065659', NULL, 'client-x509', 'appcket', 'eff54ebc-cab5-4891-8b1c-fb3cb05c9548', 2, 40, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('224ab758-3639-4833-978f-c2b77bfdc285', NULL, 'direct-grant-validate-username', 'appcket', '4de4c054-7937-4375-a52f-850a8de18890', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('482cd875-c31b-4568-bca9-685abb03a81e', NULL, 'direct-grant-validate-password', 'appcket', '4de4c054-7937-4375-a52f-850a8de18890', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('b5396d91-aec7-42db-b9b4-b7cd2df67803', NULL, NULL, 'appcket', '4de4c054-7937-4375-a52f-850a8de18890', 1, 30, true, 'e876b6f6-b587-46b4-9984-69e31ecc2eba', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('e9119b95-e3a3-436f-8e7f-f9ef21d87f6c', NULL, 'docker-http-basic-authenticator', 'appcket', '168edbbe-5ef2-45f9-8e63-211aaa6888d0', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('5bfd58fa-b6bb-420d-b51c-6e758e6400b0', NULL, 'idp-review-profile', 'appcket', '84972982-699d-4860-b241-cb735eb12c4b', 0, 10, false, NULL, 'bb812465-c4b7-43bc-8ccd-e32def694530');
INSERT INTO keycloak.authentication_execution VALUES ('db95853c-a8dc-4bdf-b117-0025351cc2d8', NULL, NULL, 'appcket', '84972982-699d-4860-b241-cb735eb12c4b', 0, 20, true, 'eb6eea0d-4610-443b-885b-93b1717177ac', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('cc045b9d-afbc-47b1-9c9d-5dd0db3ec829', NULL, 'auth-username-password-form', 'appcket', 'ae5a7c6d-5dbc-46df-8a45-ac57365b0683', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('851b4ccb-ea45-42c0-8146-3aaf009dbddc', NULL, NULL, 'appcket', 'ae5a7c6d-5dbc-46df-8a45-ac57365b0683', 1, 20, true, 'eefe3ca4-259a-4117-8034-0279fb1ad289', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('766b3c58-6523-4d72-8e65-3a0adb700591', NULL, 'no-cookie-redirect', 'appcket', 'ebfabea5-d302-4ecf-a40a-2f30aaf755cf', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('35f8200c-8476-4738-97ae-3a9ae83ee5cd', NULL, NULL, 'appcket', 'ebfabea5-d302-4ecf-a40a-2f30aaf755cf', 0, 20, true, '56001572-3902-4b1b-99e2-500fd1ac92c6', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('da99e7ce-3799-4547-8685-362838633d52', NULL, 'registration-page-form', 'appcket', '55bb6d26-e641-4b65-8205-f744ea5c2f11', 0, 10, true, '8e0a8e51-6d3a-4a66-bb23-33ae50642796', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('9d6e9d47-1518-4610-af4b-4cceb905a877', NULL, 'registration-user-creation', 'appcket', '8e0a8e51-6d3a-4a66-bb23-33ae50642796', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('4d53cbc8-3f0f-4eb1-9bb1-4dd52e5d3a1c', NULL, 'registration-profile-action', 'appcket', '8e0a8e51-6d3a-4a66-bb23-33ae50642796', 0, 40, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('84f97a47-9576-4d99-bb5f-6f1e4e032b5c', NULL, 'registration-password-action', 'appcket', '8e0a8e51-6d3a-4a66-bb23-33ae50642796', 0, 50, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('9e4d00c6-c116-4705-bf40-2bc27d9ef675', NULL, 'registration-recaptcha-action', 'appcket', '8e0a8e51-6d3a-4a66-bb23-33ae50642796', 3, 60, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('d98683b7-8564-4a6a-b548-8c2313ce3744', NULL, 'reset-credentials-choose-user', 'appcket', '24484497-8dcd-467d-8695-173911642ef9', 0, 10, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('7a246d34-a601-478a-9e0b-9507ebb0ef95', NULL, 'reset-credential-email', 'appcket', '24484497-8dcd-467d-8695-173911642ef9', 0, 20, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('d296f630-74c6-4cef-8892-753d659ec802', NULL, 'reset-password', 'appcket', '24484497-8dcd-467d-8695-173911642ef9', 0, 30, false, NULL, NULL);
INSERT INTO keycloak.authentication_execution VALUES ('0ca2aa70-9c8a-418a-a085-87a650df6f39', NULL, NULL, 'appcket', '24484497-8dcd-467d-8695-173911642ef9', 1, 40, true, 'c0124e0d-937c-4fba-9514-1577c2e8897f', NULL);
INSERT INTO keycloak.authentication_execution VALUES ('e20bafd3-97a6-4a70-aa25-2e69535425cb', NULL, 'http-basic-authenticator', 'appcket', '95187219-4901-462a-8ea3-7ea1f51525e5', 0, 10, false, NULL, NULL);


--
-- TOC entry 3868 (class 0 OID 18822)
-- Dependencies: 245
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.authentication_flow VALUES ('51153253-713c-43b3-8001-9e723e7074a1', 'browser', 'browser based authentication', 'master', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('4f8d2b1c-a14f-4f29-972c-787fa59a669e', 'forms', 'Username, password, otp and other auth forms.', 'master', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('476ba29f-2843-4691-a7ad-889af8d6fa33', 'Browser - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'master', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('9a6d37ac-44ed-4e6d-9ab2-5a2b7ae6ce52', 'direct grant', 'OpenID Connect Resource Owner Grant', 'master', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('1d5ca983-5247-41ee-8ed4-5b371bcbc668', 'Direct Grant - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'master', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('05228812-ac42-4187-82fd-0dd975978225', 'registration', 'registration flow', 'master', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('585fe2aa-f333-415c-b722-bb24f84a82c7', 'registration form', 'registration form', 'master', 'form-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('194d8beb-af77-41de-b5db-3531509e95ba', 'reset credentials', 'Reset credentials for a user if they forgot their password or something', 'master', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('345bf2d6-4f81-4733-a3a1-d1c3b9dcac4e', 'Reset - Conditional OTP', 'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.', 'master', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('c338ee23-cccd-4708-ba1b-b709f6e5a17e', 'clients', 'Base authentication for clients', 'master', 'client-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('8ac9c894-3ddf-4a9c-981c-792574cf5caa', 'first broker login', 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account', 'master', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('9bdf87a4-5db6-44c4-b521-2ad0e99309cb', 'User creation or linking', 'Flow for the existing/non-existing user alternatives', 'master', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('6ee479fa-d8b1-4dce-9da5-176749acdbf9', 'Handle Existing Account', 'Handle what to do if there is existing account with same email/username like authenticated identity provider', 'master', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('d8a24753-4020-46b1-bf4f-86d8bde2745b', 'Account verification options', 'Method with which to verity the existing account', 'master', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('064cbb45-dceb-420a-aefc-8265b8dc50fc', 'Verify Existing Account by Re-authentication', 'Reauthentication of existing account', 'master', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('31e17ad1-798b-4690-9491-3e0a8154185c', 'First broker login - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'master', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('4377200d-f73a-4687-8c08-ff77b82b724c', 'saml ecp', 'SAML ECP Profile Authentication Flow', 'master', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('3cd617be-4805-4d68-a77b-46e8320511ff', 'docker auth', 'Used by Docker clients to authenticate against the IDP', 'master', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('ddce3ae2-0153-4fd2-b351-a8311c96a42e', 'http challenge', 'An authentication flow based on challenge-response HTTP Authentication Schemes', 'master', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('0d50c2a3-aecf-4020-85cd-63a14dd56e97', 'Authentication Options', 'Authentication options.', 'master', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('cf66e0df-ebf2-4f6e-a73e-976e49957ca0', 'Account verification options', 'Method with which to verity the existing account', 'appcket', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('56001572-3902-4b1b-99e2-500fd1ac92c6', 'Authentication Options', 'Authentication options.', 'appcket', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('eefe3ca4-259a-4117-8034-0279fb1ad289', 'Browser - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'appcket', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('e876b6f6-b587-46b4-9984-69e31ecc2eba', 'Direct Grant - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'appcket', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('aaf3c6e6-a5c5-4ed4-a684-ea1b9fae821d', 'First broker login - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'appcket', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('2ff71233-7dc4-4bf2-b71b-643480901197', 'Handle Existing Account', 'Handle what to do if there is existing account with same email/username like authenticated identity provider', 'appcket', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('c0124e0d-937c-4fba-9514-1577c2e8897f', 'Reset - Conditional OTP', 'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.', 'appcket', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('eb6eea0d-4610-443b-885b-93b1717177ac', 'User creation or linking', 'Flow for the existing/non-existing user alternatives', 'appcket', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('81b759d4-3e24-40fd-9758-c451ea457f04', 'Verify Existing Account by Re-authentication', 'Reauthentication of existing account', 'appcket', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('5f1c9ea0-903e-4bda-8c25-234ece43d563', 'browser', 'browser based authentication', 'appcket', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('eff54ebc-cab5-4891-8b1c-fb3cb05c9548', 'clients', 'Base authentication for clients', 'appcket', 'client-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('4de4c054-7937-4375-a52f-850a8de18890', 'direct grant', 'OpenID Connect Resource Owner Grant', 'appcket', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('168edbbe-5ef2-45f9-8e63-211aaa6888d0', 'docker auth', 'Used by Docker clients to authenticate against the IDP', 'appcket', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('84972982-699d-4860-b241-cb735eb12c4b', 'first broker login', 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account', 'appcket', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('ae5a7c6d-5dbc-46df-8a45-ac57365b0683', 'forms', 'Username, password, otp and other auth forms.', 'appcket', 'basic-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('ebfabea5-d302-4ecf-a40a-2f30aaf755cf', 'http challenge', 'An authentication flow based on challenge-response HTTP Authentication Schemes', 'appcket', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('55bb6d26-e641-4b65-8205-f744ea5c2f11', 'registration', 'registration flow', 'appcket', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('8e0a8e51-6d3a-4a66-bb23-33ae50642796', 'registration form', 'registration form', 'appcket', 'form-flow', false, true);
INSERT INTO keycloak.authentication_flow VALUES ('24484497-8dcd-467d-8695-173911642ef9', 'reset credentials', 'Reset credentials for a user if they forgot their password or something', 'appcket', 'basic-flow', true, true);
INSERT INTO keycloak.authentication_flow VALUES ('95187219-4901-462a-8ea3-7ea1f51525e5', 'saml ecp', 'SAML ECP Profile Authentication Flow', 'appcket', 'basic-flow', true, true);


--
-- TOC entry 3867 (class 0 OID 18816)
-- Dependencies: 244
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.authenticator_config VALUES ('6f49a1c4-d520-4d59-93ec-2cc634d629b7', 'review profile config', 'master');
INSERT INTO keycloak.authenticator_config VALUES ('7bf4a1ae-55af-4da3-9f94-cacdf3777533', 'create unique user config', 'master');
INSERT INTO keycloak.authenticator_config VALUES ('96999794-fc18-422f-ba9b-665a6e913352', 'create unique user config', 'appcket');
INSERT INTO keycloak.authenticator_config VALUES ('bb812465-c4b7-43bc-8ccd-e32def694530', 'review profile config', 'appcket');


--
-- TOC entry 3870 (class 0 OID 18833)
-- Dependencies: 247
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.authenticator_config_entry VALUES ('6f49a1c4-d520-4d59-93ec-2cc634d629b7', 'missing', 'update.profile.on.first.login');
INSERT INTO keycloak.authenticator_config_entry VALUES ('7bf4a1ae-55af-4da3-9f94-cacdf3777533', 'false', 'require.password.update.after.registration');
INSERT INTO keycloak.authenticator_config_entry VALUES ('96999794-fc18-422f-ba9b-665a6e913352', 'false', 'require.password.update.after.registration');
INSERT INTO keycloak.authenticator_config_entry VALUES ('bb812465-c4b7-43bc-8ccd-e32def694530', 'missing', 'update.profile.on.first.login');


--
-- TOC entry 3896 (class 0 OID 19288)
-- Dependencies: 273
-- Data for Name: broker_link; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3827 (class 0 OID 18165)
-- Dependencies: 204
-- Data for Name: client; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.client VALUES ('e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', true, false, 'master-realm', 0, false, NULL, NULL, true, NULL, false, 'master', NULL, 0, false, false, 'master Realm', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client VALUES ('b76c70fe-8825-46a4-bd41-b8f291e910c5', true, false, 'account', 0, true, NULL, '/realms/master/account/', false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_account}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client VALUES ('567f4fd5-d705-46fc-9956-31901fd76939', true, false, 'account-console', 0, true, NULL, '/realms/master/account/', false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_account-console}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client VALUES ('b947d8c7-5d45-4789-8933-cbe58c97d415', true, false, 'broker', 0, false, NULL, NULL, true, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_broker}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client VALUES ('5b745968-9295-482c-b42f-d11087e1790b', true, false, 'security-admin-console', 0, true, NULL, '/admin/master/console/', false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_security-admin-console}', false, 'client-secret', '${authAdminUrl}', NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client VALUES ('c6e9839d-b475-44bd-aec8-9ee1d4434c89', true, false, 'admin-cli', 0, true, NULL, NULL, false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_admin-cli}', false, 'client-secret', NULL, NULL, NULL, false, false, true, false);
INSERT INTO keycloak.client VALUES ('870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', true, false, 'appcket-realm', 0, false, NULL, NULL, true, NULL, false, 'master', NULL, 0, false, false, 'appcket Realm', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client VALUES ('e801cbf0-541f-4466-80e1-fcce640df2a8', true, false, 'account', 0, false, '**********', '/realms/appcket/account/', false, NULL, false, 'appcket', 'openid-connect', 0, false, false, '${client_account}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client VALUES ('26f802c3-b7af-4e78-b785-40493ae2483a', true, false, 'account-console', 0, true, '**********', '/realms/appcket/account/', false, NULL, false, 'appcket', 'openid-connect', 0, false, false, '${client_account-console}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', true, true, 'appcket_app', 0, true, NULL, '/', false, 'https://app.appcket.localhost', false, 'appcket', 'openid-connect', -1, false, false, 'Appcket App', false, 'client-secret', 'https://app.appcket.localhost', NULL, NULL, true, false, true, false);
INSERT INTO keycloak.client VALUES ('544076b9-bf22-4731-8d85-2ddc0edbd41e', true, false, 'admin-cli', 0, true, '**********', NULL, false, NULL, false, 'appcket', 'openid-connect', 0, false, false, '${client_admin-cli}', false, 'client-secret', NULL, NULL, NULL, false, false, true, false);
INSERT INTO keycloak.client VALUES ('70da96f3-abee-4ade-a7f3-d22e04437a0a', true, false, 'broker', 0, false, '**********', NULL, false, NULL, false, 'appcket', 'openid-connect', 0, false, false, '${client_broker}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client VALUES ('5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, false, 'realm-management', 0, false, '**********', NULL, true, NULL, false, 'appcket', 'openid-connect', 0, false, false, '${client_realm-management}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client VALUES ('4dd4c360-d5b9-4730-8091-78b394cea334', true, false, 'security-admin-console', 0, true, '**********', '/admin/appcket/console/', false, NULL, false, 'appcket', 'openid-connect', 0, false, false, '${client_security-admin-console}', false, 'client-secret', '${authAdminUrl}', NULL, NULL, true, false, false, false);
INSERT INTO keycloak.client VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', true, true, 'appcket_api', 0, false, 'ca9b4ce0-f152-46ff-b672-48c5a9fd678b', NULL, false, 'https://api.appcket.localhost', false, 'appcket', 'openid-connect', -1, false, false, 'Appcket API', true, 'client-secret', 'https://api.appcket.localhost', NULL, NULL, true, false, true, false);


--
-- TOC entry 3850 (class 0 OID 18539)
-- Dependencies: 227
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.client_attributes VALUES ('567f4fd5-d705-46fc-9956-31901fd76939', 'S256', 'pkce.code.challenge.method');
INSERT INTO keycloak.client_attributes VALUES ('5b745968-9295-482c-b42f-d11087e1790b', 'S256', 'pkce.code.challenge.method');
INSERT INTO keycloak.client_attributes VALUES ('26f802c3-b7af-4e78-b785-40493ae2483a', 'S256', 'pkce.code.challenge.method');
INSERT INTO keycloak.client_attributes VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'false', 'saml.assertion.signature');
INSERT INTO keycloak.client_attributes VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', '28800', 'access.token.lifespan');
INSERT INTO keycloak.client_attributes VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'false', 'saml.multivalued.roles');
INSERT INTO keycloak.client_attributes VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'false', 'saml.force.post.binding');
INSERT INTO keycloak.client_attributes VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'false', 'saml.encrypt');
INSERT INTO keycloak.client_attributes VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'false', 'saml.server.signature');
INSERT INTO keycloak.client_attributes VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'false', 'saml.server.signature.keyinfo.ext');
INSERT INTO keycloak.client_attributes VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'false', 'exclude.session.state.from.auth.response');
INSERT INTO keycloak.client_attributes VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'false', 'saml_force_name_id_format');
INSERT INTO keycloak.client_attributes VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'false', 'saml.client.signature');
INSERT INTO keycloak.client_attributes VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'false', 'tls.client.certificate.bound.access.tokens');
INSERT INTO keycloak.client_attributes VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'false', 'saml.authnstatement');
INSERT INTO keycloak.client_attributes VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'false', 'display.on.consent.screen');
INSERT INTO keycloak.client_attributes VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'false', 'saml.onetimeuse.condition');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'false', 'saml.assertion.signature');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'false', 'saml.multivalued.roles');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'false', 'saml.force.post.binding');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'false', 'saml.encrypt');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'false', 'saml.server.signature');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'false', 'saml.server.signature.keyinfo.ext');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'false', 'exclude.session.state.from.auth.response');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'false', 'saml_force_name_id_format');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'false', 'saml.client.signature');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'false', 'tls.client.certificate.bound.access.tokens');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'false', 'saml.authnstatement');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'false', 'display.on.consent.screen');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'false', 'saml.onetimeuse.condition');
INSERT INTO keycloak.client_attributes VALUES ('4dd4c360-d5b9-4730-8091-78b394cea334', 'S256', 'pkce.code.challenge.method');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'false', 'saml.artifact.binding');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'false', 'oauth2.device.authorization.grant.enabled');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'false', 'oidc.ciba.grant.enabled');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'true', 'use.refresh.tokens');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'false', 'id.token.as.detached.signature');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'false', 'require.pushed.authorization.requests');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'false', 'client_credentials.use_refresh_token');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'false', 'backchannel.logout.session.required');
INSERT INTO keycloak.client_attributes VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'false', 'backchannel.logout.revoke.offline.tokens');


--
-- TOC entry 3907 (class 0 OID 19547)
-- Dependencies: 284
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.client_auth_flow_bindings VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', '5f1c9ea0-903e-4bda-8c25-234ece43d563', 'browser');
INSERT INTO keycloak.client_auth_flow_bindings VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', '4de4c054-7937-4375-a52f-850a8de18890', 'direct_grant');


--
-- TOC entry 3906 (class 0 OID 19422)
-- Dependencies: 283
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3852 (class 0 OID 18551)
-- Dependencies: 229
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3884 (class 0 OID 19071)
-- Dependencies: 261
-- Data for Name: client_scope; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.client_scope VALUES ('f4a49c56-0dfe-4be4-8176-4ee226f1f09f', 'offline_access', 'master', 'OpenID Connect built-in scope: offline_access', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('c300fd83-f791-4986-8ed7-bb3bb4520e36', 'role_list', 'master', 'SAML role list', 'saml');
INSERT INTO keycloak.client_scope VALUES ('a34ae2c0-3ca3-43d7-b8e4-bd7b277dfdae', 'profile', 'master', 'OpenID Connect built-in scope: profile', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('0d6aeed8-8d73-4978-bc5e-16de7f6f399d', 'email', 'master', 'OpenID Connect built-in scope: email', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('e765c4b2-81f4-472f-b26e-2fcec6f21c18', 'address', 'master', 'OpenID Connect built-in scope: address', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('c6d8e038-d6a2-44a0-875d-d82cedab755f', 'phone', 'master', 'OpenID Connect built-in scope: phone', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('d06cb9d2-8cc3-4ee2-b0d3-50e7b4599b00', 'roles', 'master', 'OpenID Connect scope for add user roles to the access token', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('61d1cc86-30fb-44e6-8a4c-bb300d512001', 'web-origins', 'master', 'OpenID Connect scope for add allowed web origins to the access token', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('0c087984-3399-4738-8c0c-14f0b6483d8e', 'microprofile-jwt', 'master', 'Microprofile - JWT built-in scope', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('1ddb5c58-3c5b-43bc-ae48-ba8947a6c108', 'offline_access', 'appcket', 'OpenID Connect built-in scope: offline_access', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('bed9e481-a783-4f6c-bd5a-f79f5d189ee6', 'role_list', 'appcket', 'SAML role list', 'saml');
INSERT INTO keycloak.client_scope VALUES ('aee86bba-572b-4335-8f5b-c9969c70cbce', 'profile', 'appcket', 'OpenID Connect built-in scope: profile', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('63984129-44c9-4bd1-97d1-da0df3407112', 'email', 'appcket', 'OpenID Connect built-in scope: email', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('b2414a14-1f25-4d4b-9162-de66eeb6652d', 'address', 'appcket', 'OpenID Connect built-in scope: address', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('4709e0fb-184a-4b47-a804-ae1556e53a73', 'phone', 'appcket', 'OpenID Connect built-in scope: phone', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('2b5c02f3-e7a9-4455-a505-9fef19838927', 'roles', 'appcket', 'OpenID Connect scope for add user roles to the access token', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('52312b11-3e69-46f2-93f2-b1e168214598', 'web-origins', 'appcket', 'OpenID Connect scope for add allowed web origins to the access token', 'openid-connect');
INSERT INTO keycloak.client_scope VALUES ('a15b2f14-004d-47f8-b137-7bca43fc8b30', 'microprofile-jwt', 'appcket', 'Microprofile - JWT built-in scope', 'openid-connect');


--
-- TOC entry 3885 (class 0 OID 19086)
-- Dependencies: 262
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.client_scope_attributes VALUES ('f4a49c56-0dfe-4be4-8176-4ee226f1f09f', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('f4a49c56-0dfe-4be4-8176-4ee226f1f09f', '${offlineAccessScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('c300fd83-f791-4986-8ed7-bb3bb4520e36', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('c300fd83-f791-4986-8ed7-bb3bb4520e36', '${samlRoleListScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('a34ae2c0-3ca3-43d7-b8e4-bd7b277dfdae', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('a34ae2c0-3ca3-43d7-b8e4-bd7b277dfdae', '${profileScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('a34ae2c0-3ca3-43d7-b8e4-bd7b277dfdae', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes VALUES ('0d6aeed8-8d73-4978-bc5e-16de7f6f399d', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('0d6aeed8-8d73-4978-bc5e-16de7f6f399d', '${emailScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('0d6aeed8-8d73-4978-bc5e-16de7f6f399d', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes VALUES ('e765c4b2-81f4-472f-b26e-2fcec6f21c18', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('e765c4b2-81f4-472f-b26e-2fcec6f21c18', '${addressScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('e765c4b2-81f4-472f-b26e-2fcec6f21c18', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes VALUES ('c6d8e038-d6a2-44a0-875d-d82cedab755f', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('c6d8e038-d6a2-44a0-875d-d82cedab755f', '${phoneScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('c6d8e038-d6a2-44a0-875d-d82cedab755f', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes VALUES ('d06cb9d2-8cc3-4ee2-b0d3-50e7b4599b00', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('d06cb9d2-8cc3-4ee2-b0d3-50e7b4599b00', '${rolesScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('d06cb9d2-8cc3-4ee2-b0d3-50e7b4599b00', 'false', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes VALUES ('61d1cc86-30fb-44e6-8a4c-bb300d512001', 'false', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('61d1cc86-30fb-44e6-8a4c-bb300d512001', '', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('61d1cc86-30fb-44e6-8a4c-bb300d512001', 'false', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes VALUES ('0c087984-3399-4738-8c0c-14f0b6483d8e', 'false', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('0c087984-3399-4738-8c0c-14f0b6483d8e', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes VALUES ('1ddb5c58-3c5b-43bc-ae48-ba8947a6c108', '${offlineAccessScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('1ddb5c58-3c5b-43bc-ae48-ba8947a6c108', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('bed9e481-a783-4f6c-bd5a-f79f5d189ee6', '${samlRoleListScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('bed9e481-a783-4f6c-bd5a-f79f5d189ee6', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('aee86bba-572b-4335-8f5b-c9969c70cbce', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes VALUES ('aee86bba-572b-4335-8f5b-c9969c70cbce', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('aee86bba-572b-4335-8f5b-c9969c70cbce', '${profileScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('63984129-44c9-4bd1-97d1-da0df3407112', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes VALUES ('63984129-44c9-4bd1-97d1-da0df3407112', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('63984129-44c9-4bd1-97d1-da0df3407112', '${emailScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('b2414a14-1f25-4d4b-9162-de66eeb6652d', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes VALUES ('b2414a14-1f25-4d4b-9162-de66eeb6652d', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('b2414a14-1f25-4d4b-9162-de66eeb6652d', '${addressScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('4709e0fb-184a-4b47-a804-ae1556e53a73', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes VALUES ('4709e0fb-184a-4b47-a804-ae1556e53a73', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('4709e0fb-184a-4b47-a804-ae1556e53a73', '${phoneScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('2b5c02f3-e7a9-4455-a505-9fef19838927', 'false', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes VALUES ('2b5c02f3-e7a9-4455-a505-9fef19838927', 'true', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('2b5c02f3-e7a9-4455-a505-9fef19838927', '${rolesScopeConsentText}', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('52312b11-3e69-46f2-93f2-b1e168214598', 'false', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes VALUES ('52312b11-3e69-46f2-93f2-b1e168214598', 'false', 'display.on.consent.screen');
INSERT INTO keycloak.client_scope_attributes VALUES ('52312b11-3e69-46f2-93f2-b1e168214598', '', 'consent.screen.text');
INSERT INTO keycloak.client_scope_attributes VALUES ('a15b2f14-004d-47f8-b137-7bca43fc8b30', 'true', 'include.in.token.scope');
INSERT INTO keycloak.client_scope_attributes VALUES ('a15b2f14-004d-47f8-b137-7bca43fc8b30', 'false', 'display.on.consent.screen');


--
-- TOC entry 3908 (class 0 OID 19589)
-- Dependencies: 285
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.client_scope_client VALUES ('b76c70fe-8825-46a4-bd41-b8f291e910c5', '61d1cc86-30fb-44e6-8a4c-bb300d512001', true);
INSERT INTO keycloak.client_scope_client VALUES ('b76c70fe-8825-46a4-bd41-b8f291e910c5', '0d6aeed8-8d73-4978-bc5e-16de7f6f399d', true);
INSERT INTO keycloak.client_scope_client VALUES ('b76c70fe-8825-46a4-bd41-b8f291e910c5', 'a34ae2c0-3ca3-43d7-b8e4-bd7b277dfdae', true);
INSERT INTO keycloak.client_scope_client VALUES ('b76c70fe-8825-46a4-bd41-b8f291e910c5', 'd06cb9d2-8cc3-4ee2-b0d3-50e7b4599b00', true);
INSERT INTO keycloak.client_scope_client VALUES ('b76c70fe-8825-46a4-bd41-b8f291e910c5', 'c6d8e038-d6a2-44a0-875d-d82cedab755f', false);
INSERT INTO keycloak.client_scope_client VALUES ('b76c70fe-8825-46a4-bd41-b8f291e910c5', 'e765c4b2-81f4-472f-b26e-2fcec6f21c18', false);
INSERT INTO keycloak.client_scope_client VALUES ('b76c70fe-8825-46a4-bd41-b8f291e910c5', '0c087984-3399-4738-8c0c-14f0b6483d8e', false);
INSERT INTO keycloak.client_scope_client VALUES ('b76c70fe-8825-46a4-bd41-b8f291e910c5', 'f4a49c56-0dfe-4be4-8176-4ee226f1f09f', false);
INSERT INTO keycloak.client_scope_client VALUES ('567f4fd5-d705-46fc-9956-31901fd76939', '61d1cc86-30fb-44e6-8a4c-bb300d512001', true);
INSERT INTO keycloak.client_scope_client VALUES ('567f4fd5-d705-46fc-9956-31901fd76939', '0d6aeed8-8d73-4978-bc5e-16de7f6f399d', true);
INSERT INTO keycloak.client_scope_client VALUES ('567f4fd5-d705-46fc-9956-31901fd76939', 'a34ae2c0-3ca3-43d7-b8e4-bd7b277dfdae', true);
INSERT INTO keycloak.client_scope_client VALUES ('567f4fd5-d705-46fc-9956-31901fd76939', 'd06cb9d2-8cc3-4ee2-b0d3-50e7b4599b00', true);
INSERT INTO keycloak.client_scope_client VALUES ('567f4fd5-d705-46fc-9956-31901fd76939', 'c6d8e038-d6a2-44a0-875d-d82cedab755f', false);
INSERT INTO keycloak.client_scope_client VALUES ('567f4fd5-d705-46fc-9956-31901fd76939', 'e765c4b2-81f4-472f-b26e-2fcec6f21c18', false);
INSERT INTO keycloak.client_scope_client VALUES ('567f4fd5-d705-46fc-9956-31901fd76939', '0c087984-3399-4738-8c0c-14f0b6483d8e', false);
INSERT INTO keycloak.client_scope_client VALUES ('567f4fd5-d705-46fc-9956-31901fd76939', 'f4a49c56-0dfe-4be4-8176-4ee226f1f09f', false);
INSERT INTO keycloak.client_scope_client VALUES ('c6e9839d-b475-44bd-aec8-9ee1d4434c89', '61d1cc86-30fb-44e6-8a4c-bb300d512001', true);
INSERT INTO keycloak.client_scope_client VALUES ('c6e9839d-b475-44bd-aec8-9ee1d4434c89', '0d6aeed8-8d73-4978-bc5e-16de7f6f399d', true);
INSERT INTO keycloak.client_scope_client VALUES ('c6e9839d-b475-44bd-aec8-9ee1d4434c89', 'a34ae2c0-3ca3-43d7-b8e4-bd7b277dfdae', true);
INSERT INTO keycloak.client_scope_client VALUES ('c6e9839d-b475-44bd-aec8-9ee1d4434c89', 'd06cb9d2-8cc3-4ee2-b0d3-50e7b4599b00', true);
INSERT INTO keycloak.client_scope_client VALUES ('c6e9839d-b475-44bd-aec8-9ee1d4434c89', 'c6d8e038-d6a2-44a0-875d-d82cedab755f', false);
INSERT INTO keycloak.client_scope_client VALUES ('c6e9839d-b475-44bd-aec8-9ee1d4434c89', 'e765c4b2-81f4-472f-b26e-2fcec6f21c18', false);
INSERT INTO keycloak.client_scope_client VALUES ('c6e9839d-b475-44bd-aec8-9ee1d4434c89', '0c087984-3399-4738-8c0c-14f0b6483d8e', false);
INSERT INTO keycloak.client_scope_client VALUES ('c6e9839d-b475-44bd-aec8-9ee1d4434c89', 'f4a49c56-0dfe-4be4-8176-4ee226f1f09f', false);
INSERT INTO keycloak.client_scope_client VALUES ('b947d8c7-5d45-4789-8933-cbe58c97d415', '61d1cc86-30fb-44e6-8a4c-bb300d512001', true);
INSERT INTO keycloak.client_scope_client VALUES ('b947d8c7-5d45-4789-8933-cbe58c97d415', '0d6aeed8-8d73-4978-bc5e-16de7f6f399d', true);
INSERT INTO keycloak.client_scope_client VALUES ('b947d8c7-5d45-4789-8933-cbe58c97d415', 'a34ae2c0-3ca3-43d7-b8e4-bd7b277dfdae', true);
INSERT INTO keycloak.client_scope_client VALUES ('b947d8c7-5d45-4789-8933-cbe58c97d415', 'd06cb9d2-8cc3-4ee2-b0d3-50e7b4599b00', true);
INSERT INTO keycloak.client_scope_client VALUES ('b947d8c7-5d45-4789-8933-cbe58c97d415', 'c6d8e038-d6a2-44a0-875d-d82cedab755f', false);
INSERT INTO keycloak.client_scope_client VALUES ('b947d8c7-5d45-4789-8933-cbe58c97d415', 'e765c4b2-81f4-472f-b26e-2fcec6f21c18', false);
INSERT INTO keycloak.client_scope_client VALUES ('b947d8c7-5d45-4789-8933-cbe58c97d415', '0c087984-3399-4738-8c0c-14f0b6483d8e', false);
INSERT INTO keycloak.client_scope_client VALUES ('b947d8c7-5d45-4789-8933-cbe58c97d415', 'f4a49c56-0dfe-4be4-8176-4ee226f1f09f', false);
INSERT INTO keycloak.client_scope_client VALUES ('e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', '61d1cc86-30fb-44e6-8a4c-bb300d512001', true);
INSERT INTO keycloak.client_scope_client VALUES ('e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', '0d6aeed8-8d73-4978-bc5e-16de7f6f399d', true);
INSERT INTO keycloak.client_scope_client VALUES ('e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', 'a34ae2c0-3ca3-43d7-b8e4-bd7b277dfdae', true);
INSERT INTO keycloak.client_scope_client VALUES ('e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', 'd06cb9d2-8cc3-4ee2-b0d3-50e7b4599b00', true);
INSERT INTO keycloak.client_scope_client VALUES ('e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', 'c6d8e038-d6a2-44a0-875d-d82cedab755f', false);
INSERT INTO keycloak.client_scope_client VALUES ('e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', 'e765c4b2-81f4-472f-b26e-2fcec6f21c18', false);
INSERT INTO keycloak.client_scope_client VALUES ('e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', '0c087984-3399-4738-8c0c-14f0b6483d8e', false);
INSERT INTO keycloak.client_scope_client VALUES ('e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', 'f4a49c56-0dfe-4be4-8176-4ee226f1f09f', false);
INSERT INTO keycloak.client_scope_client VALUES ('5b745968-9295-482c-b42f-d11087e1790b', '61d1cc86-30fb-44e6-8a4c-bb300d512001', true);
INSERT INTO keycloak.client_scope_client VALUES ('5b745968-9295-482c-b42f-d11087e1790b', '0d6aeed8-8d73-4978-bc5e-16de7f6f399d', true);
INSERT INTO keycloak.client_scope_client VALUES ('5b745968-9295-482c-b42f-d11087e1790b', 'a34ae2c0-3ca3-43d7-b8e4-bd7b277dfdae', true);
INSERT INTO keycloak.client_scope_client VALUES ('5b745968-9295-482c-b42f-d11087e1790b', 'd06cb9d2-8cc3-4ee2-b0d3-50e7b4599b00', true);
INSERT INTO keycloak.client_scope_client VALUES ('5b745968-9295-482c-b42f-d11087e1790b', 'c6d8e038-d6a2-44a0-875d-d82cedab755f', false);
INSERT INTO keycloak.client_scope_client VALUES ('5b745968-9295-482c-b42f-d11087e1790b', 'e765c4b2-81f4-472f-b26e-2fcec6f21c18', false);
INSERT INTO keycloak.client_scope_client VALUES ('5b745968-9295-482c-b42f-d11087e1790b', '0c087984-3399-4738-8c0c-14f0b6483d8e', false);
INSERT INTO keycloak.client_scope_client VALUES ('5b745968-9295-482c-b42f-d11087e1790b', 'f4a49c56-0dfe-4be4-8176-4ee226f1f09f', false);
INSERT INTO keycloak.client_scope_client VALUES ('e801cbf0-541f-4466-80e1-fcce640df2a8', '52312b11-3e69-46f2-93f2-b1e168214598', true);
INSERT INTO keycloak.client_scope_client VALUES ('e801cbf0-541f-4466-80e1-fcce640df2a8', 'aee86bba-572b-4335-8f5b-c9969c70cbce', true);
INSERT INTO keycloak.client_scope_client VALUES ('e801cbf0-541f-4466-80e1-fcce640df2a8', '2b5c02f3-e7a9-4455-a505-9fef19838927', true);
INSERT INTO keycloak.client_scope_client VALUES ('e801cbf0-541f-4466-80e1-fcce640df2a8', '63984129-44c9-4bd1-97d1-da0df3407112', true);
INSERT INTO keycloak.client_scope_client VALUES ('e801cbf0-541f-4466-80e1-fcce640df2a8', 'b2414a14-1f25-4d4b-9162-de66eeb6652d', false);
INSERT INTO keycloak.client_scope_client VALUES ('e801cbf0-541f-4466-80e1-fcce640df2a8', '4709e0fb-184a-4b47-a804-ae1556e53a73', false);
INSERT INTO keycloak.client_scope_client VALUES ('e801cbf0-541f-4466-80e1-fcce640df2a8', '1ddb5c58-3c5b-43bc-ae48-ba8947a6c108', false);
INSERT INTO keycloak.client_scope_client VALUES ('e801cbf0-541f-4466-80e1-fcce640df2a8', 'a15b2f14-004d-47f8-b137-7bca43fc8b30', false);
INSERT INTO keycloak.client_scope_client VALUES ('26f802c3-b7af-4e78-b785-40493ae2483a', '52312b11-3e69-46f2-93f2-b1e168214598', true);
INSERT INTO keycloak.client_scope_client VALUES ('26f802c3-b7af-4e78-b785-40493ae2483a', 'aee86bba-572b-4335-8f5b-c9969c70cbce', true);
INSERT INTO keycloak.client_scope_client VALUES ('26f802c3-b7af-4e78-b785-40493ae2483a', '2b5c02f3-e7a9-4455-a505-9fef19838927', true);
INSERT INTO keycloak.client_scope_client VALUES ('26f802c3-b7af-4e78-b785-40493ae2483a', '63984129-44c9-4bd1-97d1-da0df3407112', true);
INSERT INTO keycloak.client_scope_client VALUES ('26f802c3-b7af-4e78-b785-40493ae2483a', 'b2414a14-1f25-4d4b-9162-de66eeb6652d', false);
INSERT INTO keycloak.client_scope_client VALUES ('26f802c3-b7af-4e78-b785-40493ae2483a', '4709e0fb-184a-4b47-a804-ae1556e53a73', false);
INSERT INTO keycloak.client_scope_client VALUES ('26f802c3-b7af-4e78-b785-40493ae2483a', '1ddb5c58-3c5b-43bc-ae48-ba8947a6c108', false);
INSERT INTO keycloak.client_scope_client VALUES ('26f802c3-b7af-4e78-b785-40493ae2483a', 'a15b2f14-004d-47f8-b137-7bca43fc8b30', false);
INSERT INTO keycloak.client_scope_client VALUES ('544076b9-bf22-4731-8d85-2ddc0edbd41e', '52312b11-3e69-46f2-93f2-b1e168214598', true);
INSERT INTO keycloak.client_scope_client VALUES ('544076b9-bf22-4731-8d85-2ddc0edbd41e', 'aee86bba-572b-4335-8f5b-c9969c70cbce', true);
INSERT INTO keycloak.client_scope_client VALUES ('544076b9-bf22-4731-8d85-2ddc0edbd41e', '2b5c02f3-e7a9-4455-a505-9fef19838927', true);
INSERT INTO keycloak.client_scope_client VALUES ('544076b9-bf22-4731-8d85-2ddc0edbd41e', '63984129-44c9-4bd1-97d1-da0df3407112', true);
INSERT INTO keycloak.client_scope_client VALUES ('544076b9-bf22-4731-8d85-2ddc0edbd41e', 'b2414a14-1f25-4d4b-9162-de66eeb6652d', false);
INSERT INTO keycloak.client_scope_client VALUES ('544076b9-bf22-4731-8d85-2ddc0edbd41e', '4709e0fb-184a-4b47-a804-ae1556e53a73', false);
INSERT INTO keycloak.client_scope_client VALUES ('544076b9-bf22-4731-8d85-2ddc0edbd41e', '1ddb5c58-3c5b-43bc-ae48-ba8947a6c108', false);
INSERT INTO keycloak.client_scope_client VALUES ('544076b9-bf22-4731-8d85-2ddc0edbd41e', 'a15b2f14-004d-47f8-b137-7bca43fc8b30', false);
INSERT INTO keycloak.client_scope_client VALUES ('70da96f3-abee-4ade-a7f3-d22e04437a0a', '52312b11-3e69-46f2-93f2-b1e168214598', true);
INSERT INTO keycloak.client_scope_client VALUES ('70da96f3-abee-4ade-a7f3-d22e04437a0a', 'aee86bba-572b-4335-8f5b-c9969c70cbce', true);
INSERT INTO keycloak.client_scope_client VALUES ('70da96f3-abee-4ade-a7f3-d22e04437a0a', '2b5c02f3-e7a9-4455-a505-9fef19838927', true);
INSERT INTO keycloak.client_scope_client VALUES ('70da96f3-abee-4ade-a7f3-d22e04437a0a', '63984129-44c9-4bd1-97d1-da0df3407112', true);
INSERT INTO keycloak.client_scope_client VALUES ('70da96f3-abee-4ade-a7f3-d22e04437a0a', 'b2414a14-1f25-4d4b-9162-de66eeb6652d', false);
INSERT INTO keycloak.client_scope_client VALUES ('70da96f3-abee-4ade-a7f3-d22e04437a0a', '4709e0fb-184a-4b47-a804-ae1556e53a73', false);
INSERT INTO keycloak.client_scope_client VALUES ('70da96f3-abee-4ade-a7f3-d22e04437a0a', '1ddb5c58-3c5b-43bc-ae48-ba8947a6c108', false);
INSERT INTO keycloak.client_scope_client VALUES ('70da96f3-abee-4ade-a7f3-d22e04437a0a', 'a15b2f14-004d-47f8-b137-7bca43fc8b30', false);
INSERT INTO keycloak.client_scope_client VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', '52312b11-3e69-46f2-93f2-b1e168214598', true);
INSERT INTO keycloak.client_scope_client VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'aee86bba-572b-4335-8f5b-c9969c70cbce', true);
INSERT INTO keycloak.client_scope_client VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', '2b5c02f3-e7a9-4455-a505-9fef19838927', true);
INSERT INTO keycloak.client_scope_client VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', '63984129-44c9-4bd1-97d1-da0df3407112', true);
INSERT INTO keycloak.client_scope_client VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'b2414a14-1f25-4d4b-9162-de66eeb6652d', false);
INSERT INTO keycloak.client_scope_client VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', '4709e0fb-184a-4b47-a804-ae1556e53a73', false);
INSERT INTO keycloak.client_scope_client VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', '1ddb5c58-3c5b-43bc-ae48-ba8947a6c108', false);
INSERT INTO keycloak.client_scope_client VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'a15b2f14-004d-47f8-b137-7bca43fc8b30', false);
INSERT INTO keycloak.client_scope_client VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', '52312b11-3e69-46f2-93f2-b1e168214598', true);
INSERT INTO keycloak.client_scope_client VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'aee86bba-572b-4335-8f5b-c9969c70cbce', true);
INSERT INTO keycloak.client_scope_client VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', '2b5c02f3-e7a9-4455-a505-9fef19838927', true);
INSERT INTO keycloak.client_scope_client VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', '63984129-44c9-4bd1-97d1-da0df3407112', true);
INSERT INTO keycloak.client_scope_client VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'b2414a14-1f25-4d4b-9162-de66eeb6652d', false);
INSERT INTO keycloak.client_scope_client VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', '4709e0fb-184a-4b47-a804-ae1556e53a73', false);
INSERT INTO keycloak.client_scope_client VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', '1ddb5c58-3c5b-43bc-ae48-ba8947a6c108', false);
INSERT INTO keycloak.client_scope_client VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'a15b2f14-004d-47f8-b137-7bca43fc8b30', false);
INSERT INTO keycloak.client_scope_client VALUES ('5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', '52312b11-3e69-46f2-93f2-b1e168214598', true);
INSERT INTO keycloak.client_scope_client VALUES ('5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', 'aee86bba-572b-4335-8f5b-c9969c70cbce', true);
INSERT INTO keycloak.client_scope_client VALUES ('5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', '2b5c02f3-e7a9-4455-a505-9fef19838927', true);
INSERT INTO keycloak.client_scope_client VALUES ('5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', '63984129-44c9-4bd1-97d1-da0df3407112', true);
INSERT INTO keycloak.client_scope_client VALUES ('5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', 'b2414a14-1f25-4d4b-9162-de66eeb6652d', false);
INSERT INTO keycloak.client_scope_client VALUES ('5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', '4709e0fb-184a-4b47-a804-ae1556e53a73', false);
INSERT INTO keycloak.client_scope_client VALUES ('5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', '1ddb5c58-3c5b-43bc-ae48-ba8947a6c108', false);
INSERT INTO keycloak.client_scope_client VALUES ('5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', 'a15b2f14-004d-47f8-b137-7bca43fc8b30', false);
INSERT INTO keycloak.client_scope_client VALUES ('4dd4c360-d5b9-4730-8091-78b394cea334', '52312b11-3e69-46f2-93f2-b1e168214598', true);
INSERT INTO keycloak.client_scope_client VALUES ('4dd4c360-d5b9-4730-8091-78b394cea334', 'aee86bba-572b-4335-8f5b-c9969c70cbce', true);
INSERT INTO keycloak.client_scope_client VALUES ('4dd4c360-d5b9-4730-8091-78b394cea334', '2b5c02f3-e7a9-4455-a505-9fef19838927', true);
INSERT INTO keycloak.client_scope_client VALUES ('4dd4c360-d5b9-4730-8091-78b394cea334', '63984129-44c9-4bd1-97d1-da0df3407112', true);
INSERT INTO keycloak.client_scope_client VALUES ('4dd4c360-d5b9-4730-8091-78b394cea334', 'b2414a14-1f25-4d4b-9162-de66eeb6652d', false);
INSERT INTO keycloak.client_scope_client VALUES ('4dd4c360-d5b9-4730-8091-78b394cea334', '4709e0fb-184a-4b47-a804-ae1556e53a73', false);
INSERT INTO keycloak.client_scope_client VALUES ('4dd4c360-d5b9-4730-8091-78b394cea334', '1ddb5c58-3c5b-43bc-ae48-ba8947a6c108', false);
INSERT INTO keycloak.client_scope_client VALUES ('4dd4c360-d5b9-4730-8091-78b394cea334', 'a15b2f14-004d-47f8-b137-7bca43fc8b30', false);


--
-- TOC entry 3886 (class 0 OID 19092)
-- Dependencies: 263
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.client_scope_role_mapping VALUES ('f4a49c56-0dfe-4be4-8176-4ee226f1f09f', 'e07ab02f-9442-4b41-9056-b96aea48e2c4');
INSERT INTO keycloak.client_scope_role_mapping VALUES ('1ddb5c58-3c5b-43bc-ae48-ba8947a6c108', '241f95cd-d0a8-4b5e-b7d3-657f078175bb');


--
-- TOC entry 3828 (class 0 OID 18177)
-- Dependencies: 205
-- Data for Name: client_session; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3873 (class 0 OID 18854)
-- Dependencies: 250
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3851 (class 0 OID 18545)
-- Dependencies: 228
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3865 (class 0 OID 18732)
-- Dependencies: 242
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3829 (class 0 OID 18183)
-- Dependencies: 206
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3874 (class 0 OID 18935)
-- Dependencies: 251
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3904 (class 0 OID 19338)
-- Dependencies: 281
-- Data for Name: component; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.component VALUES ('80ca64e2-1776-4e22-aa2e-8716344f6474', 'Trusted Hosts', 'master', 'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO keycloak.component VALUES ('107c8004-4896-4947-91a9-d6d8c806323c', 'Consent Required', 'master', 'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO keycloak.component VALUES ('9273d8a0-5e92-414c-ad1b-ff1c7eb7447a', 'Full Scope Disabled', 'master', 'scope', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO keycloak.component VALUES ('68382013-0baa-4917-b725-43a4d0aa8c18', 'Max Clients Limit', 'master', 'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO keycloak.component VALUES ('b844ff1d-baf6-4e34-8e78-8970a4d50ecd', 'Allowed Protocol Mapper Types', 'master', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO keycloak.component VALUES ('ff062b76-096b-4796-8bee-a2f149b86abc', 'Allowed Client Scopes', 'master', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO keycloak.component VALUES ('473d404d-37f6-4aab-a160-b8ed23dd4247', 'Allowed Protocol Mapper Types', 'master', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'authenticated');
INSERT INTO keycloak.component VALUES ('c624586a-aa04-44c7-8aab-fa971f603793', 'Allowed Client Scopes', 'master', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'authenticated');
INSERT INTO keycloak.component VALUES ('dbc5139b-13c2-4526-be7c-0cbbe769ea3d', 'rsa-generated', 'master', 'rsa-generated', 'org.keycloak.keys.KeyProvider', 'master', NULL);
INSERT INTO keycloak.component VALUES ('5da649bb-be10-4d48-8387-162d5506be4e', 'rsa-enc-generated', 'master', 'rsa-generated', 'org.keycloak.keys.KeyProvider', 'master', NULL);
INSERT INTO keycloak.component VALUES ('3e91a73f-dd52-4561-9d25-3775fce4c26b', 'hmac-generated', 'master', 'hmac-generated', 'org.keycloak.keys.KeyProvider', 'master', NULL);
INSERT INTO keycloak.component VALUES ('604af98d-d7c9-4390-bc06-5c3391840b51', 'aes-generated', 'master', 'aes-generated', 'org.keycloak.keys.KeyProvider', 'master', NULL);
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
INSERT INTO keycloak.component VALUES ('182d056f-27b9-4def-97ef-cd05dbd56311', NULL, 'appcket', 'declarative-user-profile', 'org.keycloak.userprofile.UserProfileProvider', 'appcket', NULL);


--
-- TOC entry 3903 (class 0 OID 19332)
-- Dependencies: 280
-- Data for Name: component_config; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.component_config VALUES ('b7500111-d4e6-4513-969b-bd1a7cbfaf61', 'b844ff1d-baf6-4e34-8e78-8970a4d50ecd', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO keycloak.component_config VALUES ('bfc763cc-4c87-4680-96eb-2410dcd8d9fd', 'b844ff1d-baf6-4e34-8e78-8970a4d50ecd', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO keycloak.component_config VALUES ('c016e52e-f310-4941-b591-d9e3235611b1', 'b844ff1d-baf6-4e34-8e78-8970a4d50ecd', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO keycloak.component_config VALUES ('070d7491-5c1f-4f6b-9400-5beeea070b53', 'b844ff1d-baf6-4e34-8e78-8970a4d50ecd', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO keycloak.component_config VALUES ('4d379017-8614-4924-a4ef-fd2f2aa338fa', 'b844ff1d-baf6-4e34-8e78-8970a4d50ecd', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO keycloak.component_config VALUES ('5cf3b57e-914b-4597-a6b0-f06947d870e8', 'b844ff1d-baf6-4e34-8e78-8970a4d50ecd', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO keycloak.component_config VALUES ('1d097e77-c2c9-473d-99c2-2a8d0652f11e', 'b844ff1d-baf6-4e34-8e78-8970a4d50ecd', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO keycloak.component_config VALUES ('4c186202-1a1b-47ed-908c-3f31b2d2a791', 'b844ff1d-baf6-4e34-8e78-8970a4d50ecd', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO keycloak.component_config VALUES ('1e3d2b69-be85-4f97-b8f9-6f1b97bf8f5d', '80ca64e2-1776-4e22-aa2e-8716344f6474', 'host-sending-registration-request-must-match', 'true');
INSERT INTO keycloak.component_config VALUES ('a63ac016-2f38-4a18-8ee9-fdfff5431140', '80ca64e2-1776-4e22-aa2e-8716344f6474', 'client-uris-must-match', 'true');
INSERT INTO keycloak.component_config VALUES ('bfad6e5d-6d7f-47bb-8d80-e0e18b025579', 'c624586a-aa04-44c7-8aab-fa971f603793', 'allow-default-scopes', 'true');
INSERT INTO keycloak.component_config VALUES ('52199f0b-5b8b-4158-8e19-08f1efb10b62', '473d404d-37f6-4aab-a160-b8ed23dd4247', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO keycloak.component_config VALUES ('b3145c73-bfc3-44aa-9e98-bbedfe547d9c', '473d404d-37f6-4aab-a160-b8ed23dd4247', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO keycloak.component_config VALUES ('1b287766-fbae-4a5d-9532-968e14b1d62f', '473d404d-37f6-4aab-a160-b8ed23dd4247', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO keycloak.component_config VALUES ('0e2919c7-eef6-4898-b6d0-c217725f0fa6', '473d404d-37f6-4aab-a160-b8ed23dd4247', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO keycloak.component_config VALUES ('ee8177d0-ea1d-4a3d-aad3-fc380fe669e0', '473d404d-37f6-4aab-a160-b8ed23dd4247', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO keycloak.component_config VALUES ('5e432224-6801-4d44-9ba1-a01b2220c8e8', '473d404d-37f6-4aab-a160-b8ed23dd4247', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO keycloak.component_config VALUES ('e0bdd1db-bd94-4201-9bfb-71f86b156c45', '473d404d-37f6-4aab-a160-b8ed23dd4247', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO keycloak.component_config VALUES ('9d791868-ce22-4fe3-96db-0e2b52a3158e', '473d404d-37f6-4aab-a160-b8ed23dd4247', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO keycloak.component_config VALUES ('e79e0835-03a3-4a4c-a20a-730850ef26aa', '68382013-0baa-4917-b725-43a4d0aa8c18', 'max-clients', '200');
INSERT INTO keycloak.component_config VALUES ('e12e07d2-d3c6-48a3-9fed-ed827c208fc0', 'ff062b76-096b-4796-8bee-a2f149b86abc', 'allow-default-scopes', 'true');
INSERT INTO keycloak.component_config VALUES ('bbee8ba2-f0dc-497b-b126-ed684121efc2', '5da649bb-be10-4d48-8387-162d5506be4e', 'certificate', 'MIICmzCCAYMCBgF8HpdxljANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjEwOTI1MjAxMTUzWhcNMzEwOTI1MjAxMzMzWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCTeFnr9UV7NrY1cujPTGmQOEpKCaJibneQUe8LkqB4YEM16TmHkwYkj8RMTXCH4IhZCUFoXZ/MsRDYPtvOoXAfZusdk89tl0Tep7zXjdzsnd3QH4lY1ATKBY72EEWXqwEFNd++WJvXKpkGUcXdIVfrriGyBmDBWWMfWFGKVqIQvd7M7BhmnOOW5XHK9h/oQn+g1olf5sEUFvJEOWBf52WEHGulJ5TziZfu6NtzgLQ37YscbYZ0wd8fctyrs7IZfHO6lgt3gKpIgMbj9SXq1ab7JFvQSBZQ1o+a3XVkm9M8pY0MaksNEjrfL9d16bklwSx2klsN2EwxokGXYC4pXmWrAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAGdoylWgj562uAmcmElr1q/2DWZzBPxmxvPrRX7GXEKkP4XX2l4Bw7g0qI3E9TMdGS3TKuyCKLbeghq4cZ9G/w6dizsPeNQ97NhYMuJJp+aaa4lz1rJpTZPGiYVcIRqMw7vSgFFWykAjGEzMZHXx7b6Ks1odrW4FN+xxVARvf5WH500v/AmPk/3EEnGSR86+iNuJ4lWZT8Z/SDb8A/nj7Enr4a0PDBoB6XjRAD+Nos0Nd12Qsl83qmdRBiH9wljlvmgJrr/zZR2185AL1HjTB/bBJxGurAyAwrSLfGj4hVgUEM5AyGBMFSiY63/8F3JDQdR3lys7ud3M50jGJLrf1Qg=');
INSERT INTO keycloak.component_config VALUES ('45ccb7d5-4649-47dd-8727-8567fd1faff2', '5da649bb-be10-4d48-8387-162d5506be4e', 'privateKey', 'MIIEoQIBAAKCAQEAk3hZ6/VFeza2NXLoz0xpkDhKSgmiYm53kFHvC5KgeGBDNek5h5MGJI/ETE1wh+CIWQlBaF2fzLEQ2D7bzqFwH2brHZPPbZdE3qe8143c7J3d0B+JWNQEygWO9hBFl6sBBTXfvlib1yqZBlHF3SFX664hsgZgwVljH1hRilaiEL3ezOwYZpzjluVxyvYf6EJ/oNaJX+bBFBbyRDlgX+dlhBxrpSeU84mX7ujbc4C0N+2LHG2GdMHfH3Lcq7OyGXxzupYLd4CqSIDG4/Ul6tWm+yRb0EgWUNaPmt11ZJvTPKWNDGpLDRI63y/Xdem5JcEsdpJbDdhMMaJBl2AuKV5lqwIDAQABAoIBAAdQug01bovtK96844WdAcOQt0ay8aY2WqIDHnuRe3pdNBhRiHQMPArGQvOSB9oFrl3UUrVNp6asxewkOh0m7vvvzAv8kBacoWL2KSz8MZBfSGiRl+ubIN2wpuXX6svaRMOwZ3f2x0xGJa8lkU4l4EmlqrA9FsGgoIUmiWz2XTW9Ui99mJgt+vsgn7mxzHg4X7hXxZJFofe+fY9zeypcXDt4+sjz6et2CcRylImxuXEI3GaYUqzcxlvY6GnkwHYX/k5MbLvkgoiVQp3FUM+u4hyfc5YSAvLAH2PzfMKH69scpPgJTRa09G9x7RXinKIPt0IWSZmqLxeeeG7f1RKDxGECgYEAxYkBtCqakkXNUcBbu23fvfy0M9goYGcRICost60wYxjP/BUViFwZX+ohNDUReC3wnRcrx9rzJvOLYG6+kMLjixqAj3SVWVGvVEz1dHg0kAucUaFPlrsPht3EyYxJC3su7wxY5HKquxsPdmsApAiS6FAK4abL629aZRPiPSDCLzsCgYEAvx36SpTJxB5VtyDElj5QzqgIWuGnhdBX2VnUYvFGl/gT9JGC+sQC5xv7d/mrYpB17TJ6a252WaDl9/ZPbDynhhej2lKrLyzafNMCAnn6AkO+g82sbeLc/i5XYAMbZGB9JYupXmm8iFFd1k8Mehc/VCa482HeQKV+lcYCtbYZHFECgYAcf5KmWosoVTe09qqFVOm1sDKTVDknB1eaK1t+OFdFxLuk46nSnW7vvoiBzrIxg3c2QrSHRdhUo0hVZkTJ/8PyOqWXjLtLQpSn9d5nqjvzGCm6QSqJVX18+Ju+dCXJqUDxLffZJY3qJpJJhFB4WeBP8dRQD89VrR/+eyrlpMc/JwKBgQCDJKP6h4zISfSRfCfJ3SsAE+ffzRZySVvu5qhJ2LyTTYUL/sm9H8HKKrZtRmKneO+i+09r5tnJeRI1C8zGPfzKk/A4wR98eK/Ylca8Qk0fPrM9qGWY5eK1fMEyPg+O2nMlz2dCRRY9CHB2vbmXEdq/+O5S/CZRf/6T8dMsM6+ZcQJ/f5pO1Spioy/z7gGwsMpToPqAtqZ6mp8ZdzP2e9PuG2SqgU+ckFjtk9SmyN5nGpV4lQaOxegc1AFfZ5H+x6b4RaPP/BIAIxqFFFPuiBBTPUfkFr6XWN5mu6Vra18d1c6dh+09kWdG/M8YVS86iTHiEHCUwqFetYxRDJgFLycUxg==');
INSERT INTO keycloak.component_config VALUES ('d0c4328e-ff36-453f-8845-26251a450a43', '5da649bb-be10-4d48-8387-162d5506be4e', 'keyUse', 'enc');
INSERT INTO keycloak.component_config VALUES ('d1c3d2a5-6338-4e5d-bc14-65ebdb20fe8d', '5da649bb-be10-4d48-8387-162d5506be4e', 'priority', '100');
INSERT INTO keycloak.component_config VALUES ('294f5d01-2f80-4a35-985d-cadae4be0db0', 'dbc5139b-13c2-4526-be7c-0cbbe769ea3d', 'privateKey', 'MIIEogIBAAKCAQEA0Km9/zrNZJ99wvss9lqOb4pWflt7wuDPoT3/Gs7WhJnvnVpymtNaTAa+0F4AqQw0Q4TjP9j1F4Uge2khKKkzQqWnTZ8bLob2y8BOhEMVVqK9Twk17ajhuouznEgve4mbqdQl6Q7/QXwSdf4lm00MeCj0776YSkFK2WATLjwqdZ+dRyMLKnar0FfMl1Ft1RIsyFDztEvuMgqwb0mNQpaun403jP7o189qZk2VfhomBj8ox3fvlj9hRUGIkJlq3/tkFHMjI8cdw6IjaVECmHZm/aRPo1Q1jif/mcxnxWRpBNMES1VqT32C1MpKk5sUoMnkeNhBRBmUrbC2uk9DeKFQXQIDAQABAoIBABWfMS/sYPInULnOmzcf5RiLxjCrvCRSdVFpAjE9856j8N9mSu/eLMIqBMXEp97cg+HnOEEaczMvuVDwcN4swkIKtk5lyURF+fbdA4XTCbgDfwhclPj+gf15knAETt9HQBkWAaOnyS149NTDNBRmpH8jB1Z8cn1nTKE/wl0NIP01EAI2Q0yqrBN9i1vTVX6WOh+hOUOnSFTVtC45y+qqRsDou1mwqNQEhv46gv6zhOV1qkOum9cNVYFFZgklsmMsRfxH3x7iOn5uU5hiBs97NzoCA+7rUxVyM3lBJ6o+/I/M+bB0oirqeShTSIKsdXJMKD7CbY5EO13adRhk6Iy8cOUCgYEA73u9coDBAhlSt/kZKb9/FMpEry+hJj+EUuk2qLnjtYoCvOEJ7iLFH5oan+r8ffL5Gv1PZexH9ObA3H04xc4yjG7fSfUqevq25JFSsDGHAe41wOolGJaj23uGHryJWJ4TanNdF6lmXeEmA5i0jJ7YadHOW/M3Fxv1uOFZ5ku21LMCgYEA3w3YqnVjJ22Zua3WgXU45VVD/NxnrljB9rBoiOm5SlBnwCGb2B0SBQegzL2oBP/DXnK0ydZA/JzRvyrfb+vzGD0MnUDOa1hwIFH1FC7XUULNvpnZIFSd7cefjgFBCqRJjaa5wpaI/IKvXcnR+16UYoeS8zMwAl9WFCtwclY7bq8CgYEA32a/Q6F4a0zULWriXl+VXP+TMxlraxK1jeKgaqV+Fku4YhpL+SnWWbSYQbYj9BpE5ziGaL4SIhNgtk7aNywzW23SPlvGVRKsqmwmhtas6tActOm30Ug1cvm4E9QtC83qrtMPdJNCOzFdFN3PD57eo1hk+MHaEmSyxNTz2DGpTKECf0I32hrAvq712q1E7mmAY2Ox7H0k8aLQtsSFmoMK3/cv550iXSHLf43+tb4Sj87sHxPq+cDx2lkkNSCLmcmgQorvlM8abi1wE9mEez2Cqml1a58qDUuL01bD7Jo7xRNjsnJbDMq35fMQ2P7+61e0vFiD5xxMFfSeWO+j9b3726kCgYEAitkzoW+2vHSPK8YwMIqIRmq2Y9uQZSXfAtFRBOofA81KlC0pvbIjcj2cGDk5oTQAB4fSXFrohWCnd6Yy4tjpX0lpcEvR+FFDYC0K+r26nt0mfhMxaJkn6dGLabWT/8tktnEgmRqmlm9bekbF5Jh5XdfK3SWW5h0AAnU1grFWrJk=');
INSERT INTO keycloak.component_config VALUES ('1991bf5a-fbb4-49f4-8e1e-5f5903c821ca', 'dbc5139b-13c2-4526-be7c-0cbbe769ea3d', 'priority', '100');
INSERT INTO keycloak.component_config VALUES ('bb2cc2c1-77ab-49e1-8fb9-3261b5a9df84', 'dbc5139b-13c2-4526-be7c-0cbbe769ea3d', 'certificate', 'MIICmzCCAYMCBgF8Hpdw0jANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjEwOTI1MjAxMTUzWhcNMzEwOTI1MjAxMzMzWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDQqb3/Os1kn33C+yz2Wo5vilZ+W3vC4M+hPf8aztaEme+dWnKa01pMBr7QXgCpDDRDhOM/2PUXhSB7aSEoqTNCpadNnxsuhvbLwE6EQxVWor1PCTXtqOG6i7OcSC97iZup1CXpDv9BfBJ1/iWbTQx4KPTvvphKQUrZYBMuPCp1n51HIwsqdqvQV8yXUW3VEizIUPO0S+4yCrBvSY1Clq6fjTeM/ujXz2pmTZV+GiYGPyjHd++WP2FFQYiQmWrf+2QUcyMjxx3DoiNpUQKYdmb9pE+jVDWOJ/+ZzGfFZGkE0wRLVWpPfYLUykqTmxSgyeR42EFEGZStsLa6T0N4oVBdAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAIDhx/duKmJxXaodf9xKrYZdYC/s8KFFa/E/Qk166+/laIsQd8fIcdCf/jMUeyWZgS+cRmNxqIpzeM0D9Qip6fKDHUP3Qy7gd/kgPPvuXH2fbDkGRNIjom/QG2LtIpAxejYKNr7sI+LBCGpl4bXTQGkK1H6tuiArhQ1TVXTWKcHSMWMGNq2fCd6vu5g4QjjF5dla4+BZHxeHYvUM3XGzinyW2T1P5fGt+C0kgvYbKIMZLXHX8FJwHiI8UPM9i7WGjVIenVwpNta803pZ4i58DdUC8o7kGQnUIMU2oAEDS7582n4UHuSRa7hNwuPHIDix3Aokh1RBVty5SHTpqhF10yA=');
INSERT INTO keycloak.component_config VALUES ('7ffaf46c-b44c-4665-a9f1-cf90f810a017', 'dbc5139b-13c2-4526-be7c-0cbbe769ea3d', 'keyUse', 'sig');
INSERT INTO keycloak.component_config VALUES ('413070dc-5d2e-413e-89ed-23e419ce6942', '3e91a73f-dd52-4561-9d25-3775fce4c26b', 'algorithm', 'HS256');
INSERT INTO keycloak.component_config VALUES ('d7ce58c6-c77c-442c-ba58-a4a76454fa6a', '3e91a73f-dd52-4561-9d25-3775fce4c26b', 'kid', 'b80897dc-4938-40a6-b63f-642e9205340f');
INSERT INTO keycloak.component_config VALUES ('61b7206b-993c-4a01-9873-7058e704404e', '3e91a73f-dd52-4561-9d25-3775fce4c26b', 'priority', '100');
INSERT INTO keycloak.component_config VALUES ('8d5d46ca-0f03-4ff6-ae04-9f5cf205b7a2', '3e91a73f-dd52-4561-9d25-3775fce4c26b', 'secret', 'l2blH-K3iEqvvUZ0IMxOllSIBlBpYZpttVrvKRaLgX6p8DeMiUhDtvHNeUirmKZH1MtTbNFMgdNs_kI8m3WJiw');
INSERT INTO keycloak.component_config VALUES ('adb265ae-f768-48bc-9043-157bdc59b1b8', '604af98d-d7c9-4390-bc06-5c3391840b51', 'priority', '100');
INSERT INTO keycloak.component_config VALUES ('13226d00-fe66-46c8-a5a6-dec2ab238f27', '604af98d-d7c9-4390-bc06-5c3391840b51', 'kid', '1cbb4a46-5d53-4df4-b026-bdd1b4d25336');
INSERT INTO keycloak.component_config VALUES ('89e2325f-aff7-4590-a22a-06f45e56d678', '604af98d-d7c9-4390-bc06-5c3391840b51', 'secret', '07NTA7gJlb34Pvg3Gyi6ag');
INSERT INTO keycloak.component_config VALUES ('008a83b3-5cc2-498b-a953-82ff27ba48fa', '671f0403-0277-438b-a5fc-c120cebbde3a', 'allow-default-scopes', 'true');
INSERT INTO keycloak.component_config VALUES ('8024e39e-e7e3-498e-8d8b-6403415221a1', 'd121dddd-c8d1-422f-8048-aab3bfb3555d', 'certificate', 'MIICnTCCAYUCBgF8Hp0mWTANBgkqhkiG9w0BAQsFADASMRAwDgYDVQQDDAdhcHBja2V0MB4XDTIxMDkyNTIwMTgwN1oXDTMxMDkyNTIwMTk0N1owEjEQMA4GA1UEAwwHYXBwY2tldDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJs2lKoBL7cx9r3gtS9qt+s3xuofy8+Lij2brBiX6vB0XyF4uiAJUeOSXPo0mIa5CHqqhP1pWQ7RE4oQtb2c2k0f0PMW12kDD6yx7a/9brQQrConvoLVM5RNHaAyofO+X/APbLvUlKYt42wnFyQhmLJENLRFfZkQfg8n7arKYY7OnMDQXG2/sNKEJHIutgDjqeXvapTQdldUrF9jw5zdFA018KMkCn6KWG7qmn27Bzu590UtVBDfL6l30Eq0Tw25sx/pDglTAdQTPHKRIvtBoV66/jNpqnTSZy54XD7KVONSYhu4JqbRYPfKpKQTAW2gBOjKq2+ibC19rJ4WXuNZk10CAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAZO5eVbhfjk9qbgOXNhPK1j6VK6kVA4X8pdU2T1iUMR5M6Ua4omAFNIj9CGm4DA7pdU7FBizpCSRKW1IMjuVZIl9fwSz6aUyqmDs/TL/H72i1M/Be//eZl6gGr3VncYjjiD6WpAw90OQ5bcHi+vUtkUlbkCyqSFflQPxcvDEGh61WN8Akhs/+e04rO3biGgQvFM2cEd96GdS7ACsrrL2H4wJmJWNzNgTO36pyFna+AZHrkKmUSw3OAKdTZnczhLpSZrqwKSfFRYCz0jI8R2AgMaZUpzj05fcxiOctOUEaMAiRfMkbZWOjVlfrDU2V4UK8aa6GJeDV+2fXjtzj2ejlFw==');
INSERT INTO keycloak.component_config VALUES ('85818d30-19b0-4dcc-a27b-0dd61f1bc121', 'd121dddd-c8d1-422f-8048-aab3bfb3555d', 'privateKey', 'MIIEpAIBAAKCAQEAmzaUqgEvtzH2veC1L2q36zfG6h/Lz4uKPZusGJfq8HRfIXi6IAlR45Jc+jSYhrkIeqqE/WlZDtETihC1vZzaTR/Q8xbXaQMPrLHtr/1utBCsKie+gtUzlE0doDKh875f8A9su9SUpi3jbCcXJCGYskQ0tEV9mRB+Dyftqsphjs6cwNBcbb+w0oQkci62AOOp5e9qlNB2V1SsX2PDnN0UDTXwoyQKfopYbuqafbsHO7n3RS1UEN8vqXfQSrRPDbmzH+kOCVMB1BM8cpEi+0GhXrr+M2mqdNJnLnhcPspU41JiG7gmptFg98qkpBMBbaAE6Mqrb6JsLX2snhZe41mTXQIDAQABAoIBABR+P2C26WLpwOdPHP0WvRPceHH/IrzTcrwxqqZQoJ+A7fKQaxrBwEMo1wfeG+ll0t3HV+nRmAWhy0+mZyiS5ivasI74DBb8ZXxqvbRH5O73aJPkTX4ewkGpcOju5n01PJuIndWq+rl6Q5XLD34gxXV8Fe1bY3rrN4muvu2W7QyavD6zkep1eGW3XS2zIrcdUAbWLYyGAI8YVyYb5xxpBNqnmUHWy48fPxPVXej6s91Jg1pobpfl0k13R54gnrGAMxi9DuMfs+33EuhYa6+boY75y/oH461YATiL0XXcynek57UZbfvuK0fbwOVZHk3QWHgPmG2R4iv1N3kcZQe2nkECgYEA2AVWqVES1LHfeNCbSca2z/zdcZD5tvVXdL4cdHzAMz2eDSQvsBT2AxKyXh5kbnjLnODVS8lXa7p7lASXd2cQfDk0S3qzBQUNkuOPvcb/G3xZu+gbCkvzOKE2dVnD80nkrpU8/eaAMfa5CneMkJ3/2WDWc7W9y+I2xreaLja54XECgYEAt/BKUMzBIUMtFyvRXJlR8l92umv2T/3vbGWD3QGi5BMukXkYWLLtOxYW/WAecuSO5H9kGmAxKe87/Sgiy1cM9THJ3YD4AG2KABUqC1px4kK6ZntbeWVxI1oxPs0sAPYjIunDwjLWKZbbcG0jfR7V29EWIyjbjRkWzzp7Lhji2q0CgYEAtXXmklx0QQ8Z9dbmW1b9gkGbkyaBXdtCF+MK7B9PJLwB5HAdTwCMl5BBHSbSnqoCAEotYnhDY09HN9OTmM2O34r+DtmHQBQ6jsVxna1n5qLSjjIvZLrgGRXzNSiundPYsX7TuUTDMzVZwx0hiunuXaAnBRQJ1xazhMH+VgvKoUECgYEApYnPCBrOMUZIvVLFEAY4Ft5NdwcU3PbXVAGkg/EmDQcqYOfPvnwBPqzpscygepwx8XiouYgalvfkUDif38qPMdhGKWAZUiFDEkH53c/fMFcHdJXORFnEUaGpMjDqSk86XgBuGkcwMKvA/9RpHQD0TOlGeAwcU0biHUwvcdQZzd0CgYBMB2RSxsOmfGmfMA68JzB6QoQCASr5U9Bj9NmTNbsq2wnuzH8vhokvrtogjJSmTqBynTGuQKshS/K5yu/nX7SGy0hjHAO0NsH1/+/Dr+SwTpYJp30w2wa2t9Mf9Vj8NngKd0plifk3hKNi8NauVTMFIdFDtiMEShrBUFf1SEBtdQ==');
INSERT INTO keycloak.component_config VALUES ('24694918-04e1-40a9-88a3-ef3b9eacbb09', 'd121dddd-c8d1-422f-8048-aab3bfb3555d', 'priority', '100');
INSERT INTO keycloak.component_config VALUES ('f3a58d55-cc36-4334-ae02-d9992d57e0c9', '7ec14649-b2ce-47b1-a10a-064b6903c573', 'kid', '9591e52d-1b7f-4b24-83bf-508698cdce34');
INSERT INTO keycloak.component_config VALUES ('2ab558b0-99df-48dd-a2b9-ace91ff6f67c', '7ec14649-b2ce-47b1-a10a-064b6903c573', 'priority', '100');
INSERT INTO keycloak.component_config VALUES ('579f0c57-1283-40f7-a1b9-f36f73de33fb', '7ec14649-b2ce-47b1-a10a-064b6903c573', 'algorithm', 'HS256');
INSERT INTO keycloak.component_config VALUES ('83d08490-22f0-4fe6-91c3-09fe5ec45f3e', '7ec14649-b2ce-47b1-a10a-064b6903c573', 'secret', 'f_8apea_5B9EcsvR3A7pVsFHaEN_gNBoMS8qs0iQOmOtKk2TnByjddLoDR1vfVhvEGUuxTSYMNLcvNRsjZzAig');
INSERT INTO keycloak.component_config VALUES ('4e85857a-62f5-4358-8f49-4a461f295314', 'dc5145c3-7f57-40ac-a57b-90d37eccb35e', 'kid', '8a8fed41-f542-421b-b41c-a777c2aa664b');
INSERT INTO keycloak.component_config VALUES ('23b7e182-788f-4d46-9ec6-c23a05618435', 'dc5145c3-7f57-40ac-a57b-90d37eccb35e', 'priority', '100');
INSERT INTO keycloak.component_config VALUES ('29311c87-fc64-4c66-a3c1-8c89de68c9fa', 'dc5145c3-7f57-40ac-a57b-90d37eccb35e', 'secret', 'hajX63Hm-lJJpcpmPrYnOA');
INSERT INTO keycloak.component_config VALUES ('a7fc8f22-c26c-4266-abcc-12e825713857', 'e9c854d5-dea2-4325-a960-8dfed513e4fd', 'max-clients', '200');
INSERT INTO keycloak.component_config VALUES ('a0338b83-5311-4c68-97af-4a462b726e1f', '9465ec8f-999e-487d-8244-d3727e8d66a2', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO keycloak.component_config VALUES ('34b2d57e-ad43-4769-bc8b-b44776d6aa58', '9465ec8f-999e-487d-8244-d3727e8d66a2', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO keycloak.component_config VALUES ('a9f69b3a-c876-473e-8768-a6f431547d96', '9465ec8f-999e-487d-8244-d3727e8d66a2', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO keycloak.component_config VALUES ('d3345bf1-ad30-473d-b9ff-35d612995d2b', '9465ec8f-999e-487d-8244-d3727e8d66a2', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO keycloak.component_config VALUES ('6ce12dcc-3b90-4da9-809c-4a20b133f15f', '9465ec8f-999e-487d-8244-d3727e8d66a2', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO keycloak.component_config VALUES ('96776042-613f-4ce1-869c-620fe2cf2575', '9465ec8f-999e-487d-8244-d3727e8d66a2', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO keycloak.component_config VALUES ('0561091c-dae8-43ea-8ddd-37b3a490658f', '9465ec8f-999e-487d-8244-d3727e8d66a2', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO keycloak.component_config VALUES ('0eeb5bca-d36d-4d20-ae50-6950613f3232', '9465ec8f-999e-487d-8244-d3727e8d66a2', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO keycloak.component_config VALUES ('c4afd5ee-e0de-4c0b-aed3-0f9f4c12f0c7', '4b1d8e10-0855-424a-bf28-20c71714157c', 'host-sending-registration-request-must-match', 'true');
INSERT INTO keycloak.component_config VALUES ('245e799a-50a6-4731-a74f-7a84826b4617', '4b1d8e10-0855-424a-bf28-20c71714157c', 'client-uris-must-match', 'true');
INSERT INTO keycloak.component_config VALUES ('0fe21319-05fd-40d0-b460-713f3de317c8', '1de94ce5-d4ce-4f1b-a20d-3ac17113b2c9', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO keycloak.component_config VALUES ('8bd3b027-9d24-43e6-80f8-98218d2c766e', '1de94ce5-d4ce-4f1b-a20d-3ac17113b2c9', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO keycloak.component_config VALUES ('19ddd13d-0ec6-4e21-940f-c88391157dc7', '1de94ce5-d4ce-4f1b-a20d-3ac17113b2c9', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO keycloak.component_config VALUES ('04f80cee-c1d4-4182-94ad-ba6126408406', '1de94ce5-d4ce-4f1b-a20d-3ac17113b2c9', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO keycloak.component_config VALUES ('29f88569-21f7-436d-8218-27ff87785591', '1de94ce5-d4ce-4f1b-a20d-3ac17113b2c9', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO keycloak.component_config VALUES ('cc1ad2ef-c6b1-4181-a401-f2365e976bf7', '1de94ce5-d4ce-4f1b-a20d-3ac17113b2c9', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO keycloak.component_config VALUES ('b9f30a7b-df0d-40c9-bae5-ca5e508ea123', '1de94ce5-d4ce-4f1b-a20d-3ac17113b2c9', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO keycloak.component_config VALUES ('fda80699-71b5-4f3e-a09e-5b4d12193b65', '1de94ce5-d4ce-4f1b-a20d-3ac17113b2c9', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO keycloak.component_config VALUES ('15aa10ac-82b5-4f96-91d1-b62247890f7b', '0926bc49-92db-4bdb-a535-d257e43d2307', 'allow-default-scopes', 'true');


--
-- TOC entry 3830 (class 0 OID 18186)
-- Dependencies: 207
-- Data for Name: composite_role; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', '9df8472f-07f6-4abd-bf28-0e89fabf25b7');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', '857673b2-29f3-46d9-9196-19fb6c388b4f');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', 'ed55bc40-677f-499f-926a-f48a10d84da6');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', '308f9f7b-3a26-4b35-a8ca-ab2e8ede2e1b');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', 'fedbf7f6-4b56-410c-a312-bc80e632d189');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', 'bba66019-4c9b-4831-8661-0b2affd7af10');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', '40d66c88-bc65-4395-ba21-1ad80a6d8f00');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', '3c440b5e-3813-4b0a-85c6-0937028ff008');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', '7d275cc2-389a-46f0-be00-395eb2118082');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', 'dbb0aaf4-beb4-40a5-ae51-ded8d45f4d58');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', '56867975-ca71-4660-ad79-b2e899ccf2f4');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', 'ea91bfc4-4834-4287-80ee-542b0419e313');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', 'b43b0a86-ff11-4018-9e7c-920c2298e82e');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', 'de255e27-bc9b-42f3-b39d-af12e5932463');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', '3225feac-3ec1-45b4-9b0d-6a71ed8df7e9');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', '12390db9-ef6c-4a14-b6c4-1422e11479ab');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', '84f43f8e-c31c-4f96-bbe8-cfda4e8bec06');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', 'b4f400ed-cc74-4872-aab8-6ff2c69364d0');
INSERT INTO keycloak.composite_role VALUES ('fedbf7f6-4b56-410c-a312-bc80e632d189', '12390db9-ef6c-4a14-b6c4-1422e11479ab');
INSERT INTO keycloak.composite_role VALUES ('308f9f7b-3a26-4b35-a8ca-ab2e8ede2e1b', 'b4f400ed-cc74-4872-aab8-6ff2c69364d0');
INSERT INTO keycloak.composite_role VALUES ('308f9f7b-3a26-4b35-a8ca-ab2e8ede2e1b', '3225feac-3ec1-45b4-9b0d-6a71ed8df7e9');
INSERT INTO keycloak.composite_role VALUES ('f61b13f5-0859-413b-ba9f-27b4cb813144', '8cf0fd22-290f-4b41-b57c-3ce2901dd6e6');
INSERT INTO keycloak.composite_role VALUES ('f61b13f5-0859-413b-ba9f-27b4cb813144', '3bc03d66-dc4a-4a39-9a0c-f30ddbaa9770');
INSERT INTO keycloak.composite_role VALUES ('3bc03d66-dc4a-4a39-9a0c-f30ddbaa9770', '270797cb-6aab-4275-b3b9-1137966534eb');
INSERT INTO keycloak.composite_role VALUES ('186a05f0-56ab-427e-81b5-e8e50fd82cd5', '240e1880-e5b4-431a-b84d-cb668acbda4e');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', 'b6e6e9ee-b85a-4860-9df8-09d6cd98d975');
INSERT INTO keycloak.composite_role VALUES ('f61b13f5-0859-413b-ba9f-27b4cb813144', 'e07ab02f-9442-4b41-9056-b96aea48e2c4');
INSERT INTO keycloak.composite_role VALUES ('f61b13f5-0859-413b-ba9f-27b4cb813144', '64331ac1-3077-49a0-8451-3d2b74063d77');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', '15387fbb-8c52-4094-876c-08c89ec8c879');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', 'f4ba8174-d0a5-4a86-b993-b4432170bb07');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', 'fbe84264-fc60-4474-9dc7-d88271c02e12');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', '37860bf2-1f7f-4bd4-be97-ee0d60ada697');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', '955c4aea-dcf5-4878-96e4-f83f031ba898');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', '2897fc36-c1d7-4212-9077-3ac3f7e4559a');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', '29d0ec4d-11cb-40da-93f8-60e7c8fd9d8f');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', '03a642ad-e50c-4b57-8e40-28ca79d7420e');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', '2470c952-a922-4f91-8f53-2cd1866f9d30');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', '1067255b-939b-49c3-a8c7-541e63745751');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', '821f3cc6-b842-47a7-a2ec-9f8a91f17c56');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', 'ee386e8e-9487-4746-9528-84d94d69cca1');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', '17747eaa-910c-4c84-b050-594c34e7b078');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', 'c9fa526a-5325-47d3-ac0e-4f55cab07513');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', '96d918dc-383f-4c61-9b5c-4984e09ae5b8');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', '4ae9f88d-e42c-4ea0-9811-8dab1ba11928');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', '03a5c85c-2ad0-4b7b-a388-1d9e216023a1');
INSERT INTO keycloak.composite_role VALUES ('37860bf2-1f7f-4bd4-be97-ee0d60ada697', '96d918dc-383f-4c61-9b5c-4984e09ae5b8');
INSERT INTO keycloak.composite_role VALUES ('fbe84264-fc60-4474-9dc7-d88271c02e12', 'c9fa526a-5325-47d3-ac0e-4f55cab07513');
INSERT INTO keycloak.composite_role VALUES ('fbe84264-fc60-4474-9dc7-d88271c02e12', '03a5c85c-2ad0-4b7b-a388-1d9e216023a1');
INSERT INTO keycloak.composite_role VALUES ('934d2eb7-4ffa-406f-b8a9-155460dd9872', '14183e37-4d0d-4f80-89a9-d979c7676d6a');
INSERT INTO keycloak.composite_role VALUES ('934d2eb7-4ffa-406f-b8a9-155460dd9872', '3fda9186-3fda-413f-900b-43b487d08732');
INSERT INTO keycloak.composite_role VALUES ('d0202d84-e5c0-4558-b385-c04149655885', 'a1516493-c8b5-4001-a15a-d2b4a53964cc');
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
INSERT INTO keycloak.composite_role VALUES ('4be9e535-34e3-4ebc-8591-1f575899d346', '750a3b3a-0cbc-47dd-b3e5-0de2a88b8a82');
INSERT INTO keycloak.composite_role VALUES ('3a3efbeb-83dc-4f82-b78d-f00e954d7d40', '241f95cd-d0a8-4b5e-b7d3-657f078175bb');
INSERT INTO keycloak.composite_role VALUES ('3a3efbeb-83dc-4f82-b78d-f00e954d7d40', '558648c2-b53b-4dfd-906f-d30b67967ecd');
INSERT INTO keycloak.composite_role VALUES ('3a3efbeb-83dc-4f82-b78d-f00e954d7d40', '395df0fe-9ce6-4af3-9d3f-a76b64e2c6b1');
INSERT INTO keycloak.composite_role VALUES ('3a3efbeb-83dc-4f82-b78d-f00e954d7d40', 'f82082f8-ce8f-4514-a0df-08b916e08db3');
INSERT INTO keycloak.composite_role VALUES ('3a3efbeb-83dc-4f82-b78d-f00e954d7d40', 'eee97160-4b67-4071-84f4-099bbcd704af');
INSERT INTO keycloak.composite_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', 'd4118ce7-2210-418e-80d2-03c8a4da8c6d');
INSERT INTO keycloak.composite_role VALUES ('97caa102-e9d8-44de-94a1-74e5ea7bccb5', '934d2eb7-4ffa-406f-b8a9-155460dd9872');
INSERT INTO keycloak.composite_role VALUES ('eee97160-4b67-4071-84f4-099bbcd704af', '934d2eb7-4ffa-406f-b8a9-155460dd9872');
INSERT INTO keycloak.composite_role VALUES ('1b55f720-894d-4d89-b37d-358e5eb29309', '934d2eb7-4ffa-406f-b8a9-155460dd9872');
INSERT INTO keycloak.composite_role VALUES ('a1234e9b-ccf4-43c2-8c5a-f8d5964d9e22', 'f82082f8-ce8f-4514-a0df-08b916e08db3');
INSERT INTO keycloak.composite_role VALUES ('a1234e9b-ccf4-43c2-8c5a-f8d5964d9e22', '934d2eb7-4ffa-406f-b8a9-155460dd9872');


--
-- TOC entry 3831 (class 0 OID 18189)
-- Dependencies: 208
-- Data for Name: credential; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.credential VALUES ('d272d8d1-03a7-4768-b24f-63c9afcf8ce6', NULL, 'password', '60eefe04-5c0e-456b-9f20-6b6c333cece7', 1632600814644, NULL, '{"value":"6ZNpYldXDDiiE2A6JkjuNjsEQT+eLCKqexpktXtpD6CdMXwvpa/Vd+20dTNlJrG/LD7jvfrEsez89fVB7+F4Qg==","salt":"MbtLu+iaVaAZtETGdi1AeA==","additionalParameters":{}}', '{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}', 10);
INSERT INTO keycloak.credential VALUES ('992152ad-8d84-4014-8c3b-3de8883e3c72', NULL, 'password', '4379775d-7629-4dca-9dd0-8781329569b1', 1632668973268, NULL, '{"value":"hZsM7Qtd566CRWxiCQxu3FNewjDroYOjf4Te0RPhDR2a7WGuHtLtPa0AUPfEJOu9ipUiU1UJDZoFzcgpNARf0Q==","salt":"rEnAaPQ9o9FcDZtfhAV3EA==","additionalParameters":{}}', '{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}', 10);
INSERT INTO keycloak.credential VALUES ('e738320d-6c35-43ce-95b5-04da77246a6e', NULL, 'password', '18b24af2-ef61-4fcc-a1e0-b27bbc4f6a2d', 1632668988369, NULL, '{"value":"rxoMy/nSkhR4Yal+veZBuZndWH3KWIlrXLbuo2/IAhjfU5/15CuFpsKxEZrcjjwEiVdCCdRnn+6SYj/rhK4Nqg==","salt":"91gXPK4tVo/PhDVme3TjGQ==","additionalParameters":{}}', '{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}', 10);
INSERT INTO keycloak.credential VALUES ('2e3e7933-e48e-4602-9348-a88950a49868', NULL, 'password', 'ff88829c-0226-44f3-9eb2-6e294ccd57d3', 1632669036688, NULL, '{"value":"tHm9feYD5pHWcnKoXtf/COYysotK3ztoapWcYt/yCfD6i4qWM7BvMn2VZS3MXBu9blTR/yJ5UwPV0M7msyl/8A==","salt":"RzmYWrd6CqqtETnx+IwZPg==","additionalParameters":{}}', '{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}', 10);
INSERT INTO keycloak.credential VALUES ('b5781713-d6e3-46cd-a8d6-a1bd4469f91f', NULL, 'password', '6dde7b5b-ffe1-4627-9ca9-d4c5290f6f20', 1632669052834, NULL, '{"value":"XiD09egbHb0yVmpNX7BWRXJdOemplLEhJQLg++ZxT3TstE9lHZA6qddcOl2ai05sBgcDwjhcvya3V0OHGbwShg==","salt":"WD66fQtQ4jHszMfaFhBDMg==","additionalParameters":{}}', '{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}', 10);
INSERT INTO keycloak.credential VALUES ('97578ca8-4a62-4ba8-9f88-262a1c430777', NULL, 'password', 'cd88e2db-00bb-474f-91d2-2096e10f86a1', 1632669065897, NULL, '{"value":"Rb+Rs33Sly2l/nJ7lpbxKnBo8AJPxva+55c73uhzpgxzbkiFEUmR1zzcB7oyC8oE5HitbC8fjU4GjyESLDW66g==","salt":"vOMknkyxx7kE6QKA6oZDhA==","additionalParameters":{}}', '{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}', 10);


--
-- TOC entry 3826 (class 0 OID 18156)
-- Dependencies: 203
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.databasechangelog VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.0.0.Final.xml', '2021-09-25 20:13:24.313774', 1, 'EXECUTED', '7:4e70412f24a3f382c82183742ec79317', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/db2-jpa-changelog-1.0.0.Final.xml', '2021-09-25 20:13:24.328401', 2, 'MARK_RAN', '7:cb16724583e9675711801c6875114f28', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('1.1.0.Beta1', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Beta1.xml', '2021-09-25 20:13:24.385597', 3, 'EXECUTED', '7:0310eb8ba07cec616460794d42ade0fa', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('1.1.0.Final', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Final.xml', '2021-09-25 20:13:24.392484', 4, 'EXECUTED', '7:5d25857e708c3233ef4439df1f93f012', 'renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/jpa-changelog-1.2.0.Beta1.xml', '2021-09-25 20:13:24.52785', 5, 'EXECUTED', '7:c7a54a1041d58eb3817a4a883b4d4e84', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.Beta1.xml', '2021-09-25 20:13:24.533475', 6, 'MARK_RAN', '7:2e01012df20974c1c2a605ef8afe25b7', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.2.0.CR1.xml', '2021-09-25 20:13:24.662465', 7, 'EXECUTED', '7:0f08df48468428e0f30ee59a8ec01a41', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.CR1.xml', '2021-09-25 20:13:24.668329', 8, 'MARK_RAN', '7:a77ea2ad226b345e7d689d366f185c8c', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('1.2.0.Final', 'keycloak', 'META-INF/jpa-changelog-1.2.0.Final.xml', '2021-09-25 20:13:24.679429', 9, 'EXECUTED', '7:a3377a2059aefbf3b90ebb4c4cc8e2ab', 'update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('1.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.3.0.xml', '2021-09-25 20:13:24.817213', 10, 'EXECUTED', '7:04c1dbedc2aa3e9756d1a1668e003451', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.4.0.xml', '2021-09-25 20:13:24.913503', 11, 'EXECUTED', '7:36ef39ed560ad07062d956db861042ba', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.4.0.xml', '2021-09-25 20:13:24.918929', 12, 'MARK_RAN', '7:d909180b2530479a716d3f9c9eaea3d7', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('1.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.5.0.xml', '2021-09-25 20:13:24.953747', 13, 'EXECUTED', '7:cf12b04b79bea5152f165eb41f3955f6', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('1.6.1_from15', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2021-09-25 20:13:24.986922', 14, 'EXECUTED', '7:7e32c8f05c755e8675764e7d5f514509', 'addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('1.6.1_from16-pre', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2021-09-25 20:13:24.990596', 15, 'MARK_RAN', '7:980ba23cc0ec39cab731ce903dd01291', 'delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('1.6.1_from16', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2021-09-25 20:13:24.994866', 16, 'MARK_RAN', '7:2fa220758991285312eb84f3b4ff5336', 'dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('1.6.1', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2021-09-25 20:13:24.998736', 17, 'EXECUTED', '7:d41d8cd98f00b204e9800998ecf8427e', 'empty', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('1.7.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.7.0.xml', '2021-09-25 20:13:25.070866', 18, 'EXECUTED', '7:91ace540896df890cc00a0490ee52bbc', 'createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.8.0.xml', '2021-09-25 20:13:25.144449', 19, 'EXECUTED', '7:c31d1646dfa2618a9335c00e07f89f24', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('1.8.0-2', 'keycloak', 'META-INF/jpa-changelog-1.8.0.xml', '2021-09-25 20:13:25.153186', 20, 'EXECUTED', '7:df8bc21027a4f7cbbb01f6344e89ce07', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part1', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2021-09-25 20:13:26.873295', 45, 'EXECUTED', '7:6a48ce645a3525488a90fbf76adf3bb3', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2021-09-25 20:13:25.157046', 21, 'MARK_RAN', '7:f987971fe6b37d963bc95fee2b27f8df', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('1.8.0-2', 'keycloak', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2021-09-25 20:13:25.161477', 22, 'MARK_RAN', '7:df8bc21027a4f7cbbb01f6344e89ce07', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('1.9.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.9.0.xml', '2021-09-25 20:13:25.239124', 23, 'EXECUTED', '7:ed2dc7f799d19ac452cbcda56c929e47', 'update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('1.9.1', 'keycloak', 'META-INF/jpa-changelog-1.9.1.xml', '2021-09-25 20:13:25.250729', 24, 'EXECUTED', '7:80b5db88a5dda36ece5f235be8757615', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('1.9.1', 'keycloak', 'META-INF/db2-jpa-changelog-1.9.1.xml', '2021-09-25 20:13:25.254703', 25, 'MARK_RAN', '7:1437310ed1305a9b93f8848f301726ce', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('1.9.2', 'keycloak', 'META-INF/jpa-changelog-1.9.2.xml', '2021-09-25 20:13:25.506047', 26, 'EXECUTED', '7:b82ffb34850fa0836be16deefc6a87c4', 'createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('authz-2.0.0', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.0.0.xml', '2021-09-25 20:13:25.625143', 27, 'EXECUTED', '7:9cc98082921330d8d9266decdd4bd658', 'createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('authz-2.5.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.5.1.xml', '2021-09-25 20:13:25.632568', 28, 'EXECUTED', '7:03d64aeed9cb52b969bd30a7ac0db57e', 'update tableName=RESOURCE_SERVER_POLICY', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('2.1.0-KEYCLOAK-5461', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.1.0.xml', '2021-09-25 20:13:25.725837', 29, 'EXECUTED', '7:f1f9fd8710399d725b780f463c6b21cd', 'createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('2.2.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.2.0.xml', '2021-09-25 20:13:25.749323', 30, 'EXECUTED', '7:53188c3eb1107546e6f765835705b6c1', 'addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('2.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.3.0.xml', '2021-09-25 20:13:25.777424', 31, 'EXECUTED', '7:d6e6f3bc57a0c5586737d1351725d4d4', 'createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('2.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.4.0.xml', '2021-09-25 20:13:25.784513', 32, 'EXECUTED', '7:454d604fbd755d9df3fd9c6329043aa5', 'customChange', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2021-09-25 20:13:25.79455', 33, 'EXECUTED', '7:57e98a3077e29caf562f7dbf80c72600', 'customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0-unicode-oracle', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2021-09-25 20:13:25.798316', 34, 'MARK_RAN', '7:e4c7e8f2256210aee71ddc42f538b57a', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0-unicode-other-dbs', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2021-09-25 20:13:25.854159', 35, 'EXECUTED', '7:09a43c97e49bc626460480aa1379b522', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0-duplicate-email-support', 'slawomir@dabek.name', 'META-INF/jpa-changelog-2.5.0.xml', '2021-09-25 20:13:25.863013', 36, 'EXECUTED', '7:26bfc7c74fefa9126f2ce702fb775553', 'addColumn tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.0-unique-group-names', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2021-09-25 20:13:25.872847', 37, 'EXECUTED', '7:a161e2ae671a9020fff61e996a207377', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('2.5.1', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.1.xml', '2021-09-25 20:13:25.880557', 38, 'EXECUTED', '7:37fc1781855ac5388c494f1442b3f717', 'addColumn tableName=FED_USER_CONSENT', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('3.0.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-3.0.0.xml', '2021-09-25 20:13:25.888159', 39, 'EXECUTED', '7:13a27db0dae6049541136adad7261d27', 'addColumn tableName=IDENTITY_PROVIDER', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('3.2.0-fix', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2021-09-25 20:13:25.891898', 40, 'MARK_RAN', '7:550300617e3b59e8af3a6294df8248a3', 'addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('3.2.0-fix-with-keycloak-5416', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2021-09-25 20:13:25.896187', 41, 'MARK_RAN', '7:e3a9482b8931481dc2772a5c07c44f17', 'dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('3.2.0-fix-offline-sessions', 'hmlnarik', 'META-INF/jpa-changelog-3.2.0.xml', '2021-09-25 20:13:25.903495', 42, 'EXECUTED', '7:72b07d85a2677cb257edb02b408f332d', 'customChange', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('3.2.0-fixed', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2021-09-25 20:13:26.856834', 43, 'EXECUTED', '7:a72a7858967bd414835d19e04d880312', 'addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('3.3.0', 'keycloak', 'META-INF/jpa-changelog-3.3.0.xml', '2021-09-25 20:13:26.864479', 44, 'EXECUTED', '7:94edff7cf9ce179e7e85f0cd78a3cf2c', 'addColumn tableName=USER_ENTITY', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2021-09-25 20:13:26.88091', 46, 'EXECUTED', '7:e64b5dcea7db06077c6e57d3b9e5ca14', 'customChange', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2021-09-25 20:13:26.884751', 47, 'MARK_RAN', '7:fd8cf02498f8b1e72496a20afc75178c', 'dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2021-09-25 20:13:26.996172', 48, 'EXECUTED', '7:542794f25aa2b1fbabb7e577d6646319', 'addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('authn-3.4.0.CR1-refresh-token-max-reuse', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2021-09-25 20:13:27.005873', 49, 'EXECUTED', '7:edad604c882df12f74941dac3cc6d650', 'addColumn tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.0', 'keycloak', 'META-INF/jpa-changelog-3.4.0.xml', '2021-09-25 20:13:27.078831', 50, 'EXECUTED', '7:0f88b78b7b46480eb92690cbf5e44900', 'addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.0-KEYCLOAK-5230', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-3.4.0.xml', '2021-09-25 20:13:27.296824', 51, 'EXECUTED', '7:d560e43982611d936457c327f872dd59', 'createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-3.4.1.xml', '2021-09-25 20:13:27.303429', 52, 'EXECUTED', '7:c155566c42b4d14ef07059ec3b3bbd8e', 'modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.2', 'keycloak', 'META-INF/jpa-changelog-3.4.2.xml', '2021-09-25 20:13:27.308578', 53, 'EXECUTED', '7:b40376581f12d70f3c89ba8ddf5b7dea', 'update tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('3.4.2-KEYCLOAK-5172', 'mkanis@redhat.com', 'META-INF/jpa-changelog-3.4.2.xml', '2021-09-25 20:13:27.313739', 54, 'EXECUTED', '7:a1132cc395f7b95b3646146c2e38f168', 'update tableName=CLIENT', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('4.0.0-KEYCLOAK-6335', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2021-09-25 20:13:27.324697', 55, 'EXECUTED', '7:d8dc5d89c789105cfa7ca0e82cba60af', 'createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('4.0.0-CLEANUP-UNUSED-TABLE', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2021-09-25 20:13:27.332936', 56, 'EXECUTED', '7:7822e0165097182e8f653c35517656a3', 'dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('4.0.0-KEYCLOAK-6228', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2021-09-25 20:13:27.380075', 57, 'EXECUTED', '7:c6538c29b9c9a08f9e9ea2de5c2b6375', 'dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('4.0.0-KEYCLOAK-5579-fixed', 'mposolda@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2021-09-25 20:13:27.673181', 58, 'EXECUTED', '7:6d4893e36de22369cf73bcb051ded875', 'dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('authz-4.0.0.CR1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.CR1.xml', '2021-09-25 20:13:27.713267', 59, 'EXECUTED', '7:57960fc0b0f0dd0563ea6f8b2e4a1707', 'createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('authz-4.0.0.Beta3', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.Beta3.xml', '2021-09-25 20:13:27.722882', 60, 'EXECUTED', '7:2b4b8bff39944c7097977cc18dbceb3b', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('authz-4.2.0.Final', 'mhajas@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2021-09-25 20:13:27.735842', 61, 'EXECUTED', '7:2aa42a964c59cd5b8ca9822340ba33a8', 'createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('authz-4.2.0.Final-KEYCLOAK-9944', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2021-09-25 20:13:27.745036', 62, 'EXECUTED', '7:9ac9e58545479929ba23f4a3087a0346', 'addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('4.2.0-KEYCLOAK-6313', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.2.0.xml', '2021-09-25 20:13:27.75279', 63, 'EXECUTED', '7:14d407c35bc4fe1976867756bcea0c36', 'addColumn tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('4.3.0-KEYCLOAK-7984', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.3.0.xml', '2021-09-25 20:13:27.757608', 64, 'EXECUTED', '7:241a8030c748c8548e346adee548fa93', 'update tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('4.6.0-KEYCLOAK-7950', 'psilva@redhat.com', 'META-INF/jpa-changelog-4.6.0.xml', '2021-09-25 20:13:27.762569', 65, 'EXECUTED', '7:7d3182f65a34fcc61e8d23def037dc3f', 'update tableName=RESOURCE_SERVER_RESOURCE', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('4.6.0-KEYCLOAK-8377', 'keycloak', 'META-INF/jpa-changelog-4.6.0.xml', '2021-09-25 20:13:27.804667', 66, 'EXECUTED', '7:b30039e00a0b9715d430d1b0636728fa', 'createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('4.6.0-KEYCLOAK-8555', 'gideonray@gmail.com', 'META-INF/jpa-changelog-4.6.0.xml', '2021-09-25 20:13:27.829651', 67, 'EXECUTED', '7:3797315ca61d531780f8e6f82f258159', 'createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('4.7.0-KEYCLOAK-1267', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.7.0.xml', '2021-09-25 20:13:27.843675', 68, 'EXECUTED', '7:c7aa4c8d9573500c2d347c1941ff0301', 'addColumn tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('4.7.0-KEYCLOAK-7275', 'keycloak', 'META-INF/jpa-changelog-4.7.0.xml', '2021-09-25 20:13:27.873025', 69, 'EXECUTED', '7:b207faee394fc074a442ecd42185a5dd', 'renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('4.8.0-KEYCLOAK-8835', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.8.0.xml', '2021-09-25 20:13:27.882881', 70, 'EXECUTED', '7:ab9a9762faaba4ddfa35514b212c4922', 'addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('authz-7.0.0-KEYCLOAK-10443', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-7.0.0.xml', '2021-09-25 20:13:27.889708', 71, 'EXECUTED', '7:b9710f74515a6ccb51b72dc0d19df8c4', 'addColumn tableName=RESOURCE_SERVER', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-adding-credential-columns', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2021-09-25 20:13:27.900999', 72, 'EXECUTED', '7:ec9707ae4d4f0b7452fee20128083879', 'addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-updating-credential-data-not-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2021-09-25 20:13:27.91261', 73, 'EXECUTED', '7:3979a0ae07ac465e920ca696532fc736', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-updating-credential-data-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2021-09-25 20:13:27.91587', 74, 'MARK_RAN', '7:5abfde4c259119d143bd2fbf49ac2bca', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-credential-cleanup-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2021-09-25 20:13:27.947524', 75, 'EXECUTED', '7:b48da8c11a3d83ddd6b7d0c8c2219345', 'dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('8.0.0-resource-tag-support', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2021-09-25 20:13:27.972122', 76, 'EXECUTED', '7:a73379915c23bfad3e8f5c6d5c0aa4bd', 'addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.0-always-display-client', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2021-09-25 20:13:27.979088', 77, 'EXECUTED', '7:39e0073779aba192646291aa2332493d', 'addColumn tableName=CLIENT', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.0-drop-constraints-for-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2021-09-25 20:13:27.983047', 78, 'MARK_RAN', '7:81f87368f00450799b4bf42ea0b3ec34', 'dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.0-increase-column-size-federated-fk', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2021-09-25 20:13:28.010908', 79, 'EXECUTED', '7:20b37422abb9fb6571c618148f013a15', 'modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.0-recreate-constraints-after-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2021-09-25 20:13:28.014858', 80, 'MARK_RAN', '7:1970bb6cfb5ee800736b95ad3fb3c78a', 'addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-add-index-to-client.client_id', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2021-09-25 20:13:28.0447', 81, 'EXECUTED', '7:45d9b25fc3b455d522d8dcc10a0f4c80', 'createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2021-09-25 20:13:28.048376', 82, 'MARK_RAN', '7:890ae73712bc187a66c2813a724d037f', 'dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-add-not-null-constraint', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2021-09-25 20:13:28.059263', 83, 'EXECUTED', '7:0a211980d27fafe3ff50d19a3a29b538', 'addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-KEYCLOAK-12579-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2021-09-25 20:13:28.063279', 84, 'MARK_RAN', '7:a161e2ae671a9020fff61e996a207377', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('9.0.1-add-index-to-events', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2021-09-25 20:13:28.087969', 85, 'EXECUTED', '7:01c49302201bdf815b0a18d1f98a55dc', 'createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-11.0.0.xml', '2021-09-25 20:13:28.096884', 86, 'EXECUTED', '7:3dace6b144c11f53f1ad2c0361279b86', 'dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2021-09-25 20:13:28.110125', 87, 'EXECUTED', '7:578d0b92077eaf2ab95ad0ec087aa903', 'dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('12.1.0-add-realm-localization-table', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2021-09-25 20:13:28.12386', 88, 'EXECUTED', '7:c95abe90d962c57a09ecaee57972835d', 'createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('default-roles', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2021-09-25 20:13:28.134799', 89, 'EXECUTED', '7:f1313bcc2994a5c4dc1062ed6d8282d3', 'addColumn tableName=REALM; customChange', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('default-roles-cleanup', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2021-09-25 20:13:28.145368', 90, 'EXECUTED', '7:90d763b52eaffebefbcbde55f269508b', 'dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('13.0.0-KEYCLOAK-16844', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2021-09-25 20:13:28.168666', 91, 'EXECUTED', '7:d554f0cb92b764470dccfa5e0014a7dd', 'createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('map-remove-ri-13.0.0', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2021-09-25 20:13:28.182187', 92, 'EXECUTED', '7:73193e3ab3c35cf0f37ccea3bf783764', 'dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('13.0.0-KEYCLOAK-17992-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2021-09-25 20:13:28.185825', 93, 'MARK_RAN', '7:90a1e74f92e9cbaa0c5eab80b8a037f3', 'dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('13.0.0-increase-column-size-federated', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2021-09-25 20:13:28.198588', 94, 'EXECUTED', '7:5b9248f29cd047c200083cc6d8388b16', 'modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('13.0.0-KEYCLOAK-17992-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2021-09-25 20:13:28.203065', 95, 'MARK_RAN', '7:64db59e44c374f13955489e8990d17a1', 'addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('json-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2021-09-25 20:13:28.213645', 96, 'EXECUTED', '7:329a578cdb43262fff975f0a7f6cda60', 'addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-11019', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2021-09-25 20:13:28.278466', 97, 'EXECUTED', '7:fae0de241ac0fd0bbc2b380b85e4f567', 'createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2021-09-25 20:13:28.282089', 98, 'MARK_RAN', '7:075d54e9180f49bb0c64ca4218936e81', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-revert', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2021-09-25 20:13:28.309274', 99, 'MARK_RAN', '7:06499836520f4f6b3d05e35a59324910', 'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2021-09-25 20:13:28.335041', 100, 'EXECUTED', '7:fad08e83c77d0171ec166bc9bc5d390a', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('14.0.0-KEYCLOAK-18286-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2021-09-25 20:13:28.338242', 101, 'MARK_RAN', '7:3d2b23076e59c6f70bae703aa01be35b', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('KEYCLOAK-17267-add-index-to-user-attributes', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2021-09-25 20:13:28.363476', 102, 'EXECUTED', '7:1a7f28ff8d9e53aeb879d76ea3d9341a', 'createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('KEYCLOAK-18146-add-saml-art-binding-identifier', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2021-09-25 20:13:28.369455', 103, 'EXECUTED', '7:2fd554456fed4a82c698c555c5b751b6', 'customChange', '', NULL, '3.5.4', NULL, NULL, '2600803807');
INSERT INTO keycloak.databasechangelog VALUES ('15.0.0-KEYCLOAK-18467', 'keycloak', 'META-INF/jpa-changelog-15.0.0.xml', '2021-09-25 20:13:28.385421', 104, 'EXECUTED', '7:b06356d66c2790ecc2ae54ba0458397a', 'addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...', '', NULL, '3.5.4', NULL, NULL, '2600803807');


--
-- TOC entry 3825 (class 0 OID 18151)
-- Dependencies: 202
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.databasechangeloglock VALUES (1, false, NULL, NULL);
INSERT INTO keycloak.databasechangeloglock VALUES (1000, false, NULL, NULL);
INSERT INTO keycloak.databasechangeloglock VALUES (1001, false, NULL, NULL);


--
-- TOC entry 3909 (class 0 OID 19605)
-- Dependencies: 286
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.default_client_scope VALUES ('master', 'f4a49c56-0dfe-4be4-8176-4ee226f1f09f', false);
INSERT INTO keycloak.default_client_scope VALUES ('master', 'c300fd83-f791-4986-8ed7-bb3bb4520e36', true);
INSERT INTO keycloak.default_client_scope VALUES ('master', 'a34ae2c0-3ca3-43d7-b8e4-bd7b277dfdae', true);
INSERT INTO keycloak.default_client_scope VALUES ('master', '0d6aeed8-8d73-4978-bc5e-16de7f6f399d', true);
INSERT INTO keycloak.default_client_scope VALUES ('master', 'e765c4b2-81f4-472f-b26e-2fcec6f21c18', false);
INSERT INTO keycloak.default_client_scope VALUES ('master', 'c6d8e038-d6a2-44a0-875d-d82cedab755f', false);
INSERT INTO keycloak.default_client_scope VALUES ('master', 'd06cb9d2-8cc3-4ee2-b0d3-50e7b4599b00', true);
INSERT INTO keycloak.default_client_scope VALUES ('master', '61d1cc86-30fb-44e6-8a4c-bb300d512001', true);
INSERT INTO keycloak.default_client_scope VALUES ('master', '0c087984-3399-4738-8c0c-14f0b6483d8e', false);
INSERT INTO keycloak.default_client_scope VALUES ('appcket', 'bed9e481-a783-4f6c-bd5a-f79f5d189ee6', true);
INSERT INTO keycloak.default_client_scope VALUES ('appcket', 'aee86bba-572b-4335-8f5b-c9969c70cbce', true);
INSERT INTO keycloak.default_client_scope VALUES ('appcket', '63984129-44c9-4bd1-97d1-da0df3407112', true);
INSERT INTO keycloak.default_client_scope VALUES ('appcket', '2b5c02f3-e7a9-4455-a505-9fef19838927', true);
INSERT INTO keycloak.default_client_scope VALUES ('appcket', '52312b11-3e69-46f2-93f2-b1e168214598', true);
INSERT INTO keycloak.default_client_scope VALUES ('appcket', '1ddb5c58-3c5b-43bc-ae48-ba8947a6c108', false);
INSERT INTO keycloak.default_client_scope VALUES ('appcket', 'b2414a14-1f25-4d4b-9162-de66eeb6652d', false);
INSERT INTO keycloak.default_client_scope VALUES ('appcket', '4709e0fb-184a-4b47-a804-ae1556e53a73', false);
INSERT INTO keycloak.default_client_scope VALUES ('appcket', 'a15b2f14-004d-47f8-b137-7bca43fc8b30', false);


--
-- TOC entry 3832 (class 0 OID 18195)
-- Dependencies: 209
-- Data for Name: event_entity; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3897 (class 0 OID 19294)
-- Dependencies: 274
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3898 (class 0 OID 19300)
-- Dependencies: 275
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3911 (class 0 OID 19631)
-- Dependencies: 288
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3899 (class 0 OID 19309)
-- Dependencies: 276
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3900 (class 0 OID 19319)
-- Dependencies: 277
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3901 (class 0 OID 19322)
-- Dependencies: 278
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3902 (class 0 OID 19329)
-- Dependencies: 279
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3855 (class 0 OID 18589)
-- Dependencies: 232
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3905 (class 0 OID 19398)
-- Dependencies: 282
-- Data for Name: federated_user; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3881 (class 0 OID 19008)
-- Dependencies: 258
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3880 (class 0 OID 19005)
-- Dependencies: 257
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3856 (class 0 OID 18595)
-- Dependencies: 233
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3857 (class 0 OID 18605)
-- Dependencies: 234
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3862 (class 0 OID 18711)
-- Dependencies: 239
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3863 (class 0 OID 18717)
-- Dependencies: 240
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3879 (class 0 OID 19002)
-- Dependencies: 256
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3833 (class 0 OID 18204)
-- Dependencies: 210
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.keycloak_role VALUES ('f61b13f5-0859-413b-ba9f-27b4cb813144', 'master', false, '${role_default-roles}', 'default-roles-master', 'master', NULL, NULL);
INSERT INTO keycloak.keycloak_role VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', 'master', false, '${role_admin}', 'admin', 'master', NULL, NULL);
INSERT INTO keycloak.keycloak_role VALUES ('9df8472f-07f6-4abd-bf28-0e89fabf25b7', 'master', false, '${role_create-realm}', 'create-realm', 'master', NULL, NULL);
INSERT INTO keycloak.keycloak_role VALUES ('857673b2-29f3-46d9-9196-19fb6c388b4f', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', true, '${role_create-client}', 'create-client', 'master', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('ed55bc40-677f-499f-926a-f48a10d84da6', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', true, '${role_view-realm}', 'view-realm', 'master', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('308f9f7b-3a26-4b35-a8ca-ab2e8ede2e1b', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', true, '${role_view-users}', 'view-users', 'master', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('fedbf7f6-4b56-410c-a312-bc80e632d189', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', true, '${role_view-clients}', 'view-clients', 'master', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('bba66019-4c9b-4831-8661-0b2affd7af10', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', true, '${role_view-events}', 'view-events', 'master', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('40d66c88-bc65-4395-ba21-1ad80a6d8f00', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', true, '${role_view-identity-providers}', 'view-identity-providers', 'master', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('3c440b5e-3813-4b0a-85c6-0937028ff008', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', true, '${role_view-authorization}', 'view-authorization', 'master', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('7d275cc2-389a-46f0-be00-395eb2118082', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', true, '${role_manage-realm}', 'manage-realm', 'master', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('dbb0aaf4-beb4-40a5-ae51-ded8d45f4d58', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', true, '${role_manage-users}', 'manage-users', 'master', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('56867975-ca71-4660-ad79-b2e899ccf2f4', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', true, '${role_manage-clients}', 'manage-clients', 'master', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('ea91bfc4-4834-4287-80ee-542b0419e313', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', true, '${role_manage-events}', 'manage-events', 'master', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('b43b0a86-ff11-4018-9e7c-920c2298e82e', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'master', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('de255e27-bc9b-42f3-b39d-af12e5932463', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', true, '${role_manage-authorization}', 'manage-authorization', 'master', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('3225feac-3ec1-45b4-9b0d-6a71ed8df7e9', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', true, '${role_query-users}', 'query-users', 'master', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('12390db9-ef6c-4a14-b6c4-1422e11479ab', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', true, '${role_query-clients}', 'query-clients', 'master', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('84f43f8e-c31c-4f96-bbe8-cfda4e8bec06', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', true, '${role_query-realms}', 'query-realms', 'master', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('b4f400ed-cc74-4872-aab8-6ff2c69364d0', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', true, '${role_query-groups}', 'query-groups', 'master', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('8cf0fd22-290f-4b41-b57c-3ce2901dd6e6', 'b76c70fe-8825-46a4-bd41-b8f291e910c5', true, '${role_view-profile}', 'view-profile', 'master', 'b76c70fe-8825-46a4-bd41-b8f291e910c5', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('3bc03d66-dc4a-4a39-9a0c-f30ddbaa9770', 'b76c70fe-8825-46a4-bd41-b8f291e910c5', true, '${role_manage-account}', 'manage-account', 'master', 'b76c70fe-8825-46a4-bd41-b8f291e910c5', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('270797cb-6aab-4275-b3b9-1137966534eb', 'b76c70fe-8825-46a4-bd41-b8f291e910c5', true, '${role_manage-account-links}', 'manage-account-links', 'master', 'b76c70fe-8825-46a4-bd41-b8f291e910c5', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('b9a783c4-a1ae-4e7c-8a3b-7f86451fc334', 'b76c70fe-8825-46a4-bd41-b8f291e910c5', true, '${role_view-applications}', 'view-applications', 'master', 'b76c70fe-8825-46a4-bd41-b8f291e910c5', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('240e1880-e5b4-431a-b84d-cb668acbda4e', 'b76c70fe-8825-46a4-bd41-b8f291e910c5', true, '${role_view-consent}', 'view-consent', 'master', 'b76c70fe-8825-46a4-bd41-b8f291e910c5', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('186a05f0-56ab-427e-81b5-e8e50fd82cd5', 'b76c70fe-8825-46a4-bd41-b8f291e910c5', true, '${role_manage-consent}', 'manage-consent', 'master', 'b76c70fe-8825-46a4-bd41-b8f291e910c5', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('ea351297-0ad3-497f-8b1d-432ef84dfe07', 'b76c70fe-8825-46a4-bd41-b8f291e910c5', true, '${role_delete-account}', 'delete-account', 'master', 'b76c70fe-8825-46a4-bd41-b8f291e910c5', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('3ae1ac45-415e-4331-86b1-c41974e4274f', 'b947d8c7-5d45-4789-8933-cbe58c97d415', true, '${role_read-token}', 'read-token', 'master', 'b947d8c7-5d45-4789-8933-cbe58c97d415', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('b6e6e9ee-b85a-4860-9df8-09d6cd98d975', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', true, '${role_impersonation}', 'impersonation', 'master', 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('e07ab02f-9442-4b41-9056-b96aea48e2c4', 'master', false, '${role_offline-access}', 'offline_access', 'master', NULL, NULL);
INSERT INTO keycloak.keycloak_role VALUES ('64331ac1-3077-49a0-8451-3d2b74063d77', 'master', false, '${role_uma_authorization}', 'uma_authorization', 'master', NULL, NULL);
INSERT INTO keycloak.keycloak_role VALUES ('3a3efbeb-83dc-4f82-b78d-f00e954d7d40', 'appcket', false, '${role_default-roles}', 'default-roles-appcket', 'appcket', NULL, NULL);
INSERT INTO keycloak.keycloak_role VALUES ('15387fbb-8c52-4094-876c-08c89ec8c879', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', true, '${role_create-client}', 'create-client', 'master', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('f4ba8174-d0a5-4a86-b993-b4432170bb07', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', true, '${role_view-realm}', 'view-realm', 'master', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('fbe84264-fc60-4474-9dc7-d88271c02e12', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', true, '${role_view-users}', 'view-users', 'master', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('37860bf2-1f7f-4bd4-be97-ee0d60ada697', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', true, '${role_view-clients}', 'view-clients', 'master', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('955c4aea-dcf5-4878-96e4-f83f031ba898', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', true, '${role_view-events}', 'view-events', 'master', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('2897fc36-c1d7-4212-9077-3ac3f7e4559a', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', true, '${role_view-identity-providers}', 'view-identity-providers', 'master', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('29d0ec4d-11cb-40da-93f8-60e7c8fd9d8f', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', true, '${role_view-authorization}', 'view-authorization', 'master', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('03a642ad-e50c-4b57-8e40-28ca79d7420e', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', true, '${role_manage-realm}', 'manage-realm', 'master', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('2470c952-a922-4f91-8f53-2cd1866f9d30', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', true, '${role_manage-users}', 'manage-users', 'master', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('1067255b-939b-49c3-a8c7-541e63745751', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', true, '${role_manage-clients}', 'manage-clients', 'master', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('821f3cc6-b842-47a7-a2ec-9f8a91f17c56', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', true, '${role_manage-events}', 'manage-events', 'master', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('ee386e8e-9487-4746-9528-84d94d69cca1', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'master', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('17747eaa-910c-4c84-b050-594c34e7b078', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', true, '${role_manage-authorization}', 'manage-authorization', 'master', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('c9fa526a-5325-47d3-ac0e-4f55cab07513', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', true, '${role_query-users}', 'query-users', 'master', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('96d918dc-383f-4c61-9b5c-4984e09ae5b8', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', true, '${role_query-clients}', 'query-clients', 'master', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('4ae9f88d-e42c-4ea0-9811-8dab1ba11928', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', true, '${role_query-realms}', 'query-realms', 'master', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('03a5c85c-2ad0-4b7b-a388-1d9e216023a1', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', true, '${role_query-groups}', 'query-groups', 'master', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('a1234e9b-ccf4-43c2-8c5a-f8d5964d9e22', 'appcket', false, 'Spectators are people outside the organization who have been invited and have limited ability inside the app. They may only do what managers, captains or teammates allow them to do.', 'Spectator', 'appcket', NULL, NULL);
INSERT INTO keycloak.keycloak_role VALUES ('558648c2-b53b-4dfd-906f-d30b67967ecd', 'appcket', false, '${role_uma_authorization}', 'uma_authorization', 'appcket', NULL, NULL);
INSERT INTO keycloak.keycloak_role VALUES ('241f95cd-d0a8-4b5e-b7d3-657f078175bb', 'appcket', false, '${role_offline-access}', 'offline_access', 'appcket', NULL, NULL);
INSERT INTO keycloak.keycloak_role VALUES ('1b55f720-894d-4d89-b37d-358e5eb29309', 'appcket', false, 'A team leader similar to a football or hockey captain.', 'Captain', 'appcket', NULL, NULL);
INSERT INTO keycloak.keycloak_role VALUES ('eee97160-4b67-4071-84f4-099bbcd704af', 'appcket', false, 'An individual contributor to a team.', 'Teammate', 'appcket', NULL, NULL);
INSERT INTO keycloak.keycloak_role VALUES ('97caa102-e9d8-44de-94a1-74e5ea7bccb5', 'appcket', false, 'A manager is like a baseball team''s manager in that they have more permission and capability across the organization than captains and teammates.', 'Manager', 'appcket', NULL, NULL);
INSERT INTO keycloak.keycloak_role VALUES ('d95fec18-c1e8-4720-b180-f88f8813e7a0', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_manage-realm}', 'manage-realm', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('3164e832-b3b2-40d1-a50b-3bfb997d4e46', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('3a011ec6-1589-42f2-a9ae-e3e8daffb290', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_view-realm}', 'view-realm', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('14183e37-4d0d-4f80-89a9-d979c7676d6a', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_query-users}', 'query-users', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('934d2eb7-4ffa-406f-b8a9-155460dd9872', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_view-users}', 'view-users', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('de050d33-3f79-4b6d-9f0f-33ed806b0cf8', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_view-identity-providers}', 'view-identity-providers', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('e532fe1f-14b2-42a5-af86-9b523e2fe992', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_query-realms}', 'query-realms', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('a1516493-c8b5-4001-a15a-d2b4a53964cc', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_query-clients}', 'query-clients', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('2387902b-b5e8-4810-814a-820bfc0bf070', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_manage-clients}', 'manage-clients', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('561557b4-e7d0-4401-9b18-25893c663078', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_create-client}', 'create-client', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('c8c99201-43cb-4987-9100-34b135c13cd0', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_manage-authorization}', 'manage-authorization', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('d0202d84-e5c0-4558-b385-c04149655885', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_view-clients}', 'view-clients', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('b8f4990b-326a-4cd5-81d1-fc0603561b68', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_view-events}', 'view-events', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('7fed08ed-9110-4022-8550-433f0fc5054f', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_manage-users}', 'manage-users', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('6309e6a4-e13e-419b-8d06-476b6fad7177', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_manage-events}', 'manage-events', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('d303d692-a116-48ec-9d15-e3449ca00f10', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_view-authorization}', 'view-authorization', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('3fda9186-3fda-413f-900b-43b487d08732', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_query-groups}', 'query-groups', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('3b234c85-7863-4077-ba73-5c39796c4476', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_impersonation}', 'impersonation', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('32ff242f-83ed-4e5b-90d4-a5a75227b94b', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', true, '${role_realm-admin}', 'realm-admin', 'appcket', '5ab9f6c1-1f4a-4e68-9ca4-59caf655bbe8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('a5654d13-57b2-4a00-8ffa-e4be21c18524', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', true, NULL, 'uma_protection', 'appcket', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('a9603702-bbb8-4c3b-baa9-9c8e6fb34c42', '70da96f3-abee-4ade-a7f3-d22e04437a0a', true, '${role_read-token}', 'read-token', 'appcket', '70da96f3-abee-4ade-a7f3-d22e04437a0a', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('750a3b3a-0cbc-47dd-b3e5-0de2a88b8a82', 'e801cbf0-541f-4466-80e1-fcce640df2a8', true, '${role_view-consent}', 'view-consent', 'appcket', 'e801cbf0-541f-4466-80e1-fcce640df2a8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('395df0fe-9ce6-4af3-9d3f-a76b64e2c6b1', 'e801cbf0-541f-4466-80e1-fcce640df2a8', true, '${role_manage-account}', 'manage-account', 'appcket', 'e801cbf0-541f-4466-80e1-fcce640df2a8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('f82082f8-ce8f-4514-a0df-08b916e08db3', 'e801cbf0-541f-4466-80e1-fcce640df2a8', true, '${role_view-profile}', 'view-profile', 'appcket', 'e801cbf0-541f-4466-80e1-fcce640df2a8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('c187fe98-fbc1-4601-a0b8-c463193e8494', 'e801cbf0-541f-4466-80e1-fcce640df2a8', true, '${role_manage-account-links}', 'manage-account-links', 'appcket', 'e801cbf0-541f-4466-80e1-fcce640df2a8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('a7e4209f-1242-4cf6-a548-8e9fb0183623', 'e801cbf0-541f-4466-80e1-fcce640df2a8', true, '${role_view-applications}', 'view-applications', 'appcket', 'e801cbf0-541f-4466-80e1-fcce640df2a8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('4be9e535-34e3-4ebc-8591-1f575899d346', 'e801cbf0-541f-4466-80e1-fcce640df2a8', true, '${role_manage-consent}', 'manage-consent', 'appcket', 'e801cbf0-541f-4466-80e1-fcce640df2a8', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('d4118ce7-2210-418e-80d2-03c8a4da8c6d', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', true, '${role_impersonation}', 'impersonation', 'master', '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', NULL);
INSERT INTO keycloak.keycloak_role VALUES ('28c9d094-9c20-41ae-a6b8-e76ff29509bf', 'e801cbf0-541f-4466-80e1-fcce640df2a8', true, '${role_delete-account}', 'delete-account', 'appcket', 'e801cbf0-541f-4466-80e1-fcce640df2a8', NULL);


--
-- TOC entry 3861 (class 0 OID 18708)
-- Dependencies: 238
-- Data for Name: migration_model; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.migration_model VALUES ('mwnrl', '15.0.2', 1632600811);
INSERT INTO keycloak.migration_model VALUES ('onbgu', '15.1.0', 1639591161);
INSERT INTO keycloak.migration_model VALUES ('n3ufn', '16.1.0', 1640468818);
INSERT INTO keycloak.migration_model VALUES ('dv7wn', '16.1.1', 1643687807);


--
-- TOC entry 3878 (class 0 OID 18992)
-- Dependencies: 255
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3877 (class 0 OID 18986)
-- Dependencies: 254
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3891 (class 0 OID 19215)
-- Dependencies: 268
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
-- TOC entry 3853 (class 0 OID 18576)
-- Dependencies: 230
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.protocol_mapper VALUES ('52184b3a-cdcb-44f6-af80-16908b3a9b06', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', '567f4fd5-d705-46fc-9956-31901fd76939', NULL);
INSERT INTO keycloak.protocol_mapper VALUES ('36d6402f-e7b2-4e4b-9c45-3ca0f85b24a3', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', '5b745968-9295-482c-b42f-d11087e1790b', NULL);
INSERT INTO keycloak.protocol_mapper VALUES ('2516b665-cc73-4b1c-90fd-3d8ead1ee276', 'role list', 'saml', 'saml-role-list-mapper', NULL, 'c300fd83-f791-4986-8ed7-bb3bb4520e36');
INSERT INTO keycloak.protocol_mapper VALUES ('8c62020b-4985-40c6-b606-51b12a0cfc23', 'full name', 'openid-connect', 'oidc-full-name-mapper', NULL, 'a34ae2c0-3ca3-43d7-b8e4-bd7b277dfdae');
INSERT INTO keycloak.protocol_mapper VALUES ('36bfba1a-82a8-4a62-9abe-87aee47335cc', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'a34ae2c0-3ca3-43d7-b8e4-bd7b277dfdae');
INSERT INTO keycloak.protocol_mapper VALUES ('c077659c-8d5d-4679-a0eb-c81b7ec16a73', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'a34ae2c0-3ca3-43d7-b8e4-bd7b277dfdae');
INSERT INTO keycloak.protocol_mapper VALUES ('8d908e11-bf3a-443d-88eb-12b3222677ea', 'middle name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'a34ae2c0-3ca3-43d7-b8e4-bd7b277dfdae');
INSERT INTO keycloak.protocol_mapper VALUES ('40c4d393-c9a2-4e37-b72a-cac63ae52b98', 'nickname', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'a34ae2c0-3ca3-43d7-b8e4-bd7b277dfdae');
INSERT INTO keycloak.protocol_mapper VALUES ('4066f5bb-70ed-446b-b7bd-92721a6d35a6', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'a34ae2c0-3ca3-43d7-b8e4-bd7b277dfdae');
INSERT INTO keycloak.protocol_mapper VALUES ('1e336dc4-533d-46bc-bc86-927a9566230f', 'profile', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'a34ae2c0-3ca3-43d7-b8e4-bd7b277dfdae');
INSERT INTO keycloak.protocol_mapper VALUES ('a4be5142-84b6-42b9-ae91-68396163197e', 'picture', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'a34ae2c0-3ca3-43d7-b8e4-bd7b277dfdae');
INSERT INTO keycloak.protocol_mapper VALUES ('c585e82d-edb3-4a9e-88d6-25060af5154b', 'website', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'a34ae2c0-3ca3-43d7-b8e4-bd7b277dfdae');
INSERT INTO keycloak.protocol_mapper VALUES ('8e14ec05-c144-4e8b-9254-d54a33132c9d', 'gender', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'a34ae2c0-3ca3-43d7-b8e4-bd7b277dfdae');
INSERT INTO keycloak.protocol_mapper VALUES ('191a1283-066a-4d24-b848-19e96915e546', 'birthdate', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'a34ae2c0-3ca3-43d7-b8e4-bd7b277dfdae');
INSERT INTO keycloak.protocol_mapper VALUES ('19b4dbfd-beb1-4414-be3b-cce98130ee59', 'zoneinfo', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'a34ae2c0-3ca3-43d7-b8e4-bd7b277dfdae');
INSERT INTO keycloak.protocol_mapper VALUES ('352c1501-212f-4cd8-8496-e7ce82bf69c8', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'a34ae2c0-3ca3-43d7-b8e4-bd7b277dfdae');
INSERT INTO keycloak.protocol_mapper VALUES ('2f71902b-7aa4-4732-a6f2-0a7fd9db0710', 'updated at', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'a34ae2c0-3ca3-43d7-b8e4-bd7b277dfdae');
INSERT INTO keycloak.protocol_mapper VALUES ('533d3df2-7991-4fd3-98ac-91f6f485193c', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '0d6aeed8-8d73-4978-bc5e-16de7f6f399d');
INSERT INTO keycloak.protocol_mapper VALUES ('82b20ca8-aa78-4bf4-96a8-a8ae6e2cf060', 'email verified', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '0d6aeed8-8d73-4978-bc5e-16de7f6f399d');
INSERT INTO keycloak.protocol_mapper VALUES ('652500e5-ba51-4586-b6cb-c8e350fa9e33', 'address', 'openid-connect', 'oidc-address-mapper', NULL, 'e765c4b2-81f4-472f-b26e-2fcec6f21c18');
INSERT INTO keycloak.protocol_mapper VALUES ('57da9565-5f66-4266-b0bb-4e0c4ebe1993', 'phone number', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'c6d8e038-d6a2-44a0-875d-d82cedab755f');
INSERT INTO keycloak.protocol_mapper VALUES ('d989acbc-2f5b-4b7a-8516-365d1e2972cd', 'phone number verified', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'c6d8e038-d6a2-44a0-875d-d82cedab755f');
INSERT INTO keycloak.protocol_mapper VALUES ('bdb94019-bd6d-4645-90ff-ff8dc67d4a36', 'realm roles', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, 'd06cb9d2-8cc3-4ee2-b0d3-50e7b4599b00');
INSERT INTO keycloak.protocol_mapper VALUES ('e82b55f5-87d7-46de-b4ad-ab90f0ac3e86', 'client roles', 'openid-connect', 'oidc-usermodel-client-role-mapper', NULL, 'd06cb9d2-8cc3-4ee2-b0d3-50e7b4599b00');
INSERT INTO keycloak.protocol_mapper VALUES ('b38c6a6d-4da5-4779-bed6-7b1a633ad330', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', NULL, 'd06cb9d2-8cc3-4ee2-b0d3-50e7b4599b00');
INSERT INTO keycloak.protocol_mapper VALUES ('ad440c7e-ffc9-4553-b4c6-c1593838c5db', 'allowed web origins', 'openid-connect', 'oidc-allowed-origins-mapper', NULL, '61d1cc86-30fb-44e6-8a4c-bb300d512001');
INSERT INTO keycloak.protocol_mapper VALUES ('c1faf147-67a7-4627-9a70-4e26c193e359', 'upn', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '0c087984-3399-4738-8c0c-14f0b6483d8e');
INSERT INTO keycloak.protocol_mapper VALUES ('7665c6af-ce99-4ebe-ba31-da71ee6dcc08', 'groups', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, '0c087984-3399-4738-8c0c-14f0b6483d8e');
INSERT INTO keycloak.protocol_mapper VALUES ('628d5988-9461-4cb4-a16d-30f116e58d4c', 'role list', 'saml', 'saml-role-list-mapper', NULL, 'bed9e481-a783-4f6c-bd5a-f79f5d189ee6');
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
INSERT INTO keycloak.protocol_mapper VALUES ('bd5c32a6-5fca-4f65-a214-916d38aeee13', 'email verified', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '63984129-44c9-4bd1-97d1-da0df3407112');
INSERT INTO keycloak.protocol_mapper VALUES ('dc868b98-c04d-442d-8526-6092c2decf46', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '63984129-44c9-4bd1-97d1-da0df3407112');
INSERT INTO keycloak.protocol_mapper VALUES ('d2b100d8-cfd5-4485-a1b6-dd6c9277fa62', 'address', 'openid-connect', 'oidc-address-mapper', NULL, 'b2414a14-1f25-4d4b-9162-de66eeb6652d');
INSERT INTO keycloak.protocol_mapper VALUES ('533d4496-8888-4275-8afa-8d048b7ff283', 'phone number', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '4709e0fb-184a-4b47-a804-ae1556e53a73');
INSERT INTO keycloak.protocol_mapper VALUES ('d00a2308-a8d8-4d72-aa1b-ef2653198a9a', 'phone number verified', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, '4709e0fb-184a-4b47-a804-ae1556e53a73');
INSERT INTO keycloak.protocol_mapper VALUES ('ace4e693-1183-4c96-9aea-41ca084b4bbf', 'realm roles', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, '2b5c02f3-e7a9-4455-a505-9fef19838927');
INSERT INTO keycloak.protocol_mapper VALUES ('ae7c93eb-ae11-4b4d-b052-e04b2fc2a9bd', 'client roles', 'openid-connect', 'oidc-usermodel-client-role-mapper', NULL, '2b5c02f3-e7a9-4455-a505-9fef19838927');
INSERT INTO keycloak.protocol_mapper VALUES ('fb1c4748-138f-4389-aff7-59c73380e103', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', NULL, '2b5c02f3-e7a9-4455-a505-9fef19838927');
INSERT INTO keycloak.protocol_mapper VALUES ('523594f5-eecb-4f6c-9618-609d78630d9b', 'allowed web origins', 'openid-connect', 'oidc-allowed-origins-mapper', NULL, '52312b11-3e69-46f2-93f2-b1e168214598');
INSERT INTO keycloak.protocol_mapper VALUES ('27ad127b-e9e0-4cca-ae70-1889095e68b8', 'upn', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'a15b2f14-004d-47f8-b137-7bca43fc8b30');
INSERT INTO keycloak.protocol_mapper VALUES ('3ede00f8-d88c-4d51-a7bd-fc8266196d86', 'groups', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, 'a15b2f14-004d-47f8-b137-7bca43fc8b30');
INSERT INTO keycloak.protocol_mapper VALUES ('ea9bb3c5-eb5c-4fe6-8124-b55fc225d99a', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', '26f802c3-b7af-4e78-b785-40493ae2483a', NULL);
INSERT INTO keycloak.protocol_mapper VALUES ('f55bba66-f14f-4781-9295-981ccef3023d', 'Client ID', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.protocol_mapper VALUES ('cadcd86f-31bb-4bfe-9f09-b155027a8319', 'Client Host', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.protocol_mapper VALUES ('795f38ba-3268-4e2f-a956-ca2ad1a0d3be', 'Client IP Address', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.protocol_mapper VALUES ('f600d7c2-c282-46c4-877f-12e54f486cb6', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', '4dd4c360-d5b9-4730-8091-78b394cea334', NULL);
INSERT INTO keycloak.protocol_mapper VALUES ('9d14a67a-613b-4f8c-a8c4-1d34b23d595c', 'Audience for appcket_app', 'openid-connect', 'oidc-audience-mapper', '68d063b7-66bc-4e03-8ed0-38694d466ad3', NULL);


--
-- TOC entry 3854 (class 0 OID 18583)
-- Dependencies: 231
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.protocol_mapper_config VALUES ('36d6402f-e7b2-4e4b-9c45-3ca0f85b24a3', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('36d6402f-e7b2-4e4b-9c45-3ca0f85b24a3', 'locale', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('36d6402f-e7b2-4e4b-9c45-3ca0f85b24a3', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('36d6402f-e7b2-4e4b-9c45-3ca0f85b24a3', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('36d6402f-e7b2-4e4b-9c45-3ca0f85b24a3', 'locale', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('36d6402f-e7b2-4e4b-9c45-3ca0f85b24a3', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('2516b665-cc73-4b1c-90fd-3d8ead1ee276', 'false', 'single');
INSERT INTO keycloak.protocol_mapper_config VALUES ('2516b665-cc73-4b1c-90fd-3d8ead1ee276', 'Basic', 'attribute.nameformat');
INSERT INTO keycloak.protocol_mapper_config VALUES ('2516b665-cc73-4b1c-90fd-3d8ead1ee276', 'Role', 'attribute.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('8c62020b-4985-40c6-b606-51b12a0cfc23', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('8c62020b-4985-40c6-b606-51b12a0cfc23', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('8c62020b-4985-40c6-b606-51b12a0cfc23', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('36bfba1a-82a8-4a62-9abe-87aee47335cc', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('36bfba1a-82a8-4a62-9abe-87aee47335cc', 'lastName', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('36bfba1a-82a8-4a62-9abe-87aee47335cc', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('36bfba1a-82a8-4a62-9abe-87aee47335cc', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('36bfba1a-82a8-4a62-9abe-87aee47335cc', 'family_name', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('36bfba1a-82a8-4a62-9abe-87aee47335cc', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('c077659c-8d5d-4679-a0eb-c81b7ec16a73', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('c077659c-8d5d-4679-a0eb-c81b7ec16a73', 'firstName', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('c077659c-8d5d-4679-a0eb-c81b7ec16a73', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('c077659c-8d5d-4679-a0eb-c81b7ec16a73', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('c077659c-8d5d-4679-a0eb-c81b7ec16a73', 'given_name', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('c077659c-8d5d-4679-a0eb-c81b7ec16a73', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('8d908e11-bf3a-443d-88eb-12b3222677ea', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('8d908e11-bf3a-443d-88eb-12b3222677ea', 'middleName', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('8d908e11-bf3a-443d-88eb-12b3222677ea', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('8d908e11-bf3a-443d-88eb-12b3222677ea', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('8d908e11-bf3a-443d-88eb-12b3222677ea', 'middle_name', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('8d908e11-bf3a-443d-88eb-12b3222677ea', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('40c4d393-c9a2-4e37-b72a-cac63ae52b98', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('40c4d393-c9a2-4e37-b72a-cac63ae52b98', 'nickname', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('40c4d393-c9a2-4e37-b72a-cac63ae52b98', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('40c4d393-c9a2-4e37-b72a-cac63ae52b98', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('40c4d393-c9a2-4e37-b72a-cac63ae52b98', 'nickname', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('40c4d393-c9a2-4e37-b72a-cac63ae52b98', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('4066f5bb-70ed-446b-b7bd-92721a6d35a6', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('4066f5bb-70ed-446b-b7bd-92721a6d35a6', 'username', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('4066f5bb-70ed-446b-b7bd-92721a6d35a6', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('4066f5bb-70ed-446b-b7bd-92721a6d35a6', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('4066f5bb-70ed-446b-b7bd-92721a6d35a6', 'preferred_username', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('4066f5bb-70ed-446b-b7bd-92721a6d35a6', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('1e336dc4-533d-46bc-bc86-927a9566230f', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('1e336dc4-533d-46bc-bc86-927a9566230f', 'profile', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('1e336dc4-533d-46bc-bc86-927a9566230f', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('1e336dc4-533d-46bc-bc86-927a9566230f', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('1e336dc4-533d-46bc-bc86-927a9566230f', 'profile', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('1e336dc4-533d-46bc-bc86-927a9566230f', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('a4be5142-84b6-42b9-ae91-68396163197e', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('a4be5142-84b6-42b9-ae91-68396163197e', 'picture', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('a4be5142-84b6-42b9-ae91-68396163197e', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('a4be5142-84b6-42b9-ae91-68396163197e', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('a4be5142-84b6-42b9-ae91-68396163197e', 'picture', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('a4be5142-84b6-42b9-ae91-68396163197e', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('c585e82d-edb3-4a9e-88d6-25060af5154b', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('c585e82d-edb3-4a9e-88d6-25060af5154b', 'website', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('c585e82d-edb3-4a9e-88d6-25060af5154b', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('c585e82d-edb3-4a9e-88d6-25060af5154b', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('c585e82d-edb3-4a9e-88d6-25060af5154b', 'website', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('c585e82d-edb3-4a9e-88d6-25060af5154b', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('8e14ec05-c144-4e8b-9254-d54a33132c9d', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('8e14ec05-c144-4e8b-9254-d54a33132c9d', 'gender', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('8e14ec05-c144-4e8b-9254-d54a33132c9d', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('8e14ec05-c144-4e8b-9254-d54a33132c9d', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('8e14ec05-c144-4e8b-9254-d54a33132c9d', 'gender', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('8e14ec05-c144-4e8b-9254-d54a33132c9d', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('191a1283-066a-4d24-b848-19e96915e546', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('191a1283-066a-4d24-b848-19e96915e546', 'birthdate', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('191a1283-066a-4d24-b848-19e96915e546', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('191a1283-066a-4d24-b848-19e96915e546', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('191a1283-066a-4d24-b848-19e96915e546', 'birthdate', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('191a1283-066a-4d24-b848-19e96915e546', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('19b4dbfd-beb1-4414-be3b-cce98130ee59', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('19b4dbfd-beb1-4414-be3b-cce98130ee59', 'zoneinfo', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('19b4dbfd-beb1-4414-be3b-cce98130ee59', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('19b4dbfd-beb1-4414-be3b-cce98130ee59', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('19b4dbfd-beb1-4414-be3b-cce98130ee59', 'zoneinfo', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('19b4dbfd-beb1-4414-be3b-cce98130ee59', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('352c1501-212f-4cd8-8496-e7ce82bf69c8', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('352c1501-212f-4cd8-8496-e7ce82bf69c8', 'locale', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('352c1501-212f-4cd8-8496-e7ce82bf69c8', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('352c1501-212f-4cd8-8496-e7ce82bf69c8', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('352c1501-212f-4cd8-8496-e7ce82bf69c8', 'locale', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('352c1501-212f-4cd8-8496-e7ce82bf69c8', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('2f71902b-7aa4-4732-a6f2-0a7fd9db0710', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('2f71902b-7aa4-4732-a6f2-0a7fd9db0710', 'updatedAt', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('2f71902b-7aa4-4732-a6f2-0a7fd9db0710', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('2f71902b-7aa4-4732-a6f2-0a7fd9db0710', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('2f71902b-7aa4-4732-a6f2-0a7fd9db0710', 'updated_at', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('2f71902b-7aa4-4732-a6f2-0a7fd9db0710', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('533d3df2-7991-4fd3-98ac-91f6f485193c', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('533d3df2-7991-4fd3-98ac-91f6f485193c', 'email', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('533d3df2-7991-4fd3-98ac-91f6f485193c', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('533d3df2-7991-4fd3-98ac-91f6f485193c', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('533d3df2-7991-4fd3-98ac-91f6f485193c', 'email', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('533d3df2-7991-4fd3-98ac-91f6f485193c', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('82b20ca8-aa78-4bf4-96a8-a8ae6e2cf060', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('82b20ca8-aa78-4bf4-96a8-a8ae6e2cf060', 'emailVerified', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('82b20ca8-aa78-4bf4-96a8-a8ae6e2cf060', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('82b20ca8-aa78-4bf4-96a8-a8ae6e2cf060', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('82b20ca8-aa78-4bf4-96a8-a8ae6e2cf060', 'email_verified', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('82b20ca8-aa78-4bf4-96a8-a8ae6e2cf060', 'boolean', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('652500e5-ba51-4586-b6cb-c8e350fa9e33', 'formatted', 'user.attribute.formatted');
INSERT INTO keycloak.protocol_mapper_config VALUES ('652500e5-ba51-4586-b6cb-c8e350fa9e33', 'country', 'user.attribute.country');
INSERT INTO keycloak.protocol_mapper_config VALUES ('652500e5-ba51-4586-b6cb-c8e350fa9e33', 'postal_code', 'user.attribute.postal_code');
INSERT INTO keycloak.protocol_mapper_config VALUES ('652500e5-ba51-4586-b6cb-c8e350fa9e33', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('652500e5-ba51-4586-b6cb-c8e350fa9e33', 'street', 'user.attribute.street');
INSERT INTO keycloak.protocol_mapper_config VALUES ('652500e5-ba51-4586-b6cb-c8e350fa9e33', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('652500e5-ba51-4586-b6cb-c8e350fa9e33', 'region', 'user.attribute.region');
INSERT INTO keycloak.protocol_mapper_config VALUES ('652500e5-ba51-4586-b6cb-c8e350fa9e33', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('652500e5-ba51-4586-b6cb-c8e350fa9e33', 'locality', 'user.attribute.locality');
INSERT INTO keycloak.protocol_mapper_config VALUES ('57da9565-5f66-4266-b0bb-4e0c4ebe1993', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('57da9565-5f66-4266-b0bb-4e0c4ebe1993', 'phoneNumber', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('57da9565-5f66-4266-b0bb-4e0c4ebe1993', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('57da9565-5f66-4266-b0bb-4e0c4ebe1993', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('57da9565-5f66-4266-b0bb-4e0c4ebe1993', 'phone_number', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('57da9565-5f66-4266-b0bb-4e0c4ebe1993', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d989acbc-2f5b-4b7a-8516-365d1e2972cd', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d989acbc-2f5b-4b7a-8516-365d1e2972cd', 'phoneNumberVerified', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d989acbc-2f5b-4b7a-8516-365d1e2972cd', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d989acbc-2f5b-4b7a-8516-365d1e2972cd', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d989acbc-2f5b-4b7a-8516-365d1e2972cd', 'phone_number_verified', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d989acbc-2f5b-4b7a-8516-365d1e2972cd', 'boolean', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('bdb94019-bd6d-4645-90ff-ff8dc67d4a36', 'true', 'multivalued');
INSERT INTO keycloak.protocol_mapper_config VALUES ('bdb94019-bd6d-4645-90ff-ff8dc67d4a36', 'foo', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('bdb94019-bd6d-4645-90ff-ff8dc67d4a36', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('bdb94019-bd6d-4645-90ff-ff8dc67d4a36', 'realm_access.roles', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('bdb94019-bd6d-4645-90ff-ff8dc67d4a36', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e82b55f5-87d7-46de-b4ad-ab90f0ac3e86', 'true', 'multivalued');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e82b55f5-87d7-46de-b4ad-ab90f0ac3e86', 'foo', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e82b55f5-87d7-46de-b4ad-ab90f0ac3e86', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e82b55f5-87d7-46de-b4ad-ab90f0ac3e86', 'resource_access.${client_id}.roles', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e82b55f5-87d7-46de-b4ad-ab90f0ac3e86', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('c1faf147-67a7-4627-9a70-4e26c193e359', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('c1faf147-67a7-4627-9a70-4e26c193e359', 'username', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('c1faf147-67a7-4627-9a70-4e26c193e359', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('c1faf147-67a7-4627-9a70-4e26c193e359', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('c1faf147-67a7-4627-9a70-4e26c193e359', 'upn', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('c1faf147-67a7-4627-9a70-4e26c193e359', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('7665c6af-ce99-4ebe-ba31-da71ee6dcc08', 'true', 'multivalued');
INSERT INTO keycloak.protocol_mapper_config VALUES ('7665c6af-ce99-4ebe-ba31-da71ee6dcc08', 'foo', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('7665c6af-ce99-4ebe-ba31-da71ee6dcc08', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('7665c6af-ce99-4ebe-ba31-da71ee6dcc08', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('7665c6af-ce99-4ebe-ba31-da71ee6dcc08', 'groups', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('7665c6af-ce99-4ebe-ba31-da71ee6dcc08', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('628d5988-9461-4cb4-a16d-30f116e58d4c', 'false', 'single');
INSERT INTO keycloak.protocol_mapper_config VALUES ('628d5988-9461-4cb4-a16d-30f116e58d4c', 'Basic', 'attribute.nameformat');
INSERT INTO keycloak.protocol_mapper_config VALUES ('628d5988-9461-4cb4-a16d-30f116e58d4c', 'Role', 'attribute.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d372c450-4ef9-4359-894c-feb03f732747', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d372c450-4ef9-4359-894c-feb03f732747', 'profile', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d372c450-4ef9-4359-894c-feb03f732747', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d372c450-4ef9-4359-894c-feb03f732747', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d372c450-4ef9-4359-894c-feb03f732747', 'profile', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d372c450-4ef9-4359-894c-feb03f732747', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e2bcdee5-07b1-494b-ba98-64d110d3862f', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e2bcdee5-07b1-494b-ba98-64d110d3862f', 'gender', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e2bcdee5-07b1-494b-ba98-64d110d3862f', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e2bcdee5-07b1-494b-ba98-64d110d3862f', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e2bcdee5-07b1-494b-ba98-64d110d3862f', 'gender', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e2bcdee5-07b1-494b-ba98-64d110d3862f', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('54fe2e8c-ae54-40c0-a58a-65c9c14f953d', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('54fe2e8c-ae54-40c0-a58a-65c9c14f953d', 'birthdate', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('54fe2e8c-ae54-40c0-a58a-65c9c14f953d', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('54fe2e8c-ae54-40c0-a58a-65c9c14f953d', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('54fe2e8c-ae54-40c0-a58a-65c9c14f953d', 'birthdate', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('54fe2e8c-ae54-40c0-a58a-65c9c14f953d', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e3d3222b-0a96-4452-89b9-e73addb85a9e', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e3d3222b-0a96-4452-89b9-e73addb85a9e', 'locale', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e3d3222b-0a96-4452-89b9-e73addb85a9e', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e3d3222b-0a96-4452-89b9-e73addb85a9e', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e3d3222b-0a96-4452-89b9-e73addb85a9e', 'locale', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e3d3222b-0a96-4452-89b9-e73addb85a9e', 'String', 'jsonType.label');
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
INSERT INTO keycloak.protocol_mapper_config VALUES ('e1dd8224-e8a1-4006-82fe-3096fe8926c5', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e1dd8224-e8a1-4006-82fe-3096fe8926c5', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('e1dd8224-e8a1-4006-82fe-3096fe8926c5', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('cd405c84-96b5-4a5f-ba4c-d842bd6b3347', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('cd405c84-96b5-4a5f-ba4c-d842bd6b3347', 'website', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('cd405c84-96b5-4a5f-ba4c-d842bd6b3347', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('cd405c84-96b5-4a5f-ba4c-d842bd6b3347', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('cd405c84-96b5-4a5f-ba4c-d842bd6b3347', 'website', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('cd405c84-96b5-4a5f-ba4c-d842bd6b3347', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('bf451083-910a-4e3e-b86c-69c8af9de75c', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('bf451083-910a-4e3e-b86c-69c8af9de75c', 'firstName', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('bf451083-910a-4e3e-b86c-69c8af9de75c', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('bf451083-910a-4e3e-b86c-69c8af9de75c', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('bf451083-910a-4e3e-b86c-69c8af9de75c', 'given_name', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('bf451083-910a-4e3e-b86c-69c8af9de75c', 'String', 'jsonType.label');
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
INSERT INTO keycloak.protocol_mapper_config VALUES ('fbc68b60-fa5f-40b2-b2bb-e600699f3904', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('fbc68b60-fa5f-40b2-b2bb-e600699f3904', 'lastName', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('fbc68b60-fa5f-40b2-b2bb-e600699f3904', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('fbc68b60-fa5f-40b2-b2bb-e600699f3904', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('fbc68b60-fa5f-40b2-b2bb-e600699f3904', 'family_name', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('fbc68b60-fa5f-40b2-b2bb-e600699f3904', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('43fc25a2-4e2d-4269-b6b2-4e4587be6e1f', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('43fc25a2-4e2d-4269-b6b2-4e4587be6e1f', 'picture', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('43fc25a2-4e2d-4269-b6b2-4e4587be6e1f', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('43fc25a2-4e2d-4269-b6b2-4e4587be6e1f', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('43fc25a2-4e2d-4269-b6b2-4e4587be6e1f', 'picture', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('43fc25a2-4e2d-4269-b6b2-4e4587be6e1f', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('82005164-d7d3-40e5-98df-9aa79bf956cf', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('82005164-d7d3-40e5-98df-9aa79bf956cf', 'updatedAt', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('82005164-d7d3-40e5-98df-9aa79bf956cf', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('82005164-d7d3-40e5-98df-9aa79bf956cf', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('82005164-d7d3-40e5-98df-9aa79bf956cf', 'updated_at', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('82005164-d7d3-40e5-98df-9aa79bf956cf', 'String', 'jsonType.label');
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
INSERT INTO keycloak.protocol_mapper_config VALUES ('d2b100d8-cfd5-4485-a1b6-dd6c9277fa62', 'formatted', 'user.attribute.formatted');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d2b100d8-cfd5-4485-a1b6-dd6c9277fa62', 'country', 'user.attribute.country');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d2b100d8-cfd5-4485-a1b6-dd6c9277fa62', 'postal_code', 'user.attribute.postal_code');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d2b100d8-cfd5-4485-a1b6-dd6c9277fa62', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d2b100d8-cfd5-4485-a1b6-dd6c9277fa62', 'street', 'user.attribute.street');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d2b100d8-cfd5-4485-a1b6-dd6c9277fa62', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d2b100d8-cfd5-4485-a1b6-dd6c9277fa62', 'region', 'user.attribute.region');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d2b100d8-cfd5-4485-a1b6-dd6c9277fa62', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('d2b100d8-cfd5-4485-a1b6-dd6c9277fa62', 'locality', 'user.attribute.locality');
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
INSERT INTO keycloak.protocol_mapper_config VALUES ('f55bba66-f14f-4781-9295-981ccef3023d', 'clientId', 'user.session.note');
INSERT INTO keycloak.protocol_mapper_config VALUES ('f55bba66-f14f-4781-9295-981ccef3023d', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('f55bba66-f14f-4781-9295-981ccef3023d', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('f55bba66-f14f-4781-9295-981ccef3023d', 'clientId', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('f55bba66-f14f-4781-9295-981ccef3023d', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('f55bba66-f14f-4781-9295-981ccef3023d', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('cadcd86f-31bb-4bfe-9f09-b155027a8319', 'clientHost', 'user.session.note');
INSERT INTO keycloak.protocol_mapper_config VALUES ('cadcd86f-31bb-4bfe-9f09-b155027a8319', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('cadcd86f-31bb-4bfe-9f09-b155027a8319', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('cadcd86f-31bb-4bfe-9f09-b155027a8319', 'clientHost', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('cadcd86f-31bb-4bfe-9f09-b155027a8319', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('795f38ba-3268-4e2f-a956-ca2ad1a0d3be', 'clientAddress', 'user.session.note');
INSERT INTO keycloak.protocol_mapper_config VALUES ('795f38ba-3268-4e2f-a956-ca2ad1a0d3be', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('795f38ba-3268-4e2f-a956-ca2ad1a0d3be', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('795f38ba-3268-4e2f-a956-ca2ad1a0d3be', 'clientAddress', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('795f38ba-3268-4e2f-a956-ca2ad1a0d3be', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('cadcd86f-31bb-4bfe-9f09-b155027a8319', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('795f38ba-3268-4e2f-a956-ca2ad1a0d3be', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('f600d7c2-c282-46c4-877f-12e54f486cb6', 'true', 'userinfo.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('f600d7c2-c282-46c4-877f-12e54f486cb6', 'locale', 'user.attribute');
INSERT INTO keycloak.protocol_mapper_config VALUES ('f600d7c2-c282-46c4-877f-12e54f486cb6', 'true', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('f600d7c2-c282-46c4-877f-12e54f486cb6', 'true', 'access.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('f600d7c2-c282-46c4-877f-12e54f486cb6', 'locale', 'claim.name');
INSERT INTO keycloak.protocol_mapper_config VALUES ('f600d7c2-c282-46c4-877f-12e54f486cb6', 'String', 'jsonType.label');
INSERT INTO keycloak.protocol_mapper_config VALUES ('9d14a67a-613b-4f8c-a8c4-1d34b23d595c', 'appcket_api', 'included.client.audience');
INSERT INTO keycloak.protocol_mapper_config VALUES ('9d14a67a-613b-4f8c-a8c4-1d34b23d595c', 'false', 'id.token.claim');
INSERT INTO keycloak.protocol_mapper_config VALUES ('9d14a67a-613b-4f8c-a8c4-1d34b23d595c', 'true', 'access.token.claim');


--
-- TOC entry 3834 (class 0 OID 18211)
-- Dependencies: 211
-- Data for Name: realm; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.realm VALUES ('master', 60, 300, 60, NULL, NULL, NULL, true, false, 0, NULL, 'master', 0, NULL, false, false, false, false, 'EXTERNAL', 1800, 36000, false, false, 'e4b73cc6-e42f-4c2f-b9cd-3f70446f9794', 1800, false, NULL, false, false, false, false, 0, 1, 30, 6, 'HmacSHA1', 'totp', '51153253-713c-43b3-8001-9e723e7074a1', '05228812-ac42-4187-82fd-0dd975978225', '9a6d37ac-44ed-4e6d-9ab2-5a2b7ae6ce52', '194d8beb-af77-41de-b5db-3531509e95ba', 'c338ee23-cccd-4708-ba1b-b709f6e5a17e', 2592000, false, 900, true, false, '3cd617be-4805-4d68-a77b-46e8320511ff', 0, false, 0, 0, 'f61b13f5-0859-413b-ba9f-27b4cb813144');
INSERT INTO keycloak.realm VALUES ('appcket', 60, 300, 1800, NULL, NULL, NULL, true, false, 0, NULL, 'appcket', 0, NULL, false, false, false, false, 'EXTERNAL', 864000, 864000, false, false, '870ce4fe-4e0d-4fc1-a536-d1dbc292c22a', 1800, false, NULL, false, false, false, false, 0, 1, 30, 6, 'HmacSHA1', 'totp', '5f1c9ea0-903e-4bda-8c25-234ece43d563', '55bb6d26-e641-4b65-8205-f744ea5c2f11', '4de4c054-7937-4375-a52f-850a8de18890', '24484497-8dcd-467d-8695-173911642ef9', 'eff54ebc-cab5-4891-8b1c-fb3cb05c9548', 36000, false, 2700, true, false, '168edbbe-5ef2-45f9-8e63-211aaa6888d0', 0, false, 0, 0, '3a3efbeb-83dc-4f82-b78d-f00e954d7d40');


--
-- TOC entry 3835 (class 0 OID 18229)
-- Dependencies: 212
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
INSERT INTO keycloak.realm_attribute VALUES ('_browser_header.xFrameOptions', 'appcket', 'SAMEORIGIN');
INSERT INTO keycloak.realm_attribute VALUES ('_browser_header.contentSecurityPolicy', 'appcket', 'frame-src ''self''; frame-ancestors ''self''; object-src ''none'';');
INSERT INTO keycloak.realm_attribute VALUES ('_browser_header.xXSSProtection', 'appcket', '1; mode=block');
INSERT INTO keycloak.realm_attribute VALUES ('_browser_header.strictTransportSecurity', 'appcket', 'max-age=31536000; includeSubDomains');


--
-- TOC entry 3883 (class 0 OID 19018)
-- Dependencies: 260
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3860 (class 0 OID 18700)
-- Dependencies: 237
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3836 (class 0 OID 18238)
-- Dependencies: 213
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.realm_events_listeners VALUES ('master', 'jboss-logging');
INSERT INTO keycloak.realm_events_listeners VALUES ('appcket', 'jboss-logging');


--
-- TOC entry 3916 (class 0 OID 19745)
-- Dependencies: 293
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3837 (class 0 OID 18241)
-- Dependencies: 214
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.realm_required_credential VALUES ('password', 'password', true, true, 'master');
INSERT INTO keycloak.realm_required_credential VALUES ('password', 'password', true, true, 'appcket');


--
-- TOC entry 3838 (class 0 OID 18249)
-- Dependencies: 215
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3858 (class 0 OID 18615)
-- Dependencies: 235
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3839 (class 0 OID 18261)
-- Dependencies: 216
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.redirect_uris VALUES ('b76c70fe-8825-46a4-bd41-b8f291e910c5', '/realms/master/account/*');
INSERT INTO keycloak.redirect_uris VALUES ('567f4fd5-d705-46fc-9956-31901fd76939', '/realms/master/account/*');
INSERT INTO keycloak.redirect_uris VALUES ('5b745968-9295-482c-b42f-d11087e1790b', '/admin/master/console/*');
INSERT INTO keycloak.redirect_uris VALUES ('e801cbf0-541f-4466-80e1-fcce640df2a8', '/realms/appcket/account/*');
INSERT INTO keycloak.redirect_uris VALUES ('26f802c3-b7af-4e78-b785-40493ae2483a', '/realms/appcket/account/*');
INSERT INTO keycloak.redirect_uris VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'https://api.appcket.localhost/*');
INSERT INTO keycloak.redirect_uris VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'http://api.appcket.localhost/*');
INSERT INTO keycloak.redirect_uris VALUES ('4dd4c360-d5b9-4730-8091-78b394cea334', '/admin/appcket/console/*');
INSERT INTO keycloak.redirect_uris VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'https://app.appcket.localhost/*');
INSERT INTO keycloak.redirect_uris VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'https://appcket.localhost');


--
-- TOC entry 3876 (class 0 OID 18949)
-- Dependencies: 253
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3875 (class 0 OID 18941)
-- Dependencies: 252
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.required_action_provider VALUES ('df9b6dd7-68b7-4c12-959b-4e4f9b7f7793', 'VERIFY_EMAIL', 'Verify Email', 'master', true, false, 'VERIFY_EMAIL', 50);
INSERT INTO keycloak.required_action_provider VALUES ('ed5452a8-db66-4150-891b-bd4592ac728d', 'UPDATE_PROFILE', 'Update Profile', 'master', true, false, 'UPDATE_PROFILE', 40);
INSERT INTO keycloak.required_action_provider VALUES ('24bcdb9f-f8ed-4d27-8f0d-f02aa7c24cdd', 'CONFIGURE_TOTP', 'Configure OTP', 'master', true, false, 'CONFIGURE_TOTP', 10);
INSERT INTO keycloak.required_action_provider VALUES ('251cbcaa-0527-41a8-907d-79624507b15d', 'UPDATE_PASSWORD', 'Update Password', 'master', true, false, 'UPDATE_PASSWORD', 30);
INSERT INTO keycloak.required_action_provider VALUES ('85bd8694-ee12-4758-a814-0ca885776445', 'terms_and_conditions', 'Terms and Conditions', 'master', false, false, 'terms_and_conditions', 20);
INSERT INTO keycloak.required_action_provider VALUES ('463c442c-6694-47af-b3cc-07be1b296f9e', 'update_user_locale', 'Update User Locale', 'master', true, false, 'update_user_locale', 1000);
INSERT INTO keycloak.required_action_provider VALUES ('ede20f96-e8ce-400a-a4a5-d6bb3cc0ca93', 'delete_account', 'Delete Account', 'master', false, false, 'delete_account', 60);
INSERT INTO keycloak.required_action_provider VALUES ('decb3163-79c3-4470-b186-2f27ad808ad2', 'CONFIGURE_TOTP', 'Configure OTP', 'appcket', true, false, 'CONFIGURE_TOTP', 10);
INSERT INTO keycloak.required_action_provider VALUES ('953aa395-7fb6-463c-bef1-f1a25911fb46', 'terms_and_conditions', 'Terms and Conditions', 'appcket', false, false, 'terms_and_conditions', 20);
INSERT INTO keycloak.required_action_provider VALUES ('b60d9d5b-3614-405e-8cbf-11365dc259f7', 'UPDATE_PASSWORD', 'Update Password', 'appcket', true, false, 'UPDATE_PASSWORD', 30);
INSERT INTO keycloak.required_action_provider VALUES ('7a1694ca-3c29-4635-b146-7beada111d01', 'UPDATE_PROFILE', 'Update Profile', 'appcket', true, false, 'UPDATE_PROFILE', 40);
INSERT INTO keycloak.required_action_provider VALUES ('d495c3d5-b458-4f03-9e52-0f23adc21dbd', 'VERIFY_EMAIL', 'Verify Email', 'appcket', true, false, 'VERIFY_EMAIL', 50);
INSERT INTO keycloak.required_action_provider VALUES ('4f3f4b82-831f-4ce4-b537-8cab80284ac2', 'update_user_locale', 'Update User Locale', 'appcket', true, false, 'update_user_locale', 1000);
INSERT INTO keycloak.required_action_provider VALUES ('148c3a84-d1df-4887-9fd4-88d06f14ffc0', 'delete_account', 'Delete Account', 'appcket', false, false, 'delete_account', 60);


--
-- TOC entry 3913 (class 0 OID 19670)
-- Dependencies: 290
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3893 (class 0 OID 19243)
-- Dependencies: 270
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.resource_policy VALUES ('31e55791-13e5-4d30-a7d8-35864230ab8c', 'beb7d05d-19f7-4690-86e9-13dd49936d71');
INSERT INTO keycloak.resource_policy VALUES ('31e55791-13e5-4d30-a7d8-35864230ab8c', 'a03337fa-5ad4-42e1-8beb-52afcac74329');
INSERT INTO keycloak.resource_policy VALUES ('31e55791-13e5-4d30-a7d8-35864230ab8c', 'ab1f242c-d8bf-4860-a2b1-4702f367bbd5');
INSERT INTO keycloak.resource_policy VALUES ('31e55791-13e5-4d30-a7d8-35864230ab8c', 'f93476a3-2536-4e2c-bcad-212d0859fbe1');
INSERT INTO keycloak.resource_policy VALUES ('d5e429e0-d6c9-40c5-95b4-b56d1ec01cd6', '6338e03e-6909-496e-b52c-1cc62eb5eba6');
INSERT INTO keycloak.resource_policy VALUES ('d5e429e0-d6c9-40c5-95b4-b56d1ec01cd6', '42c43075-9052-4129-bebc-691c56a66dfd');
INSERT INTO keycloak.resource_policy VALUES ('d5e429e0-d6c9-40c5-95b4-b56d1ec01cd6', 'f7b5232d-91c5-4444-b8ca-165d17552a5d');
INSERT INTO keycloak.resource_policy VALUES ('d5e429e0-d6c9-40c5-95b4-b56d1ec01cd6', 'b6033d87-3b1b-4002-8f97-255956c2b506');
INSERT INTO keycloak.resource_policy VALUES ('d2dbc0cc-0a77-4194-b291-4199b719bb3f', '7db68186-ebbb-40a8-8dd7-147deddae4ce');
INSERT INTO keycloak.resource_policy VALUES ('d2dbc0cc-0a77-4194-b291-4199b719bb3f', '48345f52-292b-474c-acd3-1cc56513aa4f');
INSERT INTO keycloak.resource_policy VALUES ('d2dbc0cc-0a77-4194-b291-4199b719bb3f', '73c7d9cb-5b6a-4a57-a7e1-5e81ec3aa8c2');
INSERT INTO keycloak.resource_policy VALUES ('d2dbc0cc-0a77-4194-b291-4199b719bb3f', '2d99ec81-c6a8-4949-b129-0bc425126832');
INSERT INTO keycloak.resource_policy VALUES ('c2b44cad-bf85-486a-b96e-45f849b7ae24', '68061593-00a9-46ae-b3a5-b21333100a20');
INSERT INTO keycloak.resource_policy VALUES ('c2b44cad-bf85-486a-b96e-45f849b7ae24', '69a3bcf1-89b4-4602-bc26-9d34eb5d9c55');
INSERT INTO keycloak.resource_policy VALUES ('c2b44cad-bf85-486a-b96e-45f849b7ae24', 'df6b4650-ee44-4f35-b5fe-1891afe29334');
INSERT INTO keycloak.resource_policy VALUES ('c2b44cad-bf85-486a-b96e-45f849b7ae24', 'dbc609b4-6662-4067-b552-7ff079e1d7ed');


--
-- TOC entry 3892 (class 0 OID 19228)
-- Dependencies: 269
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.resource_scope VALUES ('d5e429e0-d6c9-40c5-95b4-b56d1ec01cd6', '6ba0e730-65b0-4c13-81c1-ccf1576b3926');
INSERT INTO keycloak.resource_scope VALUES ('d5e429e0-d6c9-40c5-95b4-b56d1ec01cd6', 'fb335bfa-b1e9-4557-8cc4-a113e9a7f929');
INSERT INTO keycloak.resource_scope VALUES ('d5e429e0-d6c9-40c5-95b4-b56d1ec01cd6', 'cfc355ca-0083-4237-b2a5-b8bba690e9f2');
INSERT INTO keycloak.resource_scope VALUES ('d5e429e0-d6c9-40c5-95b4-b56d1ec01cd6', '34d6c370-b0af-41e9-a129-3fd5fc4622f6');
INSERT INTO keycloak.resource_scope VALUES ('d2dbc0cc-0a77-4194-b291-4199b719bb3f', 'cb74d4a6-b1c6-4643-b97c-25e1a2ada279');
INSERT INTO keycloak.resource_scope VALUES ('d2dbc0cc-0a77-4194-b291-4199b719bb3f', '0cad1c5f-c4ca-4bb1-955f-532f0d1e1862');
INSERT INTO keycloak.resource_scope VALUES ('d2dbc0cc-0a77-4194-b291-4199b719bb3f', 'e28c708d-3237-486e-a2ac-f716b1b2727f');
INSERT INTO keycloak.resource_scope VALUES ('d2dbc0cc-0a77-4194-b291-4199b719bb3f', '2de7d2b4-f1a9-41d9-a34a-07b2f2f35f66');
INSERT INTO keycloak.resource_scope VALUES ('31e55791-13e5-4d30-a7d8-35864230ab8c', '347b3c43-989e-4273-9247-89f233557b7c');
INSERT INTO keycloak.resource_scope VALUES ('31e55791-13e5-4d30-a7d8-35864230ab8c', '58c400a6-61f6-47fd-81ad-67e002198882');
INSERT INTO keycloak.resource_scope VALUES ('31e55791-13e5-4d30-a7d8-35864230ab8c', '7a452b00-fae1-416f-ad9c-f1c622819c3a');
INSERT INTO keycloak.resource_scope VALUES ('31e55791-13e5-4d30-a7d8-35864230ab8c', 'cc04a208-f6d1-446e-bea6-5de03622579a');
INSERT INTO keycloak.resource_scope VALUES ('c2b44cad-bf85-486a-b96e-45f849b7ae24', 'bd4a6c23-aba5-4b86-b394-690ee1c3ddc1');
INSERT INTO keycloak.resource_scope VALUES ('c2b44cad-bf85-486a-b96e-45f849b7ae24', '7b62a73c-d6cf-4e6c-9b79-fa02e98c4ecd');
INSERT INTO keycloak.resource_scope VALUES ('c2b44cad-bf85-486a-b96e-45f849b7ae24', '4aef873b-3fbb-4ffb-9736-03b1615e172b');
INSERT INTO keycloak.resource_scope VALUES ('c2b44cad-bf85-486a-b96e-45f849b7ae24', '328dd4b0-065d-4a9c-86dc-412b567f7331');


--
-- TOC entry 3887 (class 0 OID 19162)
-- Dependencies: 264
-- Data for Name: resource_server; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.resource_server VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', true, '0', 1);


--
-- TOC entry 3912 (class 0 OID 19646)
-- Dependencies: 289
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3890 (class 0 OID 19200)
-- Dependencies: 267
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.resource_server_policy VALUES ('bfaf527b-4238-46d7-aa48-1d605b7c390f', 'Default Policy', 'A policy that grants access only for users within this realm', 'js', '0', '0', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('f54d2838-ff5a-4259-8560-c50f042375ab', 'Captain Policy', 'Captain role-based policy', 'role', '1', '0', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('0f3a33e0-4365-44e0-b7af-c6af4aa8e9c7', 'Manager Policy', 'Manager role-based policy', 'role', '1', '0', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('53667455-8734-49e0-9e11-db6aacce6cbf', 'Teammate Policy', 'Teammate role-based policy', 'role', '1', '0', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('56cc0301-6b50-4bb1-b870-514669458695', 'Spectator Policy', 'Spectator role-based policy', 'role', '1', '0', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('b498b31a-81fa-4a32-b625-71ca3e577dcb', 'Default Permission', 'A permission that applies to the default resource type', 'resource', '1', '0', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('6338e03e-6909-496e-b52c-1cc62eb5eba6', 'Create Task Permission', NULL, 'scope', '0', '0', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('42c43075-9052-4129-bebc-691c56a66dfd', 'Read Task Permission', NULL, 'scope', '0', '0', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('f7b5232d-91c5-4444-b8ca-165d17552a5d', 'Update Task Permission', NULL, 'scope', '0', '0', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('b6033d87-3b1b-4002-8f97-255956c2b506', 'Delete Task Permission', NULL, 'scope', '0', '0', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('2d99ec81-c6a8-4949-b129-0bc425126832', 'Delete Team Permission', NULL, 'scope', '0', '0', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('48345f52-292b-474c-acd3-1cc56513aa4f', 'Read Team Permission', NULL, 'scope', '0', '0', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('73c7d9cb-5b6a-4a57-a7e1-5e81ec3aa8c2', 'Update Team Permission', NULL, 'scope', '0', '0', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('beb7d05d-19f7-4690-86e9-13dd49936d71', 'Create Organization Permission', NULL, 'scope', '0', '0', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('f93476a3-2536-4e2c-bcad-212d0859fbe1', 'Delete Organization Permission', NULL, 'scope', '0', '0', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('a03337fa-5ad4-42e1-8beb-52afcac74329', 'Read Organization Permission', NULL, 'scope', '0', '0', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('ab1f242c-d8bf-4860-a2b1-4702f367bbd5', 'Update Organization Permission', NULL, 'scope', '0', '0', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('7db68186-ebbb-40a8-8dd7-147deddae4ce', 'Create Team Permission', NULL, 'scope', '0', '0', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('68061593-00a9-46ae-b3a5-b21333100a20', 'Create Project Permission', NULL, 'scope', '0', '0', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('69a3bcf1-89b4-4602-bc26-9d34eb5d9c55', 'Read Project Permission', NULL, 'scope', '0', '0', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('df6b4650-ee44-4f35-b5fe-1891afe29334', 'Update Project Permission', NULL, 'scope', '0', '0', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);
INSERT INTO keycloak.resource_server_policy VALUES ('dbc609b4-6662-4067-b552-7ff079e1d7ed', 'Delete Project Permission', NULL, 'scope', '0', '0', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', NULL);


--
-- TOC entry 3888 (class 0 OID 19170)
-- Dependencies: 265
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.resource_server_resource VALUES ('b59ef162-80d4-43af-9758-9fa0a2fc158a', 'Default Resource', 'urn:appcket_api:resources:default', NULL, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', false, NULL);
INSERT INTO keycloak.resource_server_resource VALUES ('d5e429e0-d6c9-40c5-95b4-b56d1ec01cd6', 'Task', NULL, NULL, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', false, 'Task');
INSERT INTO keycloak.resource_server_resource VALUES ('d2dbc0cc-0a77-4194-b291-4199b719bb3f', 'Team', NULL, NULL, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', false, 'Team');
INSERT INTO keycloak.resource_server_resource VALUES ('31e55791-13e5-4d30-a7d8-35864230ab8c', 'Organization', NULL, NULL, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', false, 'Organization');
INSERT INTO keycloak.resource_server_resource VALUES ('c2b44cad-bf85-486a-b96e-45f849b7ae24', 'Project', NULL, NULL, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', '6518e1e7-19a8-4e2b-8718-18a075b49ac6', false, 'Project');


--
-- TOC entry 3889 (class 0 OID 19185)
-- Dependencies: 266
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


--
-- TOC entry 3914 (class 0 OID 19689)
-- Dependencies: 291
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.resource_uris VALUES ('b59ef162-80d4-43af-9758-9fa0a2fc158a', '/*');


--
-- TOC entry 3915 (class 0 OID 19699)
-- Dependencies: 292
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3840 (class 0 OID 18264)
-- Dependencies: 217
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.scope_mapping VALUES ('567f4fd5-d705-46fc-9956-31901fd76939', '3bc03d66-dc4a-4a39-9a0c-f30ddbaa9770');
INSERT INTO keycloak.scope_mapping VALUES ('26f802c3-b7af-4e78-b785-40493ae2483a', '395df0fe-9ce6-4af3-9d3f-a76b64e2c6b1');


--
-- TOC entry 3894 (class 0 OID 19258)
-- Dependencies: 271
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.scope_policy VALUES ('7a452b00-fae1-416f-ad9c-f1c622819c3a', 'beb7d05d-19f7-4690-86e9-13dd49936d71');
INSERT INTO keycloak.scope_policy VALUES ('58c400a6-61f6-47fd-81ad-67e002198882', 'a03337fa-5ad4-42e1-8beb-52afcac74329');
INSERT INTO keycloak.scope_policy VALUES ('cc04a208-f6d1-446e-bea6-5de03622579a', 'ab1f242c-d8bf-4860-a2b1-4702f367bbd5');
INSERT INTO keycloak.scope_policy VALUES ('347b3c43-989e-4273-9247-89f233557b7c', 'f93476a3-2536-4e2c-bcad-212d0859fbe1');
INSERT INTO keycloak.scope_policy VALUES ('fb335bfa-b1e9-4557-8cc4-a113e9a7f929', '6338e03e-6909-496e-b52c-1cc62eb5eba6');
INSERT INTO keycloak.scope_policy VALUES ('fb335bfa-b1e9-4557-8cc4-a113e9a7f929', '42c43075-9052-4129-bebc-691c56a66dfd');
INSERT INTO keycloak.scope_policy VALUES ('cfc355ca-0083-4237-b2a5-b8bba690e9f2', 'f7b5232d-91c5-4444-b8ca-165d17552a5d');
INSERT INTO keycloak.scope_policy VALUES ('6ba0e730-65b0-4c13-81c1-ccf1576b3926', 'b6033d87-3b1b-4002-8f97-255956c2b506');
INSERT INTO keycloak.scope_policy VALUES ('0cad1c5f-c4ca-4bb1-955f-532f0d1e1862', '7db68186-ebbb-40a8-8dd7-147deddae4ce');
INSERT INTO keycloak.scope_policy VALUES ('cb74d4a6-b1c6-4643-b97c-25e1a2ada279', '48345f52-292b-474c-acd3-1cc56513aa4f');
INSERT INTO keycloak.scope_policy VALUES ('e28c708d-3237-486e-a2ac-f716b1b2727f', '73c7d9cb-5b6a-4a57-a7e1-5e81ec3aa8c2');
INSERT INTO keycloak.scope_policy VALUES ('2de7d2b4-f1a9-41d9-a34a-07b2f2f35f66', '2d99ec81-c6a8-4949-b129-0bc425126832');
INSERT INTO keycloak.scope_policy VALUES ('4aef873b-3fbb-4ffb-9736-03b1615e172b', '68061593-00a9-46ae-b3a5-b21333100a20');
INSERT INTO keycloak.scope_policy VALUES ('bd4a6c23-aba5-4b86-b394-690ee1c3ddc1', '69a3bcf1-89b4-4602-bc26-9d34eb5d9c55');
INSERT INTO keycloak.scope_policy VALUES ('328dd4b0-065d-4a9c-86dc-412b567f7331', 'df6b4650-ee44-4f35-b5fe-1891afe29334');
INSERT INTO keycloak.scope_policy VALUES ('7b62a73c-d6cf-4e6c-9b79-fa02e98c4ecd', 'dbc609b4-6662-4067-b552-7ff079e1d7ed');


--
-- TOC entry 3842 (class 0 OID 18270)
-- Dependencies: 219
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.user_attribute VALUES ('jobTitle', 'CEO, Vandelay Industries', 'cd88e2db-00bb-474f-91d2-2096e10f86a1', '315da26d-7b3b-4ce1-bc1e-341590d23390');
INSERT INTO keycloak.user_attribute VALUES ('jobTitle', 'Regional Director, Manufacturing', 'ff88829c-0226-44f3-9eb2-6e294ccd57d3', '4bfe5508-8121-46db-bf9a-44679a51b174');
INSERT INTO keycloak.user_attribute VALUES ('jobTitle', 'Assistant Vice President', '4379775d-7629-4dca-9dd0-8781329569b1', '11fa4509-3efc-46fb-9d36-f2beacdfe8da');


--
-- TOC entry 3864 (class 0 OID 18723)
-- Dependencies: 241
-- Data for Name: user_consent; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3910 (class 0 OID 19621)
-- Dependencies: 287
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3843 (class 0 OID 18276)
-- Dependencies: 220
-- Data for Name: user_entity; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.user_entity VALUES ('60eefe04-5c0e-456b-9f20-6b6c333cece7', NULL, '5e98eaf7-5e9f-421d-be4a-85a77ecdf066', false, true, NULL, NULL, NULL, 'master', 'admin', 1632600814557, NULL, 0);
INSERT INTO keycloak.user_entity VALUES ('6c15646c-89cb-43ad-aa91-cbdc4bdca430', NULL, 'df522d01-960d-4689-8913-3d15ca3224fd', false, true, NULL, NULL, NULL, 'appcket', 'service-account-appcket_api', 1588298918111, '6518e1e7-19a8-4e2b-8718-18a075b49ac6', 0);
INSERT INTO keycloak.user_entity VALUES ('4379775d-7629-4dca-9dd0-8781329569b1', 'ryan@appcket.org', 'ryan@appcket.org', true, true, NULL, 'Ryan', NULL, 'appcket', 'ryan', 1632601225247, NULL, 0);
INSERT INTO keycloak.user_entity VALUES ('18b24af2-ef61-4fcc-a1e0-b27bbc4f6a2d', 'lloyd@appcket.org', 'lloyd@appcket.org', true, true, NULL, 'Lloyd', 'Braun', 'appcket', 'lloyd', 1632601326687, NULL, 0);
INSERT INTO keycloak.user_entity VALUES ('cd88e2db-00bb-474f-91d2-2096e10f86a1', 'art@vandelay.com', 'art@vandelay.com', true, true, NULL, 'Art', 'Vandelay', 'appcket', 'art', 1632601367277, NULL, 0);
INSERT INTO keycloak.user_entity VALUES ('ff88829c-0226-44f3-9eb2-6e294ccd57d3', 'kel@appcket.org', 'kel@appcket.org', true, true, NULL, 'Kel', 'Varnson', 'appcket', 'kel', 1632601760070, NULL, 0);
INSERT INTO keycloak.user_entity VALUES ('6dde7b5b-ffe1-4627-9ca9-d4c5290f6f20', 'he@appcket.org', 'he@appcket.org', true, true, NULL, 'Horace', 'Pennypacker', 'appcket', 'he', 1632601781288, NULL, 0);


--
-- TOC entry 3844 (class 0 OID 18285)
-- Dependencies: 221
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3871 (class 0 OID 18839)
-- Dependencies: 248
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3872 (class 0 OID 18845)
-- Dependencies: 249
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3845 (class 0 OID 18291)
-- Dependencies: 222
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3882 (class 0 OID 19015)
-- Dependencies: 259
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3846 (class 0 OID 18297)
-- Dependencies: 223
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3847 (class 0 OID 18300)
-- Dependencies: 224
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.user_role_mapping VALUES ('f61b13f5-0859-413b-ba9f-27b4cb813144', '60eefe04-5c0e-456b-9f20-6b6c333cece7');
INSERT INTO keycloak.user_role_mapping VALUES ('d602aef9-4148-4ac0-bbe3-32894bb7cbf6', '60eefe04-5c0e-456b-9f20-6b6c333cece7');
INSERT INTO keycloak.user_role_mapping VALUES ('558648c2-b53b-4dfd-906f-d30b67967ecd', '6c15646c-89cb-43ad-aa91-cbdc4bdca430');
INSERT INTO keycloak.user_role_mapping VALUES ('241f95cd-d0a8-4b5e-b7d3-657f078175bb', '6c15646c-89cb-43ad-aa91-cbdc4bdca430');
INSERT INTO keycloak.user_role_mapping VALUES ('a5654d13-57b2-4a00-8ffa-e4be21c18524', '6c15646c-89cb-43ad-aa91-cbdc4bdca430');
INSERT INTO keycloak.user_role_mapping VALUES ('395df0fe-9ce6-4af3-9d3f-a76b64e2c6b1', '6c15646c-89cb-43ad-aa91-cbdc4bdca430');
INSERT INTO keycloak.user_role_mapping VALUES ('f82082f8-ce8f-4514-a0df-08b916e08db3', '6c15646c-89cb-43ad-aa91-cbdc4bdca430');
INSERT INTO keycloak.user_role_mapping VALUES ('3a3efbeb-83dc-4f82-b78d-f00e954d7d40', '4379775d-7629-4dca-9dd0-8781329569b1');
INSERT INTO keycloak.user_role_mapping VALUES ('a1234e9b-ccf4-43c2-8c5a-f8d5964d9e22', '18b24af2-ef61-4fcc-a1e0-b27bbc4f6a2d');
INSERT INTO keycloak.user_role_mapping VALUES ('3a3efbeb-83dc-4f82-b78d-f00e954d7d40', 'cd88e2db-00bb-474f-91d2-2096e10f86a1');
INSERT INTO keycloak.user_role_mapping VALUES ('3a3efbeb-83dc-4f82-b78d-f00e954d7d40', 'ff88829c-0226-44f3-9eb2-6e294ccd57d3');
INSERT INTO keycloak.user_role_mapping VALUES ('3a3efbeb-83dc-4f82-b78d-f00e954d7d40', '6dde7b5b-ffe1-4627-9ca9-d4c5290f6f20');
INSERT INTO keycloak.user_role_mapping VALUES ('934d2eb7-4ffa-406f-b8a9-155460dd9872', '6c15646c-89cb-43ad-aa91-cbdc4bdca430');
INSERT INTO keycloak.user_role_mapping VALUES ('eee97160-4b67-4071-84f4-099bbcd704af', '6c15646c-89cb-43ad-aa91-cbdc4bdca430');
INSERT INTO keycloak.user_role_mapping VALUES ('1b55f720-894d-4d89-b37d-358e5eb29309', '4379775d-7629-4dca-9dd0-8781329569b1');
INSERT INTO keycloak.user_role_mapping VALUES ('97caa102-e9d8-44de-94a1-74e5ea7bccb5', 'cd88e2db-00bb-474f-91d2-2096e10f86a1');
INSERT INTO keycloak.user_role_mapping VALUES ('97caa102-e9d8-44de-94a1-74e5ea7bccb5', '6dde7b5b-ffe1-4627-9ca9-d4c5290f6f20');


--
-- TOC entry 3848 (class 0 OID 18303)
-- Dependencies: 225
-- Data for Name: user_session; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3859 (class 0 OID 18618)
-- Dependencies: 236
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3841 (class 0 OID 18267)
-- Dependencies: 218
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--



--
-- TOC entry 3849 (class 0 OID 18316)
-- Dependencies: 226
-- Data for Name: web_origins; Type: TABLE DATA; Schema: keycloak; Owner: dbuser
--

INSERT INTO keycloak.web_origins VALUES ('5b745968-9295-482c-b42f-d11087e1790b', '+');
INSERT INTO keycloak.web_origins VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'http://api.appcket.localhost/');
INSERT INTO keycloak.web_origins VALUES ('6518e1e7-19a8-4e2b-8718-18a075b49ac6', 'https://api.appcket.localhost');
INSERT INTO keycloak.web_origins VALUES ('4dd4c360-d5b9-4730-8091-78b394cea334', '+');
INSERT INTO keycloak.web_origins VALUES ('68d063b7-66bc-4e03-8ed0-38694d466ad3', 'https://app.appcket.localhost');


--
-- TOC entry 3380 (class 2606 OID 19412)
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- TOC entry 3353 (class 2606 OID 19726)
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- TOC entry 3594 (class 2606 OID 19551)
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- TOC entry 3596 (class 2606 OID 19758)
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- TOC entry 3591 (class 2606 OID 19426)
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- TOC entry 3508 (class 2606 OID 19057)
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- TOC entry 3556 (class 2606 OID 19345)
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3478 (class 2606 OID 18962)
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- TOC entry 3582 (class 2606 OID 19365)
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- TOC entry 3585 (class 2606 OID 19363)
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- TOC entry 3574 (class 2606 OID 19361)
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3558 (class 2606 OID 19347)
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3561 (class 2606 OID 19349)
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- TOC entry 3566 (class 2606 OID 19355)
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- TOC entry 3570 (class 2606 OID 19357)
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3578 (class 2606 OID 19359)
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3589 (class 2606 OID 19405)
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- TOC entry 3510 (class 2606 OID 19510)
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- TOC entry 3438 (class 2606 OID 19527)
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- TOC entry 3367 (class 2606 OID 19529)
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- TOC entry 3433 (class 2606 OID 19531)
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- TOC entry 3426 (class 2606 OID 18628)
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- TOC entry 3409 (class 2606 OID 18556)
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- TOC entry 3350 (class 2606 OID 18328)
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- TOC entry 3422 (class 2606 OID 18630)
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3359 (class 2606 OID 18330)
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- TOC entry 3341 (class 2606 OID 18332)
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- TOC entry 3404 (class 2606 OID 18334)
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- TOC entry 3395 (class 2606 OID 18336)
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- TOC entry 3412 (class 2606 OID 18558)
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- TOC entry 3333 (class 2606 OID 18340)
-- Name: client constraint_7; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- TOC entry 3338 (class 2606 OID 18342)
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- TOC entry 3377 (class 2606 OID 18344)
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- TOC entry 3414 (class 2606 OID 18560)
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- TOC entry 3364 (class 2606 OID 18346)
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- TOC entry 3370 (class 2606 OID 18348)
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- TOC entry 3355 (class 2606 OID 18350)
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- TOC entry 3456 (class 2606 OID 19514)
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- TOC entry 3468 (class 2606 OID 18867)
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- TOC entry 3464 (class 2606 OID 18865)
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- TOC entry 3461 (class 2606 OID 18863)
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- TOC entry 3458 (class 2606 OID 18861)
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- TOC entry 3476 (class 2606 OID 18871)
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- TOC entry 3401 (class 2606 OID 18352)
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3343 (class 2606 OID 19508)
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- TOC entry 3454 (class 2606 OID 18748)
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- TOC entry 3431 (class 2606 OID 18632)
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- TOC entry 3542 (class 2606 OID 19222)
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- TOC entry 3372 (class 2606 OID 18354)
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- TOC entry 3347 (class 2606 OID 18356)
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- TOC entry 3393 (class 2606 OID 18358)
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- TOC entry 3609 (class 2606 OID 19650)
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- TOC entry 3527 (class 2606 OID 19177)
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- TOC entry 3537 (class 2606 OID 19207)
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- TOC entry 3553 (class 2606 OID 19277)
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- TOC entry 3547 (class 2606 OID 19247)
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- TOC entry 3532 (class 2606 OID 19192)
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- TOC entry 3544 (class 2606 OID 19232)
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- TOC entry 3550 (class 2606 OID 19262)
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- TOC entry 3386 (class 2606 OID 18360)
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- TOC entry 3474 (class 2606 OID 18875)
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- TOC entry 3470 (class 2606 OID 18873)
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- TOC entry 3607 (class 2606 OID 19635)
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3604 (class 2606 OID 19625)
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3449 (class 2606 OID 18742)
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- TOC entry 3495 (class 2606 OID 19024)
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- TOC entry 3502 (class 2606 OID 19031)
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3499 (class 2606 OID 19045)
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- TOC entry 3444 (class 2606 OID 18738)
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- TOC entry 3447 (class 2606 OID 18924)
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- TOC entry 3441 (class 2606 OID 18736)
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- TOC entry 3491 (class 2606 OID 19733)
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- TOC entry 3485 (class 2606 OID 18999)
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- TOC entry 3416 (class 2606 OID 18626)
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- TOC entry 3420 (class 2606 OID 18917)
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- TOC entry 3374 (class 2606 OID 19533)
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- TOC entry 3483 (class 2606 OID 18960)
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- TOC entry 3480 (class 2606 OID 18958)
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- TOC entry 3398 (class 2606 OID 18869)
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3615 (class 2606 OID 19698)
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- TOC entry 3617 (class 2606 OID 19706)
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3382 (class 2606 OID 18956)
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3505 (class 2606 OID 19038)
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3436 (class 2606 OID 18636)
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- TOC entry 3406 (class 2606 OID 19535)
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- TOC entry 3519 (class 2606 OID 19143)
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- TOC entry 3514 (class 2606 OID 19102)
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- TOC entry 3331 (class 2606 OID 18155)
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- TOC entry 3525 (class 2606 OID 19488)
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- TOC entry 3523 (class 2606 OID 19131)
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- TOC entry 3602 (class 2606 OID 19610)
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- TOC entry 3620 (class 2606 OID 19752)
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- TOC entry 3613 (class 2606 OID 19678)
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3497 (class 2606 OID 19418)
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- TOC entry 3429 (class 2606 OID 18683)
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- TOC entry 3336 (class 2606 OID 18364)
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- TOC entry 3516 (class 2606 OID 19563)
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- TOC entry 3389 (class 2606 OID 18368)
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- TOC entry 3530 (class 2606 OID 19742)
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- TOC entry 3611 (class 2606 OID 19737)
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- TOC entry 3540 (class 2606 OID 19479)
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3535 (class 2606 OID 19483)
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3452 (class 2606 OID 19728)
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- TOC entry 3362 (class 2606 OID 18376)
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- TOC entry 3391 (class 2606 OID 19407)
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- TOC entry 3554 (class 1259 OID 19432)
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON keycloak.associated_policy USING btree (associated_policy_id);


--
-- TOC entry 3459 (class 1259 OID 19436)
-- Name: idx_auth_config_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_auth_config_realm ON keycloak.authenticator_config USING btree (realm_id);


--
-- TOC entry 3465 (class 1259 OID 19434)
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_auth_exec_flow ON keycloak.authentication_execution USING btree (flow_id);


--
-- TOC entry 3466 (class 1259 OID 19433)
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_auth_exec_realm_flow ON keycloak.authentication_execution USING btree (realm_id, flow_id);


--
-- TOC entry 3462 (class 1259 OID 19435)
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_auth_flow_realm ON keycloak.authentication_flow USING btree (realm_id);


--
-- TOC entry 3597 (class 1259 OID 19759)
-- Name: idx_cl_clscope; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_cl_clscope ON keycloak.client_scope_client USING btree (scope_id);


--
-- TOC entry 3410 (class 1259 OID 19766)
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_client_att_by_name_value ON keycloak.client_attributes USING btree (name, ((value)::character varying(250)));


--
-- TOC entry 3334 (class 1259 OID 19743)
-- Name: idx_client_id; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_client_id ON keycloak.client USING btree (client_id);


--
-- TOC entry 3592 (class 1259 OID 19476)
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_client_init_acc_realm ON keycloak.client_initial_access USING btree (realm_id);


--
-- TOC entry 3339 (class 1259 OID 19440)
-- Name: idx_client_session_session; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_client_session_session ON keycloak.client_session USING btree (session_id);


--
-- TOC entry 3517 (class 1259 OID 19640)
-- Name: idx_clscope_attrs; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_clscope_attrs ON keycloak.client_scope_attributes USING btree (scope_id);


--
-- TOC entry 3598 (class 1259 OID 19756)
-- Name: idx_clscope_cl; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_clscope_cl ON keycloak.client_scope_client USING btree (client_id);


--
-- TOC entry 3417 (class 1259 OID 19637)
-- Name: idx_clscope_protmap; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_clscope_protmap ON keycloak.protocol_mapper USING btree (client_scope_id);


--
-- TOC entry 3520 (class 1259 OID 19638)
-- Name: idx_clscope_role; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_clscope_role ON keycloak.client_scope_role_mapping USING btree (scope_id);


--
-- TOC entry 3583 (class 1259 OID 19442)
-- Name: idx_compo_config_compo; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_compo_config_compo ON keycloak.component_config USING btree (component_id);


--
-- TOC entry 3586 (class 1259 OID 19713)
-- Name: idx_component_provider_type; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_component_provider_type ON keycloak.component USING btree (provider_type);


--
-- TOC entry 3587 (class 1259 OID 19441)
-- Name: idx_component_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_component_realm ON keycloak.component USING btree (realm_id);


--
-- TOC entry 3344 (class 1259 OID 19443)
-- Name: idx_composite; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_composite ON keycloak.composite_role USING btree (composite);


--
-- TOC entry 3345 (class 1259 OID 19444)
-- Name: idx_composite_child; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_composite_child ON keycloak.composite_role USING btree (child_role);


--
-- TOC entry 3599 (class 1259 OID 19643)
-- Name: idx_defcls_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_defcls_realm ON keycloak.default_client_scope USING btree (realm_id);


--
-- TOC entry 3600 (class 1259 OID 19644)
-- Name: idx_defcls_scope; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_defcls_scope ON keycloak.default_client_scope USING btree (scope_id);


--
-- TOC entry 3351 (class 1259 OID 19744)
-- Name: idx_event_time; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_event_time ON keycloak.event_entity USING btree (realm_id, event_time);


--
-- TOC entry 3423 (class 1259 OID 19161)
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_fedidentity_feduser ON keycloak.federated_identity USING btree (federated_user_id);


--
-- TOC entry 3424 (class 1259 OID 19160)
-- Name: idx_fedidentity_user; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_fedidentity_user ON keycloak.federated_identity USING btree (user_id);


--
-- TOC entry 3559 (class 1259 OID 19536)
-- Name: idx_fu_attribute; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_fu_attribute ON keycloak.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- TOC entry 3562 (class 1259 OID 19557)
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_fu_cnsnt_ext ON keycloak.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- TOC entry 3563 (class 1259 OID 19724)
-- Name: idx_fu_consent; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_fu_consent ON keycloak.fed_user_consent USING btree (user_id, client_id);


--
-- TOC entry 3564 (class 1259 OID 19538)
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_fu_consent_ru ON keycloak.fed_user_consent USING btree (realm_id, user_id);


--
-- TOC entry 3567 (class 1259 OID 19539)
-- Name: idx_fu_credential; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_fu_credential ON keycloak.fed_user_credential USING btree (user_id, type);


--
-- TOC entry 3568 (class 1259 OID 19540)
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_fu_credential_ru ON keycloak.fed_user_credential USING btree (realm_id, user_id);


--
-- TOC entry 3571 (class 1259 OID 19541)
-- Name: idx_fu_group_membership; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_fu_group_membership ON keycloak.fed_user_group_membership USING btree (user_id, group_id);


--
-- TOC entry 3572 (class 1259 OID 19542)
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_fu_group_membership_ru ON keycloak.fed_user_group_membership USING btree (realm_id, user_id);


--
-- TOC entry 3575 (class 1259 OID 19543)
-- Name: idx_fu_required_action; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_fu_required_action ON keycloak.fed_user_required_action USING btree (user_id, required_action);


--
-- TOC entry 3576 (class 1259 OID 19544)
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_fu_required_action_ru ON keycloak.fed_user_required_action USING btree (realm_id, user_id);


--
-- TOC entry 3579 (class 1259 OID 19545)
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_fu_role_mapping ON keycloak.fed_user_role_mapping USING btree (user_id, role_id);


--
-- TOC entry 3580 (class 1259 OID 19546)
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_fu_role_mapping_ru ON keycloak.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- TOC entry 3503 (class 1259 OID 19447)
-- Name: idx_group_attr_group; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_group_attr_group ON keycloak.group_attribute USING btree (group_id);


--
-- TOC entry 3500 (class 1259 OID 19448)
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_group_role_mapp_group ON keycloak.group_role_mapping USING btree (group_id);


--
-- TOC entry 3445 (class 1259 OID 19450)
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_id_prov_mapp_realm ON keycloak.identity_provider_mapper USING btree (realm_id);


--
-- TOC entry 3427 (class 1259 OID 19449)
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_ident_prov_realm ON keycloak.identity_provider USING btree (realm_id);


--
-- TOC entry 3356 (class 1259 OID 19451)
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_keycloak_role_client ON keycloak.keycloak_role USING btree (client);


--
-- TOC entry 3357 (class 1259 OID 19452)
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_keycloak_role_realm ON keycloak.keycloak_role USING btree (realm);


--
-- TOC entry 3492 (class 1259 OID 19763)
-- Name: idx_offline_css_preload; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_offline_css_preload ON keycloak.offline_client_session USING btree (client_id, offline_flag);


--
-- TOC entry 3486 (class 1259 OID 19764)
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_offline_uss_by_user ON keycloak.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- TOC entry 3487 (class 1259 OID 19765)
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_offline_uss_by_usersess ON keycloak.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- TOC entry 3488 (class 1259 OID 19717)
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_offline_uss_createdon ON keycloak.offline_user_session USING btree (created_on);


--
-- TOC entry 3489 (class 1259 OID 19753)
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_offline_uss_preload ON keycloak.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- TOC entry 3418 (class 1259 OID 19453)
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_protocol_mapper_client ON keycloak.protocol_mapper USING btree (client_id);


--
-- TOC entry 3365 (class 1259 OID 19456)
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_realm_attr_realm ON keycloak.realm_attribute USING btree (realm_id);


--
-- TOC entry 3512 (class 1259 OID 19636)
-- Name: idx_realm_clscope; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_realm_clscope ON keycloak.client_scope USING btree (realm_id);


--
-- TOC entry 3511 (class 1259 OID 19457)
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_realm_def_grp_realm ON keycloak.realm_default_groups USING btree (realm_id);


--
-- TOC entry 3368 (class 1259 OID 19460)
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_realm_evt_list_realm ON keycloak.realm_events_listeners USING btree (realm_id);


--
-- TOC entry 3439 (class 1259 OID 19459)
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_realm_evt_types_realm ON keycloak.realm_enabled_event_types USING btree (realm_id);


--
-- TOC entry 3360 (class 1259 OID 19455)
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_realm_master_adm_cli ON keycloak.realm USING btree (master_admin_client);


--
-- TOC entry 3434 (class 1259 OID 19461)
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_realm_supp_local_realm ON keycloak.realm_supported_locales USING btree (realm_id);


--
-- TOC entry 3375 (class 1259 OID 19462)
-- Name: idx_redir_uri_client; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_redir_uri_client ON keycloak.redirect_uris USING btree (client_id);


--
-- TOC entry 3481 (class 1259 OID 19463)
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_req_act_prov_realm ON keycloak.required_action_provider USING btree (realm_id);


--
-- TOC entry 3548 (class 1259 OID 19464)
-- Name: idx_res_policy_policy; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_res_policy_policy ON keycloak.resource_policy USING btree (policy_id);


--
-- TOC entry 3545 (class 1259 OID 19465)
-- Name: idx_res_scope_scope; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_res_scope_scope ON keycloak.resource_scope USING btree (scope_id);


--
-- TOC entry 3538 (class 1259 OID 19484)
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_res_serv_pol_res_serv ON keycloak.resource_server_policy USING btree (resource_server_id);


--
-- TOC entry 3528 (class 1259 OID 19485)
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_res_srv_res_res_srv ON keycloak.resource_server_resource USING btree (resource_server_id);


--
-- TOC entry 3533 (class 1259 OID 19486)
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_res_srv_scope_res_srv ON keycloak.resource_server_scope USING btree (resource_server_id);


--
-- TOC entry 3618 (class 1259 OID 19712)
-- Name: idx_role_attribute; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_role_attribute ON keycloak.role_attribute USING btree (role_id);


--
-- TOC entry 3521 (class 1259 OID 19639)
-- Name: idx_role_clscope; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_role_clscope ON keycloak.client_scope_role_mapping USING btree (role_id);


--
-- TOC entry 3378 (class 1259 OID 19469)
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_scope_mapping_role ON keycloak.scope_mapping USING btree (role_id);


--
-- TOC entry 3551 (class 1259 OID 19470)
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_scope_policy_policy ON keycloak.scope_policy USING btree (policy_id);


--
-- TOC entry 3442 (class 1259 OID 19722)
-- Name: idx_update_time; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_update_time ON keycloak.migration_model USING btree (update_time);


--
-- TOC entry 3493 (class 1259 OID 19150)
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON keycloak.offline_client_session USING btree (user_session_id);


--
-- TOC entry 3605 (class 1259 OID 19645)
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_usconsent_clscope ON keycloak.user_consent_client_scope USING btree (user_consent_id);


--
-- TOC entry 3383 (class 1259 OID 19157)
-- Name: idx_user_attribute; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_user_attribute ON keycloak.user_attribute USING btree (user_id);


--
-- TOC entry 3384 (class 1259 OID 19767)
-- Name: idx_user_attribute_name; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_user_attribute_name ON keycloak.user_attribute USING btree (name, value);


--
-- TOC entry 3450 (class 1259 OID 19154)
-- Name: idx_user_consent; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_user_consent ON keycloak.user_consent USING btree (user_id);


--
-- TOC entry 3348 (class 1259 OID 19158)
-- Name: idx_user_credential; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_user_credential ON keycloak.credential USING btree (user_id);


--
-- TOC entry 3387 (class 1259 OID 19151)
-- Name: idx_user_email; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_user_email ON keycloak.user_entity USING btree (email);


--
-- TOC entry 3506 (class 1259 OID 19153)
-- Name: idx_user_group_mapping; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_user_group_mapping ON keycloak.user_group_membership USING btree (user_id);


--
-- TOC entry 3399 (class 1259 OID 19159)
-- Name: idx_user_reqactions; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_user_reqactions ON keycloak.user_required_action USING btree (user_id);


--
-- TOC entry 3402 (class 1259 OID 19152)
-- Name: idx_user_role_mapping; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_user_role_mapping ON keycloak.user_role_mapping USING btree (user_id);


--
-- TOC entry 3471 (class 1259 OID 19472)
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_usr_fed_map_fed_prv ON keycloak.user_federation_mapper USING btree (federation_provider_id);


--
-- TOC entry 3472 (class 1259 OID 19473)
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_usr_fed_map_realm ON keycloak.user_federation_mapper USING btree (realm_id);


--
-- TOC entry 3396 (class 1259 OID 19474)
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_usr_fed_prv_realm ON keycloak.user_federation_provider USING btree (realm_id);


--
-- TOC entry 3407 (class 1259 OID 19475)
-- Name: idx_web_orig_client; Type: INDEX; Schema: keycloak; Owner: dbuser
--

CREATE INDEX idx_web_orig_client ON keycloak.web_origins USING btree (client_id);


--
-- TOC entry 3662 (class 2606 OID 18876)
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES keycloak.client_session(id);


--
-- TOC entry 3646 (class 2606 OID 18637)
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3639 (class 2606 OID 18561)
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 3645 (class 2606 OID 18647)
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 3641 (class 2606 OID 18796)
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 3640 (class 2606 OID 18566)
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES keycloak.client_session(id);


--
-- TOC entry 3649 (class 2606 OID 18677)
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES keycloak.user_session(id);


--
-- TOC entry 3622 (class 2606 OID 18379)
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES keycloak.client_session(id);


--
-- TOC entry 3631 (class 2606 OID 18384)
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 3635 (class 2606 OID 18389)
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3654 (class 2606 OID 18774)
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES keycloak.client_session(id);


--
-- TOC entry 3629 (class 2606 OID 18399)
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3692 (class 2606 OID 19679)
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES keycloak.resource_server_resource(id);


--
-- TOC entry 3633 (class 2606 OID 18404)
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 3636 (class 2606 OID 18414)
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 3626 (class 2606 OID 18419)
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES keycloak.realm(id);


--
-- TOC entry 3630 (class 2606 OID 18424)
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3627 (class 2606 OID 18439)
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3623 (class 2606 OID 18444)
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES keycloak.keycloak_role(id);


--
-- TOC entry 3658 (class 2606 OID 18896)
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES keycloak.authentication_flow(id);


--
-- TOC entry 3657 (class 2606 OID 18891)
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3656 (class 2606 OID 18886)
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3655 (class 2606 OID 18881)
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3621 (class 2606 OID 18449)
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES keycloak.user_session(id);


--
-- TOC entry 3637 (class 2606 OID 18454)
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 3669 (class 2606 OID 19584)
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES keycloak.client_scope(id);


--
-- TOC entry 3670 (class 2606 OID 19574)
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES keycloak.client_scope(id);


--
-- TOC entry 3663 (class 2606 OID 18968)
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES keycloak.client_session(id);


--
-- TOC entry 3643 (class 2606 OID 19569)
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES keycloak.client_scope(id);


--
-- TOC entry 3685 (class 2606 OID 19427)
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3683 (class 2606 OID 19371)
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES keycloak.component(id);


--
-- TOC entry 3684 (class 2606 OID 19366)
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3668 (class 2606 OID 19058)
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3661 (class 2606 OID 18911)
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES keycloak.user_federation_mapper(id);


--
-- TOC entry 3660 (class 2606 OID 18906)
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES keycloak.user_federation_provider(id);


--
-- TOC entry 3659 (class 2606 OID 18901)
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3682 (class 2606 OID 19283)
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- TOC entry 3680 (class 2606 OID 19268)
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- TOC entry 3688 (class 2606 OID 19651)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES keycloak.resource_server(id);


--
-- TOC entry 3671 (class 2606 OID 19494)
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES keycloak.resource_server(id);


--
-- TOC entry 3689 (class 2606 OID 19656)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES keycloak.resource_server_resource(id);


--
-- TOC entry 3690 (class 2606 OID 19661)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES keycloak.resource_server_scope(id);


--
-- TOC entry 3681 (class 2606 OID 19278)
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- TOC entry 3679 (class 2606 OID 19263)
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES keycloak.resource_server_scope(id);


--
-- TOC entry 3691 (class 2606 OID 19684)
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- TOC entry 3673 (class 2606 OID 19489)
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES keycloak.resource_server(id);


--
-- TOC entry 3675 (class 2606 OID 19233)
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES keycloak.resource_server_resource(id);


--
-- TOC entry 3677 (class 2606 OID 19248)
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES keycloak.resource_server_resource(id);


--
-- TOC entry 3678 (class 2606 OID 19253)
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- TOC entry 3676 (class 2606 OID 19238)
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES keycloak.resource_server_scope(id);


--
-- TOC entry 3672 (class 2606 OID 19499)
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES keycloak.resource_server(id);


--
-- TOC entry 3624 (class 2606 OID 18469)
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES keycloak.keycloak_role(id);


--
-- TOC entry 3687 (class 2606 OID 19626)
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES keycloak.user_consent(id);


--
-- TOC entry 3653 (class 2606 OID 18759)
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 3666 (class 2606 OID 19032)
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES keycloak.keycloak_group(id);


--
-- TOC entry 3665 (class 2606 OID 19046)
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES keycloak.keycloak_group(id);


--
-- TOC entry 3650 (class 2606 OID 18703)
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3628 (class 2606 OID 18479)
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3651 (class 2606 OID 18749)
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3652 (class 2606 OID 18925)
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES keycloak.identity_provider_mapper(id);


--
-- TOC entry 3638 (class 2606 OID 18489)
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 3632 (class 2606 OID 18499)
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 3642 (class 2606 OID 18642)
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES keycloak.client(id);


--
-- TOC entry 3625 (class 2606 OID 18514)
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 3644 (class 2606 OID 18918)
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES keycloak.protocol_mapper(id);


--
-- TOC entry 3686 (class 2606 OID 19611)
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3664 (class 2606 OID 18963)
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3693 (class 2606 OID 19692)
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES keycloak.resource_server_resource(id);


--
-- TOC entry 3694 (class 2606 OID 19707)
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES keycloak.keycloak_role(id);


--
-- TOC entry 3648 (class 2606 OID 18672)
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES keycloak.realm(id);


--
-- TOC entry 3634 (class 2606 OID 18534)
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES keycloak.user_federation_provider(id);


--
-- TOC entry 3667 (class 2606 OID 19039)
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES keycloak.user_entity(id);


--
-- TOC entry 3674 (class 2606 OID 19223)
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES keycloak.resource_server_policy(id);


--
-- TOC entry 3647 (class 2606 OID 18652)
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: keycloak; Owner: dbuser
--

ALTER TABLE ONLY keycloak.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES keycloak.identity_provider(internal_id);


-- Completed on 2022-02-01 24:27:18 UTC

--
-- PostgreSQL database dump complete
--

