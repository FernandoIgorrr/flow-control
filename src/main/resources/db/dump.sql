--
-- PostgreSQL database dump
--

\restrict H8BhFP5qLwE2CZuH0SqgFChf1GUaibDl7NGSLtE4YDgbSzWXkagODbYYV42kyor

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.0

-- Started on 2026-01-27 13:34:12

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
-- TOC entry 219 (class 1259 OID 42101)
-- Name: city; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.city (
    id smallint NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.city OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 42108)
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
-- TOC entry 5174 (class 0 OID 0)
-- Dependencies: 220
-- Name: city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.city_id_seq OWNED BY public.city.id;


--
-- TOC entry 221 (class 1259 OID 42109)
-- Name: company_partner; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.company_partner (
    id uuid NOT NULL,
    cnpj character varying(14)
);


ALTER TABLE public.company_partner OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 42113)
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
-- TOC entry 223 (class 1259 OID 42124)
-- Name: personal_partner; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personal_partner (
    id uuid NOT NULL,
    cpf character varying(11)
);


ALTER TABLE public.personal_partner OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 42128)
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
-- TOC entry 225 (class 1259 OID 42133)
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee (
    id uuid NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 42140)
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
-- TOC entry 227 (class 1259 OID 42147)
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
-- TOC entry 5175 (class 0 OID 0)
-- Dependencies: 227
-- Name: employee_wage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employee_wage_id_seq OWNED BY public.employee_wage.id;


--
-- TOC entry 228 (class 1259 OID 42148)
-- Name: measurement_unit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.measurement_unit (
    id smallint NOT NULL,
    name text NOT NULL,
    plural_name text NOT NULL,
    symbol character varying(3) NOT NULL,
    unit text
);


ALTER TABLE public.measurement_unit OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 42157)
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
-- TOC entry 5176 (class 0 OID 0)
-- Dependencies: 229
-- Name: measurement_unit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.measurement_unit_id_seq OWNED BY public.measurement_unit.id;


--
-- TOC entry 230 (class 1259 OID 42158)
-- Name: partner_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.partner_role (
    id smallint NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.partner_role OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 42165)
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
-- TOC entry 5177 (class 0 OID 0)
-- Dependencies: 231
-- Name: partner_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.partner_role_id_seq OWNED BY public.partner_role.id;


--
-- TOC entry 232 (class 1259 OID 42166)
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    id smallint NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    category_id smallint CONSTRAINT product_category_id_not_null1 NOT NULL,
    measurement_unit_id smallint NOT NULL,
    quantity numeric(38,3) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE public.product OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 42178)
-- Name: product_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_category (
    id smallint NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.product_category OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 42185)
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
-- TOC entry 5178 (class 0 OID 0)
-- Dependencies: 234
-- Name: product_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_category_id_seq OWNED BY public.product_category.id;


--
-- TOC entry 235 (class 1259 OID 42186)
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
-- TOC entry 236 (class 1259 OID 42193)
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
-- TOC entry 237 (class 1259 OID 42198)
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
-- TOC entry 5179 (class 0 OID 0)
-- Dependencies: 237
-- Name: product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;


--
-- TOC entry 238 (class 1259 OID 42199)
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
-- TOC entry 5180 (class 0 OID 0)
-- Dependencies: 238
-- Name: product_price_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_price_id_seq OWNED BY public.product_price.id;


--
-- TOC entry 245 (class 1259 OID 42330)
-- Name: production; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.production (
    id integer NOT NULL,
    product_id smallint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone,
    is_closed boolean DEFAULT false NOT NULL,
    closed_at timestamp with time zone,
    quantity_produced numeric(38,3) NOT NULL,
    date date NOT NULL,
    gross_quantity_produced numeric(38,3) NOT NULL,
    gqp_measurement_unit_id smallint
);


ALTER TABLE public.production OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 42458)
-- Name: production_full; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.production_full AS
 SELECT p.id,
    prod.name AS product_name,
    prod.description AS product_description,
    prod.quantity AS product_quantity,
    pp.price AS product_current_price,
    muu.symbol AS product_quantity_measurement_unit,
    p.quantity_produced,
    p.gross_quantity_produced,
    mu.unit AS gross_quantity_measurement_unit_unit,
    mu.name AS gross_quantity_measurement_unit_name,
    mu.plural_name AS gross_quantity_measurement_unit_plural_name,
    mu.symbol AS gross_quantity_measurement_unit_symbol,
    p.date,
    p.created_at,
    p.deleted_at,
    p.is_closed
   FROM ((((public.production p
     JOIN public.product prod ON ((prod.id = p.product_id)))
     JOIN public.measurement_unit mu ON ((mu.id = p.gqp_measurement_unit_id)))
     JOIN public.measurement_unit muu ON ((muu.id = prod.measurement_unit_id)))
     LEFT JOIN LATERAL ( SELECT product_price.price
           FROM public.product_price
          WHERE (product_price.product_id = prod.id)
          ORDER BY product_price.price_change_date DESC
         LIMIT 1) pp ON (true))
  WHERE (p.deleted_at IS NULL);


ALTER VIEW public.production_full OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 42329)
-- Name: production_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.production_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.production_id_seq OWNER TO postgres;

--
-- TOC entry 5181 (class 0 OID 0)
-- Dependencies: 244
-- Name: production_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.production_id_seq OWNED BY public.production.id;


--
-- TOC entry 246 (class 1259 OID 42338)
-- Name: production_raw_material_purchase; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.production_raw_material_purchase (
    production_id integer CONSTRAINT production_raw_materials_production_id_not_null NOT NULL,
    purchase_id integer CONSTRAINT production_raw_materials_purchase_id_not_null NOT NULL,
    quantity_used numeric(38,3) CONSTRAINT production_raw_materials_quantity_used_not_null NOT NULL
);


ALTER TABLE public.production_raw_material_purchase OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 42200)
-- Name: purchase; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchase (
    id integer NOT NULL,
    partner_id uuid NOT NULL,
    raw_material_id smallint NOT NULL,
    quantity numeric(38,3) NOT NULL,
    measurement_unit_id smallint NOT NULL,
    price_per_unit numeric(38,2) CONSTRAINT purchase_price_not_null NOT NULL,
    date date NOT NULL,
    created_at timestamp with time zone CONSTRAINT purchase_create_at_not_null NOT NULL,
    deleted_at timestamp with time zone,
    is_closed boolean DEFAULT false NOT NULL,
    note text,
    closed_at timestamp with time zone
);


ALTER TABLE public.purchase OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 42215)
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
-- TOC entry 247 (class 1259 OID 42428)
-- Name: production_raw_material_purchase_full; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.production_raw_material_purchase_full AS
 SELECT prmp.production_id,
    prmp.purchase_id,
    rm.name AS raw_material_name,
    rm.description AS raw_material_description,
    pur.price_per_unit AS purchase_total_price,
    pur.quantity AS quantity_total,
    mu.symbol AS measurement_symbol,
    prmp.quantity_used
   FROM (((public.production_raw_material_purchase prmp
     JOIN public.purchase pur ON ((pur.id = prmp.purchase_id)))
     JOIN public.raw_material rm ON ((rm.id = pur.raw_material_id)))
     JOIN public.measurement_unit mu ON ((mu.id = pur.measurement_unit_id)));


ALTER VIEW public.production_raw_material_purchase_full OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 42463)
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
    mu.plural_name AS measurement_unit_plural_name,
    mu.symbol AS measurement_unit_symbol,
    p.price_per_unit,
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
-- TOC entry 241 (class 1259 OID 42229)
-- Name: purchase_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.purchase_id_seq
    START WITH 1001
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.purchase_id_seq OWNER TO postgres;

--
-- TOC entry 5182 (class 0 OID 0)
-- Dependencies: 241
-- Name: purchase_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.purchase_id_seq OWNED BY public.purchase.id;


--
-- TOC entry 242 (class 1259 OID 42230)
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
-- TOC entry 5183 (class 0 OID 0)
-- Dependencies: 242
-- Name: raw_material_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.raw_material_id_seq OWNED BY public.raw_material.id;


--
-- TOC entry 243 (class 1259 OID 42231)
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
-- TOC entry 4945 (class 2604 OID 42236)
-- Name: city id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city ALTER COLUMN id SET DEFAULT nextval('public.city_id_seq'::regclass);


--
-- TOC entry 4947 (class 2604 OID 42237)
-- Name: employee_wage id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_wage ALTER COLUMN id SET DEFAULT nextval('public.employee_wage_id_seq'::regclass);


--
-- TOC entry 4948 (class 2604 OID 42238)
-- Name: measurement_unit id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measurement_unit ALTER COLUMN id SET DEFAULT nextval('public.measurement_unit_id_seq'::regclass);


--
-- TOC entry 4949 (class 2604 OID 42239)
-- Name: partner_role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partner_role ALTER COLUMN id SET DEFAULT nextval('public.partner_role_id_seq'::regclass);


--
-- TOC entry 4950 (class 2604 OID 42240)
-- Name: product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);


--
-- TOC entry 4951 (class 2604 OID 42241)
-- Name: product_category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_category ALTER COLUMN id SET DEFAULT nextval('public.product_category_id_seq'::regclass);


--
-- TOC entry 4952 (class 2604 OID 42242)
-- Name: product_price id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_price ALTER COLUMN id SET DEFAULT nextval('public.product_price_id_seq'::regclass);


--
-- TOC entry 4956 (class 2604 OID 42333)
-- Name: production id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.production ALTER COLUMN id SET DEFAULT nextval('public.production_id_seq'::regclass);


--
-- TOC entry 4953 (class 2604 OID 42243)
-- Name: purchase id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase ALTER COLUMN id SET DEFAULT nextval('public.purchase_id_seq'::regclass);


--
-- TOC entry 4955 (class 2604 OID 42244)
-- Name: raw_material id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.raw_material ALTER COLUMN id SET DEFAULT nextval('public.raw_material_id_seq'::regclass);


--
-- TOC entry 4961 (class 2606 OID 42246)
-- Name: city city_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (id);


--
-- TOC entry 4963 (class 2606 OID 42248)
-- Name: city city_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_unique UNIQUE (name);


--
-- TOC entry 4958 (class 2606 OID 42249)
-- Name: company_partner cnpj_format; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.company_partner
    ADD CONSTRAINT cnpj_format CHECK (((cnpj IS NULL) OR ((cnpj)::text ~ '^[0-9]{14}$'::text))) NOT VALID;


--
-- TOC entry 4965 (class 2606 OID 42251)
-- Name: company_partner company_partner_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company_partner
    ADD CONSTRAINT company_partner_pkey PRIMARY KEY (id);


--
-- TOC entry 4959 (class 2606 OID 42252)
-- Name: personal_partner cpf_format; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.personal_partner
    ADD CONSTRAINT cpf_format CHECK (((cpf IS NULL) OR ((cpf)::text ~ '^[0-9]{11}$'::text))) NOT VALID;


--
-- TOC entry 4976 (class 2606 OID 42254)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (id);


--
-- TOC entry 4978 (class 2606 OID 42256)
-- Name: employee_wage employee_wage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_wage
    ADD CONSTRAINT employee_wage_pkey PRIMARY KEY (id);


--
-- TOC entry 4981 (class 2606 OID 42258)
-- Name: measurement_unit measurement_unit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measurement_unit
    ADD CONSTRAINT measurement_unit_pkey PRIMARY KEY (id);


--
-- TOC entry 4970 (class 2606 OID 42260)
-- Name: partner partner_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partner
    ADD CONSTRAINT partner_pkey PRIMARY KEY (id);


--
-- TOC entry 4983 (class 2606 OID 42262)
-- Name: partner_role partner_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partner_role
    ADD CONSTRAINT partner_role_pkey PRIMARY KEY (id);


--
-- TOC entry 4972 (class 2606 OID 42264)
-- Name: personal_partner personal_partner_cpf_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_partner
    ADD CONSTRAINT personal_partner_cpf_key UNIQUE (cpf);


--
-- TOC entry 4974 (class 2606 OID 42266)
-- Name: personal_partner personal_partner_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_partner
    ADD CONSTRAINT personal_partner_pkey PRIMARY KEY (id);


--
-- TOC entry 4988 (class 2606 OID 42268)
-- Name: product_category product_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_category
    ADD CONSTRAINT product_category_pkey PRIMARY KEY (id);


--
-- TOC entry 4986 (class 2606 OID 42270)
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- TOC entry 4990 (class 2606 OID 42272)
-- Name: product_price product_price_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_price
    ADD CONSTRAINT product_price_pkey PRIMARY KEY (id);


--
-- TOC entry 4998 (class 2606 OID 42337)
-- Name: production production_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.production
    ADD CONSTRAINT production_pkey PRIMARY KEY (id);


--
-- TOC entry 5002 (class 2606 OID 42345)
-- Name: production_raw_material_purchase production_raw_materials_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.production_raw_material_purchase
    ADD CONSTRAINT production_raw_materials_pkey PRIMARY KEY (production_id, purchase_id);


--
-- TOC entry 4994 (class 2606 OID 42274)
-- Name: purchase purchase_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT purchase_pkey PRIMARY KEY (id);


--
-- TOC entry 4996 (class 2606 OID 42276)
-- Name: raw_material raw_material_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.raw_material
    ADD CONSTRAINT raw_material_pkey PRIMARY KEY (id);


--
-- TOC entry 4984 (class 1259 OID 42392)
-- Name: fki_category_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_category_fkey ON public.product USING btree (category_id);


--
-- TOC entry 4967 (class 1259 OID 42277)
-- Name: fki_city_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_city_fkey ON public.partner USING btree (city_id);


--
-- TOC entry 4979 (class 1259 OID 42278)
-- Name: fki_employee_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_employee_fkey ON public.employee_wage USING btree (employee_id);


--
-- TOC entry 4991 (class 1259 OID 42279)
-- Name: fki_measurement_unit_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_measurement_unit_fkey ON public.purchase USING btree (measurement_unit_id);


--
-- TOC entry 4966 (class 1259 OID 42280)
-- Name: fki_partner_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_partner_fkey ON public.company_partner USING btree (id);


--
-- TOC entry 4999 (class 1259 OID 42351)
-- Name: fki_production_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_production_fkey ON public.production_raw_material_purchase USING btree (production_id);


--
-- TOC entry 5000 (class 1259 OID 42357)
-- Name: fki_purchase_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_purchase_fkey ON public.production_raw_material_purchase USING btree (purchase_id);


--
-- TOC entry 4992 (class 1259 OID 42281)
-- Name: fki_raw_material_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_raw_material_fkey ON public.purchase USING btree (raw_material_id);


--
-- TOC entry 4968 (class 1259 OID 42282)
-- Name: fki_role_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_role_fkey ON public.partner USING btree (role_id);


--
-- TOC entry 5008 (class 2606 OID 42387)
-- Name: product category_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT category_fkey FOREIGN KEY (category_id) REFERENCES public.product_category(id) NOT VALID;


--
-- TOC entry 5004 (class 2606 OID 42283)
-- Name: partner city_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partner
    ADD CONSTRAINT city_fkey FOREIGN KEY (city_id) REFERENCES public.city(id) NOT VALID;


--
-- TOC entry 5007 (class 2606 OID 42288)
-- Name: employee_wage employee_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_wage
    ADD CONSTRAINT employee_fkey FOREIGN KEY (employee_id) REFERENCES public.employee(id) NOT VALID;


--
-- TOC entry 5010 (class 2606 OID 42293)
-- Name: purchase measurement_unit_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT measurement_unit_fkey FOREIGN KEY (measurement_unit_id) REFERENCES public.measurement_unit(id) NOT VALID;


--
-- TOC entry 5009 (class 2606 OID 42382)
-- Name: product measurement_unit_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT measurement_unit_fkey FOREIGN KEY (measurement_unit_id) REFERENCES public.measurement_unit(id) NOT VALID;


--
-- TOC entry 5013 (class 2606 OID 42393)
-- Name: production measurement_unit_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.production
    ADD CONSTRAINT measurement_unit_fkey FOREIGN KEY (gqp_measurement_unit_id) REFERENCES public.measurement_unit(id) NOT VALID;


--
-- TOC entry 5003 (class 2606 OID 42298)
-- Name: company_partner partner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company_partner
    ADD CONSTRAINT partner_fkey FOREIGN KEY (id) REFERENCES public.partner(id) NOT VALID;


--
-- TOC entry 5006 (class 2606 OID 42303)
-- Name: personal_partner partner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_partner
    ADD CONSTRAINT partner_fkey FOREIGN KEY (id) REFERENCES public.partner(id) NOT VALID;


--
-- TOC entry 5011 (class 2606 OID 42308)
-- Name: purchase partner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT partner_fkey FOREIGN KEY (partner_id) REFERENCES public.partner(id) NOT VALID;


--
-- TOC entry 5014 (class 2606 OID 42346)
-- Name: production_raw_material_purchase production_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.production_raw_material_purchase
    ADD CONSTRAINT production_fkey FOREIGN KEY (production_id) REFERENCES public.production(id) NOT VALID;


--
-- TOC entry 5015 (class 2606 OID 42352)
-- Name: production_raw_material_purchase purchase_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.production_raw_material_purchase
    ADD CONSTRAINT purchase_fkey FOREIGN KEY (purchase_id) REFERENCES public.purchase(id) NOT VALID;


--
-- TOC entry 5012 (class 2606 OID 42313)
-- Name: purchase raw_material_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT raw_material_fkey FOREIGN KEY (raw_material_id) REFERENCES public.raw_material(id) NOT VALID;


--
-- TOC entry 5005 (class 2606 OID 42318)
-- Name: partner role_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partner
    ADD CONSTRAINT role_fkey FOREIGN KEY (role_id) REFERENCES public.partner_role(id) NOT VALID;


-- Completed on 2026-01-27 13:34:13

--
-- PostgreSQL database dump complete
--

\unrestrict H8BhFP5qLwE2CZuH0SqgFChf1GUaibDl7NGSLtE4YDgbSzWXkagODbYYV42kyor

