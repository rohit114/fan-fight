--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2
-- Dumped by pg_dump version 11.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: user; Type: TABLE; Schema: public; Owner: fanfight
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    name text,
    "imageUrl" text,
    phone text,
    email text,
    "registeredAt" timestamp with time zone,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone
);


ALTER TABLE public."user" OWNER TO fanfight;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: fanfight
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO fanfight;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: fanfight
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: wallet; Type: TABLE; Schema: public; Owner: fanfight
--

CREATE TABLE public.wallet (
    id integer NOT NULL,
    "user" integer,
    bonus real,
    deposit real,
    winnings real,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone
);


ALTER TABLE public.wallet OWNER TO fanfight;

--
-- Name: wallet_id_seq; Type: SEQUENCE; Schema: public; Owner: fanfight
--

CREATE SEQUENCE public.wallet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wallet_id_seq OWNER TO fanfight;

--
-- Name: wallet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: fanfight
--

ALTER SEQUENCE public.wallet_id_seq OWNED BY public.wallet.id;


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: fanfight
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Name: wallet id; Type: DEFAULT; Schema: public; Owner: fanfight
--

ALTER TABLE ONLY public.wallet ALTER COLUMN id SET DEFAULT nextval('public.wallet_id_seq'::regclass);


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: fanfight
--

COPY public."user" (id, name, "imageUrl", phone, email, "registeredAt", "createdAt", "updatedAt") FROM stdin;
1	Mukul	\N	\N	mukul@gmail.com	2019-07-27 21:28:23.989646+05:30	2019-07-27 21:28:23.989646+05:30	2019-07-27 21:28:23.989646+05:30
2	Rohit	\N	\N	rohit@gmail.com	2019-07-27 23:35:14.433024+05:30	2019-07-27 23:35:14.433024+05:30	2019-07-27 23:35:14.433024+05:30
3	Rahul	\N	\N	rahul@gmail.com	2019-07-27 23:35:14.443697+05:30	2019-07-27 23:35:14.443697+05:30	2019-07-27 23:35:14.443697+05:30
4	Neeraj	\N	\N	neeraj@gmail.com	2019-07-27 23:35:14.445855+05:30	2019-07-27 23:35:14.445855+05:30	2019-07-27 23:35:14.445855+05:30
5	Abhishek	\N	\N	abhishek@gmail.com	2019-07-27 23:35:14.44812+05:30	2019-07-27 23:35:14.44812+05:30	2019-07-27 23:35:14.44812+05:30
6	Sunny	\N	\N	sunny@gmail.com	2019-07-27 23:35:16.035347+05:30	2019-07-27 23:35:16.035347+05:30	2019-07-27 23:35:16.035347+05:30
\.


--
-- Data for Name: wallet; Type: TABLE DATA; Schema: public; Owner: fanfight
--

COPY public.wallet (id, "user", bonus, deposit, winnings, "createdAt", "updatedAt") FROM stdin;
4	1	28	0	152	\N	\N
5	2	0	0	160	\N	\N
6	1	60	100	340	\N	\N
7	2	60	100	340	\N	\N
8	3	60	400	340	\N	\N
9	4	60	400	340	\N	\N
10	5	100	10	500	\N	\N
11	6	100	200	400	\N	\N
\.


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: fanfight
--

SELECT pg_catalog.setval('public.user_id_seq', 6, true);


--
-- Name: wallet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: fanfight
--

SELECT pg_catalog.setval('public.wallet_id_seq', 11, true);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: fanfight
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: wallet wallet_pkey; Type: CONSTRAINT; Schema: public; Owner: fanfight
--

ALTER TABLE ONLY public.wallet
    ADD CONSTRAINT wallet_pkey PRIMARY KEY (id);


--
-- Name: wallet wallet_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fanfight
--

ALTER TABLE ONLY public.wallet
    ADD CONSTRAINT wallet_user_fkey FOREIGN KEY ("user") REFERENCES public."user"(id);


--
-- PostgreSQL database dump complete
--

