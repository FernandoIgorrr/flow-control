--
-- PostgreSQL database dump
--

\restrict kPNPJtMxubTBTzLf2pbJcFXwUVXlX2UudGk43qkm8ElGqmoXxqJubNaB493Clnh

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.0

-- Started on 2026-01-15 01:03:26

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
-- TOC entry 221 (class 1259 OID 24610)
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    product_id smallint CONSTRAINT "Product_product_id_not_null" NOT NULL,
    product_name text CONSTRAINT "Product_product_name_not_null" NOT NULL,
    product_description text CONSTRAINT "Product_product_description_not_null" NOT NULL,
    product_measurement_unit smallint
);


ALTER TABLE public.product OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 24609)
-- Name: Product_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Product_product_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Product_product_id_seq" OWNER TO postgres;

--
-- TOC entry 5084 (class 0 OID 0)
-- Dependencies: 220
-- Name: Product_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Product_product_id_seq" OWNED BY public.product.product_id;


--
-- TOC entry 227 (class 1259 OID 32772)
-- Name: city; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.city (
    city_id smallint NOT NULL,
    city_name text NOT NULL
);


ALTER TABLE public.city OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 32771)
-- Name: city_city_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.city_city_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.city_city_id_seq OWNER TO postgres;

--
-- TOC entry 5085 (class 0 OID 0)
-- Dependencies: 226
-- Name: city_city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.city_city_id_seq OWNED BY public.city.city_id;


--
-- TOC entry 232 (class 1259 OID 32850)
-- Name: partner; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.partner (
    partner_id uuid NOT NULL,
    partner_name text NOT NULL,
    partner_telephone text,
    partner_city smallint NOT NULL,
    partner_type text NOT NULL
);


ALTER TABLE public.partner OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 32862)
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    NOT NULL partner_id
)
INHERITS (public.partner);


ALTER TABLE public.client OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 24582)
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE public.flyway_schema_history OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 32818)
-- Name: measurement_unit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.measurement_unit (
    measurement_unit_id smallint CONSTRAINT unit_unit_id_not_null NOT NULL,
    measurement_unit_name text CONSTRAINT unit_unit_name_not_null NOT NULL,
    measurement_unit_symbol text CONSTRAINT unit_unit_symbol_not_null NOT NULL
);


ALTER TABLE public.measurement_unit OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24645)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    order_id integer CONSTRAINT order_order_id_not_null NOT NULL,
    client_id uuid CONSTRAINT order_client_id_not_null NOT NULL,
    created_at date CONSTRAINT order_created_at_not_null NOT NULL,
    total_amount numeric(32,2) CONSTRAINT order_total_amount_not_null NOT NULL,
    discount smallint
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 24644)
-- Name: order_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_order_id_seq OWNER TO postgres;

--
-- TOC entry 5086 (class 0 OID 0)
-- Dependencies: 222
-- Name: order_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_order_id_seq OWNED BY public.orders.order_id;


--
-- TOC entry 225 (class 1259 OID 24716)
-- Name: order_products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_products (
    order_products_id integer NOT NULL,
    order_id integer NOT NULL,
    product_id smallint NOT NULL,
    product_quantity numeric(38,3) NOT NULL,
    unit_price numeric(38,2) NOT NULL
);


ALTER TABLE public.order_products OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 24715)
-- Name: order_products_order_products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_products_order_products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_products_order_products_id_seq OWNER TO postgres;

--
-- TOC entry 5087 (class 0 OID 0)
-- Dependencies: 224
-- Name: order_products_order_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_products_order_products_id_seq OWNED BY public.order_products.order_products_id;


--
-- TOC entry 229 (class 1259 OID 32806)
-- Name: raw_material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.raw_material (
    raw_material_id smallint NOT NULL,
    raw_materia_name text NOT NULL,
    raw_material_description text NOT NULL
);


ALTER TABLE public.raw_material OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 32805)
-- Name: raw_material_raw_material_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.raw_material_raw_material_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.raw_material_raw_material_id_seq OWNER TO postgres;

--
-- TOC entry 5088 (class 0 OID 0)
-- Dependencies: 228
-- Name: raw_material_raw_material_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.raw_material_raw_material_id_seq OWNED BY public.raw_material.raw_material_id;


--
-- TOC entry 234 (class 1259 OID 32874)
-- Name: supplier; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.supplier (
)
INHERITS (public.partner);


ALTER TABLE public.supplier OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 32817)
-- Name: unit_unit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.unit_unit_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.unit_unit_id_seq OWNER TO postgres;

--
-- TOC entry 5089 (class 0 OID 0)
-- Dependencies: 230
-- Name: unit_unit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.unit_unit_id_seq OWNED BY public.measurement_unit.measurement_unit_id;


--
-- TOC entry 4901 (class 2604 OID 32775)
-- Name: city city_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city ALTER COLUMN city_id SET DEFAULT nextval('public.city_city_id_seq'::regclass);


--
-- TOC entry 4903 (class 2604 OID 32821)
-- Name: measurement_unit measurement_unit_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measurement_unit ALTER COLUMN measurement_unit_id SET DEFAULT nextval('public.unit_unit_id_seq'::regclass);


--
-- TOC entry 4900 (class 2604 OID 24719)
-- Name: order_products order_products_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_products ALTER COLUMN order_products_id SET DEFAULT nextval('public.order_products_order_products_id_seq'::regclass);


--
-- TOC entry 4899 (class 2604 OID 24648)
-- Name: orders order_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.order_order_id_seq'::regclass);


--
-- TOC entry 4898 (class 2604 OID 24686)
-- Name: product product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product ALTER COLUMN product_id SET DEFAULT nextval('public."Product_product_id_seq"'::regclass);


--
-- TOC entry 4902 (class 2604 OID 32809)
-- Name: raw_material raw_material_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.raw_material ALTER COLUMN raw_material_id SET DEFAULT nextval('public.raw_material_raw_material_id_seq'::regclass);


--
-- TOC entry 4908 (class 2606 OID 24688)
-- Name: product Product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT "Product_pkey" PRIMARY KEY (product_id);


--
-- TOC entry 4918 (class 2606 OID 32781)
-- Name: city city_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (city_id);


--
-- TOC entry 4927 (class 2606 OID 32873)
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (partner_id);


--
-- TOC entry 4905 (class 2606 OID 24597)
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- TOC entry 4912 (class 2606 OID 24654)
-- Name: orders order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT order_pkey PRIMARY KEY (order_id);


--
-- TOC entry 4916 (class 2606 OID 24727)
-- Name: order_products order_products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_products
    ADD CONSTRAINT order_products_pkey PRIMARY KEY (order_products_id);


--
-- TOC entry 4925 (class 2606 OID 32861)
-- Name: partner partner_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partner
    ADD CONSTRAINT partner_pkey PRIMARY KEY (partner_id);


--
-- TOC entry 4920 (class 2606 OID 32816)
-- Name: raw_material raw_material_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.raw_material
    ADD CONSTRAINT raw_material_pkey PRIMARY KEY (raw_material_id);


--
-- TOC entry 4922 (class 2606 OID 32828)
-- Name: measurement_unit unit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measurement_unit
    ADD CONSTRAINT unit_pkey PRIMARY KEY (measurement_unit_id);


--
-- TOC entry 4923 (class 1259 OID 32888)
-- Name: fki_city_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_city_fkey ON public.partner USING btree (partner_city);


--
-- TOC entry 4910 (class 1259 OID 24660)
-- Name: fki_client_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_client_fkey ON public.orders USING btree (client_id);


--
-- TOC entry 4913 (class 1259 OID 24733)
-- Name: fki_order_id_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_order_id_fkey ON public.order_products USING btree (order_id);


--
-- TOC entry 4914 (class 1259 OID 24740)
-- Name: fki_product_id_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_product_id_fkey ON public.order_products USING btree (product_id);


--
-- TOC entry 4909 (class 1259 OID 32849)
-- Name: fki_product_measurement_unit_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_product_measurement_unit_fkey ON public.product USING btree (product_measurement_unit);


--
-- TOC entry 4906 (class 1259 OID 24598)
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- TOC entry 4931 (class 2606 OID 32883)
-- Name: partner city_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partner
    ADD CONSTRAINT city_fkey FOREIGN KEY (partner_city) REFERENCES public.city(city_id) NOT VALID;


--
-- TOC entry 4929 (class 2606 OID 24728)
-- Name: order_products order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_products
    ADD CONSTRAINT order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id) NOT VALID;


--
-- TOC entry 4930 (class 2606 OID 24735)
-- Name: order_products product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_products
    ADD CONSTRAINT product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id) NOT VALID;


--
-- TOC entry 4928 (class 2606 OID 32844)
-- Name: product product_measurement_unit_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_measurement_unit_fkey FOREIGN KEY (product_measurement_unit) REFERENCES public.measurement_unit(measurement_unit_id) NOT VALID;


-- Completed on 2026-01-15 01:03:27

--
-- PostgreSQL database dump complete
--

\unrestrict kPNPJtMxubTBTzLf2pbJcFXwUVXlX2UudGk43qkm8ElGqmoXxqJubNaB493Clnh

