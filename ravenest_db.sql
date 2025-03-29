--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: forum_comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.forum_comments (
    id integer NOT NULL,
    content text NOT NULL,
    "userId" integer,
    "topicId" integer,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: forum_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.forum_comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: forum_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.forum_comments_id_seq OWNED BY public.forum_comments.id;


--
-- Name: forum_replies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.forum_replies (
    id integer NOT NULL,
    content text NOT NULL,
    "topicId" integer,
    "authorId" integer,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: forum_replies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.forum_replies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: forum_replies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.forum_replies_id_seq OWNED BY public.forum_replies.id;


--
-- Name: forum_topics; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.forum_topics (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    content text NOT NULL,
    category character varying(255) DEFAULT 'General Discussion'::character varying NOT NULL,
    "authorId" integer,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: forum_topics_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.forum_topics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: forum_topics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.forum_topics_id_seq OWNED BY public.forum_topics.id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reviews (
    id integer NOT NULL,
    mentor_id integer,
    mentee_id integer,
    rating integer NOT NULL,
    comment text,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sessions (
    id integer NOT NULL,
    "mentorId" integer,
    "menteeId" integer,
    status character varying(50) NOT NULL,
    "startTime" timestamp with time zone,
    "endTime" timestamp with time zone,
    notes text,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sessions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sessions_id_seq OWNED BY public.sessions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    skills jsonb DEFAULT '[]'::jsonb,
    role character varying(50) NOT NULL,
    rating double precision DEFAULT 0,
    "profilePicture" character varying(255),
    bio text,
    availability jsonb DEFAULT '[]'::jsonb,
    location character varying(255),
    linkedin character varying(255),
    github character varying(255),
    twitter character varying(255),
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: forum_comments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.forum_comments ALTER COLUMN id SET DEFAULT nextval('public.forum_comments_id_seq'::regclass);


--
-- Name: forum_replies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.forum_replies ALTER COLUMN id SET DEFAULT nextval('public.forum_replies_id_seq'::regclass);


--
-- Name: forum_topics id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.forum_topics ALTER COLUMN id SET DEFAULT nextval('public.forum_topics_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Name: sessions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: forum_comments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.forum_comments (id, content, "userId", "topicId", "createdAt", "updatedAt") FROM stdin;
1	Helo	2	3	2025-03-24 03:21:05.578+05	2025-03-24 03:21:05.578+05
2	Hi	2	3	2025-03-24 03:21:30.981+05	2025-03-24 03:21:30.981+05
3	Lol123	2	8	2025-03-24 03:31:14.302+05	2025-03-24 03:31:14.302+05
\.


--
-- Data for Name: forum_replies; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.forum_replies (id, content, "topicId", "authorId", "createdAt", "updatedAt") FROM stdin;
1	Great to be here! Looking forward to learning from everyone.	1	8	2025-03-29 18:14:18.795+05	2025-03-29 18:14:18.795+05
2	This community is amazing! I've already learned so much.	1	8	2025-03-29 18:14:18.797+05	2025-03-29 18:14:18.797+05
3	I'm new to coding and this place seems perfect for learning!	1	8	2025-03-29 18:14:18.798+05	2025-03-29 18:14:18.798+05
\.


--
-- Data for Name: forum_topics; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.forum_topics (id, title, content, category, "authorId", "createdAt", "updatedAt") FROM stdin;
1	Welcome to the Community!	This is a place to discuss coding, share experiences, and help each other grow.	General Discussion	8	2025-03-29 18:14:18.713+05	2025-03-29 18:14:18.713+05
2	Best Practices for Code Review	What are your tips for conducting effective code reviews? Share your experiences and learn from others.	Backend Development	8	2025-03-29 18:14:18.713+05	2025-03-29 18:14:18.713+05
3	Learning Resources	Share your favorite coding tutorials, books, and online courses! Let's help each other find the best learning materials.	General Discussion	8	2025-03-29 18:14:18.714+05	2025-03-29 18:14:18.714+05
4	React vs Vue: Which to Choose?	I'm starting a new project and can't decide between React and Vue. What are your thoughts and experiences?	Frontend Development	8	2025-03-29 18:14:18.714+05	2025-03-29 18:14:18.714+05
5	Career Transition Tips	I'm looking to transition into software development from a different field. Any advice or success stories to share?	Career Advice	8	2025-03-29 18:14:18.715+05	2025-03-29 18:14:18.715+05
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.reviews (id, mentor_id, mentee_id, rating, comment, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sessions (id, "mentorId", "menteeId", status, "startTime", "endTime", notes, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, username, email, password, skills, role, rating, "profilePicture", bio, availability, location, linkedin, github, twitter, "createdAt", "updatedAt") FROM stdin;
2	Sarah Chen	sarah.chen@example.com	$2b$10$hii9XgrsGzbAE0C5iGpXruEW1acmxqt58Z85ZFVSEFOzXx4s2KOSO	["Python", "Data Science", "Machine Learning"]	mentor	4.8	https://api.dicebear.com/7.x/avataaars/svg?seed=Sarah	Data scientist with 5+ years of experience in ML and AI. Passionate about teaching and helping others grow in tech.	["Tuesday", "Thursday", "Saturday"]	San Francisco	https://linkedin.com/in/sarahchen	https://github.com/sarahchen	https://twitter.com/sarahchen	2025-03-29 18:14:17.874+05	2025-03-29 18:14:17.874+05
3	Michael Rodriguez	michael.rodriguez@example.com	$2b$10$QzRLFtkTkHfSBkplqxzck.ozSVOyayxBKdP5X30.RuhJzfNm3j0BK	["Java", "Spring Boot", "Microservices"]	mentor	4.6	https://api.dicebear.com/7.x/avataaars/svg?seed=Emma	Senior backend developer specializing in enterprise applications. Expert in Java ecosystem and cloud architecture.	["Monday", "Wednesday", "Friday"]	Austin	https://linkedin.com/in/michaelrodriguez	https://github.com/michaelrodriguez	https://twitter.com/michaelrodriguez	2025-03-29 18:14:18.016+05	2025-03-29 18:14:18.016+05
4	Emma Thompson	emma.thompson@example.com	$2b$10$8v1t8diJiRUHBvU6ZtGFMeghTkTxN/DeRpdvlF0qoh6EOYkVnZHKe	["UI/UX Design", "Figma", "Adobe XD"]	mentor	4.9	https://api.dicebear.com/7.x/avataaars/svg?seed=Michael	UI/UX designer with a focus on creating beautiful and intuitive user experiences. Former design lead at Google.	["Monday", "Tuesday", "Thursday"]	Seattle	https://linkedin.com/in/emmathompson	https://github.com/emmathompson	https://twitter.com/emmathompson	2025-03-29 18:14:18.149+05	2025-03-29 18:14:18.149+05
5	David Kim	david.kim@example.com	$2b$10$km7pZPAt6FfpXpCTA9KZlumHklIvI9Fxpwo.T4JxLQlc2KmeBk5WW	["React Native", "iOS", "Android"]	mentor	4.7	https://api.dicebear.com/7.x/avataaars/svg?seed=Lisa	Mobile app developer with expertise in cross-platform development. Created multiple successful apps on both App Store and Play Store.	["Wednesday", "Friday", "Saturday"]	Los Angeles	https://linkedin.com/in/davidkim	https://github.com/davidkim	https://twitter.com/davidkim	2025-03-29 18:14:18.284+05	2025-03-29 18:14:18.284+05
6	Lisa Patel	lisa.patel@example.com	$2b$10$4fzsI4MFHlAZUPloKDHfvOdRHFekuIVLa4.71p3jKMq/B1jPAXL0K	["DevOps", "AWS", "Docker"]	mentor	4.5	https://api.dicebear.com/7.x/avataaars/svg?seed=David	DevOps engineer with extensive experience in cloud infrastructure and CI/CD pipelines. Certified AWS Solutions Architect.	["Tuesday", "Thursday", "Friday"]	Boston	https://linkedin.com/in/lisapatel	https://github.com/lisapatel	https://twitter.com/lisapatel	2025-03-29 18:14:18.413+05	2025-03-29 18:14:18.413+05
7	James Wilson	james.wilson@example.com	$2b$10$II6tEhQYifeUOS.pZeM6oe5h5sCeRDkV/e8abMyrP1WX15DVT6mzS	["Full Stack", "React", "Node.js"]	mentor	4.8	https://api.dicebear.com/7.x/avataaars/svg?seed=James	Full-stack developer with expertise in modern web technologies. Built scalable applications for startups and enterprises.	["Monday", "Wednesday", "Friday"]	Chicago	https://linkedin.com/in/jameswilson	https://github.com/jameswilson	https://twitter.com/jameswilson	2025-03-29 18:14:18.534+05	2025-03-29 18:14:18.534+05
8	John Doe	john@example.com	$2b$10$0wDdUnHsAQ4Lu7RE0jg4QuTjmjWMMzseAfkwCeMo/85IPcrF/tLue	["JavaScript", "React", "Node.js"]	mentor	4.5	https://api.dicebear.com/7.x/avataaars/svg?seed=john	Experienced software developer and mentor	["Monday", "Wednesday", "Friday"]	New York	https://linkedin.com/in/johndoe	https://github.com/johndoe	https://twitter.com/johndoe	2025-03-29 18:14:18.696+05	2025-03-29 18:14:18.696+05
9	umar4	umar4@gmail.com	$2b$10$6Tg3CFkD8gQskEl3QvZY.epV6JipWLZR4pZeUFePKOwFoLBjPtvSa	[]	mentor	0	\N	\N	[]	\N	\N	\N	\N	2025-03-29 18:16:50.977+05	2025-03-29 18:16:50.977+05
\.


--
-- Name: forum_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.forum_comments_id_seq', 3, true);


--
-- Name: forum_replies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.forum_replies_id_seq', 3, true);


--
-- Name: forum_topics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.forum_topics_id_seq', 5, true);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.reviews_id_seq', 1, false);


--
-- Name: sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sessions_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 9, true);


--
-- Name: forum_comments forum_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.forum_comments
    ADD CONSTRAINT forum_comments_pkey PRIMARY KEY (id);


--
-- Name: forum_replies forum_replies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.forum_replies
    ADD CONSTRAINT forum_replies_pkey PRIMARY KEY (id);


--
-- Name: forum_topics forum_topics_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.forum_topics
    ADD CONSTRAINT forum_topics_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: forum_replies forum_replies_authorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.forum_replies
    ADD CONSTRAINT "forum_replies_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES public.users(id);


--
-- Name: forum_replies forum_replies_topicId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.forum_replies
    ADD CONSTRAINT "forum_replies_topicId_fkey" FOREIGN KEY ("topicId") REFERENCES public.forum_topics(id);


--
-- Name: forum_topics forum_topics_authorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.forum_topics
    ADD CONSTRAINT "forum_topics_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES public.users(id);


--
-- Name: reviews reviews_mentee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_mentee_id_fkey FOREIGN KEY (mentee_id) REFERENCES public.users(id);


--
-- Name: reviews reviews_mentor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_mentor_id_fkey FOREIGN KEY (mentor_id) REFERENCES public.users(id);


--
-- Name: sessions sessions_menteeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT "sessions_menteeId_fkey" FOREIGN KEY ("menteeId") REFERENCES public.users(id);


--
-- Name: sessions sessions_mentorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT "sessions_mentorId_fkey" FOREIGN KEY ("mentorId") REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

