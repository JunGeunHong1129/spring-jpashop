--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1 (Debian 14.1-1.pgdg110+1)
-- Dumped by pg_dump version 14.1

-- Started on 2021-12-28 14:39:53 KST

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
-- TOC entry 9 (class 2615 OID 16384)
-- Name: chat_log_dev; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA chat_log_dev;


ALTER SCHEMA chat_log_dev OWNER TO postgres;

--
-- TOC entry 10 (class 2615 OID 16385)
-- Name: chat_log_prod; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA chat_log_prod;


ALTER SCHEMA chat_log_prod OWNER TO postgres;

--
-- TOC entry 4 (class 2615 OID 16386)
-- Name: chat_server_dev; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA chat_server_dev;


ALTER SCHEMA chat_server_dev OWNER TO postgres;

--
-- TOC entry 6 (class 2615 OID 16387)
-- Name: chat_server_prod; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA chat_server_prod;


ALTER SCHEMA chat_server_prod OWNER TO postgres;

--
-- TOC entry 5 (class 2615 OID 16388)
-- Name: spring_taco_dev; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA spring_taco_dev;


ALTER SCHEMA spring_taco_dev OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 214 (class 1259 OID 16389)
-- Name: chat_log; Type: TABLE; Schema: chat_log_dev; Owner: postgres
--

CREATE TABLE chat_log_dev.chat_log (
    chat_id character varying NOT NULL,
    user_id bigint NOT NULL,
    chat_content character varying,
    createat timestamp without time zone NOT NULL,
    room_id bigint NOT NULL
);


ALTER TABLE chat_log_dev.chat_log OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16394)
-- Name: chat_log_chat_id_seq; Type: SEQUENCE; Schema: chat_log_dev; Owner: postgres
--

CREATE SEQUENCE chat_log_dev.chat_log_chat_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chat_log_dev.chat_log_chat_id_seq OWNER TO postgres;

--
-- TOC entry 3473 (class 0 OID 0)
-- Dependencies: 215
-- Name: chat_log_chat_id_seq; Type: SEQUENCE OWNED BY; Schema: chat_log_dev; Owner: postgres
--

ALTER SEQUENCE chat_log_dev.chat_log_chat_id_seq OWNED BY chat_log_dev.chat_log.chat_id;


--
-- TOC entry 216 (class 1259 OID 16395)
-- Name: chat_log_room_id_seq; Type: SEQUENCE; Schema: chat_log_dev; Owner: postgres
--

CREATE SEQUENCE chat_log_dev.chat_log_room_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chat_log_dev.chat_log_room_id_seq OWNER TO postgres;

--
-- TOC entry 3474 (class 0 OID 0)
-- Dependencies: 216
-- Name: chat_log_room_id_seq; Type: SEQUENCE OWNED BY; Schema: chat_log_dev; Owner: postgres
--

ALTER SEQUENCE chat_log_dev.chat_log_room_id_seq OWNED BY chat_log_dev.chat_log.room_id;


--
-- TOC entry 217 (class 1259 OID 16396)
-- Name: chat_log_user_id_seq; Type: SEQUENCE; Schema: chat_log_dev; Owner: postgres
--

CREATE SEQUENCE chat_log_dev.chat_log_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chat_log_dev.chat_log_user_id_seq OWNER TO postgres;

--
-- TOC entry 3475 (class 0 OID 0)
-- Dependencies: 217
-- Name: chat_log_user_id_seq; Type: SEQUENCE OWNED BY; Schema: chat_log_dev; Owner: postgres
--

ALTER SEQUENCE chat_log_dev.chat_log_user_id_seq OWNED BY chat_log_dev.chat_log.user_id;


--
-- TOC entry 218 (class 1259 OID 16397)
-- Name: chat_state; Type: TABLE; Schema: chat_log_dev; Owner: postgres
--

CREATE TABLE chat_log_dev.chat_state (
    chat_state_id bigint NOT NULL,
    chat_id character varying NOT NULL,
    chat_state integer NOT NULL,
    createat timestamp without time zone NOT NULL
);


ALTER TABLE chat_log_dev.chat_state OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16402)
-- Name: chat_log_view; Type: VIEW; Schema: chat_log_dev; Owner: postgres
--

CREATE VIEW chat_log_dev.chat_log_view AS
 SELECT cl.chat_id,
    cl.user_id,
    cl.chat_content,
    cl.room_id,
    cs.chat_state,
    cl.createat
   FROM chat_log_dev.chat_log cl,
    ( SELECT chat_state.chat_state_id,
            chat_state.chat_id,
            chat_state.chat_state,
            chat_state.createat
           FROM chat_log_dev.chat_state
          WHERE (chat_state.chat_state_id IN ( SELECT max(chat_state_1.chat_state_id) AS max
                   FROM chat_log_dev.chat_state chat_state_1
                  GROUP BY chat_state_1.chat_id))) cs
  WHERE ((cl.chat_id)::text = (cs.chat_id)::text);


ALTER TABLE chat_log_dev.chat_log_view OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16407)
-- Name: chat_state_chat_id_seq; Type: SEQUENCE; Schema: chat_log_dev; Owner: postgres
--

CREATE SEQUENCE chat_log_dev.chat_state_chat_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chat_log_dev.chat_state_chat_id_seq OWNER TO postgres;

--
-- TOC entry 3476 (class 0 OID 0)
-- Dependencies: 220
-- Name: chat_state_chat_id_seq; Type: SEQUENCE OWNED BY; Schema: chat_log_dev; Owner: postgres
--

ALTER SEQUENCE chat_log_dev.chat_state_chat_id_seq OWNED BY chat_log_dev.chat_state.chat_id;


--
-- TOC entry 221 (class 1259 OID 16408)
-- Name: chat_state_chat_state_id_seq; Type: SEQUENCE; Schema: chat_log_dev; Owner: postgres
--

CREATE SEQUENCE chat_log_dev.chat_state_chat_state_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chat_log_dev.chat_state_chat_state_id_seq OWNER TO postgres;

--
-- TOC entry 3477 (class 0 OID 0)
-- Dependencies: 221
-- Name: chat_state_chat_state_id_seq; Type: SEQUENCE OWNED BY; Schema: chat_log_dev; Owner: postgres
--

ALTER SEQUENCE chat_log_dev.chat_state_chat_state_id_seq OWNED BY chat_log_dev.chat_state.chat_state_id;


--
-- TOC entry 222 (class 1259 OID 16409)
-- Name: member; Type: TABLE; Schema: chat_server_dev; Owner: postgres
--

CREATE TABLE chat_server_dev.member (
    user_id bigint NOT NULL,
    room_id bigint NOT NULL,
    createat timestamp without time zone NOT NULL,
    member_id bigint NOT NULL
);


ALTER TABLE chat_server_dev.member OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16412)
-- Name: member_member_id_seq; Type: SEQUENCE; Schema: chat_server_dev; Owner: postgres
--

CREATE SEQUENCE chat_server_dev.member_member_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chat_server_dev.member_member_id_seq OWNER TO postgres;

--
-- TOC entry 3478 (class 0 OID 0)
-- Dependencies: 223
-- Name: member_member_id_seq; Type: SEQUENCE OWNED BY; Schema: chat_server_dev; Owner: postgres
--

ALTER SEQUENCE chat_server_dev.member_member_id_seq OWNED BY chat_server_dev.member.member_id;


--
-- TOC entry 224 (class 1259 OID 16413)
-- Name: member_room_id_seq; Type: SEQUENCE; Schema: chat_server_dev; Owner: postgres
--

CREATE SEQUENCE chat_server_dev.member_room_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chat_server_dev.member_room_id_seq OWNER TO postgres;

--
-- TOC entry 3479 (class 0 OID 0)
-- Dependencies: 224
-- Name: member_room_id_seq; Type: SEQUENCE OWNED BY; Schema: chat_server_dev; Owner: postgres
--

ALTER SEQUENCE chat_server_dev.member_room_id_seq OWNED BY chat_server_dev.member.room_id;


--
-- TOC entry 225 (class 1259 OID 16414)
-- Name: member_state; Type: TABLE; Schema: chat_server_dev; Owner: postgres
--

CREATE TABLE chat_server_dev.member_state (
    member_state_id bigint NOT NULL,
    member_id bigint NOT NULL,
    member_state bigint DEFAULT 0 NOT NULL,
    create_at timestamp without time zone NOT NULL,
    member_last_read_msg_index bigint DEFAULT 0 NOT NULL
);


ALTER TABLE chat_server_dev.member_state OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16419)
-- Name: member_state_member_id_seq; Type: SEQUENCE; Schema: chat_server_dev; Owner: postgres
--

CREATE SEQUENCE chat_server_dev.member_state_member_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chat_server_dev.member_state_member_id_seq OWNER TO postgres;

--
-- TOC entry 3480 (class 0 OID 0)
-- Dependencies: 226
-- Name: member_state_member_id_seq; Type: SEQUENCE OWNED BY; Schema: chat_server_dev; Owner: postgres
--

ALTER SEQUENCE chat_server_dev.member_state_member_id_seq OWNED BY chat_server_dev.member_state.member_id;


--
-- TOC entry 227 (class 1259 OID 16420)
-- Name: member_state_member_state_id_seq; Type: SEQUENCE; Schema: chat_server_dev; Owner: postgres
--

CREATE SEQUENCE chat_server_dev.member_state_member_state_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chat_server_dev.member_state_member_state_id_seq OWNER TO postgres;

--
-- TOC entry 3481 (class 0 OID 0)
-- Dependencies: 227
-- Name: member_state_member_state_id_seq; Type: SEQUENCE OWNED BY; Schema: chat_server_dev; Owner: postgres
--

ALTER SEQUENCE chat_server_dev.member_state_member_state_id_seq OWNED BY chat_server_dev.member_state.member_state_id;


--
-- TOC entry 228 (class 1259 OID 16421)
-- Name: member_user_id_seq; Type: SEQUENCE; Schema: chat_server_dev; Owner: postgres
--

CREATE SEQUENCE chat_server_dev.member_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chat_server_dev.member_user_id_seq OWNER TO postgres;

--
-- TOC entry 3482 (class 0 OID 0)
-- Dependencies: 228
-- Name: member_user_id_seq; Type: SEQUENCE OWNED BY; Schema: chat_server_dev; Owner: postgres
--

ALTER SEQUENCE chat_server_dev.member_user_id_seq OWNED BY chat_server_dev.member.user_id;


--
-- TOC entry 229 (class 1259 OID 16422)
-- Name: room; Type: TABLE; Schema: chat_server_dev; Owner: postgres
--

CREATE TABLE chat_server_dev.room (
    room_id bigint NOT NULL,
    room_name character varying NOT NULL,
    createat timestamp without time zone NOT NULL
);


ALTER TABLE chat_server_dev.room OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16427)
-- Name: room_room_id_seq; Type: SEQUENCE; Schema: chat_server_dev; Owner: postgres
--

CREATE SEQUENCE chat_server_dev.room_room_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chat_server_dev.room_room_id_seq OWNER TO postgres;

--
-- TOC entry 3483 (class 0 OID 0)
-- Dependencies: 230
-- Name: room_room_id_seq; Type: SEQUENCE OWNED BY; Schema: chat_server_dev; Owner: postgres
--

ALTER SEQUENCE chat_server_dev.room_room_id_seq OWNED BY chat_server_dev.room.room_id;


--
-- TOC entry 231 (class 1259 OID 16428)
-- Name: room_state; Type: TABLE; Schema: chat_server_dev; Owner: postgres
--

CREATE TABLE chat_server_dev.room_state (
    room_state_id bigint NOT NULL,
    room_id bigint NOT NULL,
    room_state bigint DEFAULT 0 NOT NULL,
    create_at timestamp without time zone NOT NULL
);


ALTER TABLE chat_server_dev.room_state OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16432)
-- Name: room_state_room_id_seq; Type: SEQUENCE; Schema: chat_server_dev; Owner: postgres
--

CREATE SEQUENCE chat_server_dev.room_state_room_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chat_server_dev.room_state_room_id_seq OWNER TO postgres;

--
-- TOC entry 3484 (class 0 OID 0)
-- Dependencies: 232
-- Name: room_state_room_id_seq; Type: SEQUENCE OWNED BY; Schema: chat_server_dev; Owner: postgres
--

ALTER SEQUENCE chat_server_dev.room_state_room_id_seq OWNED BY chat_server_dev.room_state.room_id;


--
-- TOC entry 233 (class 1259 OID 16433)
-- Name: room_state_room_state_id_seq; Type: SEQUENCE; Schema: chat_server_dev; Owner: postgres
--

CREATE SEQUENCE chat_server_dev.room_state_room_state_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chat_server_dev.room_state_room_state_id_seq OWNER TO postgres;

--
-- TOC entry 3485 (class 0 OID 0)
-- Dependencies: 233
-- Name: room_state_room_state_id_seq; Type: SEQUENCE OWNED BY; Schema: chat_server_dev; Owner: postgres
--

ALTER SEQUENCE chat_server_dev.room_state_room_state_id_seq OWNED BY chat_server_dev.room_state.room_state_id;


--
-- TOC entry 234 (class 1259 OID 16434)
-- Name: user; Type: TABLE; Schema: chat_server_dev; Owner: postgres
--

CREATE TABLE chat_server_dev."user" (
    user_id bigint NOT NULL,
    user_uuid character varying NOT NULL,
    email_addr character varying NOT NULL,
    pwd character varying NOT NULL,
    nickname character varying NOT NULL,
    birthdate date,
    phone_number character varying,
    createat timestamp without time zone NOT NULL,
    fcm_token character varying DEFAULT 0 NOT NULL
);


ALTER TABLE chat_server_dev."user" OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16439)
-- Name: user_state; Type: TABLE; Schema: chat_server_dev; Owner: postgres
--

CREATE TABLE chat_server_dev.user_state (
    user_state_id bigint NOT NULL,
    user_id bigint NOT NULL,
    user_state bigint DEFAULT 0 NOT NULL,
    create_at timestamp without time zone NOT NULL,
    user_fcm_token character varying DEFAULT 0 NOT NULL
);


ALTER TABLE chat_server_dev.user_state OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16446)
-- Name: user_state_user_id_seq; Type: SEQUENCE; Schema: chat_server_dev; Owner: postgres
--

CREATE SEQUENCE chat_server_dev.user_state_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chat_server_dev.user_state_user_id_seq OWNER TO postgres;

--
-- TOC entry 3486 (class 0 OID 0)
-- Dependencies: 236
-- Name: user_state_user_id_seq; Type: SEQUENCE OWNED BY; Schema: chat_server_dev; Owner: postgres
--

ALTER SEQUENCE chat_server_dev.user_state_user_id_seq OWNED BY chat_server_dev.user_state.user_id;


--
-- TOC entry 237 (class 1259 OID 16447)
-- Name: user_state_user_state_id_seq; Type: SEQUENCE; Schema: chat_server_dev; Owner: postgres
--

CREATE SEQUENCE chat_server_dev.user_state_user_state_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chat_server_dev.user_state_user_state_id_seq OWNER TO postgres;

--
-- TOC entry 3487 (class 0 OID 0)
-- Dependencies: 237
-- Name: user_state_user_state_id_seq; Type: SEQUENCE OWNED BY; Schema: chat_server_dev; Owner: postgres
--

ALTER SEQUENCE chat_server_dev.user_state_user_state_id_seq OWNED BY chat_server_dev.user_state.user_state_id;


--
-- TOC entry 238 (class 1259 OID 16448)
-- Name: user_user_id_seq; Type: SEQUENCE; Schema: chat_server_dev; Owner: postgres
--

CREATE SEQUENCE chat_server_dev.user_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chat_server_dev.user_user_id_seq OWNER TO postgres;

--
-- TOC entry 3488 (class 0 OID 0)
-- Dependencies: 238
-- Name: user_user_id_seq; Type: SEQUENCE OWNED BY; Schema: chat_server_dev; Owner: postgres
--

ALTER SEQUENCE chat_server_dev.user_user_id_seq OWNED BY chat_server_dev."user".user_id;


--
-- TOC entry 239 (class 1259 OID 16449)
-- Name: ingredient; Type: TABLE; Schema: spring_taco_dev; Owner: postgres
--

CREATE TABLE spring_taco_dev.ingredient (
    id character varying NOT NULL,
    name character varying NOT NULL,
    type character varying
);


ALTER TABLE spring_taco_dev.ingredient OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 16454)
-- Name: taco; Type: TABLE; Schema: spring_taco_dev; Owner: postgres
--

CREATE TABLE spring_taco_dev.taco (
    id bigint NOT NULL,
    name character varying NOT NULL,
    createat timestamp without time zone NOT NULL
);


ALTER TABLE spring_taco_dev.taco OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16459)
-- Name: taco_id_seq; Type: SEQUENCE; Schema: spring_taco_dev; Owner: postgres
--

ALTER TABLE spring_taco_dev.taco ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME spring_taco_dev.taco_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 242 (class 1259 OID 16460)
-- Name: taco_ingredients; Type: TABLE; Schema: spring_taco_dev; Owner: postgres
--

CREATE TABLE spring_taco_dev.taco_ingredients (
    taco bigint NOT NULL,
    ingredient character varying NOT NULL
);


ALTER TABLE spring_taco_dev.taco_ingredients OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 16465)
-- Name: taco_order; Type: TABLE; Schema: spring_taco_dev; Owner: postgres
--

CREATE TABLE spring_taco_dev.taco_order (
    id bigint NOT NULL,
    deliveryname character varying NOT NULL,
    deliverystreet character varying NOT NULL,
    deliverycity character varying NOT NULL,
    deliverystate character varying NOT NULL,
    deliveryzip character varying NOT NULL,
    ccnumber character varying NOT NULL,
    ccexpiration character varying NOT NULL,
    ccccv character varying NOT NULL,
    placedat timestamp without time zone NOT NULL
);


ALTER TABLE spring_taco_dev.taco_order OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 16470)
-- Name: taco_order_id_seq; Type: SEQUENCE; Schema: spring_taco_dev; Owner: postgres
--

ALTER TABLE spring_taco_dev.taco_order ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME spring_taco_dev.taco_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 245 (class 1259 OID 16471)
-- Name: taco_order_tacos; Type: TABLE; Schema: spring_taco_dev; Owner: postgres
--

CREATE TABLE spring_taco_dev.taco_order_tacos (
    tacoorder bigint NOT NULL,
    taco bigint NOT NULL
);


ALTER TABLE spring_taco_dev.taco_order_tacos OWNER TO postgres;

--
-- TOC entry 3241 (class 2604 OID 16474)
-- Name: chat_log chat_id; Type: DEFAULT; Schema: chat_log_dev; Owner: postgres
--

ALTER TABLE ONLY chat_log_dev.chat_log ALTER COLUMN chat_id SET DEFAULT nextval('chat_log_dev.chat_log_chat_id_seq'::regclass);


--
-- TOC entry 3242 (class 2604 OID 16475)
-- Name: chat_log user_id; Type: DEFAULT; Schema: chat_log_dev; Owner: postgres
--

ALTER TABLE ONLY chat_log_dev.chat_log ALTER COLUMN user_id SET DEFAULT nextval('chat_log_dev.chat_log_user_id_seq'::regclass);


--
-- TOC entry 3243 (class 2604 OID 16476)
-- Name: chat_log room_id; Type: DEFAULT; Schema: chat_log_dev; Owner: postgres
--

ALTER TABLE ONLY chat_log_dev.chat_log ALTER COLUMN room_id SET DEFAULT nextval('chat_log_dev.chat_log_room_id_seq'::regclass);


--
-- TOC entry 3244 (class 2604 OID 16477)
-- Name: chat_state chat_state_id; Type: DEFAULT; Schema: chat_log_dev; Owner: postgres
--

ALTER TABLE ONLY chat_log_dev.chat_state ALTER COLUMN chat_state_id SET DEFAULT nextval('chat_log_dev.chat_state_chat_state_id_seq'::regclass);


--
-- TOC entry 3245 (class 2604 OID 16478)
-- Name: chat_state chat_id; Type: DEFAULT; Schema: chat_log_dev; Owner: postgres
--

ALTER TABLE ONLY chat_log_dev.chat_state ALTER COLUMN chat_id SET DEFAULT nextval('chat_log_dev.chat_state_chat_id_seq'::regclass);


--
-- TOC entry 3246 (class 2604 OID 16479)
-- Name: member user_id; Type: DEFAULT; Schema: chat_server_dev; Owner: postgres
--

ALTER TABLE ONLY chat_server_dev.member ALTER COLUMN user_id SET DEFAULT nextval('chat_server_dev.member_user_id_seq'::regclass);


--
-- TOC entry 3247 (class 2604 OID 16480)
-- Name: member room_id; Type: DEFAULT; Schema: chat_server_dev; Owner: postgres
--

ALTER TABLE ONLY chat_server_dev.member ALTER COLUMN room_id SET DEFAULT nextval('chat_server_dev.member_room_id_seq'::regclass);


--
-- TOC entry 3248 (class 2604 OID 16481)
-- Name: member member_id; Type: DEFAULT; Schema: chat_server_dev; Owner: postgres
--

ALTER TABLE ONLY chat_server_dev.member ALTER COLUMN member_id SET DEFAULT nextval('chat_server_dev.member_member_id_seq'::regclass);


--
-- TOC entry 3251 (class 2604 OID 16482)
-- Name: member_state member_state_id; Type: DEFAULT; Schema: chat_server_dev; Owner: postgres
--

ALTER TABLE ONLY chat_server_dev.member_state ALTER COLUMN member_state_id SET DEFAULT nextval('chat_server_dev.member_state_member_state_id_seq'::regclass);


--
-- TOC entry 3252 (class 2604 OID 16483)
-- Name: member_state member_id; Type: DEFAULT; Schema: chat_server_dev; Owner: postgres
--

ALTER TABLE ONLY chat_server_dev.member_state ALTER COLUMN member_id SET DEFAULT nextval('chat_server_dev.member_state_member_id_seq'::regclass);


--
-- TOC entry 3253 (class 2604 OID 16484)
-- Name: room room_id; Type: DEFAULT; Schema: chat_server_dev; Owner: postgres
--

ALTER TABLE ONLY chat_server_dev.room ALTER COLUMN room_id SET DEFAULT nextval('chat_server_dev.room_room_id_seq'::regclass);


--
-- TOC entry 3255 (class 2604 OID 16485)
-- Name: room_state room_state_id; Type: DEFAULT; Schema: chat_server_dev; Owner: postgres
--

ALTER TABLE ONLY chat_server_dev.room_state ALTER COLUMN room_state_id SET DEFAULT nextval('chat_server_dev.room_state_room_state_id_seq'::regclass);


--
-- TOC entry 3256 (class 2604 OID 16486)
-- Name: room_state room_id; Type: DEFAULT; Schema: chat_server_dev; Owner: postgres
--

ALTER TABLE ONLY chat_server_dev.room_state ALTER COLUMN room_id SET DEFAULT nextval('chat_server_dev.room_state_room_id_seq'::regclass);


--
-- TOC entry 3257 (class 2604 OID 16487)
-- Name: user user_id; Type: DEFAULT; Schema: chat_server_dev; Owner: postgres
--

ALTER TABLE ONLY chat_server_dev."user" ALTER COLUMN user_id SET DEFAULT nextval('chat_server_dev.user_user_id_seq'::regclass);


--
-- TOC entry 3261 (class 2604 OID 16488)
-- Name: user_state user_state_id; Type: DEFAULT; Schema: chat_server_dev; Owner: postgres
--

ALTER TABLE ONLY chat_server_dev.user_state ALTER COLUMN user_state_id SET DEFAULT nextval('chat_server_dev.user_state_user_state_id_seq'::regclass);


--
-- TOC entry 3262 (class 2604 OID 16489)
-- Name: user_state user_id; Type: DEFAULT; Schema: chat_server_dev; Owner: postgres
--

ALTER TABLE ONLY chat_server_dev.user_state ALTER COLUMN user_id SET DEFAULT nextval('chat_server_dev.user_state_user_id_seq'::regclass);


--
-- TOC entry 3437 (class 0 OID 16389)
-- Dependencies: 214
-- Data for Name: chat_log; Type: TABLE DATA; Schema: chat_log_dev; Owner: postgres
--

COPY chat_log_dev.chat_log (chat_id, user_id, chat_content, createat, room_id) FROM stdin;
104_200_2021-12-13 18:16:34.729627 +0900 KST m=+4.313637209	21	6	2021-12-13 18:16:34.739511	104
104_200_2021-12-13 18:16:35.25277 +0900 KST m=+4.836778418	21	6	2021-12-13 18:16:35.26475	104
104_200_2021-12-13 18:16:35.673159 +0900 KST m=+5.257165918	21	6	2021-12-13 18:16:35.677813	104
104_200_2021-12-13 18:16:36.280753 +0900 KST m=+5.864758709	21	6	2021-12-13 18:16:36.290706	104
104_200_2021-12-13 18:17:15.833535 +0900 KST m=+45.417442793	21	6	2021-12-13 18:17:15.839449	104
104_200_2021-12-13 18:18:47.432875 +0900 KST m=+137.016556001	21	6	2021-12-13 18:18:47.45304	104
104_200_2021-12-13 18:18:47.785812 +0900 KST m=+137.369492501	21	6	2021-12-13 18:18:47.79472	104
104_200_2021-12-13 18:18:48.18145 +0900 KST m=+137.765129418	21	6	2021-12-13 18:18:48.189303	104
104_200_2021-12-13 18:18:48.569827 +0900 KST m=+138.153505834	21	6	2021-12-13 18:18:48.578903	104
104_200_2021-12-13 18:18:48.882262 +0900 KST m=+138.465939918	21	6	2021-12-13 18:18:48.890699	104
104_199_2021-12-13 18:23:17.145265 +0900 KST m=+406.728279834	20	6	2021-12-13 18:23:17.151914	104
104_199_2021-12-13 18:23:17.733573 +0900 KST m=+407.316586376	20	6	2021-12-13 18:23:17.742792	104
104_199_2021-12-13 18:23:18.101643 +0900 KST m=+407.684655501	20	6	2021-12-13 18:23:18.110743	104
104_199_2021-12-13 18:23:18.637266 +0900 KST m=+408.220277209	20	6	2021-12-13 18:23:18.644263	104
104_199_2021-12-13 18:23:19.042039 +0900 KST m=+408.625048793	20	6	2021-12-13 18:23:19.048577	104
\.


--
-- TOC entry 3441 (class 0 OID 16397)
-- Dependencies: 218
-- Data for Name: chat_state; Type: TABLE DATA; Schema: chat_log_dev; Owner: postgres
--

COPY chat_log_dev.chat_state (chat_state_id, chat_id, chat_state, createat) FROM stdin;
188	104_200_2021-12-13 18:16:34.729627 +0900 KST m=+4.313637209	0	2021-12-13 18:16:34.739511
189	104_200_2021-12-13 18:16:35.25277 +0900 KST m=+4.836778418	0	2021-12-13 18:16:35.26475
190	104_200_2021-12-13 18:16:35.673159 +0900 KST m=+5.257165918	0	2021-12-13 18:16:35.677813
191	104_200_2021-12-13 18:16:36.280753 +0900 KST m=+5.864758709	0	2021-12-13 18:16:36.290706
192	104_200_2021-12-13 18:17:15.833535 +0900 KST m=+45.417442793	0	2021-12-13 18:17:15.839449
193	104_200_2021-12-13 18:16:36.280753 +0900 KST m=+5.864758709	2	0001-01-01 00:00:00
194	104_200_2021-12-13 18:18:47.432875 +0900 KST m=+137.016556001	0	2021-12-13 18:18:47.45304
195	104_200_2021-12-13 18:18:47.785812 +0900 KST m=+137.369492501	0	2021-12-13 18:18:47.79472
196	104_200_2021-12-13 18:18:48.18145 +0900 KST m=+137.765129418	0	2021-12-13 18:18:48.189303
197	104_200_2021-12-13 18:18:48.569827 +0900 KST m=+138.153505834	0	2021-12-13 18:18:48.578903
198	104_200_2021-12-13 18:18:48.882262 +0900 KST m=+138.465939918	0	2021-12-13 18:18:48.890699
199	104_199_2021-12-13 18:23:17.145265 +0900 KST m=+406.728279834	0	2021-12-13 18:23:17.151914
200	104_199_2021-12-13 18:23:17.733573 +0900 KST m=+407.316586376	0	2021-12-13 18:23:17.742792
201	104_199_2021-12-13 18:23:18.101643 +0900 KST m=+407.684655501	0	2021-12-13 18:23:18.110743
202	104_199_2021-12-13 18:23:18.637266 +0900 KST m=+408.220277209	0	2021-12-13 18:23:18.644263
203	104_199_2021-12-13 18:23:19.042039 +0900 KST m=+408.625048793	0	2021-12-13 18:23:19.048577
\.


--
-- TOC entry 3444 (class 0 OID 16409)
-- Dependencies: 222
-- Data for Name: member; Type: TABLE DATA; Schema: chat_server_dev; Owner: postgres
--

COPY chat_server_dev.member (user_id, room_id, createat, member_id) FROM stdin;
20	73	2021-12-13 11:45:12.009501	137
21	73	2021-12-13 11:45:12.009524	138
20	74	2021-12-13 11:47:41.93923	139
21	74	2021-12-13 11:47:41.939249	140
20	75	2021-12-13 12:00:52.08437	141
21	75	2021-12-13 12:00:52.084392	142
20	76	2021-12-13 12:04:21.730121	143
21	76	2021-12-13 12:04:21.730146	144
20	77	2021-12-13 12:12:17.752944	145
21	77	2021-12-13 12:12:17.752969	146
20	78	2021-12-13 12:18:56.25678	147
21	78	2021-12-13 12:18:56.256829	148
20	79	2021-12-13 12:25:58.642169	149
21	79	2021-12-13 12:25:58.642195	150
20	80	2021-12-13 12:27:21.177345	151
21	80	2021-12-13 12:27:21.177365	152
20	81	2021-12-13 12:29:12.263361	153
21	81	2021-12-13 12:29:12.263388	154
20	82	2021-12-13 13:44:13.266251	155
21	82	2021-12-13 13:44:13.266271	156
20	83	2021-12-13 13:56:15.27289	157
21	83	2021-12-13 13:56:15.272913	158
20	84	2021-12-13 13:57:48.587786	159
21	84	2021-12-13 13:57:48.58781	160
20	85	2021-12-13 13:59:05.004081	161
21	85	2021-12-13 13:59:05.004114	162
20	86	2021-12-13 14:05:29.762671	163
21	86	2021-12-13 14:05:29.762696	164
20	87	2021-12-13 14:13:28.451661	165
21	87	2021-12-13 14:13:28.45168	166
20	88	2021-12-13 14:17:49.392044	167
21	88	2021-12-13 14:17:49.392076	168
20	89	2021-12-13 14:19:44.206408	169
21	89	2021-12-13 14:19:44.206428	170
20	90	2021-12-13 14:33:12.806742	171
21	90	2021-12-13 14:33:12.806763	172
20	91	2021-12-13 14:36:41.521693	173
21	91	2021-12-13 14:36:41.521715	174
20	92	2021-12-13 14:42:36.232091	175
21	92	2021-12-13 14:42:36.232121	176
20	93	2021-12-13 14:45:54.832527	177
21	93	2021-12-13 14:45:54.832549	178
20	94	2021-12-13 14:48:31.30006	179
21	94	2021-12-13 14:48:31.300103	180
20	95	2021-12-13 14:50:17.508474	181
21	95	2021-12-13 14:50:17.508493	182
20	96	2021-12-13 14:51:56.516579	183
21	96	2021-12-13 14:51:56.516605	184
20	97	2021-12-13 14:52:57.096601	185
21	97	2021-12-13 14:52:57.096626	186
20	98	2021-12-13 14:53:26.617015	187
21	98	2021-12-13 14:53:26.617035	188
20	99	2021-12-13 14:55:54.675096	189
21	99	2021-12-13 14:55:54.675118	190
20	100	2021-12-13 14:57:32.348149	191
21	100	2021-12-13 14:57:32.348177	192
20	101	2021-12-13 15:03:21.454076	193
21	101	2021-12-13 15:03:21.454102	194
20	102	2021-12-13 15:04:30.597238	195
21	102	2021-12-13 15:04:30.597261	196
20	103	2021-12-13 15:08:14.767009	197
21	103	2021-12-13 15:08:14.767044	198
20	104	2021-12-13 15:11:12.280296	199
21	104	2021-12-13 15:11:12.280314	200
20	105	2021-12-13 16:15:01.997731	201
21	105	2021-12-13 16:15:01.997754	202
20	106	2021-12-13 16:16:25.229843	203
21	106	2021-12-13 16:16:25.229866	204
20	107	2021-12-13 16:17:09.63004	205
21	107	2021-12-13 16:17:09.63006	206
20	108	2021-12-13 16:20:01.057672	207
21	108	2021-12-13 16:20:01.057706	208
20	109	2021-12-13 16:20:37.650908	209
21	109	2021-12-13 16:20:37.650925	210
20	110	2021-12-13 16:21:15.473753	211
21	110	2021-12-13 16:21:15.473784	212
20	111	2021-12-13 16:22:34.489183	213
21	111	2021-12-13 16:22:34.489214	214
20	112	2021-12-13 16:23:52.767925	215
21	112	2021-12-13 16:23:52.767948	216
20	113	2021-12-13 16:24:50.622057	217
21	113	2021-12-13 16:24:50.622077	218
20	114	2021-12-13 16:26:11.118311	219
21	114	2021-12-13 16:26:11.118333	220
20	115	2021-12-13 16:26:39.494131	221
21	115	2021-12-13 16:26:39.494163	222
20	116	2021-12-13 16:30:15.176245	223
21	116	2021-12-13 16:30:15.176266	224
20	117	2021-12-13 16:31:03.238543	225
21	117	2021-12-13 16:31:03.23857	226
20	118	2021-12-13 16:32:15.940214	227
21	118	2021-12-13 16:32:15.940232	228
\.


--
-- TOC entry 3447 (class 0 OID 16414)
-- Dependencies: 225
-- Data for Name: member_state; Type: TABLE DATA; Schema: chat_server_dev; Owner: postgres
--

COPY chat_server_dev.member_state (member_state_id, member_id, member_state, create_at, member_last_read_msg_index) FROM stdin;
132	137	1	2021-12-13 11:45:12.017186	0
133	138	1	2021-12-13 11:45:12.017242	0
134	139	1	2021-12-13 11:47:41.946646	0
135	140	1	2021-12-13 11:47:41.946686	0
136	141	1	2021-12-13 12:00:52.09112	0
137	142	1	2021-12-13 12:00:52.091149	0
138	143	1	2021-12-13 12:04:21.73788	0
139	144	1	2021-12-13 12:04:21.737912	0
140	145	1	2021-12-13 12:12:17.760715	0
141	146	1	2021-12-13 12:12:17.760747	0
142	147	1	2021-12-13 12:18:56.267464	0
143	148	1	2021-12-13 12:18:56.267519	0
144	149	1	2021-12-13 12:25:58.650319	0
145	150	1	2021-12-13 12:25:58.650369	0
146	151	1	2021-12-13 12:27:21.18737	0
147	152	1	2021-12-13 12:27:21.187417	0
148	153	1	2021-12-13 12:29:12.271444	0
149	154	1	2021-12-13 12:29:12.271482	0
150	155	1	2021-12-13 13:44:13.273094	0
151	156	1	2021-12-13 13:44:13.273126	0
152	157	1	2021-12-13 13:56:15.280517	0
153	158	1	2021-12-13 13:56:15.280552	0
154	159	1	2021-12-13 13:57:48.599732	0
155	160	1	2021-12-13 13:57:48.599776	0
156	161	1	2021-12-13 13:59:05.011853	0
157	162	1	2021-12-13 13:59:05.01189	0
158	163	1	2021-12-13 14:05:29.769777	0
159	164	1	2021-12-13 14:05:29.769814	0
160	165	1	2021-12-13 14:13:28.459286	0
161	166	1	2021-12-13 14:13:28.459331	0
162	167	1	2021-12-13 14:17:49.397383	0
163	168	1	2021-12-13 14:17:49.397414	0
164	169	1	2021-12-13 14:19:44.220253	0
165	170	1	2021-12-13 14:19:44.220318	0
166	171	1	2021-12-13 14:33:12.81318	0
167	172	1	2021-12-13 14:33:12.813217	0
168	173	1	2021-12-13 14:36:41.530696	0
169	174	1	2021-12-13 14:36:41.530737	0
170	175	1	2021-12-13 14:42:36.239121	0
171	176	1	2021-12-13 14:42:36.239159	0
172	177	1	2021-12-13 14:45:54.840676	0
173	178	1	2021-12-13 14:45:54.840838	0
174	179	1	2021-12-13 14:48:31.308506	0
175	180	1	2021-12-13 14:48:31.308547	0
176	181	1	2021-12-13 14:50:17.515425	0
177	182	1	2021-12-13 14:50:17.515453	0
178	183	1	2021-12-13 14:51:56.526265	0
179	184	1	2021-12-13 14:51:56.526308	0
180	185	1	2021-12-13 14:52:57.103812	0
181	186	1	2021-12-13 14:52:57.103844	0
182	187	1	2021-12-13 14:53:26.623148	0
183	188	1	2021-12-13 14:53:26.623181	0
184	189	1	2021-12-13 14:55:54.681199	0
185	190	1	2021-12-13 14:55:54.681232	0
186	191	1	2021-12-13 14:57:32.354627	0
187	192	1	2021-12-13 14:57:32.354664	0
188	191	1	2021-12-13 14:57:32.372129	0
189	193	1	2021-12-13 15:03:21.461505	0
190	194	1	2021-12-13 15:03:21.461547	0
191	193	1	2021-12-13 15:03:21.480747	0
192	195	1	2021-12-13 15:04:30.604746	0
193	196	1	2021-12-13 15:04:30.60478	0
194	195	1	2021-12-13 15:04:30.62107	1
195	197	1	2021-12-13 15:08:14.775669	0
196	198	1	2021-12-13 15:08:14.775701	0
197	197	1	2021-12-13 15:08:14.794899	1
198	199	1	2021-12-13 15:11:12.287531	0
199	200	1	2021-12-13 15:11:12.287566	0
200	199	1	2021-12-13 15:11:12.306289	1
201	201	1	2021-12-13 16:15:02.005245	0
202	202	1	2021-12-13 16:15:02.005278	0
203	201	1	2021-12-13 16:15:02.022171	1
204	203	1	2021-12-13 16:16:25.236833	0
205	204	1	2021-12-13 16:16:25.236869	0
206	203	1	2021-12-13 16:16:25.255867	0
207	205	1	2021-12-13 16:17:09.6357	0
208	206	1	2021-12-13 16:17:09.635727	0
209	205	1	2021-12-13 16:17:09.652041	1
210	207	1	2021-12-13 16:20:01.065256	0
211	208	1	2021-12-13 16:20:01.06529	0
212	207	1	2021-12-13 16:20:01.086718	1
213	209	1	2021-12-13 16:20:37.656704	0
214	210	1	2021-12-13 16:20:37.656733	0
215	209	1	2021-12-13 16:20:37.674501	0
216	211	1	2021-12-13 16:21:15.481192	0
217	212	1	2021-12-13 16:21:15.481229	0
218	211	1	2021-12-13 16:21:15.504042	1
219	213	1	2021-12-13 16:22:34.497336	0
220	214	1	2021-12-13 16:22:34.497374	0
221	213	1	2021-12-13 16:22:34.516694	0
222	215	1	2021-12-13 16:23:52.774672	0
223	216	1	2021-12-13 16:23:52.774705	0
224	215	1	2021-12-13 16:23:52.790308	0
225	217	1	2021-12-13 16:24:50.629883	0
226	218	1	2021-12-13 16:24:50.629924	0
227	217	1	2021-12-13 16:24:50.64999	1
228	219	1	2021-12-13 16:26:11.125268	0
229	220	1	2021-12-13 16:26:11.12537	0
230	219	1	2021-12-13 16:26:11.142424	1
231	221	1	2021-12-13 16:26:39.502177	0
232	222	1	2021-12-13 16:26:39.50222	0
233	221	1	2021-12-13 16:26:39.520182	0
234	223	1	2021-12-13 16:30:15.1835	0
235	224	1	2021-12-13 16:30:15.183598	0
236	223	1	2021-12-13 16:30:15.201687	1
237	225	1	2021-12-13 16:31:03.246345	0
238	226	1	2021-12-13 16:31:03.246443	0
239	225	1	2021-12-13 16:31:03.263269	0
240	227	1	2021-12-13 16:32:15.946755	0
241	228	1	2021-12-13 16:32:15.946853	0
242	227	1	2021-12-13 16:32:15.963007	1
243	200	1	2021-12-13 18:22:17.493003	10
\.


--
-- TOC entry 3451 (class 0 OID 16422)
-- Dependencies: 229
-- Data for Name: room; Type: TABLE DATA; Schema: chat_server_dev; Owner: postgres
--

COPY chat_server_dev.room (room_id, room_name, createat) FROM stdin;
105	test-3	2021-12-13 16:15:01.986717
106	test-3	2021-12-13 16:16:25.218322
107	test-3	2021-12-13 16:17:09.620193
108	test-3	2021-12-13 16:20:01.046187
109	test-3	2021-12-13 16:20:37.641034
110	test-3	2021-12-13 16:21:15.462453
111	test-3	2021-12-13 16:22:34.475531
112	test-3	2021-12-13 16:23:52.758494
113	test-3	2021-12-13 16:24:50.610707
114	test-3	2021-12-13 16:26:11.106711
115	test-3	2021-12-13 16:26:39.484128
116	test-3	2021-12-13 16:30:15.164859
117	test-3	2021-12-13 16:31:03.22657
118	test-3	2021-12-13 16:32:15.930294
73	test-3	2021-12-13 11:45:11.999599
74	test-3	2021-12-13 11:47:41.929036
75	test-3	2021-12-13 12:00:52.074505
76	test-3	2021-12-13 12:04:21.719158
77	test-3	2021-12-13 12:12:17.741217
78	test-3	2021-12-13 12:18:56.229283
79	test-3	2021-12-13 12:25:58.632494
80	test-3	2021-12-13 12:27:21.166745
81	test-3	2021-12-13 12:29:12.251734
82	test-3	2021-12-13 13:44:13.256701
83	test-3	2021-12-13 13:56:15.261322
84	test-3	2021-12-13 13:57:48.574238
85	test-3	2021-12-13 13:59:04.993481
86	test-3	2021-12-13 14:05:29.75206
87	test-3	2021-12-13 14:13:28.440844
88	test-3	2021-12-13 14:17:49.383433
89	test-3	2021-12-13 14:19:44.196423
90	test-3	2021-12-13 14:33:12.796677
91	test-3	2021-12-13 14:36:41.509746
92	test-3	2021-12-13 14:42:36.222418
93	test-3	2021-12-13 14:45:54.821254
94	test-3	2021-12-13 14:48:31.283335
95	test-3	2021-12-13 14:50:17.498376
96	test-3	2021-12-13 14:51:56.505445
97	test-3	2021-12-13 14:52:57.084809
98	test-3	2021-12-13 14:53:26.607209
99	test-3	2021-12-13 14:55:54.665562
100	test-3	2021-12-13 14:57:32.338199
101	test-3	2021-12-13 15:03:21.44377
102	test-3	2021-12-13 15:04:30.586477
103	test-3	2021-12-13 15:08:14.752755
104	test-3	2021-12-13 15:11:12.269988
\.


--
-- TOC entry 3453 (class 0 OID 16428)
-- Dependencies: 231
-- Data for Name: room_state; Type: TABLE DATA; Schema: chat_server_dev; Owner: postgres
--

COPY chat_server_dev.room_state (room_state_id, room_id, room_state, create_at) FROM stdin;
87	89	1	2021-12-13 14:19:44.196423
88	90	1	2021-12-13 14:33:12.796677
89	91	1	2021-12-13 14:36:41.509746
90	92	1	2021-12-13 14:42:36.222418
91	93	1	2021-12-13 14:45:54.821254
92	94	1	2021-12-13 14:48:31.283335
93	95	1	2021-12-13 14:50:17.498376
94	96	1	2021-12-13 14:51:56.505445
95	97	1	2021-12-13 14:52:57.084809
96	98	1	2021-12-13 14:53:26.607209
97	99	1	2021-12-13 14:55:54.665562
98	100	1	2021-12-13 14:57:32.338199
99	101	1	2021-12-13 15:03:21.44377
100	102	1	2021-12-13 15:04:30.586477
101	103	1	2021-12-13 15:08:14.752755
102	104	1	2021-12-13 15:11:12.269988
103	105	1	2021-12-13 16:15:01.986717
104	106	1	2021-12-13 16:16:25.218322
105	107	1	2021-12-13 16:17:09.620193
106	108	1	2021-12-13 16:20:01.046187
107	109	1	2021-12-13 16:20:37.641034
108	110	1	2021-12-13 16:21:15.462453
109	111	1	2021-12-13 16:22:34.475531
110	112	1	2021-12-13 16:23:52.758494
111	113	1	2021-12-13 16:24:50.610707
112	114	1	2021-12-13 16:26:11.106711
113	115	1	2021-12-13 16:26:39.484128
114	116	1	2021-12-13 16:30:15.164859
115	117	1	2021-12-13 16:31:03.22657
116	118	1	2021-12-13 16:32:15.930294
71	73	1	2021-12-13 11:45:11.999599
72	74	1	2021-12-13 11:47:41.929036
73	75	1	2021-12-13 12:00:52.074505
74	76	1	2021-12-13 12:04:21.719158
75	77	1	2021-12-13 12:12:17.741217
76	78	1	2021-12-13 12:18:56.229283
77	79	1	2021-12-13 12:25:58.632494
78	80	1	2021-12-13 12:27:21.166745
79	81	1	2021-12-13 12:29:12.251734
80	82	1	2021-12-13 13:44:13.256701
81	83	1	2021-12-13 13:56:15.261322
82	84	1	2021-12-13 13:57:48.574238
83	85	1	2021-12-13 13:59:04.993481
84	86	1	2021-12-13 14:05:29.75206
85	87	1	2021-12-13 14:13:28.440844
86	88	1	2021-12-13 14:17:49.383433
\.


--
-- TOC entry 3456 (class 0 OID 16434)
-- Dependencies: 234
-- Data for Name: user; Type: TABLE DATA; Schema: chat_server_dev; Owner: postgres
--

COPY chat_server_dev."user" (user_id, user_uuid, email_addr, pwd, nickname, birthdate, phone_number, createat, fcm_token) FROM stdin;
19	test1test2	test1@test.com	$2a$10$Tn6BqWrK0yGKdruCVgTVM.TfzUmybDlwzm1vt1bcDcWtHgPhQsn.C	test2 Nick	\N	000000000	2021-12-02 11:06:16.048952	0
20	test1test3	test2@test.com	$2a$10$t6eqTbMw6jeu8VR6t3B5k.SXYtWQn7otlShF/f22oN3ELUf93iM9K	test3 Nick	\N	000000000	2021-12-02 12:26:51.35549	0
21	test1test3	test3@test.com	$2a$10$CbRcZ1onY4w.g/ntP9GkLOj82mRnOpJA12qZgSS7o4FQ948.htvZm	test4 Nick	\N	000000000	2021-12-02 14:33:28.723764	0
1					\N		0001-01-01 00:00:00	0
\.


--
-- TOC entry 3457 (class 0 OID 16439)
-- Dependencies: 235
-- Data for Name: user_state; Type: TABLE DATA; Schema: chat_server_dev; Owner: postgres
--

COPY chat_server_dev.user_state (user_state_id, user_id, user_state, create_at, user_fcm_token) FROM stdin;
3	19	1	2021-12-02 11:06:16.062078	0
4	19	2	2021-12-02 12:06:34.242366	0
5	20	1	2021-12-02 12:26:51.35549	0
6	21	1	2021-12-02 14:33:28.723764	0
7	19	1	2021-12-02 14:33:28.723764	0
\.


--
-- TOC entry 3461 (class 0 OID 16449)
-- Dependencies: 239
-- Data for Name: ingredient; Type: TABLE DATA; Schema: spring_taco_dev; Owner: postgres
--

COPY spring_taco_dev.ingredient (id, name, type) FROM stdin;
FLTO	Flour Tortilla	WRAP
COTO	Corn Tortilla	WRAP
GRBF	Ground Beef	PROTEIN
CARN	Carnitas	PROTEIN
TMTO	Diced Tomatoes	VEGGIES
LETC	Lettuce	VEGGIES
CHED	Cheddar	CHEESE
JACK	Monterrey Jeck	CHEESE
SLSA	Salsa	SAUCE
SRCR	Sour Cream	SAUCE
\.


--
-- TOC entry 3462 (class 0 OID 16454)
-- Dependencies: 240
-- Data for Name: taco; Type: TABLE DATA; Schema: spring_taco_dev; Owner: postgres
--

COPY spring_taco_dev.taco (id, name, createat) FROM stdin;
\.


--
-- TOC entry 3464 (class 0 OID 16460)
-- Dependencies: 242
-- Data for Name: taco_ingredients; Type: TABLE DATA; Schema: spring_taco_dev; Owner: postgres
--

COPY spring_taco_dev.taco_ingredients (taco, ingredient) FROM stdin;
\.


--
-- TOC entry 3465 (class 0 OID 16465)
-- Dependencies: 243
-- Data for Name: taco_order; Type: TABLE DATA; Schema: spring_taco_dev; Owner: postgres
--

COPY spring_taco_dev.taco_order (id, deliveryname, deliverystreet, deliverycity, deliverystate, deliveryzip, ccnumber, ccexpiration, ccccv, placedat) FROM stdin;
\.


--
-- TOC entry 3467 (class 0 OID 16471)
-- Dependencies: 245
-- Data for Name: taco_order_tacos; Type: TABLE DATA; Schema: spring_taco_dev; Owner: postgres
--

COPY spring_taco_dev.taco_order_tacos (tacoorder, taco) FROM stdin;
\.


--
-- TOC entry 3489 (class 0 OID 0)
-- Dependencies: 215
-- Name: chat_log_chat_id_seq; Type: SEQUENCE SET; Schema: chat_log_dev; Owner: postgres
--

SELECT pg_catalog.setval('chat_log_dev.chat_log_chat_id_seq', 169, true);


--
-- TOC entry 3490 (class 0 OID 0)
-- Dependencies: 216
-- Name: chat_log_room_id_seq; Type: SEQUENCE SET; Schema: chat_log_dev; Owner: postgres
--

SELECT pg_catalog.setval('chat_log_dev.chat_log_room_id_seq', 1, false);


--
-- TOC entry 3491 (class 0 OID 0)
-- Dependencies: 217
-- Name: chat_log_user_id_seq; Type: SEQUENCE SET; Schema: chat_log_dev; Owner: postgres
--

SELECT pg_catalog.setval('chat_log_dev.chat_log_user_id_seq', 1, false);


--
-- TOC entry 3492 (class 0 OID 0)
-- Dependencies: 220
-- Name: chat_state_chat_id_seq; Type: SEQUENCE SET; Schema: chat_log_dev; Owner: postgres
--

SELECT pg_catalog.setval('chat_log_dev.chat_state_chat_id_seq', 1, false);


--
-- TOC entry 3493 (class 0 OID 0)
-- Dependencies: 221
-- Name: chat_state_chat_state_id_seq; Type: SEQUENCE SET; Schema: chat_log_dev; Owner: postgres
--

SELECT pg_catalog.setval('chat_log_dev.chat_state_chat_state_id_seq', 203, true);


--
-- TOC entry 3494 (class 0 OID 0)
-- Dependencies: 223
-- Name: member_member_id_seq; Type: SEQUENCE SET; Schema: chat_server_dev; Owner: postgres
--

SELECT pg_catalog.setval('chat_server_dev.member_member_id_seq', 228, true);


--
-- TOC entry 3495 (class 0 OID 0)
-- Dependencies: 224
-- Name: member_room_id_seq; Type: SEQUENCE SET; Schema: chat_server_dev; Owner: postgres
--

SELECT pg_catalog.setval('chat_server_dev.member_room_id_seq', 1, false);


--
-- TOC entry 3496 (class 0 OID 0)
-- Dependencies: 226
-- Name: member_state_member_id_seq; Type: SEQUENCE SET; Schema: chat_server_dev; Owner: postgres
--

SELECT pg_catalog.setval('chat_server_dev.member_state_member_id_seq', 1, false);


--
-- TOC entry 3497 (class 0 OID 0)
-- Dependencies: 227
-- Name: member_state_member_state_id_seq; Type: SEQUENCE SET; Schema: chat_server_dev; Owner: postgres
--

SELECT pg_catalog.setval('chat_server_dev.member_state_member_state_id_seq', 243, true);


--
-- TOC entry 3498 (class 0 OID 0)
-- Dependencies: 228
-- Name: member_user_id_seq; Type: SEQUENCE SET; Schema: chat_server_dev; Owner: postgres
--

SELECT pg_catalog.setval('chat_server_dev.member_user_id_seq', 1, false);


--
-- TOC entry 3499 (class 0 OID 0)
-- Dependencies: 230
-- Name: room_room_id_seq; Type: SEQUENCE SET; Schema: chat_server_dev; Owner: postgres
--

SELECT pg_catalog.setval('chat_server_dev.room_room_id_seq', 118, true);


--
-- TOC entry 3500 (class 0 OID 0)
-- Dependencies: 232
-- Name: room_state_room_id_seq; Type: SEQUENCE SET; Schema: chat_server_dev; Owner: postgres
--

SELECT pg_catalog.setval('chat_server_dev.room_state_room_id_seq', 1, false);


--
-- TOC entry 3501 (class 0 OID 0)
-- Dependencies: 233
-- Name: room_state_room_state_id_seq; Type: SEQUENCE SET; Schema: chat_server_dev; Owner: postgres
--

SELECT pg_catalog.setval('chat_server_dev.room_state_room_state_id_seq', 116, true);


--
-- TOC entry 3502 (class 0 OID 0)
-- Dependencies: 236
-- Name: user_state_user_id_seq; Type: SEQUENCE SET; Schema: chat_server_dev; Owner: postgres
--

SELECT pg_catalog.setval('chat_server_dev.user_state_user_id_seq', 1, false);


--
-- TOC entry 3503 (class 0 OID 0)
-- Dependencies: 237
-- Name: user_state_user_state_id_seq; Type: SEQUENCE SET; Schema: chat_server_dev; Owner: postgres
--

SELECT pg_catalog.setval('chat_server_dev.user_state_user_state_id_seq', 7, true);


--
-- TOC entry 3504 (class 0 OID 0)
-- Dependencies: 238
-- Name: user_user_id_seq; Type: SEQUENCE SET; Schema: chat_server_dev; Owner: postgres
--

SELECT pg_catalog.setval('chat_server_dev.user_user_id_seq', 21, true);


--
-- TOC entry 3505 (class 0 OID 0)
-- Dependencies: 241
-- Name: taco_id_seq; Type: SEQUENCE SET; Schema: spring_taco_dev; Owner: postgres
--

SELECT pg_catalog.setval('spring_taco_dev.taco_id_seq', 1, false);


--
-- TOC entry 3506 (class 0 OID 0)
-- Dependencies: 244
-- Name: taco_order_id_seq; Type: SEQUENCE SET; Schema: spring_taco_dev; Owner: postgres
--

SELECT pg_catalog.setval('spring_taco_dev.taco_order_id_seq', 1, false);


--
-- TOC entry 3264 (class 2606 OID 16491)
-- Name: chat_log chat_log_pk; Type: CONSTRAINT; Schema: chat_log_dev; Owner: postgres
--

ALTER TABLE ONLY chat_log_dev.chat_log
    ADD CONSTRAINT chat_log_pk PRIMARY KEY (chat_id);


--
-- TOC entry 3266 (class 2606 OID 16493)
-- Name: chat_state chat_state_pk; Type: CONSTRAINT; Schema: chat_log_dev; Owner: postgres
--

ALTER TABLE ONLY chat_log_dev.chat_state
    ADD CONSTRAINT chat_state_pk PRIMARY KEY (chat_state_id);


--
-- TOC entry 3268 (class 2606 OID 16495)
-- Name: member member_pk; Type: CONSTRAINT; Schema: chat_server_dev; Owner: postgres
--

ALTER TABLE ONLY chat_server_dev.member
    ADD CONSTRAINT member_pk PRIMARY KEY (member_id);


--
-- TOC entry 3270 (class 2606 OID 16497)
-- Name: member_state member_state_pk; Type: CONSTRAINT; Schema: chat_server_dev; Owner: postgres
--

ALTER TABLE ONLY chat_server_dev.member_state
    ADD CONSTRAINT member_state_pk PRIMARY KEY (member_state_id);


--
-- TOC entry 3272 (class 2606 OID 16499)
-- Name: room room_pk; Type: CONSTRAINT; Schema: chat_server_dev; Owner: postgres
--

ALTER TABLE ONLY chat_server_dev.room
    ADD CONSTRAINT room_pk PRIMARY KEY (room_id);


--
-- TOC entry 3274 (class 2606 OID 16501)
-- Name: room_state room_state_pk; Type: CONSTRAINT; Schema: chat_server_dev; Owner: postgres
--

ALTER TABLE ONLY chat_server_dev.room_state
    ADD CONSTRAINT room_state_pk PRIMARY KEY (room_state_id);


--
-- TOC entry 3276 (class 2606 OID 16503)
-- Name: user user_pk; Type: CONSTRAINT; Schema: chat_server_dev; Owner: postgres
--

ALTER TABLE ONLY chat_server_dev."user"
    ADD CONSTRAINT user_pk PRIMARY KEY (user_id);


--
-- TOC entry 3278 (class 2606 OID 16505)
-- Name: user_state user_state_pk; Type: CONSTRAINT; Schema: chat_server_dev; Owner: postgres
--

ALTER TABLE ONLY chat_server_dev.user_state
    ADD CONSTRAINT user_state_pk PRIMARY KEY (user_state_id);


--
-- TOC entry 3280 (class 2606 OID 16507)
-- Name: ingredient ingredient_pk; Type: CONSTRAINT; Schema: spring_taco_dev; Owner: postgres
--

ALTER TABLE ONLY spring_taco_dev.ingredient
    ADD CONSTRAINT ingredient_pk PRIMARY KEY (id);


--
-- TOC entry 3284 (class 2606 OID 16509)
-- Name: taco_order taco_order_pk; Type: CONSTRAINT; Schema: spring_taco_dev; Owner: postgres
--

ALTER TABLE ONLY spring_taco_dev.taco_order
    ADD CONSTRAINT taco_order_pk PRIMARY KEY (id);


--
-- TOC entry 3282 (class 2606 OID 16511)
-- Name: taco taco_pk; Type: CONSTRAINT; Schema: spring_taco_dev; Owner: postgres
--

ALTER TABLE ONLY spring_taco_dev.taco
    ADD CONSTRAINT taco_pk PRIMARY KEY (id);


--
-- TOC entry 3285 (class 2606 OID 16512)
-- Name: chat_log chat_log_fk; Type: FK CONSTRAINT; Schema: chat_log_dev; Owner: postgres
--

ALTER TABLE ONLY chat_log_dev.chat_log
    ADD CONSTRAINT chat_log_fk FOREIGN KEY (user_id) REFERENCES chat_server_dev."user"(user_id);


--
-- TOC entry 3286 (class 2606 OID 16517)
-- Name: chat_log chat_log_fk_1; Type: FK CONSTRAINT; Schema: chat_log_dev; Owner: postgres
--

ALTER TABLE ONLY chat_log_dev.chat_log
    ADD CONSTRAINT chat_log_fk_1 FOREIGN KEY (room_id) REFERENCES chat_server_dev.room(room_id);


--
-- TOC entry 3287 (class 2606 OID 16522)
-- Name: chat_state chat_state_fk; Type: FK CONSTRAINT; Schema: chat_log_dev; Owner: postgres
--

ALTER TABLE ONLY chat_log_dev.chat_state
    ADD CONSTRAINT chat_state_fk FOREIGN KEY (chat_id) REFERENCES chat_log_dev.chat_log(chat_id);


--
-- TOC entry 3288 (class 2606 OID 16527)
-- Name: member member_fk; Type: FK CONSTRAINT; Schema: chat_server_dev; Owner: postgres
--

ALTER TABLE ONLY chat_server_dev.member
    ADD CONSTRAINT member_fk FOREIGN KEY (user_id) REFERENCES chat_server_dev."user"(user_id);


--
-- TOC entry 3289 (class 2606 OID 16532)
-- Name: member member_fk_1; Type: FK CONSTRAINT; Schema: chat_server_dev; Owner: postgres
--

ALTER TABLE ONLY chat_server_dev.member
    ADD CONSTRAINT member_fk_1 FOREIGN KEY (room_id) REFERENCES chat_server_dev.room(room_id);


--
-- TOC entry 3290 (class 2606 OID 16537)
-- Name: member_state member_state_fk; Type: FK CONSTRAINT; Schema: chat_server_dev; Owner: postgres
--

ALTER TABLE ONLY chat_server_dev.member_state
    ADD CONSTRAINT member_state_fk FOREIGN KEY (member_id) REFERENCES chat_server_dev.member(member_id);


--
-- TOC entry 3291 (class 2606 OID 16542)
-- Name: room_state room_state_fk; Type: FK CONSTRAINT; Schema: chat_server_dev; Owner: postgres
--

ALTER TABLE ONLY chat_server_dev.room_state
    ADD CONSTRAINT room_state_fk FOREIGN KEY (room_id) REFERENCES chat_server_dev.room(room_id);


--
-- TOC entry 3292 (class 2606 OID 16547)
-- Name: user_state user_state_fk; Type: FK CONSTRAINT; Schema: chat_server_dev; Owner: postgres
--

ALTER TABLE ONLY chat_server_dev.user_state
    ADD CONSTRAINT user_state_fk FOREIGN KEY (user_id) REFERENCES chat_server_dev."user"(user_id);


--
-- TOC entry 3293 (class 2606 OID 16552)
-- Name: taco_ingredients taco_ingredients_fk; Type: FK CONSTRAINT; Schema: spring_taco_dev; Owner: postgres
--

ALTER TABLE ONLY spring_taco_dev.taco_ingredients
    ADD CONSTRAINT taco_ingredients_fk FOREIGN KEY (taco) REFERENCES spring_taco_dev.taco(id);


--
-- TOC entry 3294 (class 2606 OID 16557)
-- Name: taco_ingredients taco_ingredients_fk_1; Type: FK CONSTRAINT; Schema: spring_taco_dev; Owner: postgres
--

ALTER TABLE ONLY spring_taco_dev.taco_ingredients
    ADD CONSTRAINT taco_ingredients_fk_1 FOREIGN KEY (ingredient) REFERENCES spring_taco_dev.ingredient(id);


--
-- TOC entry 3295 (class 2606 OID 16562)
-- Name: taco_order_tacos taco_order_tacos_fk; Type: FK CONSTRAINT; Schema: spring_taco_dev; Owner: postgres
--

ALTER TABLE ONLY spring_taco_dev.taco_order_tacos
    ADD CONSTRAINT taco_order_tacos_fk FOREIGN KEY (tacoorder) REFERENCES spring_taco_dev.taco_order(id);


--
-- TOC entry 3296 (class 2606 OID 16567)
-- Name: taco_order_tacos taco_order_tacos_fk_1; Type: FK CONSTRAINT; Schema: spring_taco_dev; Owner: postgres
--

ALTER TABLE ONLY spring_taco_dev.taco_order_tacos
    ADD CONSTRAINT taco_order_tacos_fk_1 FOREIGN KEY (taco) REFERENCES spring_taco_dev.taco(id);


-- Completed on 2021-12-28 14:39:53 KST

--
-- PostgreSQL database dump complete
--

