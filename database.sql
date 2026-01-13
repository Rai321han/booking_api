--
-- PostgreSQL database dump
--

\restrict bTpaDisETu7CQOzV4tAHz9drRdc2UUIi6ulj5oW4lBURiPPeQzZc6vxo1quowxG

-- Dumped from database version 16.11 (Debian 16.11-1.pgdg13+1)
-- Dumped by pg_dump version 16.11 (Debian 16.11-1.pgdg13+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: attractions; Type: TABLE; Schema: public; Owner: raihanuddin
--

CREATE TABLE public.attractions (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    additional_info text,
    cancellation_policy boolean,
    price numeric(10,2),
    currency character varying(10) DEFAULT 'USD'::character varying,
    whats_included text[],
    location_id integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    images text[]
);


ALTER TABLE public.attractions OWNER TO raihanuddin;

--
-- Name: attractions_id_seq; Type: SEQUENCE; Schema: public; Owner: raihanuddin
--

CREATE SEQUENCE public.attractions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.attractions_id_seq OWNER TO raihanuddin;

--
-- Name: attractions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: raihanuddin
--

ALTER SEQUENCE public.attractions_id_seq OWNED BY public.attractions.id;


--
-- Name: flights; Type: TABLE; Schema: public; Owner: raihanuddin
--

CREATE TABLE public.flights (
    id integer NOT NULL,
    flight_name character varying(50) NOT NULL,
    flight_logo character varying(255),
    fare numeric(10,2) NOT NULL,
    departure_time timestamp with time zone NOT NULL,
    arrival_time timestamp with time zone NOT NULL,
    departure_airport character varying(255) NOT NULL,
    arrival_airport character varying(255) NOT NULL,
    location_id integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.flights OWNER TO raihanuddin;

--
-- Name: flights_id_seq; Type: SEQUENCE; Schema: public; Owner: raihanuddin
--

CREATE SEQUENCE public.flights_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.flights_id_seq OWNER TO raihanuddin;

--
-- Name: flights_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: raihanuddin
--

ALTER SEQUENCE public.flights_id_seq OWNED BY public.flights.id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: raihanuddin
--

CREATE TABLE public.locations (
    id integer NOT NULL,
    cityname character varying(255) NOT NULL,
    countrycode character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.locations OWNER TO raihanuddin;

--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: raihanuddin
--

CREATE SEQUENCE public.locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.locations_id_seq OWNER TO raihanuddin;

--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: raihanuddin
--

ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;


--
-- Name: pgmigrations; Type: TABLE; Schema: public; Owner: raihanuddin
--

CREATE TABLE public.pgmigrations (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    run_on timestamp without time zone NOT NULL
);


ALTER TABLE public.pgmigrations OWNER TO raihanuddin;

--
-- Name: pgmigrations_id_seq; Type: SEQUENCE; Schema: public; Owner: raihanuddin
--

CREATE SEQUENCE public.pgmigrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pgmigrations_id_seq OWNER TO raihanuddin;

--
-- Name: pgmigrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: raihanuddin
--

ALTER SEQUENCE public.pgmigrations_id_seq OWNED BY public.pgmigrations.id;


--
-- Name: attractions id; Type: DEFAULT; Schema: public; Owner: raihanuddin
--

ALTER TABLE ONLY public.attractions ALTER COLUMN id SET DEFAULT nextval('public.attractions_id_seq'::regclass);


--
-- Name: flights id; Type: DEFAULT; Schema: public; Owner: raihanuddin
--

ALTER TABLE ONLY public.flights ALTER COLUMN id SET DEFAULT nextval('public.flights_id_seq'::regclass);


--
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: raihanuddin
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);


--
-- Name: pgmigrations id; Type: DEFAULT; Schema: public; Owner: raihanuddin
--

ALTER TABLE ONLY public.pgmigrations ALTER COLUMN id SET DEFAULT nextval('public.pgmigrations_id_seq'::regclass);


--
-- Data for Name: attractions; Type: TABLE DATA; Schema: public; Owner: raihanuddin
--

COPY public.attractions (id, name, slug, additional_info, cancellation_policy, price, currency, whats_included, location_id, created_at, updated_at, images) FROM stdin;
5	Jeddah Historical Tour From Jeddah Port	prp94lumypzb-jeddah-historical-tour-from-jeddah-port	Wheelchair accessible\n\nSuitable for all physical fitness levels\n\n\n\nYour driver will be waiting for you with sign of your name\n\nPlease bring your ticket with you to the attraction.\n\nBe aware that operators may cancel for unforeseen reasons.\n\nYou need to be 18 years or older to book. Children must be accompanied by an adult.	t	550.00	USD	{"English speaking tour leader/driver.","Pick up services from Jeddah Port & return (by the cruise exit door)","Entrance fees."}	5	2026-01-13 07:48:38.551669+00	2026-01-13 07:48:38.551669+00	{https://q-xx.bstatic.com/xdata/images/xphoto/300x320/400331127.jpg?k=83dbdb7b810aaec80e33204e5d6e7e0062872bed91926ffa5009e314d6c9a1db&o=,https://r-xx.bstatic.com/xdata/images/xphoto/300x320/400331172.jpg?k=8e76d40fef8a1bd1964664f4e0001cdf14ab7453575304d494f5d0babcb9550a&o=,https://r-xx.bstatic.com/xdata/images/xphoto/300x320/400331222.jpg?k=461402837050879fe48b11131548aa7214683e27656e55cf8ec965469fad7301&o=,https://r-xx.bstatic.com/xdata/images/xphoto/300x320/400331288.jpg?k=c8ba0c65818005f13811fe9e0621c73b2669e471982a318cd43ca1d043fa31f0&o=,https://q-xx.bstatic.com/xdata/images/xphoto/300x320/400331350.jpg?k=f28bf9befc77356aed08a274c986c186c27d022c3e9b30a1b02c1d83c6280271&o=,https://r-xx.bstatic.com/xdata/images/xphoto/300x320/400331416.jpg?k=9ee45b21e5012561d9ed28d240b202146a5d49d39bee0358e57e6beeb7c9fd3b&o=}
3	Jeddah’s Traditional Tour from Jeddah	pr1oxtdhxjii-half-day-jeddah-traditional-city-tour	Suitable for all physical fitness levels\n\n\n\nTour start: Our tour will start at 09:00 Hrs, but pick up is 30-60 minutes before.\n\n*Pick up: We will pick up its customers in most of the major hotels in Jeddah. The pickup time varies between 1 hour to 30 minutes before the start of the tour at the terminal point. We will confirm with you one day earlier at a precise time by email.\n\n*Drop off: After the tour, our vehicle will drop off the passengers in your Hotel in Jeddah\n\nNot wheelchair accessible\n\nPlease bring your ticket with you to the attraction.\n\nBe aware that operators may cancel for unforeseen reasons.\n\nYou need to be 18 years or older to book. Children must be accompanied by an adult.	t	30.60	USD	{"Driver Assistance English or Arabic","Entrance fees.","Pick up from your Hotel in Jeddah."}	5	2026-01-13 07:48:36.416345+00	2026-01-13 07:48:36.416345+00	{https://r-xx.bstatic.com/xdata/images/xphoto/300x320/144286898.jpg?k=803adae978d8d6fb3c7c4bf6b469d1af86e9e59f5a69f8fed30fe0dc63425a70&o=,https://r-xx.bstatic.com/xdata/images/xphoto/300x320/144286906.jpg?k=d812bdf11de047b94e6b1ff21b13d6e4d9d6ff234767b7a5226c60c5dd4afa8f&o=,https://q-xx.bstatic.com/xdata/images/xphoto/300x320/144286914.jpg?k=5f9ce0d615f270963108ab5109036531f355d0f95aea05b47a56c9edfb654241&o=,https://q-xx.bstatic.com/xdata/images/xphoto/300x320/144286924.jpg?k=80ecb99cdb13e6b333fc3ca1dbbd280bf2bdf07a19ce54b94807b7279f211a9a&o=,https://q-xx.bstatic.com/xdata/images/xphoto/300x320/144286931.jpg?k=21555161627aea89418d53e3bd7554d9f732dfc9696cbd880416fc50d282f558&o=,https://r-xx.bstatic.com/xdata/images/xphoto/300x320/144286938.jpg?k=392bac307765ddeaec5990016a74453d7f299536176c52819e350b5b1068f76d&o=,https://r-xx.bstatic.com/xdata/images/xphoto/300x320/144286946.jpg?k=371998da80a745705fc1466f4594552885df1f69633ff39b1a6710302a48fc2d&o=,https://q-xx.bstatic.com/xdata/images/xphoto/300x320/144286951.jpg?k=aec416b88f23cc48f5bd5fc5170376bd221aa074a609b7c8ea626831288dd75c&o=,https://q-xx.bstatic.com/xdata/images/xphoto/300x320/144286958.jpg?k=11d2d19cd008b0e8fe2c69d30232508dc15f4b74521852f622cc4b8245670cb6&o=}
7	Historical Jeddah Tour	prjk539gaiqm-historical-jeddah-tour	Wheelchair accessible\n\nInfants and small children can ride in a pram or stroller\n\nService animals allowed\n\nPublic transportation options are available nearby\n\nTransportation options are wheelchair accessible\n\nTravelers should have at least a moderate level of physical fitness\n\nTotal tour duration includes travel time\n\nPlease bring your ticket with you to the attraction.\n\nBe aware that operators may cancel for unforeseen reasons.\n\nYou need to be 18 years or older to book. Children must be accompanied by an adult.	t	215.00	USD	{"Free WiFi","Bottled water","Museums Entry fees"}	5	2026-01-13 07:48:40.953742+00	2026-01-13 07:48:40.953742+00	{https://r-xx.bstatic.com/xdata/images/xphoto/300x320/339776587.jpg?k=bb1d984db3390eb0b5b0ef30979b6b1c502a8558beeb4b4ec1ca849603e467c0&o=,https://q-xx.bstatic.com/xdata/images/xphoto/300x320/339776660.jpg?k=f11bd2ae0bf26975b64007940e43dd56067c312b583d9dac7daa12fc1d6b47ad&o=,https://r-xx.bstatic.com/xdata/images/xphoto/300x320/339776730.jpg?k=b4ef0d881d3397f15ff8e250a0e15bc3a28f0de17abcef3251121b929b7bc7cc&o=,https://r-xx.bstatic.com/xdata/images/xphoto/300x320/339776787.jpg?k=39bc4d3190c24e43258bd35b5c8ed4c55a06f7b4a31c7bc1850eb77b2ffe421e&o=,https://q-xx.bstatic.com/xdata/images/xphoto/300x320/339776837.jpg?k=045bfca871e7212e2d37a3d015af3c85c561d17575749adb55b02f4b2c1761dd&o=,https://r-xx.bstatic.com/xdata/images/xphoto/300x320/339776904.jpg?k=1ac17aaf4ab234a8e207d104812ea26104565d47249d08136564bc195197abc3&o=,https://r-xx.bstatic.com/xdata/images/xphoto/300x320/339776973.jpg?k=c1553d38467eef7d7b85a54888f0f3930e3b6534356eb6bbcbdd9e7061f3b82e&o=,https://q-xx.bstatic.com/xdata/images/xphoto/300x320/339777040.jpg?k=1ad09e17963ded0fc1eab8dda8fc7339e43cd15b457285406f9894b40fdb7943&o=,https://r-xx.bstatic.com/xdata/images/xphoto/300x320/339777105.jpg?k=22d9f965caf625aace0a579a06ccbab5dfc11a203ff7f72997d0a2a853920da4&o=}
6	Jeddah city tour and old Jeddah Albalad	pr0tqdokrd3h-jeddah-city-tour-and-old-jeddah-albalad	Infants and small children can ride in a pram or stroller\n\nPublic transportation options are available nearby\n\nSuitable for all physical fitness levels\n\n\n\nCall me or send me your location through whatapp or email\n\nNot wheelchair accessible\n\nPlease bring your ticket with you to the attraction.\n\nBe aware that operators may cancel for unforeseen reasons.\n\nYou need to be 18 years or older to book. Children must be accompanied by an adult.	t	300.00	USD	{"Bottled water","Entrance fee","Air-conditioned vehicle","Coffee and/or Tea","Parking Fees"}	5	2026-01-13 07:48:39.712119+00	2026-01-13 07:48:39.712119+00	{https://r-xx.bstatic.com/xdata/images/xphoto/300x320/536368077.jpg?k=69f07c42e786f5428a2989f567f649811afc8a51fe5adb09f77ebe7497806c99&o=,https://q-xx.bstatic.com/xdata/images/xphoto/300x320/536368160.jpg?k=d1ad2af1c671fbe67ae6cb61ac05ba2cc3ea7969c70660d46f55b6ca085406ff&o=,https://r-xx.bstatic.com/xdata/images/xphoto/300x320/536368220.jpg?k=ee74483095fe4b431a1a7f02571c865f3d08262679469f59defbe9ae6f4183c4&o=,https://q-xx.bstatic.com/xdata/images/xphoto/300x320/536368288.jpg?k=778e9fd98cc12efaf5df207c6e15f42801d207ab59e75b8859afc343494fec22&o=,https://q-xx.bstatic.com/xdata/images/xphoto/300x320/536368349.jpg?k=76c56246aca9805b656226bd5aa072ab8e30e56b6ad3cac8ff43cdf0e2d3f63a&o=,https://q-xx.bstatic.com/xdata/images/xphoto/300x320/536368416.jpg?k=b0bc84c11900e6452f3a94d674b5b5fd2512ba246babfe47d4670430759f8d44&o=,https://r-xx.bstatic.com/xdata/images/xphoto/300x320/536368482.jpg?k=b04c3f48521e7daaffb83840ac5b3ec5e5d732a67b653f557985e3e9e5bd8a7d&o=,https://q-xx.bstatic.com/xdata/images/xphoto/300x320/536368543.jpg?k=26185a280c7c945f1f6c381a77f895b40cc40be32e4f59eb6384178d003250cd&o=}
4	From Jeddah Airport To Jeddah Hotels Or Return	prhjyxd7tlzd-from-jeddah-airport-to-jeddah-hotels-or-return	Infants are required to sit on an adult’s lap\n\nPublic transportation options are available nearby\n\nSuitable for all physical fitness levels\n\n• Post the free waiting time specified, additional waiting time is chargeable at the driver's discretion and is payable by the traveler.\n\n• Our driver will wait for you for 1 (one) hour after your plane has landed. If you have correctly indicated your flight number, it will be monitored and our driver will wait for y\n\nWe pickup all travelers from airports or hotels in Jeddah and maintain communication throughout the process. \nWe provide comprehensive details, including the driver's phone number, a photo of the vehicle, and all relevant information.\n\nNot wheelchair accessible\n\nPlease bring your ticket with you to the attraction.\n\nBe aware that operators may cancel for unforeseen reasons.\n\nYou need to be 18 years or older to book.	t	65.00	USD	{"Private transportation","Bottled water","Air-conditioned vehicle","Fuel surcharge"}	5	2026-01-13 07:48:37.410363+00	2026-01-13 07:48:37.410363+00	{https://q-xx.bstatic.com/xdata/images/xphoto/300x320/409188862.jpg?k=22625ad3ab9d78b897a72cec5f61fc19e1d4209277afb8e56b824e64c2c6bb23&o=,https://r-xx.bstatic.com/xdata/images/xphoto/300x320/409188924.jpg?k=6e443db0dac518aedce8d8719f31db023e00b58ddb703f27a39ed33a0b7ee004&o=,https://q-xx.bstatic.com/xdata/images/xphoto/300x320/409188953.jpg?k=a2d23abdee861db5f7a24c1fd2587faf8d757d4715f630303bb54cc9a1c197c2&o=,https://q-xx.bstatic.com/xdata/images/xphoto/300x320/409188974.jpg?k=d13c1a28eafac12b8a7af6282fd087478942fca4732523db7ee11499d3e69bf6&o=,https://r-xx.bstatic.com/xdata/images/xphoto/300x320/409188996.jpg?k=ce1375cf9df06b6cfd9918798257be3aedef163cca4984e9ce34a3a5c11ba64b&o=,https://r-xx.bstatic.com/xdata/images/xphoto/300x320/409189020.jpg?k=de911a98d4e634b0635f7298f898fdb8726adb78fad2614be96f8b9934b93dd6&o=}
8	Introduction to Auckland Wine History	pr0aogcrxxng-introduction-to-auckland-wine-history	Travelers should have at least a moderate level of physical fitness\n\nGuests must be over 18 unless by arrangement\n\nNot wheelchair accessible\n\nPlease bring your ticket with you to the attraction.\n\nBe aware that operators may cancel for unforeseen reasons.\n\nYou need to be 18 years or older to book.	f	249.61	USD	{"We sample a number of locally made artisan products","All wine, beer and spirit tasting included","Our Kiwi BBQ is an absolute winner on this tour"}	6	2026-01-13 07:48:42.23307+00	2026-01-13 07:48:42.23307+00	{https://r-xx.bstatic.com/xdata/images/xphoto/300x320/593722927.jpg?k=0b44fda666f2a64879358ccccf666b818953c6c92dd7f90111362598e5e041f4&o=,https://r-xx.bstatic.com/xdata/images/xphoto/300x320/593722935.jpg?k=d8369b40a94bf659413a02871a1f364e6709b30881fe73c3b5243c5a993515d4&o=,https://r-xx.bstatic.com/xdata/images/xphoto/300x320/593722942.jpg?k=c4b32dd5163c2cfcac5496615989f5491f953707de982c63a3d01c1668c80ca5&o=,https://q-xx.bstatic.com/xdata/images/xphoto/300x320/593722950.jpg?k=9e8f2482f359456a6eb16b38c1073c332cf852a1c121086d6ad40e8377fe6545&o=,https://q-xx.bstatic.com/xdata/images/xphoto/300x320/593722958.jpg?k=01504701e920517951a4a573989703fb585ecd342bad7985241d065a108f39fc&o=,https://q-xx.bstatic.com/xdata/images/xphoto/300x320/593722969.jpg?k=019d67970f0fa924280399d57aff0c8dda6b3906415d888365a917f1c8b656f7&o=}
\.


--
-- Data for Name: flights; Type: TABLE DATA; Schema: public; Owner: raihanuddin
--

COPY public.flights (id, flight_name, flight_logo, fare, departure_time, arrival_time, departure_airport, arrival_airport, location_id, created_at, updated_at) FROM stdin;
8	Fly Dubai	https://r-xx.bstatic.com/data/airlines_logo/FZ.png	1359.00	2026-01-13 18:10:00+00	2026-01-13 22:00:00+00	King Abdulaziz International Airport	Auckland Airport	5	2026-01-13 09:10:38.352215+00	2026-01-13 09:10:38.352215+00
9	Saudi Arabian Airlines	https://r-xx.bstatic.com/data/airlines_logo/SV.png	1492.00	2026-01-13 17:45:00+00	2026-01-13 21:30:00+00	King Abdulaziz International Airport	Auckland Airport	5	2026-01-13 09:10:43.45453+00	2026-01-13 09:10:43.45453+00
10	Scoot	https://r-xx.bstatic.com/data/airlines_logo/TR.png	1082.00	2026-01-13 22:45:00+00	2026-01-14 12:55:00+00	King Abdulaziz International Airport	Auckland Airport	5	2026-01-13 09:10:52.414533+00	2026-01-13 09:10:52.414533+00
11	Airasiax SDN BHD	https://r-xx.bstatic.com/data/airlines_logo/D7.png	1107.00	2026-01-13 21:45:00+00	2026-01-14 11:40:00+00	King Abdulaziz International Airport	Auckland Airport	5	2026-01-13 09:11:05.279877+00	2026-01-13 09:11:05.279877+00
12	China Southern Airlines	https://r-xx.bstatic.com/data/airlines_logo/CZ.png	1606.00	2026-01-14 22:10:00+00	2026-01-15 05:00:00+00	Auckland Airport	King Abdulaziz International Airport	6	2026-01-13 09:15:58.32656+00	2026-01-13 09:15:58.32656+00
13	Qatar Airways	https://r-xx.bstatic.com/data/airlines_logo/QR.png	1387.00	2026-01-14 23:45:00+00	2026-01-15 06:55:00+00	Auckland Airport	King Abdulaziz International Airport	6	2026-01-13 09:30:10.206415+00	2026-01-13 09:30:10.206415+00
\.


--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: raihanuddin
--

COPY public.locations (id, cityname, countrycode, created_at, updated_at) FROM stdin;
5	jeddah	sa	2026-01-13 07:48:36.416345+00	2026-01-13 07:48:36.416345+00
6	auckland	nz	2026-01-13 07:48:42.23307+00	2026-01-13 07:48:42.23307+00
\.


--
-- Data for Name: pgmigrations; Type: TABLE DATA; Schema: public; Owner: raihanuddin
--

COPY public.pgmigrations (id, name, run_on) FROM stdin;
1	1768289660618_create-table-location	2026-01-13 07:35:05.040964
2	1768289723129_add-index-cityname	2026-01-13 07:35:34.378761
3	1768289747541_create-table-flights	2026-01-13 07:35:57.557275
4	1768289764919_create-table-attractions	2026-01-13 07:36:14.233614
\.


--
-- Name: attractions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raihanuddin
--

SELECT pg_catalog.setval('public.attractions_id_seq', 8, true);


--
-- Name: flights_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raihanuddin
--

SELECT pg_catalog.setval('public.flights_id_seq', 13, true);


--
-- Name: locations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raihanuddin
--

SELECT pg_catalog.setval('public.locations_id_seq', 6, true);


--
-- Name: pgmigrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: raihanuddin
--

SELECT pg_catalog.setval('public.pgmigrations_id_seq', 4, true);


--
-- Name: attractions attractions_pkey; Type: CONSTRAINT; Schema: public; Owner: raihanuddin
--

ALTER TABLE ONLY public.attractions
    ADD CONSTRAINT attractions_pkey PRIMARY KEY (id);


--
-- Name: attractions attractions_slug_key; Type: CONSTRAINT; Schema: public; Owner: raihanuddin
--

ALTER TABLE ONLY public.attractions
    ADD CONSTRAINT attractions_slug_key UNIQUE (slug);


--
-- Name: flights flights_pkey; Type: CONSTRAINT; Schema: public; Owner: raihanuddin
--

ALTER TABLE ONLY public.flights
    ADD CONSTRAINT flights_pkey PRIMARY KEY (id);


--
-- Name: locations locations_cityname_key; Type: CONSTRAINT; Schema: public; Owner: raihanuddin
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_cityname_key UNIQUE (cityname);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: raihanuddin
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: pgmigrations pgmigrations_pkey; Type: CONSTRAINT; Schema: public; Owner: raihanuddin
--

ALTER TABLE ONLY public.pgmigrations
    ADD CONSTRAINT pgmigrations_pkey PRIMARY KEY (id);


--
-- Name: unique_location_city; Type: INDEX; Schema: public; Owner: raihanuddin
--

CREATE UNIQUE INDEX unique_location_city ON public.locations USING btree (cityname);


--
-- Name: attractions attractions_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: raihanuddin
--

ALTER TABLE ONLY public.attractions
    ADD CONSTRAINT attractions_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id) ON DELETE CASCADE;


--
-- Name: flights flights_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: raihanuddin
--

ALTER TABLE ONLY public.flights
    ADD CONSTRAINT flights_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict bTpaDisETu7CQOzV4tAHz9drRdc2UUIi6ulj5oW4lBURiPPeQzZc6vxo1quowxG

