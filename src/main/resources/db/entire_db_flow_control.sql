--
-- PostgreSQL database dump
--

\restrict LfLdy8PvjJZWo2k3w8KbaTdKqiddrwxxgt8UDaSMxY9hIJPzhWg6fM5zpcJ0Hu2

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.0

-- Started on 2026-01-21 17:21:23

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
-- TOC entry 222 (class 1259 OID 33113)
-- Name: city; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.city (
    id smallint NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.city OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 33112)
-- Name: city_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.city_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.city_id_seq OWNER TO postgres;

--
-- TOC entry 5141 (class 0 OID 0)
-- Dependencies: 221
-- Name: city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.city_id_seq OWNED BY public.city.id;


--
-- TOC entry 227 (class 1259 OID 33258)
-- Name: company_partner; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.company_partner (
    id uuid NOT NULL,
    cnpj character varying(14)
);


ALTER TABLE public.company_partner OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 33237)
-- Name: partner; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.partner (
    id uuid NOT NULL,
    name text NOT NULL,
    email text,
    phone text,
    city_id smallint CONSTRAINT partner_city_not_null NOT NULL,
    role_id smallint CONSTRAINT partner_category_not_null NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.partner OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 33250)
-- Name: personal_partner; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personal_partner (
    id uuid NOT NULL,
    cpf character varying(11)
);


ALTER TABLE public.personal_partner OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 33312)
-- Name: client_full; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.client_full AS
 SELECT p.id,
    p.name,
    pp.cpf,
    cp.cnpj,
    p.phone,
    p.email,
    c.name AS city,
        CASE
            WHEN (pp.id IS NOT NULL) THEN 'p'::text
            WHEN (cp.id IS NOT NULL) THEN 'c'::text
            ELSE 'u'::text
        END AS category
   FROM (((public.partner p
     LEFT JOIN public.personal_partner pp ON ((pp.id = p.id)))
     LEFT JOIN public.company_partner cp ON ((cp.id = p.id)))
     JOIN public.city c ON ((p.city_id = c.id)))
  WHERE ((p.role_id = 1) AND (p.deleted_at IS NULL));


ALTER VIEW public.client_full OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 41685)
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee (
    id uuid NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 41668)
-- Name: employee_wage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee_wage (
    id integer NOT NULL,
    wage numeric(38,2) NOT NULL,
    wage_change_date timestamp with time zone NOT NULL,
    employee_id uuid NOT NULL
);


ALTER TABLE public.employee_wage OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 41667)
-- Name: employee_wage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employee_wage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employee_wage_id_seq OWNER TO postgres;

--
-- TOC entry 5142 (class 0 OID 0)
-- Dependencies: 229
-- Name: employee_wage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employee_wage_id_seq OWNED BY public.employee_wage.id;


--
-- TOC entry 220 (class 1259 OID 32912)
-- Name: measurement_unit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.measurement_unit (
    id smallint NOT NULL,
    name text NOT NULL,
    plural_name text NOT NULL,
    symbol character varying(2) NOT NULL,
    unit text
);


ALTER TABLE public.measurement_unit OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 32911)
-- Name: measurement_unit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.measurement_unit_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.measurement_unit_id_seq OWNER TO postgres;

--
-- TOC entry 5143 (class 0 OID 0)
-- Dependencies: 219
-- Name: measurement_unit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.measurement_unit_id_seq OWNED BY public.measurement_unit.id;


--
-- TOC entry 224 (class 1259 OID 33135)
-- Name: partner_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.partner_role (
    id smallint NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.partner_role OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 33134)
-- Name: partner_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.partner_role_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.partner_role_id_seq OWNER TO postgres;

--
-- TOC entry 5144 (class 0 OID 0)
-- Dependencies: 223
-- Name: partner_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.partner_role_id_seq OWNED BY public.partner_role.id;


--
-- TOC entry 236 (class 1259 OID 41724)
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    id smallint NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    category_id smallint CONSTRAINT product_category_id_not_null1 NOT NULL,
    measurement_unit_id smallint NOT NULL,
    quantity numeric(10,3) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.product OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 41756)
-- Name: product_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_category (
    id smallint NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.product_category OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 41755)
-- Name: product_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_category_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_category_id_seq OWNER TO postgres;

--
-- TOC entry 5145 (class 0 OID 0)
-- Dependencies: 239
-- Name: product_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_category_id_seq OWNED BY public.product_category.id;


--
-- TOC entry 238 (class 1259 OID 41740)
-- Name: product_price; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_price (
    id integer NOT NULL,
    product_id smallint NOT NULL,
    price numeric(38,2) NOT NULL,
    price_change_date timestamp with time zone NOT NULL
);


ALTER TABLE public.product_price OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 41771)
-- Name: product_full; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.product_full AS
 SELECT p.id,
    p.name,
    p.description,
    pc.name AS category,
    p.quantity,
    mu.unit AS measurement_unit_unit,
    mu.name AS measurement_unit_name,
    mu.plural_name AS measurement_unit_plural_name,
    mu.symbol AS measurement_unit_symbol,
    pp.price AS current_price
   FROM (((public.product p
     JOIN public.measurement_unit mu ON ((p.measurement_unit_id = mu.id)))
     JOIN public.product_category pc ON ((p.category_id = pc.id)))
     LEFT JOIN LATERAL ( SELECT product_price.price
           FROM public.product_price
          WHERE (product_price.product_id = p.id)
          ORDER BY product_price.price_change_date DESC
         LIMIT 1) pp ON (true))
  WHERE (p.deleted_at IS NULL);


ALTER VIEW public.product_full OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 41723)
-- Name: product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_id_seq OWNER TO postgres;

--
-- TOC entry 5146 (class 0 OID 0)
-- Dependencies: 235
-- Name: product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;


--
-- TOC entry 237 (class 1259 OID 41739)
-- Name: product_price_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_price_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_price_id_seq OWNER TO postgres;

--
-- TOC entry 5147 (class 0 OID 0)
-- Dependencies: 237
-- Name: product_price_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_price_id_seq OWNED BY public.product_price.id;


--
-- TOC entry 243 (class 1259 OID 41831)
-- Name: purchase; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchase (
    id integer NOT NULL,
    partner_id uuid NOT NULL,
    raw_material_id smallint NOT NULL,
    quantity numeric(10,3) NOT NULL,
    measurement_unit_id smallint NOT NULL,
    total_price numeric(38,2) CONSTRAINT purchase_price_not_null NOT NULL,
    date date NOT NULL,
    created_at timestamp with time zone CONSTRAINT purchase_create_at_not_null NOT NULL,
    deleted_at timestamp with time zone,
    is_closed boolean DEFAULT false NOT NULL,
    note text
);


ALTER TABLE public.purchase OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 41709)
-- Name: raw_material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.raw_material (
    id smallint NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.raw_material OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 41893)
-- Name: purchase_full; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.purchase_full AS
 SELECT p.id,
    prs.name AS partner_name,
        CASE
            WHEN (pp.id IS NOT NULL) THEN 'p'::text
            WHEN (cp.id IS NOT NULL) THEN 'c'::text
            ELSE 'u'::text
        END AS partner_category,
    rm.name AS raw_material_name,
    rm.description AS raw_material_description,
    p.quantity,
    mu.unit AS measurement_unit_unit,
    mu.name AS measurement_unit_name,
    mu.symbol AS measurement_unit_symbol,
    p.total_price,
    p.date,
    p.note,
    p.created_at,
    p.deleted_at,
    p.is_closed
   FROM (((((public.purchase p
     JOIN public.partner prs ON ((prs.id = p.partner_id)))
     LEFT JOIN public.personal_partner pp ON ((pp.id = p.partner_id)))
     LEFT JOIN public.company_partner cp ON ((cp.id = p.partner_id)))
     JOIN public.raw_material rm ON ((rm.id = p.raw_material_id)))
     JOIN public.measurement_unit mu ON ((mu.id = p.measurement_unit_id)))
  WHERE (p.deleted_at IS NULL);


ALTER VIEW public.purchase_full OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 41830)
-- Name: purchase_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.purchase_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.purchase_id_seq OWNER TO postgres;

--
-- TOC entry 5148 (class 0 OID 0)
-- Dependencies: 242
-- Name: purchase_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.purchase_id_seq OWNED BY public.purchase.id;


--
-- TOC entry 233 (class 1259 OID 41708)
-- Name: raw_material_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.raw_material_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.raw_material_id_seq OWNER TO postgres;

--
-- TOC entry 5149 (class 0 OID 0)
-- Dependencies: 233
-- Name: raw_material_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.raw_material_id_seq OWNED BY public.raw_material.id;


--
-- TOC entry 232 (class 1259 OID 41702)
-- Name: supplier_full; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.supplier_full AS
 SELECT p.id,
    p.name,
    pp.cpf,
    cp.cnpj,
    p.phone,
    p.email,
    c.name AS city,
        CASE
            WHEN (pp.id IS NOT NULL) THEN 'p'::text
            WHEN (cp.id IS NOT NULL) THEN 'c'::text
            ELSE 'u'::text
        END AS category
   FROM (((public.partner p
     LEFT JOIN public.personal_partner pp ON ((pp.id = p.id)))
     LEFT JOIN public.company_partner cp ON ((cp.id = p.id)))
     JOIN public.city c ON ((p.city_id = c.id)))
  WHERE ((p.role_id = 2) AND (p.deleted_at IS NULL));


ALTER VIEW public.supplier_full OWNER TO postgres;

--
-- TOC entry 4929 (class 2604 OID 33116)
-- Name: city id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city ALTER COLUMN id SET DEFAULT nextval('public.city_id_seq'::regclass);


--
-- TOC entry 4932 (class 2604 OID 41671)
-- Name: employee_wage id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_wage ALTER COLUMN id SET DEFAULT nextval('public.employee_wage_id_seq'::regclass);


--
-- TOC entry 4928 (class 2604 OID 32915)
-- Name: measurement_unit id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measurement_unit ALTER COLUMN id SET DEFAULT nextval('public.measurement_unit_id_seq'::regclass);


--
-- TOC entry 4930 (class 2604 OID 33138)
-- Name: partner_role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partner_role ALTER COLUMN id SET DEFAULT nextval('public.partner_role_id_seq'::regclass);


--
-- TOC entry 4934 (class 2604 OID 41727)
-- Name: product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);


--
-- TOC entry 4936 (class 2604 OID 41759)
-- Name: product_category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_category ALTER COLUMN id SET DEFAULT nextval('public.product_category_id_seq'::regclass);


--
-- TOC entry 4935 (class 2604 OID 41743)
-- Name: product_price id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_price ALTER COLUMN id SET DEFAULT nextval('public.product_price_id_seq'::regclass);


--
-- TOC entry 4937 (class 2604 OID 41871)
-- Name: purchase id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase ALTER COLUMN id SET DEFAULT nextval('public.purchase_id_seq'::regclass);


--
-- TOC entry 4933 (class 2604 OID 41712)
-- Name: raw_material id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.raw_material ALTER COLUMN id SET DEFAULT nextval('public.raw_material_id_seq'::regclass);


--
-- TOC entry 4944 (class 2606 OID 33122)
-- Name: city city_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (id);


--
-- TOC entry 4946 (class 2606 OID 33306)
-- Name: city city_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_unique UNIQUE (name);


--
-- TOC entry 4940 (class 2606 OID 33298)
-- Name: company_partner cnpj_format; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.company_partner
    ADD CONSTRAINT cnpj_format CHECK (((cnpj IS NULL) OR ((cnpj)::text ~ '^[0-9]{14}$'::text))) NOT VALID;


--
-- TOC entry 4958 (class 2606 OID 33264)
-- Name: company_partner company_partner_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company_partner
    ADD CONSTRAINT company_partner_pkey PRIMARY KEY (id);


--
-- TOC entry 4939 (class 2606 OID 33295)
-- Name: personal_partner cpf_format; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.personal_partner
    ADD CONSTRAINT cpf_format CHECK (((cpf IS NULL) OR ((cpf)::text ~ '^[0-9]{11}$'::text))) NOT VALID;


--
-- TOC entry 4964 (class 2606 OID 41693)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (id);


--
-- TOC entry 4961 (class 2606 OID 41677)
-- Name: employee_wage employee_wage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_wage
    ADD CONSTRAINT employee_wage_pkey PRIMARY KEY (id);


--
-- TOC entry 4942 (class 2606 OID 32922)
-- Name: measurement_unit measurement_unit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measurement_unit
    ADD CONSTRAINT measurement_unit_pkey PRIMARY KEY (id);


--
-- TOC entry 4952 (class 2606 OID 33249)
-- Name: partner partner_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partner
    ADD CONSTRAINT partner_pkey PRIMARY KEY (id);


--
-- TOC entry 4948 (class 2606 OID 33144)
-- Name: partner_role partner_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partner_role
    ADD CONSTRAINT partner_role_pkey PRIMARY KEY (id);


--
-- TOC entry 4954 (class 2606 OID 33297)
-- Name: personal_partner personal_partner_cpf_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_partner
    ADD CONSTRAINT personal_partner_cpf_key UNIQUE (cpf);


--
-- TOC entry 4956 (class 2606 OID 33256)
-- Name: personal_partner personal_partner_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_partner
    ADD CONSTRAINT personal_partner_pkey PRIMARY KEY (id);


--
-- TOC entry 4972 (class 2606 OID 41765)
-- Name: product_category product_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_category
    ADD CONSTRAINT product_category_pkey PRIMARY KEY (id);


--
-- TOC entry 4968 (class 2606 OID 41738)
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- TOC entry 4970 (class 2606 OID 41749)
-- Name: product_price product_price_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_price
    ADD CONSTRAINT product_price_pkey PRIMARY KEY (id);


--
-- TOC entry 4976 (class 2606 OID 41873)
-- Name: purchase purchase_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT purchase_pkey PRIMARY KEY (id);


--
-- TOC entry 4966 (class 2606 OID 41720)
-- Name: raw_material raw_material_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.raw_material
    ADD CONSTRAINT raw_material_pkey PRIMARY KEY (id);


--
-- TOC entry 4949 (class 1259 OID 33283)
-- Name: fki_city_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_city_fkey ON public.partner USING btree (city_id);


--
-- TOC entry 4962 (class 1259 OID 41700)
-- Name: fki_employee_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_employee_fkey ON public.employee_wage USING btree (employee_id);


--
-- TOC entry 4973 (class 1259 OID 41863)
-- Name: fki_measurement_unit_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_measurement_unit_fkey ON public.purchase USING btree (measurement_unit_id);


--
-- TOC entry 4959 (class 1259 OID 33270)
-- Name: fki_partner_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_partner_fkey ON public.company_partner USING btree (id);


--
-- TOC entry 4974 (class 1259 OID 41857)
-- Name: fki_raw_material_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_raw_material_fkey ON public.purchase USING btree (raw_material_id);


--
-- TOC entry 4950 (class 1259 OID 33289)
-- Name: fki_role_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_role_fkey ON public.partner USING btree (role_id);


--
-- TOC entry 4977 (class 2606 OID 33278)
-- Name: partner city_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partner
    ADD CONSTRAINT city_fkey FOREIGN KEY (city_id) REFERENCES public.city(id) NOT VALID;


--
-- TOC entry 4981 (class 2606 OID 41695)
-- Name: employee_wage employee_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_wage
    ADD CONSTRAINT employee_fkey FOREIGN KEY (employee_id) REFERENCES public.employee(id) NOT VALID;


--
-- TOC entry 4982 (class 2606 OID 41858)
-- Name: purchase measurement_unit_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT measurement_unit_fkey FOREIGN KEY (measurement_unit_id) REFERENCES public.measurement_unit(id) NOT VALID;


--
-- TOC entry 4980 (class 2606 OID 33265)
-- Name: company_partner partner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company_partner
    ADD CONSTRAINT partner_fkey FOREIGN KEY (id) REFERENCES public.partner(id) NOT VALID;


--
-- TOC entry 4979 (class 2606 OID 33272)
-- Name: personal_partner partner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_partner
    ADD CONSTRAINT partner_fkey FOREIGN KEY (id) REFERENCES public.partner(id) NOT VALID;


--
-- TOC entry 4983 (class 2606 OID 41847)
-- Name: purchase partner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT partner_fkey FOREIGN KEY (partner_id) REFERENCES public.partner(id) NOT VALID;


--
-- TOC entry 4984 (class 2606 OID 41852)
-- Name: purchase raw_material_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT raw_material_fkey FOREIGN KEY (raw_material_id) REFERENCES public.raw_material(id) NOT VALID;


--
-- TOC entry 4978 (class 2606 OID 33284)
-- Name: partner role_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partner
    ADD CONSTRAINT role_fkey FOREIGN KEY (role_id) REFERENCES public.partner_role(id) NOT VALID;


-- Completed on 2026-01-21 17:21:23

--
-- PostgreSQL database dump complete
--

\unrestrict LfLdy8PvjJZWo2k3w8KbaTdKqiddrwxxgt8UDaSMxY9hIJPzhWg6fM5zpcJ0Hu2

