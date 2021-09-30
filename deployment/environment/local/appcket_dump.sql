--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1 (Debian 13.1-1.pgdg100+1)
-- Dumped by pg_dump version 13.1 (Debian 13.1-1.pgdg100+1)

-- Started on 021-09-30 02:20:29 UTC

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
-- TOC entry 9 (class 2615 OID 16385)
-- Name: appcket; Type: SCHEMA; Schema: -; Owner: appcketuser
--

CREATE SCHEMA appcket;


ALTER SCHEMA appcket OWNER TO appcketuser;

SET default_tablespace = '';

SET default_table_access_method = heap;

SET search_path TO appcket;
DROP EXTENSION IF EXISTS "uuid-ossp";

CREATE EXTENSION "uuid-ossp" SCHEMA appcket;

--
-- TOC entry 295 (class 1259 OID 18041)
-- Name: organization; Type: TABLE; Schema: appcket; Owner: appcketuser
--

CREATE TABLE appcket.organization (
    organization_id uuid DEFAULT appcket.uuid_generate_v4() NOT NULL,
    name character varying(30) NOT NULL,
    created_at timestamp(0) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(0) with time zone,
    effective_at timestamp(0) with time zone DEFAULT now() NOT NULL,
    created_by uuid,
    updated_by uuid,
    deleted_by uuid
);


ALTER TABLE appcket.organization OWNER TO appcketuser;

--
-- TOC entry 296 (class 1259 OID 18047)
-- Name: organization_user; Type: TABLE; Schema: appcket; Owner: appcketuser
--

CREATE TABLE appcket.organization_user (
    organization_user_id uuid DEFAULT appcket.uuid_generate_v4() NOT NULL,
    organization_id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp(0) with time zone DEFAULT now() NOT NULL,
    effective_at timestamp(0) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(0) with time zone,
    created_by uuid,
    updated_by uuid,
    deleted_by uuid
);


ALTER TABLE appcket.organization_user OWNER TO appcketuser;

--
-- TOC entry 297 (class 1259 OID 18053)
-- Name: task; Type: TABLE; Schema: appcket; Owner: appcketuser
--

CREATE TABLE appcket.task (
    task_id uuid DEFAULT appcket.uuid_generate_v4() NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    assigned_to uuid,
    created_at timestamp(0) with time zone DEFAULT now() NOT NULL,
    effective_at timestamp(0) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(0) with time zone,
    created_by uuid,
    updated_by uuid,
    deleted_by uuid,
    task_status_type_id uuid
);


ALTER TABLE appcket.task OWNER TO appcketuser;

--
-- TOC entry 298 (class 1259 OID 18062)
-- Name: task_status_type; Type: TABLE; Schema: appcket; Owner: appcketuser
--

CREATE TABLE appcket.task_status_type (
    task_status_type_id uuid DEFAULT appcket.uuid_generate_v4() NOT NULL,
    name character varying(30),
    created_at timestamp(0) with time zone DEFAULT now() NOT NULL,
    effective_at timestamp(0) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(0) with time zone,
    created_by uuid,
    updated_by uuid,
    deleted_by uuid
);


ALTER TABLE appcket.task_status_type OWNER TO appcketuser;

--
-- TOC entry 299 (class 1259 OID 18068)
-- Name: team; Type: TABLE; Schema: appcket; Owner: appcketuser
--

CREATE TABLE appcket.team (
    team_id uuid DEFAULT appcket.uuid_generate_v4() NOT NULL,
    name character varying(50) NOT NULL,
    organization_id uuid NOT NULL,
    created_at timestamp(0) with time zone DEFAULT now() NOT NULL,
    effective_at timestamp(0) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(0) with time zone,
    created_by uuid,
    updated_by uuid,
    deleted_by uuid
);


ALTER TABLE appcket.team OWNER TO appcketuser;

--
-- TOC entry 300 (class 1259 OID 18074)
-- Name: team_user; Type: TABLE; Schema: appcket; Owner: appcketuser
--

CREATE TABLE appcket.team_user (
    team_user_id uuid DEFAULT appcket.uuid_generate_v4() NOT NULL,
    team_id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp(0) with time zone DEFAULT now() NOT NULL,
    effective_at timestamp(0) with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp(0) with time zone,
    created_by uuid,
    updated_by uuid,
    deleted_by uuid
);


ALTER TABLE appcket.team_user OWNER TO appcketuser;

--
-- TOC entry 3337 (class 0 OID 18041)
-- Dependencies: 295
-- Data for Name: organization; Type: TABLE DATA; Schema: appcket; Owner: appcketuser
--

INSERT INTO appcket.organization VALUES ('4cb17fd4-9292-4e20-bfa7-809d1a62fcc8', 'Vandelay Industries', '2020-10-23 03:47:13+00', NULL, '2020-10-23 04:04:57+00', '95a696bf-5aff-4e26-bcc8-d3b5f4dd3789', NULL, NULL);


--
-- TOC entry 3338 (class 0 OID 18047)
-- Dependencies: 296
-- Data for Name: organization_user; Type: TABLE DATA; Schema: appcket; Owner: appcketuser
--

INSERT INTO appcket.organization_user VALUES ('c9361c5f-078b-4d17-9e04-bc3bec74af6a', '4cb17fd4-9292-4e20-bfa7-809d1a62fcc8', '7fb9b0c7-9c62-4c6a-8c2a-c5b1b035ed62', '2020-10-27 02:49:41+00', '2020-10-27 02:49:41+00', NULL, NULL, NULL, NULL);
INSERT INTO appcket.organization_user VALUES ('c1825b7b-5e0d-49f9-a67a-b3284395890a', '4cb17fd4-9292-4e20-bfa7-809d1a62fcc8', '1eb405c4-2b6a-4c56-9b9f-62fdd21466e6', '2020-10-27 02:51:06+00', '2020-10-27 02:51:06+00', NULL, NULL, NULL, NULL);
INSERT INTO appcket.organization_user VALUES ('a1b7271f-692b-4719-aa65-00f73229047e', '4cb17fd4-9292-4e20-bfa7-809d1a62fcc8', '8ad3e618-7fa1-4f43-9e23-d45e76fb88e7', '2020-10-27 02:51:06+00', '2020-10-27 02:51:06+00', NULL, NULL, NULL, NULL);
INSERT INTO appcket.organization_user VALUES ('c5b363e5-4ee8-4e1c-9db2-bf3026e5c356', '4cb17fd4-9292-4e20-bfa7-809d1a62fcc8', 'e7ca2c89-76e9-4903-bdd3-187553a64ddc', '2020-10-27 02:51:06+00', '2020-10-27 02:51:06+00', NULL, NULL, NULL, NULL);
INSERT INTO appcket.organization_user VALUES ('805b1648-2cbd-4a44-9516-da1f9486cd30', '4cb17fd4-9292-4e20-bfa7-809d1a62fcc8', '7f784575-5512-444d-a21b-8b1335ac5474', '2020-11-14 23:20:59+00', '2020-11-14 23:21:01+00', NULL, NULL, NULL, NULL);


--
-- TOC entry 3339 (class 0 OID 18053)
-- Dependencies: 297
-- Data for Name: task; Type: TABLE DATA; Schema: appcket; Owner: appcketuser
--

INSERT INTO appcket.task VALUES ('c1cd0232-4955-4e45-b7e8-d5c83709d295', 'Hire new salesman to help sell Latex 2.0 line', 'Optional description text notes', '7fb9b0c7-9c62-4c6a-8c2a-c5b1b035ed62', '2020-10-27 03:45:24+00', '2020-10-27 03:45:24+00', NULL, NULL, NULL, NULL, '272892f2-f03b-4c33-94e0-a5ed27f9e2df');
INSERT INTO appcket.task VALUES ('4fea3c92-d3f0-4b95-b4cf-c1091f529d92', 'Reply to George Costanza and inform him we have decided to go in a different direction', 'George''s email is jerkstore@gmail.com', 'e7ca2c89-76e9-4903-bdd3-187553a64ddc', '2020-10-27 03:45:32+00', '2020-10-27 03:45:32+00', NULL, NULL, NULL, NULL, '34987d28-089e-4f21-bc93-2fd1827107d4');
INSERT INTO appcket.task VALUES ('e74c1a6b-688a-4a08-8885-9c7c9630e155', 'Research new materials for super secret Latex 3.0 line', 'TOP SECRET, require NDAs from everybody you speak with', '1eb405c4-2b6a-4c56-9b9f-62fdd21466e6', '2020-10-27 03:45:32+00', '2020-10-27 03:45:32+00', NULL, NULL, NULL, NULL, '272892f2-f03b-4c33-94e0-a5ed27f9e2df');


--
-- TOC entry 3340 (class 0 OID 18062)
-- Dependencies: 298
-- Data for Name: task_status_type; Type: TABLE DATA; Schema: appcket; Owner: appcketuser
--

INSERT INTO appcket.task_status_type VALUES ('272892f2-f03b-4c33-94e0-a5ed27f9e2df', 'Incomplete', '2020-10-27 03:37:07+00', '2020-10-27 03:37:07+00', NULL, NULL, NULL, NULL);
INSERT INTO appcket.task_status_type VALUES ('34987d28-089e-4f21-bc93-2fd1827107d4', 'Doing', '2020-10-27 03:37:07+00', '2020-10-27 03:37:07+00', NULL, NULL, NULL, NULL);
INSERT INTO appcket.task_status_type VALUES ('9ab3c72c-ada3-4809-9f3c-322f7d05cab9', 'Done', '2020-10-27 03:37:07+00', '2020-10-27 03:37:07+00', NULL, NULL, NULL, NULL);


--
-- TOC entry 3341 (class 0 OID 18068)
-- Dependencies: 299
-- Data for Name: team; Type: TABLE DATA; Schema: appcket; Owner: appcketuser
--

INSERT INTO appcket.team VALUES ('9f107212-ecb8-4a3c-931e-10edaf9af582', 'Sales', '4cb17fd4-9292-4e20-bfa7-809d1a62fcc8', '2020-10-27 02:58:10+00', '2020-10-27 02:58:10+00', NULL, NULL, NULL, NULL);
INSERT INTO appcket.team VALUES ('da31bf7f-b32c-4ef3-83fb-e16ce7781753', 'Manufacturing', '4cb17fd4-9292-4e20-bfa7-809d1a62fcc8', '2020-10-27 02:58:10+00', '2020-10-27 02:58:10+00', NULL, NULL, NULL, NULL);


--
-- TOC entry 3342 (class 0 OID 18074)
-- Dependencies: 300
-- Data for Name: team_user; Type: TABLE DATA; Schema: appcket; Owner: appcketuser
--

INSERT INTO appcket.team_user VALUES ('53d1e59f-716f-4f9c-9289-63e72721e301', '9f107212-ecb8-4a3c-931e-10edaf9af582', '7fb9b0c7-9c62-4c6a-8c2a-c5b1b035ed62', '2020-10-27 03:05:33+00', '2020-10-27 03:05:33+00', NULL, NULL, NULL, NULL);
INSERT INTO appcket.team_user VALUES ('1cabb60c-a5ee-4c7f-9de5-1d42f486b981', '9f107212-ecb8-4a3c-931e-10edaf9af582', 'e7ca2c89-76e9-4903-bdd3-187553a64ddc', '2020-10-27 03:05:39+00', '2020-10-27 03:05:39+00', NULL, NULL, NULL, NULL);
INSERT INTO appcket.team_user VALUES ('926fb4dd-0d16-4893-b3d1-eb23fd09d3b2', 'da31bf7f-b32c-4ef3-83fb-e16ce7781753', '1eb405c4-2b6a-4c56-9b9f-62fdd21466e6', '2020-10-27 03:07:09+00', '2020-10-27 03:07:09+00', NULL, NULL, NULL, NULL);
INSERT INTO appcket.team_user VALUES ('1d0817fd-13db-4d98-8927-2b2223b5bfe5', 'da31bf7f-b32c-4ef3-83fb-e16ce7781753', '8ad3e618-7fa1-4f43-9e23-d45e76fb88e7', '2020-10-27 03:07:09+00', '2020-10-27 03:07:09+00', NULL, NULL, NULL, NULL);


--
-- TOC entry 3191 (class 2606 OID 18081)
-- Name: organization organization_pk; Type: CONSTRAINT; Schema: appcket; Owner: appcketuser
--

ALTER TABLE ONLY appcket.organization
    ADD CONSTRAINT organization_pk PRIMARY KEY (organization_id);


--
-- TOC entry 3194 (class 2606 OID 18083)
-- Name: organization_user organization_user_pk; Type: CONSTRAINT; Schema: appcket; Owner: appcketuser
--

ALTER TABLE ONLY appcket.organization_user
    ADD CONSTRAINT organization_user_pk PRIMARY KEY (organization_user_id);


--
-- TOC entry 3196 (class 2606 OID 18085)
-- Name: task task_pk; Type: CONSTRAINT; Schema: appcket; Owner: appcketuser
--

ALTER TABLE ONLY appcket.task
    ADD CONSTRAINT task_pk PRIMARY KEY (task_id);


--
-- TOC entry 3198 (class 2606 OID 18087)
-- Name: task_status_type task_status_type_pk; Type: CONSTRAINT; Schema: appcket; Owner: appcketuser
--

ALTER TABLE ONLY appcket.task_status_type
    ADD CONSTRAINT task_status_type_pk PRIMARY KEY (task_status_type_id);


--
-- TOC entry 3200 (class 2606 OID 18089)
-- Name: team team_pk; Type: CONSTRAINT; Schema: appcket; Owner: appcketuser
--

ALTER TABLE ONLY appcket.team
    ADD CONSTRAINT team_pk PRIMARY KEY (team_id);


--
-- TOC entry 3202 (class 2606 OID 18091)
-- Name: team_user team_user_pk; Type: CONSTRAINT; Schema: appcket; Owner: appcketuser
--

ALTER TABLE ONLY appcket.team_user
    ADD CONSTRAINT team_user_pk PRIMARY KEY (team_user_id);


--
-- TOC entry 3192 (class 1259 OID 18092)
-- Name: organization_user_id_idx; Type: INDEX; Schema: appcket; Owner: appcketuser
--

CREATE INDEX organization_user_id_idx ON appcket.organization_user USING btree (organization_user_id);


--
-- TOC entry 3203 (class 2606 OID 18093)
-- Name: organization_user organization_user_fk; Type: FK CONSTRAINT; Schema: appcket; Owner: appcketuser
--

ALTER TABLE ONLY appcket.organization_user
    ADD CONSTRAINT organization_user_fk FOREIGN KEY (organization_id) REFERENCES appcket.organization(organization_id);


--
-- TOC entry 3204 (class 2606 OID 18098)
-- Name: task task_fk; Type: FK CONSTRAINT; Schema: appcket; Owner: appcketuser
--

ALTER TABLE ONLY appcket.task
    ADD CONSTRAINT task_fk FOREIGN KEY (task_status_type_id) REFERENCES appcket.task_status_type(task_status_type_id);


--
-- TOC entry 3205 (class 2606 OID 18103)
-- Name: team team_fk; Type: FK CONSTRAINT; Schema: appcket; Owner: appcketuser
--

ALTER TABLE ONLY appcket.team
    ADD CONSTRAINT team_fk FOREIGN KEY (organization_id) REFERENCES appcket.organization(organization_id);


--
-- TOC entry 3206 (class 2606 OID 18108)
-- Name: team_user team_user_fk; Type: FK CONSTRAINT; Schema: appcket; Owner: appcketuser
--

ALTER TABLE ONLY appcket.team_user
    ADD CONSTRAINT team_user_fk FOREIGN KEY (team_id) REFERENCES appcket.team(team_id);


-- Completed on 021-09-30 02:20:29 UTC

--
-- PostgreSQL database dump complete
--

