--
-- PostgreSQL database dump
--

\restrict gx1I5ResLZh9gpHC8Iwx5CAIACfajtCQFb6ryoolr3EMaQNhnSlHBSvl2eWboIY

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.0

-- Started on 2026-01-15 01:37:31

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 229 (class 1259 OID 32971)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    client uuid NOT NULL,
    create_at date NOT NULL,
    discount_percentage numeric(5,2) CONSTRAINT orders_discount_not_null NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 32970)
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO postgres;

--
-- TOC entry 5032 (class 0 OID 0)
-- Dependencies: 228
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- TOC entry 4876 (class 2604 OID 32974)
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- TOC entry 4877 (class 2606 OID 32981)
-- Name: orders check_discount_percentage; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.orders
    ADD CONSTRAINT check_discount_percentage CHECK (((discount_percentage >= (0)::numeric) AND (discount_percentage <= (100)::numeric))) NOT VALID;


--
-- TOC entry 4879 (class 2606 OID 32980)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


-- Completed on 2026-01-15 01:37:32

--
-- PostgreSQL database dump complete
--

\unrestrict gx1I5ResLZh9gpHC8Iwx5CAIACfajtCQFb6ryoolr3EMaQNhnSlHBSvl2eWboIY

