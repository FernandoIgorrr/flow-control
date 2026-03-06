--
-- PostgreSQL database dump
--

\restrict 24vdpRgw1Q67eHL9UWI9Df3kw6xagH4pIChIMiLRj6QDi0BE5sBnhOnahxkZPET

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

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

ALTER TABLE IF EXISTS ONLY public.partner DROP CONSTRAINT IF EXISTS role_fkey;
ALTER TABLE IF EXISTS ONLY public.purchase DROP CONSTRAINT IF EXISTS raw_material_fkey;
ALTER TABLE IF EXISTS ONLY public.sale_product DROP CONSTRAINT IF EXISTS product_fkey;
ALTER TABLE IF EXISTS ONLY public.purchase DROP CONSTRAINT IF EXISTS partner_fkey;
ALTER TABLE IF EXISTS ONLY public.personal_partner DROP CONSTRAINT IF EXISTS partner_fkey;
ALTER TABLE IF EXISTS ONLY public.company_partner DROP CONSTRAINT IF EXISTS partner_fkey;
ALTER TABLE IF EXISTS ONLY public.purchase DROP CONSTRAINT IF EXISTS measurement_unit_fkey;
ALTER TABLE IF EXISTS ONLY public.production DROP CONSTRAINT IF EXISTS measurement_unit_fkey;
ALTER TABLE IF EXISTS ONLY public.product DROP CONSTRAINT IF EXISTS measurement_unit_fkey;
ALTER TABLE IF EXISTS ONLY public.employee_payment DROP CONSTRAINT IF EXISTS employee_fkey;
ALTER TABLE IF EXISTS ONLY public.sale DROP CONSTRAINT IF EXISTS client_fkey;
ALTER TABLE IF EXISTS ONLY public.partner DROP CONSTRAINT IF EXISTS city_fkey;
ALTER TABLE IF EXISTS ONLY public.spent DROP CONSTRAINT IF EXISTS category_fkey;
ALTER TABLE IF EXISTS ONLY public.purchase DROP CONSTRAINT IF EXISTS category_fkey;
ALTER TABLE IF EXISTS ONLY public.product DROP CONSTRAINT IF EXISTS category_fkey;
ALTER TABLE IF EXISTS ONLY public.employee_payment DROP CONSTRAINT IF EXISTS category_fkey;
DROP TRIGGER IF EXISTS trg_set_product_price_on_sale ON public.sale_product;
CREATE OR REPLACE VIEW public.production_full AS
SELECT
    NULL::integer AS id,
    NULL::text AS product_name,
    NULL::text AS product_description,
    NULL::numeric(38,3) AS product_quantity,
    NULL::numeric(38,2) AS product_current_price,
    NULL::character varying(3) AS product_quantity_measurement_unit,
    NULL::numeric(38,3) AS quantity_produced,
    NULL::numeric(38,3) AS gross_quantity_produced,
    NULL::text AS gross_quantity_measurement_unit_unit,
    NULL::text AS gross_quantity_measurement_unit_name,
    NULL::text AS gross_quantity_measurement_unit_plural_name,
    NULL::character varying(3) AS gross_quantity_measurement_unit_symbol,
    NULL::numeric AS avg_raw_material_unit_price,
    NULL::date AS raw_material_purchase_date,
    NULL::numeric(38,3) AS quantity_used,
    NULL::date AS date,
    NULL::timestamp with time zone AS created_at,
    NULL::timestamp with time zone AS deleted_at,
    NULL::boolean AS confirmed;
DROP INDEX IF EXISTS public.fki_role_fkey;
DROP INDEX IF EXISTS public.fki_raw_material_fkey;
DROP INDEX IF EXISTS public.fki_product_fkey;
DROP INDEX IF EXISTS public.fki_partner_fkey;
DROP INDEX IF EXISTS public.fki_measurement_unit_fkey;
DROP INDEX IF EXISTS public.fki_employee_fkey;
DROP INDEX IF EXISTS public.fki_client_fkey;
DROP INDEX IF EXISTS public.fki_city_fkey;
DROP INDEX IF EXISTS public.fki_category_fkey;
ALTER TABLE IF EXISTS ONLY public.spent DROP CONSTRAINT IF EXISTS spent_pkey;
ALTER TABLE IF EXISTS ONLY public.spent_category DROP CONSTRAINT IF EXISTS spent_category_pkey;
ALTER TABLE IF EXISTS public.employee_payment DROP CONSTRAINT IF EXISTS spent_category_id_cheker;
ALTER TABLE IF EXISTS public.purchase DROP CONSTRAINT IF EXISTS spent_category_id_checker;
ALTER TABLE IF EXISTS ONLY public.sale_product DROP CONSTRAINT IF EXISTS sale_production_pkey;
ALTER TABLE IF EXISTS ONLY public.sale DROP CONSTRAINT IF EXISTS sale_pkey;
ALTER TABLE IF EXISTS ONLY public.raw_material DROP CONSTRAINT IF EXISTS raw_material_pkey;
ALTER TABLE IF EXISTS ONLY public.purchase DROP CONSTRAINT IF EXISTS purchase_pkey;
ALTER TABLE IF EXISTS ONLY public.production DROP CONSTRAINT IF EXISTS production_pkey;
ALTER TABLE IF EXISTS ONLY public.product_price DROP CONSTRAINT IF EXISTS product_price_pkey;
ALTER TABLE IF EXISTS ONLY public.product DROP CONSTRAINT IF EXISTS product_pkey;
ALTER TABLE IF EXISTS ONLY public.product_category DROP CONSTRAINT IF EXISTS product_category_pkey;
ALTER TABLE IF EXISTS ONLY public.personal_partner DROP CONSTRAINT IF EXISTS personal_partner_pkey;
ALTER TABLE IF EXISTS ONLY public.personal_partner DROP CONSTRAINT IF EXISTS personal_partner_cpf_key;
ALTER TABLE IF EXISTS ONLY public.partner_role DROP CONSTRAINT IF EXISTS partner_role_pkey;
ALTER TABLE IF EXISTS ONLY public.partner DROP CONSTRAINT IF EXISTS partner_pkey;
ALTER TABLE IF EXISTS ONLY public.measurement_unit DROP CONSTRAINT IF EXISTS measurement_unit_pkey;
ALTER TABLE IF EXISTS ONLY public.employee_payment DROP CONSTRAINT IF EXISTS employee_wage_pkey;
ALTER TABLE IF EXISTS ONLY public.employee DROP CONSTRAINT IF EXISTS employee_pkey;
ALTER TABLE IF EXISTS public.personal_partner DROP CONSTRAINT IF EXISTS cpf_format;
ALTER TABLE IF EXISTS ONLY public.company_partner DROP CONSTRAINT IF EXISTS company_partner_pkey;
ALTER TABLE IF EXISTS public.company_partner DROP CONSTRAINT IF EXISTS cnpj_format;
ALTER TABLE IF EXISTS ONLY public.city DROP CONSTRAINT IF EXISTS city_unique;
ALTER TABLE IF EXISTS ONLY public.city DROP CONSTRAINT IF EXISTS city_pkey;
ALTER TABLE IF EXISTS public.spent_category ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.spent ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sale_product ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sale ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.raw_material ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.purchase ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.production ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.product_price ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.product_category ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.product ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.partner_role ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.measurement_unit ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.employee_payment ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.city ALTER COLUMN id DROP DEFAULT;
DROP VIEW IF EXISTS public.supplier_full;
DROP SEQUENCE IF EXISTS public.spent_id_seq;
DROP SEQUENCE IF EXISTS public.spent_category_id_seq;
DROP TABLE IF EXISTS public.spent;
DROP SEQUENCE IF EXISTS public.sale_product_id_seq;
DROP VIEW IF EXISTS public.sale_product_full;
DROP TABLE IF EXISTS public.sale_product;
DROP SEQUENCE IF EXISTS public.sale_id_seq;
DROP VIEW IF EXISTS public.sale_full;
DROP TABLE IF EXISTS public.sale;
DROP SEQUENCE IF EXISTS public.raw_material_id_seq;
DROP SEQUENCE IF EXISTS public.purchase_id_seq;
DROP VIEW IF EXISTS public.purchase_full;
DROP TABLE IF EXISTS public.spent_category;
DROP TABLE IF EXISTS public.raw_material;
DROP TABLE IF EXISTS public.purchase;
DROP SEQUENCE IF EXISTS public.production_id_seq;
DROP VIEW IF EXISTS public.production_full;
DROP TABLE IF EXISTS public.production;
DROP SEQUENCE IF EXISTS public.product_price_id_seq;
DROP SEQUENCE IF EXISTS public.product_id_seq;
DROP VIEW IF EXISTS public.product_full;
DROP TABLE IF EXISTS public.product_price;
DROP SEQUENCE IF EXISTS public.product_category_id_seq;
DROP TABLE IF EXISTS public.product_category;
DROP TABLE IF EXISTS public.product;
DROP SEQUENCE IF EXISTS public.partner_role_id_seq;
DROP TABLE IF EXISTS public.partner_role;
DROP SEQUENCE IF EXISTS public.measurement_unit_id_seq;
DROP TABLE IF EXISTS public.measurement_unit;
DROP SEQUENCE IF EXISTS public.employee_wage_id_seq;
DROP TABLE IF EXISTS public.employee_payment;
DROP TABLE IF EXISTS public.employee;
DROP VIEW IF EXISTS public.client_full;
DROP TABLE IF EXISTS public.personal_partner;
DROP TABLE IF EXISTS public.partner;
DROP TABLE IF EXISTS public.company_partner;
DROP SEQUENCE IF EXISTS public.city_id_seq;
DROP TABLE IF EXISTS public.city;
DROP FUNCTION IF EXISTS public.set_product_price_on_sale();
--
-- Name: set_product_price_on_sale(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.set_product_price_on_sale() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    SELECT pp.price
    INTO NEW.product_price_on_sale_date
    FROM product_price pp
    JOIN sale s ON s.id = NEW.sale_id
    WHERE pp.product_id = NEW.product_id
      AND pp.price_change_date::date <= s.date
    ORDER BY pp.price_change_date DESC
    LIMIT 1;

     -- 2. Se não encontrou (preço nulo), busca o preço mais antigo disponível
    IF NEW.product_price_on_sale_date IS NULL THEN
        SELECT pp.price
        INTO NEW.product_price_on_sale_date
        FROM product_price pp
        WHERE pp.product_id = NEW.product_id
        ORDER BY pp.price_change_date ASC -- Pega o primeiro registro histórico
        LIMIT 1;
    END IF;

    -- Opcional: Se AINDA assim for nulo, significa que o produto não existe na tabela de preços
    IF NEW.product_price_on_sale_date IS NULL THEN
        RAISE EXCEPTION 'Produto % não possui nenhum preço em toda a base de dados', NEW.product_id;
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.set_product_price_on_sale() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: city; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.city (
    id smallint NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.city OWNER TO postgres;

--
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
-- Name: city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.city_id_seq OWNED BY public.city.id;


--
-- Name: company_partner; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.company_partner (
    id uuid NOT NULL,
    cnpj character varying(14)
);


ALTER TABLE public.company_partner OWNER TO postgres;

--
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
    deleted_at timestamp with time zone,
    confirmed boolean DEFAULT false CONSTRAINT partner_is_closed_not_null NOT NULL
);


ALTER TABLE public.partner OWNER TO postgres;

--
-- Name: personal_partner; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personal_partner (
    id uuid NOT NULL,
    cpf character varying(11)
);


ALTER TABLE public.personal_partner OWNER TO postgres;

--
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
        END AS category,
    p.confirmed
   FROM (((public.partner p
     LEFT JOIN public.personal_partner pp ON ((pp.id = p.id)))
     LEFT JOIN public.company_partner cp ON ((cp.id = p.id)))
     JOIN public.city c ON ((p.city_id = c.id)))
  WHERE ((p.role_id = 1) AND (p.deleted_at IS NULL));


ALTER VIEW public.client_full OWNER TO postgres;

--
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee (
    id uuid NOT NULL,
    name text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    confirmed boolean DEFAULT false CONSTRAINT employee_is_closed_not_null NOT NULL
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- Name: employee_payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee_payment (
    id integer CONSTRAINT employee_wage_id_not_null NOT NULL,
    payment numeric(38,2) CONSTRAINT employee_wage_wage_not_null NOT NULL,
    employee_id uuid CONSTRAINT employee_wage_employee_id_not_null NOT NULL,
    payment_change_date date CONSTRAINT employee_wage_wage_change_date_not_null NOT NULL,
    spent_category_id smallint DEFAULT 2 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    confirmed boolean DEFAULT false NOT NULL
);


ALTER TABLE public.employee_payment OWNER TO postgres;

--
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
-- Name: employee_wage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employee_wage_id_seq OWNED BY public.employee_payment.id;


--
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
-- Name: measurement_unit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.measurement_unit_id_seq OWNED BY public.measurement_unit.id;


--
-- Name: partner_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.partner_role (
    id smallint NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.partner_role OWNER TO postgres;

--
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
-- Name: partner_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.partner_role_id_seq OWNED BY public.partner_role.id;


--
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    id smallint NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    category_id smallint CONSTRAINT product_category_id_not_null1 NOT NULL,
    measurement_unit_id smallint NOT NULL,
    quantity numeric(38,3) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    confirmed boolean DEFAULT false CONSTRAINT product_is_closed_not_null NOT NULL
);


ALTER TABLE public.product OWNER TO postgres;

--
-- Name: product_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_category (
    id smallint NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.product_category OWNER TO postgres;

--
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
-- Name: product_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_category_id_seq OWNED BY public.product_category.id;


--
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
    pp.price AS current_price,
    p.confirmed
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
-- Name: product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;


--
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
-- Name: product_price_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_price_id_seq OWNED BY public.product_price.id;


--
-- Name: production; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.production (
    id integer NOT NULL,
    product_id smallint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone,
    confirmed boolean DEFAULT false CONSTRAINT production_is_closed_not_null NOT NULL,
    quantity_produced numeric(38,3) NOT NULL,
    date date NOT NULL,
    gross_quantity_produced numeric(38,3) NOT NULL,
    gqp_measurement_unit_id smallint,
    raw_material_purchase_date date CONSTRAINT production_raw_matrial_purchase_date_not_null NOT NULL,
    quantity_used numeric(38,3) CONSTRAINT production_quantity_ued_not_null NOT NULL
);


ALTER TABLE public.production OWNER TO postgres;

--
-- Name: production_full; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.production_full AS
SELECT
    NULL::integer AS id,
    NULL::text AS product_name,
    NULL::text AS product_description,
    NULL::numeric(38,3) AS product_quantity,
    NULL::numeric(38,2) AS product_current_price,
    NULL::character varying(3) AS product_quantity_measurement_unit,
    NULL::numeric(38,3) AS quantity_produced,
    NULL::numeric(38,3) AS gross_quantity_produced,
    NULL::text AS gross_quantity_measurement_unit_unit,
    NULL::text AS gross_quantity_measurement_unit_name,
    NULL::text AS gross_quantity_measurement_unit_plural_name,
    NULL::character varying(3) AS gross_quantity_measurement_unit_symbol,
    NULL::numeric AS avg_raw_material_unit_price,
    NULL::date AS raw_material_purchase_date,
    NULL::numeric(38,3) AS quantity_used,
    NULL::date AS date,
    NULL::timestamp with time zone AS created_at,
    NULL::timestamp with time zone AS deleted_at,
    NULL::boolean AS confirmed;


ALTER VIEW public.production_full OWNER TO postgres;

--
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
-- Name: production_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.production_id_seq OWNED BY public.production.id;


--
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
    created_at timestamp with time zone DEFAULT now() CONSTRAINT purchase_create_at_not_null NOT NULL,
    deleted_at timestamp with time zone,
    confirmed boolean DEFAULT false CONSTRAINT purchase_is_closed_not_null NOT NULL,
    note text,
    spent_category_id smallint DEFAULT 1 CONSTRAINT purchase_spent_category_not_null NOT NULL
);


ALTER TABLE public.purchase OWNER TO postgres;

--
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
-- Name: spent_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.spent_category (
    id smallint CONSTRAINT spent_category_id_not_null1 NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.spent_category OWNER TO postgres;

--
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
    sc.id AS spent_category_id,
    p.price_per_unit,
    p.date,
    p.note,
    p.created_at,
    p.deleted_at,
    p.confirmed
   FROM ((((((public.purchase p
     JOIN public.partner prs ON ((prs.id = p.partner_id)))
     JOIN public.spent_category sc ON ((sc.id = p.spent_category_id)))
     LEFT JOIN public.personal_partner pp ON ((pp.id = p.partner_id)))
     LEFT JOIN public.company_partner cp ON ((cp.id = p.partner_id)))
     JOIN public.raw_material rm ON ((rm.id = p.raw_material_id)))
     JOIN public.measurement_unit mu ON ((mu.id = p.measurement_unit_id)))
  WHERE (p.deleted_at IS NULL);


ALTER VIEW public.purchase_full OWNER TO postgres;

--
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
-- Name: purchase_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.purchase_id_seq OWNED BY public.purchase.id;


--
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
-- Name: raw_material_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.raw_material_id_seq OWNED BY public.raw_material.id;


--
-- Name: sale; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sale (
    id integer NOT NULL,
    client_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    confirmed boolean DEFAULT false CONSTRAINT sale_is_closed_not_null NOT NULL,
    date date NOT NULL
);


ALTER TABLE public.sale OWNER TO postgres;

--
-- Name: sale_full; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.sale_full AS
 SELECT s.id,
    cf.id AS client_id,
    cf.name AS client_name,
    cf.category AS client_category,
    cf.cpf AS client_cpf,
    cf.cnpj AS client_cnpj,
    cf.city AS client_city,
    s.date,
    s.created_at,
    s.deleted_at,
    s.confirmed
   FROM (public.sale s
     JOIN public.client_full cf ON ((cf.id = s.client_id)))
  WHERE (s.deleted_at IS NULL);


ALTER VIEW public.sale_full OWNER TO postgres;

--
-- Name: sale_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sale_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sale_id_seq OWNER TO postgres;

--
-- Name: sale_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sale_id_seq OWNED BY public.sale.id;


--
-- Name: sale_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sale_product (
    id integer NOT NULL,
    product_id integer NOT NULL,
    quantity numeric(38,3) NOT NULL,
    sale_id integer NOT NULL,
    product_price_on_sale_date numeric(38,2) DEFAULT 1 CONSTRAINT sale_product_product_price_on_date_not_null NOT NULL
);


ALTER TABLE public.sale_product OWNER TO postgres;

--
-- Name: sale_product_full; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.sale_product_full AS
 SELECT sp.id,
    sp.sale_id,
    prod.id AS product_id,
    prod.name AS product_name,
    prod.description AS product_description,
    mu.unit AS product_measurement_unit_unit,
    mu.name AS product_measurement_unit_name,
    mu.plural_name AS product_measurement_unit_plural_name,
    mu.symbol AS product_measurement_unit_symbol,
    sp.product_price_on_sale_date,
    sp.quantity AS product_quantity_sold
   FROM (((public.sale_product sp
     JOIN public.product prod ON ((prod.id = sp.product_id)))
     JOIN public.measurement_unit mu ON ((prod.measurement_unit_id = mu.id)))
     LEFT JOIN LATERAL ( SELECT product_price.price
           FROM public.product_price
          WHERE (product_price.product_id = prod.id)
          ORDER BY product_price.price_change_date DESC
         LIMIT 1) pp ON (true));


ALTER VIEW public.sale_product_full OWNER TO postgres;

--
-- Name: sale_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sale_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sale_product_id_seq OWNER TO postgres;

--
-- Name: sale_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sale_product_id_seq OWNED BY public.sale_product.id;


--
-- Name: spent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.spent (
    id integer NOT NULL,
    description text NOT NULL,
    amount_paid numeric(38,2) CONSTRAINT spent_price_not_null NOT NULL,
    category_id smallint NOT NULL,
    date date NOT NULL,
    created_at timestamp with time zone DEFAULT now() CONSTRAINT "spent_createdAt_not_null" NOT NULL,
    deleted_at timestamp with time zone,
    confirmed boolean DEFAULT false CONSTRAINT spent_is_closed_not_null NOT NULL
);


ALTER TABLE public.spent OWNER TO postgres;

--
-- Name: spent_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.spent_category_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.spent_category_id_seq OWNER TO postgres;

--
-- Name: spent_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.spent_category_id_seq OWNED BY public.spent_category.id;


--
-- Name: spent_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.spent_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.spent_id_seq OWNER TO postgres;

--
-- Name: spent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.spent_id_seq OWNED BY public.spent.id;


--
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
        END AS category,
    p.confirmed
   FROM (((public.partner p
     LEFT JOIN public.personal_partner pp ON ((pp.id = p.id)))
     LEFT JOIN public.company_partner cp ON ((cp.id = p.id)))
     JOIN public.city c ON ((p.city_id = c.id)))
  WHERE ((p.role_id = 2) AND (p.deleted_at IS NULL));


ALTER VIEW public.supplier_full OWNER TO postgres;

--
-- Name: city id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city ALTER COLUMN id SET DEFAULT nextval('public.city_id_seq'::regclass);


--
-- Name: employee_payment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_payment ALTER COLUMN id SET DEFAULT nextval('public.employee_wage_id_seq'::regclass);


--
-- Name: measurement_unit id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measurement_unit ALTER COLUMN id SET DEFAULT nextval('public.measurement_unit_id_seq'::regclass);


--
-- Name: partner_role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partner_role ALTER COLUMN id SET DEFAULT nextval('public.partner_role_id_seq'::regclass);


--
-- Name: product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);


--
-- Name: product_category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_category ALTER COLUMN id SET DEFAULT nextval('public.product_category_id_seq'::regclass);


--
-- Name: product_price id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_price ALTER COLUMN id SET DEFAULT nextval('public.product_price_id_seq'::regclass);


--
-- Name: production id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.production ALTER COLUMN id SET DEFAULT nextval('public.production_id_seq'::regclass);


--
-- Name: purchase id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase ALTER COLUMN id SET DEFAULT nextval('public.purchase_id_seq'::regclass);


--
-- Name: raw_material id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.raw_material ALTER COLUMN id SET DEFAULT nextval('public.raw_material_id_seq'::regclass);


--
-- Name: sale id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale ALTER COLUMN id SET DEFAULT nextval('public.sale_id_seq'::regclass);


--
-- Name: sale_product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale_product ALTER COLUMN id SET DEFAULT nextval('public.sale_product_id_seq'::regclass);


--
-- Name: spent id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spent ALTER COLUMN id SET DEFAULT nextval('public.spent_id_seq'::regclass);


--
-- Name: spent_category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spent_category ALTER COLUMN id SET DEFAULT nextval('public.spent_category_id_seq'::regclass);


--
-- Data for Name: city; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.city (id, name) FROM stdin;
1	Acari (RN)
2	Açu (RN)
3	Afonso Bezerra (RN)
4	Água Nova (RN)
5	Alexandria (RN)
6	Almino Afonso (RN)
7	Alto do Rodrigues (RN)
8	Angicos (RN)
9	Antônio Martins (RN)
10	Apodi (RN)
11	Areia Branca (RN)
12	Arês (RN)
13	Campo Grande (RN)
14	Baía Formosa (RN)
15	Baraúna (RN)
16	Barcelona (RN)
17	Bento Fernandes (RN)
18	Bodó (RN)
19	Bom Jesus (RN)
20	Brejinho (RN)
21	Caiçara do Norte (RN)
22	Caiçara do Rio do Vento (RN)
23	Caicó (RN)
24	Campo Redondo (RN)
25	Canguaretama (RN)
26	Caraúbas (RN)
27	Carnaúba dos Dantas (RN)
28	Carnaubais (RN)
29	Ceará-Mirim (RN)
30	Cerro Corá (RN)
31	Coronel Ezequiel (RN)
32	Coronel João Pessoa (RN)
33	Cruzeta (RN)
34	Currais Novos (RN)
35	Doutor Severiano (RN)
36	Parnamirim (RN)
37	Encanto (RN)
38	Equador (RN)
39	Espírito Santo (RN)
40	Extremoz (RN)
41	Felipe Guerra (RN)
42	Fernando Pedroza (RN)
43	Florânia (RN)
44	Francisco Dantas (RN)
45	Frutuoso Gomes (RN)
46	Galinhos (RN)
47	Goianinha (RN)
48	Governador Dix-Sept Rosado (RN)
49	Grossos (RN)
50	Guamaré (RN)
51	Ielmo Marinho (RN)
52	Ipanguaçu (RN)
53	Ipueira (RN)
54	Itajá (RN)
55	Itaú (RN)
56	Jaçanã (RN)
57	Jandaíra (RN)
58	Janduís (RN)
59	Januário Cicco (RN)
60	Japi (RN)
61	Jardim de Angicos (RN)
62	Jardim de Piranhas (RN)
63	Jardim do Seridó (RN)
64	João Câmara (RN)
65	João Dias (RN)
66	José da Penha (RN)
67	Jucurutu (RN)
68	Jundiá (RN)
69	Lagoa d'Anta (RN)
70	Lagoa de Pedras (RN)
71	Lagoa de Velhos (RN)
72	Lagoa Nova (RN)
73	Lagoa Salgada (RN)
74	Lajes (RN)
75	Lajes Pintadas (RN)
76	Lucrécia (RN)
77	Luís Gomes (RN)
78	Macaíba (RN)
79	Macau (RN)
80	Major Sales (RN)
81	Marcelino Vieira (RN)
82	Martins (RN)
83	Maxaranguape (RN)
84	Messias Targino (RN)
85	Montanhas (RN)
86	Monte Alegre (RN)
87	Monte das Gameleiras (RN)
88	Mossoró (RN)
89	Natal (RN)
90	Nísia Floresta (RN)
91	Nova Cruz (RN)
92	Olho d'Água do Borges (RN)
93	Ouro Branco (RN)
94	Paraná (RN)
95	Paraú (RN)
96	Parazinho (RN)
97	Parelhas (RN)
98	Rio do Fogo (RN)
99	Passa e Fica (RN)
100	Passagem (RN)
101	Patu (RN)
102	Santa Maria (RN)
103	Pau dos Ferros (RN)
104	Pedra Grande (RN)
105	Pedra Preta (RN)
106	Pedro Avelino (RN)
107	Pedro Velho (RN)
108	Pendências (RN)
109	Pilões (RN)
110	Poço Branco (RN)
111	Portalegre (RN)
112	Porto do Mangue (RN)
113	Serra Caiada (RN)
114	Pureza (RN)
115	Rafael Fernandes (RN)
116	Rafael Godeiro (RN)
117	Riacho da Cruz (RN)
118	Riacho de Santana (RN)
119	Riachuelo (RN)
120	Rodolfo Fernandes (RN)
121	Tibau (RN)
122	Ruy Barbosa (RN)
123	Santa Cruz (RN)
124	Santana do Matos (RN)
125	Santana do Seridó (RN)
126	Santo Antônio (RN)
127	São Bento do Norte (RN)
128	São Bento do Trairí (RN)
129	São Fernando (RN)
130	São Francisco do Oeste (RN)
131	São Gonçalo do Amarante (RN)
132	São João do Sabugi (RN)
133	São José de Mipibu (RN)
134	São José do Campestre (RN)
135	São José do Seridó (RN)
136	São Miguel (RN)
137	São Miguel do Gostoso (RN)
138	São Paulo do Potengi (RN)
139	São Pedro (RN)
140	São Rafael (RN)
141	São Tomé (RN)
142	São Vicente (RN)
143	Senador Elói de Souza (RN)
144	Senador Georgino Avelino (RN)
145	Serra de São Bento (RN)
146	Serra do Mel (RN)
147	Serra Negra do Norte (RN)
148	Serrinha (RN)
149	Serrinha dos Pintos (RN)
150	Severiano Melo (RN)
151	Sítio Novo (RN)
152	Taboleiro Grande (RN)
153	Taipu (RN)
154	Tangará (RN)
155	Tenente Ananias (RN)
156	Tenente Laurentino Cruz (RN)
157	Tibau do Sul (RN)
158	Timbaúba dos Batistas (RN)
159	Touros (RN)
160	Triunfo Potiguar (RN)
161	Umarizal (RN)
162	Upanema (RN)
163	Várzea (RN)
164	Venha-Ver (RN)
165	Vera Cruz (RN)
166	Viçosa (RN)
167	Vila Flor (RN)
168	Água Branca (PB)
169	Aguiar (PB)
170	Alagoa Grande (PB)
171	Alagoa Nova (PB)
172	Alagoinha (PB)
173	Alcantil (PB)
174	Algodão de Jandaíra (PB)
175	Alhandra (PB)
176	São João do Rio do Peixe (PB)
177	Amparo (PB)
178	Aparecida (PB)
179	Araçagi (PB)
180	Arara (PB)
181	Araruna (PB)
182	Areia (PB)
183	Areia de Baraúnas (PB)
184	Areial (PB)
185	Aroeiras (PB)
186	Assunção (PB)
187	Baía da Traição (PB)
188	Bananeiras (PB)
189	Baraúna (PB)
190	Barra de Santana (PB)
191	Barra de Santa Rosa (PB)
192	Barra de São Miguel (PB)
193	Bayeux (PB)
194	Belém (PB)
195	Belém do Brejo do Cruz (PB)
196	Bernardino Batista (PB)
197	Boa Ventura (PB)
198	Boa Vista (PB)
199	Bom Jesus (PB)
200	Bom Sucesso (PB)
201	Bonito de Santa Fé (PB)
202	Boqueirão (PB)
203	Igaracy (PB)
204	Borborema (PB)
205	Brejo do Cruz (PB)
206	Brejo dos Santos (PB)
207	Caaporã (PB)
208	Cabaceiras (PB)
209	Cabedelo (PB)
210	Cachoeira dos Índios (PB)
211	Cacimba de Areia (PB)
212	Cacimba de Dentro (PB)
213	Cacimbas (PB)
214	Caiçara (PB)
215	Cajazeiras (PB)
216	Cajazeirinhas (PB)
217	Caldas Brandão (PB)
218	Camalaú (PB)
219	Campina Grande (PB)
220	Capim (PB)
221	Caraúbas (PB)
222	Carrapateira (PB)
223	Casserengue (PB)
224	Catingueira (PB)
225	Catolé do Rocha (PB)
226	Caturité (PB)
227	Conceição (PB)
228	Condado (PB)
229	Conde (PB)
230	Congo (PB)
231	Coremas (PB)
232	Coxixola (PB)
233	Cruz do Espírito Santo (PB)
234	Cubati (PB)
235	Cuité (PB)
236	Cuitegi (PB)
237	Cuité de Mamanguape (PB)
238	Curral de Cima (PB)
239	Curral Velho (PB)
240	Damião (PB)
241	Desterro (PB)
242	Vista Serrana (PB)
243	Diamante (PB)
244	Dona Inês (PB)
245	Duas Estradas (PB)
246	Emas (PB)
247	Esperança (PB)
248	Fagundes (PB)
249	Frei Martinho (PB)
250	Gado Bravo (PB)
251	Guarabira (PB)
252	Gurinhém (PB)
253	Gurjão (PB)
254	Ibiara (PB)
255	Imaculada (PB)
256	Ingá (PB)
257	Itabaiana (PB)
258	Itaporanga (PB)
259	Itapororoca (PB)
260	Itatuba (PB)
261	Jacaraú (PB)
262	Jericó (PB)
263	João Pessoa (PB)
264	Juarez Távora (PB)
265	Juazeirinho (PB)
266	Junco do Seridó (PB)
267	Juripiranga (PB)
268	Juru (PB)
269	Lagoa (PB)
270	Lagoa de Dentro (PB)
271	Lagoa Seca (PB)
272	Lastro (PB)
273	Livramento (PB)
274	Logradouro (PB)
275	Lucena (PB)
276	Mãe d'Água (PB)
277	Malta (PB)
278	Mamanguape (PB)
279	Manaíra (PB)
280	Marcação (PB)
281	Mari (PB)
282	Marizópolis (PB)
283	Massaranduba (PB)
284	Mataraca (PB)
285	Matinhas (PB)
286	Mato Grosso (PB)
287	Maturéia (PB)
288	Mogeiro (PB)
289	Montadas (PB)
290	Monte Horebe (PB)
291	Monteiro (PB)
292	Mulungu (PB)
293	Natuba (PB)
294	Nazarezinho (PB)
295	Nova Floresta (PB)
296	Nova Olinda (PB)
297	Nova Palmeira (PB)
298	Olho d'Água (PB)
299	Olivedos (PB)
300	Ouro Velho (PB)
301	Parari (PB)
302	Passagem (PB)
303	Patos (PB)
304	Paulista (PB)
305	Pedra Branca (PB)
306	Pedra Lavrada (PB)
307	Pedras de Fogo (PB)
308	Piancó (PB)
309	Picuí (PB)
310	Pilar (PB)
311	Pilões (PB)
312	Pilõezinhos (PB)
313	Pirpirituba (PB)
314	Pitimbu (PB)
315	Pocinhos (PB)
316	Poço Dantas (PB)
317	Poço de José de Moura (PB)
318	Pombal (PB)
319	Prata (PB)
320	Princesa Isabel (PB)
321	Puxinanã (PB)
322	Queimadas (PB)
323	Quixaba (PB)
324	Remígio (PB)
325	Pedro Régis (PB)
326	Riachão (PB)
327	Riachão do Bacamarte (PB)
328	Riachão do Poço (PB)
329	Riacho de Santo Antônio (PB)
330	Riacho dos Cavalos (PB)
331	Rio Tinto (PB)
332	Salgadinho (PB)
333	Salgado de São Félix (PB)
334	Santa Cecília (PB)
335	Santa Cruz (PB)
336	Santa Helena (PB)
337	Santa Inês (PB)
338	Santa Luzia (PB)
339	Santana de Mangueira (PB)
340	Santana dos Garrotes (PB)
341	Joca Claudino (PB)
342	Santa Rita (PB)
343	Santa Teresinha (PB)
344	Santo André (PB)
345	São Bento (PB)
346	São Bentinho (PB)
347	São Domingos do Cariri (PB)
348	São Domingos (PB)
349	São Francisco (PB)
350	São João do Cariri (PB)
351	São João do Tigre (PB)
352	São José da Lagoa Tapada (PB)
353	São José de Caiana (PB)
354	São José de Espinharas (PB)
355	São José dos Ramos (PB)
356	São José de Piranhas (PB)
357	São José de Princesa (PB)
358	São José do Bonfim (PB)
359	São José do Brejo do Cruz (PB)
360	São José do Sabugi (PB)
361	São José dos Cordeiros (PB)
362	São Mamede (PB)
363	São Miguel de Taipu (PB)
364	São Sebastião de Lagoa de Roça (PB)
365	São Sebastião do Umbuzeiro (PB)
366	Sapé (PB)
367	São Vicente do Seridó (PB)
368	Serra Branca (PB)
369	Serra da Raiz (PB)
370	Serra Grande (PB)
371	Serra Redonda (PB)
372	Serraria (PB)
373	Sertãozinho (PB)
374	Sobrado (PB)
375	Solânea (PB)
376	Soledade (PB)
377	Sossêgo (PB)
378	Sousa (PB)
379	Sumé (PB)
380	Tacima (PB)
381	Taperoá (PB)
382	Tavares (PB)
383	Teixeira (PB)
384	Tenório (PB)
385	Triunfo (PB)
386	Uiraúna (PB)
387	Umbuzeiro (PB)
388	Várzea (PB)
389	Vieirópolis (PB)
390	Zabelê (PB)
391	Abreu e Lima (PE)
392	Afogados da Ingazeira (PE)
393	Afrânio (PE)
394	Agrestina (PE)
395	Água Preta (PE)
396	Águas Belas (PE)
397	Alagoinha (PE)
398	Aliança (PE)
399	Altinho (PE)
400	Amaraji (PE)
401	Angelim (PE)
402	Araçoiaba (PE)
403	Araripina (PE)
404	Arcoverde (PE)
405	Barra de Guabiraba (PE)
406	Barreiros (PE)
407	Belém de Maria (PE)
408	Belém do São Francisco (PE)
409	Belo Jardim (PE)
410	Betânia (PE)
411	Bezerros (PE)
412	Bodocó (PE)
413	Bom Conselho (PE)
414	Bom Jardim (PE)
415	Bonito (PE)
416	Brejão (PE)
417	Brejinho (PE)
418	Brejo da Madre de Deus (PE)
419	Buenos Aires (PE)
420	Buíque (PE)
421	Cabo de Santo Agostinho (PE)
422	Cabrobó (PE)
423	Cachoeirinha (PE)
424	Caetés (PE)
425	Calçado (PE)
426	Calumbi (PE)
427	Camaragibe (PE)
428	Camocim de São Félix (PE)
429	Camutanga (PE)
430	Canhotinho (PE)
431	Capoeiras (PE)
432	Carnaíba (PE)
433	Carnaubeira da Penha (PE)
434	Carpina (PE)
435	Caruaru (PE)
436	Casinhas (PE)
437	Catende (PE)
438	Cedro (PE)
439	Chã de Alegria (PE)
440	Chã Grande (PE)
441	Condado (PE)
442	Correntes (PE)
443	Cortês (PE)
444	Cumaru (PE)
445	Cupira (PE)
446	Custódia (PE)
447	Dormentes (PE)
448	Escada (PE)
449	Exu (PE)
450	Feira Nova (PE)
451	Fernando de Noronha (PE)
452	Ferreiros (PE)
453	Flores (PE)
454	Floresta (PE)
455	Frei Miguelinho (PE)
456	Gameleira (PE)
457	Garanhuns (PE)
458	Glória do Goitá (PE)
459	Goiana (PE)
460	Granito (PE)
461	Gravatá (PE)
462	Iati (PE)
463	Ibimirim (PE)
464	Ibirajuba (PE)
465	Igarassu (PE)
466	Iguaracy (PE)
467	Inajá (PE)
468	Ingazeira (PE)
469	Ipojuca (PE)
470	Ipubi (PE)
471	Itacuruba (PE)
472	Itaíba (PE)
473	Ilha de Itamaracá (PE)
474	Itambé (PE)
475	Itapetim (PE)
476	Itapissuma (PE)
477	Itaquitinga (PE)
478	Jaboatão dos Guararapes (PE)
479	Jaqueira (PE)
480	Jataúba (PE)
481	Jatobá (PE)
482	João Alfredo (PE)
483	Joaquim Nabuco (PE)
484	Jucati (PE)
485	Jupi (PE)
486	Jurema (PE)
487	Lagoa do Carro (PE)
488	Lagoa de Itaenga (PE)
489	Lagoa do Ouro (PE)
490	Lagoa dos Gatos (PE)
491	Lagoa Grande (PE)
492	Lajedo (PE)
493	Limoeiro (PE)
494	Macaparana (PE)
495	Machados (PE)
496	Manari (PE)
497	Maraial (PE)
498	Mirandiba (PE)
499	Moreno (PE)
500	Nazaré da Mata (PE)
501	Olinda (PE)
502	Orobó (PE)
503	Orocó (PE)
504	Ouricuri (PE)
505	Palmares (PE)
506	Palmeirina (PE)
507	Panelas (PE)
508	Paranatama (PE)
509	Parnamirim (PE)
510	Passira (PE)
511	Paudalho (PE)
512	Paulista (PE)
513	Pedra (PE)
514	Pesqueira (PE)
515	Petrolândia (PE)
516	Petrolina (PE)
517	Poção (PE)
518	Pombos (PE)
519	Primavera (PE)
520	Quipapá (PE)
521	Quixaba (PE)
522	Recife (PE)
523	Riacho das Almas (PE)
524	Ribeirão (PE)
525	Rio Formoso (PE)
526	Sairé (PE)
527	Salgadinho (PE)
528	Salgueiro (PE)
529	Saloá (PE)
530	Sanharó (PE)
531	Santa Cruz (PE)
532	Santa Cruz da Baixa Verde (PE)
533	Santa Cruz do Capibaribe (PE)
534	Santa Filomena (PE)
535	Santa Maria da Boa Vista (PE)
536	Santa Maria do Cambucá (PE)
537	Santa Terezinha (PE)
538	São Benedito do Sul (PE)
539	São Bento do Una (PE)
540	São Caitano (PE)
541	São João (PE)
542	São Joaquim do Monte (PE)
543	São José da Coroa Grande (PE)
544	São José do Belmonte (PE)
545	São José do Egito (PE)
546	São Lourenço da Mata (PE)
547	São Vicente Férrer (PE)
548	Serra Talhada (PE)
549	Serrita (PE)
550	Sertânia (PE)
551	Sirinhaém (PE)
552	Moreilândia (PE)
553	Solidão (PE)
554	Surubim (PE)
555	Tabira (PE)
556	Tacaimbó (PE)
557	Tacaratu (PE)
558	Tamandaré (PE)
559	Taquaritinga do Norte (PE)
560	Terezinha (PE)
561	Terra Nova (PE)
562	Timbaúba (PE)
563	Toritama (PE)
564	Tracunhaém (PE)
565	Trindade (PE)
566	Triunfo (PE)
567	Tupanatinga (PE)
568	Tuparetama (PE)
569	Venturosa (PE)
570	Verdejante (PE)
571	Vertente do Lério (PE)
572	Vertentes (PE)
573	Vicência (PE)
574	Vitória de Santo Antão (PE)
575	Xexéu (PE)
576	Abaiara (CE)
577	Acarape (CE)
578	Acaraú (CE)
579	Acopiara (CE)
580	Aiuaba (CE)
581	Alcântaras (CE)
582	Altaneira (CE)
583	Alto Santo (CE)
584	Amontada (CE)
585	Antonina do Norte (CE)
586	Apuiarés (CE)
587	Aquiraz (CE)
588	Aracati (CE)
589	Aracoiaba (CE)
590	Ararendá (CE)
591	Araripe (CE)
592	Aratuba (CE)
593	Arneiroz (CE)
594	Assaré (CE)
595	Aurora (CE)
596	Baixio (CE)
597	Banabuiú (CE)
598	Barbalha (CE)
599	Barreira (CE)
600	Barro (CE)
601	Barroquinha (CE)
602	Baturité (CE)
603	Beberibe (CE)
604	Bela Cruz (CE)
605	Boa Viagem (CE)
606	Brejo Santo (CE)
607	Camocim (CE)
608	Campos Sales (CE)
609	Canindé (CE)
610	Capistrano (CE)
611	Caridade (CE)
612	Cariré (CE)
613	Caririaçu (CE)
614	Cariús (CE)
615	Carnaubal (CE)
616	Cascavel (CE)
617	Catarina (CE)
618	Catunda (CE)
619	Caucaia (CE)
620	Cedro (CE)
621	Chaval (CE)
622	Choró (CE)
623	Chorozinho (CE)
624	Coreaú (CE)
625	Crateús (CE)
626	Crato (CE)
627	Croatá (CE)
628	Cruz (CE)
629	Deputado Irapuan Pinheiro (CE)
630	Ereré (CE)
631	Eusébio (CE)
632	Farias Brito (CE)
633	Forquilha (CE)
634	Fortaleza (CE)
635	Fortim (CE)
636	Frecheirinha (CE)
637	General Sampaio (CE)
638	Graça (CE)
639	Granja (CE)
640	Granjeiro (CE)
641	Groaíras (CE)
642	Guaiúba (CE)
643	Guaraciaba do Norte (CE)
644	Guaramiranga (CE)
645	Hidrolândia (CE)
646	Horizonte (CE)
647	Ibaretama (CE)
648	Ibiapina (CE)
649	Ibicuitinga (CE)
650	Icapuí (CE)
651	Icó (CE)
652	Iguatu (CE)
653	Independência (CE)
654	Ipaporanga (CE)
655	Ipaumirim (CE)
656	Ipu (CE)
657	Ipueiras (CE)
658	Iracema (CE)
659	Irauçuba (CE)
660	Itaiçaba (CE)
661	Itaitinga (CE)
662	Itapajé (CE)
663	Itapipoca (CE)
664	Itapiúna (CE)
665	Itarema (CE)
666	Itatira (CE)
667	Jaguaretama (CE)
668	Jaguaribara (CE)
669	Jaguaribe (CE)
670	Jaguaruana (CE)
671	Jardim (CE)
672	Jati (CE)
673	Jijoca de Jericoacoara (CE)
674	Juazeiro do Norte (CE)
675	Jucás (CE)
676	Lavras da Mangabeira (CE)
677	Limoeiro do Norte (CE)
678	Madalena (CE)
679	Maracanaú (CE)
680	Maranguape (CE)
681	Marco (CE)
682	Martinópole (CE)
683	Massapê (CE)
684	Mauriti (CE)
685	Meruoca (CE)
686	Milagres (CE)
687	Milhã (CE)
688	Miraíma (CE)
689	Missão Velha (CE)
690	Mombaça (CE)
691	Monsenhor Tabosa (CE)
692	Morada Nova (CE)
693	Moraújo (CE)
694	Morrinhos (CE)
695	Mucambo (CE)
696	Mulungu (CE)
697	Nova Olinda (CE)
698	Nova Russas (CE)
699	Novo Oriente (CE)
700	Ocara (CE)
701	Orós (CE)
702	Pacajus (CE)
703	Pacatuba (CE)
704	Pacoti (CE)
705	Pacujá (CE)
706	Palhano (CE)
707	Palmácia (CE)
708	Paracuru (CE)
709	Paraipaba (CE)
710	Parambu (CE)
711	Paramoti (CE)
712	Pedra Branca (CE)
713	Penaforte (CE)
714	Pentecoste (CE)
715	Pereiro (CE)
716	Pindoretama (CE)
717	Piquet Carneiro (CE)
718	Pires Ferreira (CE)
719	Poranga (CE)
720	Porteiras (CE)
721	Potengi (CE)
722	Potiretama (CE)
723	Quiterianópolis (CE)
724	Quixadá (CE)
725	Quixelô (CE)
726	Quixeramobim (CE)
727	Quixeré (CE)
728	Redenção (CE)
729	Reriutaba (CE)
730	Russas (CE)
731	Saboeiro (CE)
732	Salitre (CE)
733	Santana do Acaraú (CE)
734	Santana do Cariri (CE)
735	Santa Quitéria (CE)
736	São Benedito (CE)
737	São Gonçalo do Amarante (CE)
738	São João do Jaguaribe (CE)
739	São Luís do Curu (CE)
740	Senador Pompeu (CE)
741	Senador Sá (CE)
742	Sobral (CE)
743	Solonópole (CE)
744	Tabuleiro do Norte (CE)
745	Tamboril (CE)
746	Tarrafas (CE)
747	Tauá (CE)
748	Tejuçuoca (CE)
749	Tianguá (CE)
750	Trairi (CE)
751	Tururu (CE)
752	Ubajara (CE)
753	Umari (CE)
754	Umirim (CE)
755	Uruburetama (CE)
756	Uruoca (CE)
757	Varjota (CE)
758	Várzea Alegre (CE)
759	Viçosa do Ceará (CE)
\.


--
-- Data for Name: company_partner; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.company_partner (id, cnpj) FROM stdin;
16885bfb-2530-408a-9824-0d0f7c84eb84	40662925000112
d1af9e50-a745-488d-bebe-8c64d934abf4	\N
0d4f14cf-ba3b-4425-8426-7452be9fb3ac	60377990000103
f467f142-e8a9-4536-bdca-b8178be17caa	65630775000196
daffb955-173f-4c74-9ac2-9fb63c335136	\N
\.


--
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employee (id, name, created_at, deleted_at, confirmed) FROM stdin;
a5fa2fe0-564c-4174-8087-234f6e62f731	Donzelitos dantas	2026-02-02 18:25:49.30326-03	\N	f
3f75f15b-5d44-410b-8cde-5067188befa5	Felipinho da Silva	2026-02-02 18:25:49.30326-03	\N	f
d622a2cb-52a9-4d06-87d9-6da07a779830	fernando igor	2026-02-02 18:25:49.30326-03	\N	f
8f9fea32-1578-415f-8910-ee84d02afafe	Eustrucio da silva	2026-02-03 03:24:22.448222-03	\N	f
079f833f-03e4-49bc-9a04-2ae74ec5d264	MONIQUE	2026-02-03 04:02:20.833124-03	\N	f
3426fbe8-3857-4ffe-a98d-c003916c2fa5	HELENO DE BARROS	2026-02-03 03:52:28.843614-03	2026-02-03 04:05:00.129019-03	f
cae828c2-b9a2-422f-bf79-5d2f68e24faa	ATILA	2026-02-03 04:02:26.074246-03	2026-02-03 04:26:06.976261-03	f
15a62094-2ecd-451f-b4ee-f5202a0fc105	FUNCIONARIO X	2026-02-05 02:49:05.008599-03	\N	f
a43f6ff1-68b2-4dec-aef2-ab1323732682	GERMANO	2026-02-03 03:21:29.72194-03	2026-02-05 04:21:29.600787-03	f
92a2da8a-1af8-445f-bf38-98c81095ba30	Alan 	2026-02-03 04:02:15.03345-03	2026-02-08 19:45:07.566986-03	f
4b7b6c22-bab6-442f-924b-de249c9c58ef	REAN DA SILVA SAURO	2026-02-03 03:52:20.307332-03	\N	f
\.


--
-- Data for Name: employee_payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employee_payment (id, payment, employee_id, payment_change_date, spent_category_id, created_at, deleted_at, confirmed) FROM stdin;
2	3456.34	d622a2cb-52a9-4d06-87d9-6da07a779830	2026-02-02	2	2026-02-05 01:44:32.403129-03	\N	f
4	2345.23	3f75f15b-5d44-410b-8cde-5067188befa5	2026-02-02	2	2026-02-05 01:44:32.403129-03	\N	f
6	1233.12	d622a2cb-52a9-4d06-87d9-6da07a779830	2026-01-30	2	2026-02-05 01:44:32.403129-03	\N	f
7	2344.12	3f75f15b-5d44-410b-8cde-5067188befa5	2026-01-30	2	2026-02-05 01:44:32.403129-03	\N	f
8	1000.00	d622a2cb-52a9-4d06-87d9-6da07a779830	2026-02-02	2	2026-02-05 01:44:32.403129-03	\N	f
11	1231.00	d622a2cb-52a9-4d06-87d9-6da07a779830	2026-02-03	2	2026-02-05 01:44:32.403129-03	\N	f
12	1234.00	8f9fea32-1578-415f-8910-ee84d02afafe	2026-02-03	2	2026-02-05 01:44:32.403129-03	\N	f
13	1231.00	3f75f15b-5d44-410b-8cde-5067188befa5	2026-02-03	2	2026-02-05 01:44:32.403129-03	\N	f
14	924.13	d622a2cb-52a9-4d06-87d9-6da07a779830	2026-02-03	2	2026-02-05 01:44:32.403129-03	\N	f
9	1234.00	a43f6ff1-68b2-4dec-aef2-ab1323732682	2026-02-03	2	2026-02-05 01:44:32.403129-03	\N	t
10	1231.00	a5fa2fe0-564c-4174-8087-234f6e62f731	2026-02-03	2	2026-02-05 01:44:32.403129-03	\N	t
3	1234.12	a5fa2fe0-564c-4174-8087-234f6e62f731	2026-02-02	2	2026-02-05 01:44:32.403129-03	\N	t
5	1233.12	a5fa2fe0-564c-4174-8087-234f6e62f731	2026-01-30	2	2026-02-05 01:44:32.403129-03	\N	t
18	35000000.00	d622a2cb-52a9-4d06-87d9-6da07a779830	2026-02-05	2	2026-02-05 02:48:02.745689-03	2026-02-05 02:48:16.607919-03	f
\.


--
-- Data for Name: measurement_unit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.measurement_unit (id, name, plural_name, symbol, unit) FROM stdin;
1	Quilograma	Quilogramas	Kg	Peso
2	Litro	Litros	L	Volume
3	Metro Cúbico	Metros Cúbicos	m3	Volume
4	UNIDADEs	UNIDADES	UN	UNIDADE
\.


--
-- Data for Name: partner; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.partner (id, name, email, phone, city_id, role_id, created_at, deleted_at, confirmed) FROM stdin;
a8c29980-6638-45e2-a3b0-aa280b802a68	cliente maluco			238	1	2026-02-03 00:52:54.62257-03	2026-02-03 00:52:57.742992-03	f
17143286-1e17-4e4f-957a-06313bbc146e	Tião do leite		23523523523	135	2	2026-01-27 16:33:29.627966-03	\N	t
d1af9e50-a745-488d-bebe-8c64d934abf4	Mercado			23	2	2026-01-27 23:32:48.626345-03	\N	t
b18699ef-5fda-47a2-b28c-f2a2b00bd022	PARA DELETAR			1	1	2026-02-04 19:52:14.768184-03	2026-02-04 19:52:17.861376-03	f
51cf4853-8c81-4ec5-95e2-80fb24dc5cce	PESSOA TO DELETE			17	1	2026-02-04 19:56:37.273701-03	2026-02-04 19:56:46.033915-03	f
2aab3e29-0eab-48d6-b159-7c6d6f220b68	PESSOA COMUM 			62	1	2026-02-04 18:29:08.929038-03	\N	f
e2ac0af7-cd0a-4e84-84d1-35a6a0aa22a9	Fornecedor X			21	2	2026-02-05 00:28:13.540994-03	\N	t
f467f142-e8a9-4536-bdca-b8178be17caa	Supermercado REDE SERIDÓ	redeserido@grupo.com	84998045544	23	1	2026-01-30 02:19:45.240062-03	\N	t
0d4f14cf-ba3b-4425-8426-7452be9fb3ac	Supermercado penedos	penedo@supermercado.com	84993240231	23	1	2026-01-30 02:18:13.204009-03	\N	t
16885bfb-2530-408a-9824-0d0f7c84eb84	Sítio TESTE 0010	sitioTEST0001@test.test	48573405876	23	2	2026-01-27 14:56:10.435116-03	\N	t
daffb955-173f-4c74-9ac2-9fb63c335136	Carrefour zona sul			89	1	2026-02-02 15:07:52.016608-03	\N	t
\.


--
-- Data for Name: partner_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.partner_role (id, name) FROM stdin;
1	Cliente
2	Fornecedor
\.


--
-- Data for Name: personal_partner; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personal_partner (id, cpf) FROM stdin;
17143286-1e17-4e4f-957a-06313bbc146e	\N
a8c29980-6638-45e2-a3b0-aa280b802a68	\N
b18699ef-5fda-47a2-b28c-f2a2b00bd022	\N
51cf4853-8c81-4ec5-95e2-80fb24dc5cce	\N
2aab3e29-0eab-48d6-b159-7c6d6f220b68	\N
e2ac0af7-cd0a-4e84-84d1-35a6a0aa22a9	\N
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product (id, name, description, category_id, measurement_unit_id, quantity, created_at, deleted_at, confirmed) FROM stdin;
1	Queijo Coalho	Queijo Coalho de 1 Kg Empacotado	1	1	1.000	2026-01-27 14:49:14.197499-03	\N	t
4	Queijo Mussarela	Queijo Mussarela 500 g	1	1	0.500	2026-01-27 14:54:08.332932-03	\N	t
3	Iogurte	Iogurte varios sabores 900 g	2	1	0.900	2026-01-27 14:50:37.469576-03	\N	t
2	Queijo Manteiga	Queijo Manteiga fatiado 2 Kg	1	1	2.000	2026-01-27 14:50:05.37436-03	\N	t
5	Queijo Mussarela	Queijo Mussarela de 1 Kg	1	1	1.000	2026-01-27 14:54:43.268609-03	\N	t
6	Manteiga de garrafaa	mateiga de garrafa 200g	4	1	0.200	2026-02-09 02:03:19.962633-03	\N	t
7	Nata	Nata comum	3	1	0.500	2026-02-09 02:06:25.811494-03	\N	t
\.


--
-- Data for Name: product_category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_category (id, name) FROM stdin;
1	Queijo
2	Iogurte
3	Nata
4	Manteiga
\.


--
-- Data for Name: product_price; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_price (id, product_id, price, price_change_date) FROM stdin;
1	1	25.50	2026-01-27 14:49:14.186019-03
2	2	44.00	2026-01-27 14:50:05.37436-03
3	3	3.20	2026-01-27 14:50:37.46858-03
4	4	18.50	2026-01-27 14:54:08.332932-03
5	5	37.00	2026-01-27 14:54:43.268609-03
6	1	28.50	2026-01-28 14:21:32.421979-03
7	1	32.50	2026-01-31 14:38:45.459642-03
8	5	32.00	2026-02-01 00:54:31.38219-03
9	6	8.20	2026-02-09 02:03:19.956931-03
10	7	14.00	2026-02-09 02:06:25.805075-03
\.


--
-- Data for Name: production; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.production (id, product_id, created_at, deleted_at, confirmed, quantity_produced, date, gross_quantity_produced, gqp_measurement_unit_id, raw_material_purchase_date, quantity_used) FROM stdin;
10	1	2026-02-08 22:36:21.581698-03	\N	f	257.000	2026-02-08	257.000	1	2025-12-09	2500.000
11	5	2026-02-08 23:05:06.095236-03	\N	f	12890.000	2026-02-08	12890.000	1	2026-02-05	120800.000
12	1	2026-02-08 23:21:04.194307-03	2026-02-09 01:39:48.358145-03	f	13.000	2026-02-08	13.000	1	2026-02-02	123.000
13	4	2026-02-09 01:44:23.701358-03	\N	f	24.000	2025-12-31	12.000	1	2026-02-01	123.000
15	3	2026-02-09 01:49:05.382278-03	2026-02-09 01:58:27.722413-03	f	411.000	2026-02-01	411.000	1	2025-12-09	200.000
14	3	2026-02-09 01:47:14.50887-03	\N	f	225.000	2026-02-09	225.000	1	2026-02-02	155.501
\.


--
-- Data for Name: purchase; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purchase (id, partner_id, raw_material_id, quantity, measurement_unit_id, price_per_unit, date, created_at, deleted_at, confirmed, note, spent_category_id) FROM stdin;
1002	16885bfb-2530-408a-9824-0d0f7c84eb84	1	2500.000	2	2.15	2026-02-01	2026-02-01 17:09:20.329194-03	\N	t		1
1007	17143286-1e17-4e4f-957a-06313bbc146e	1	10000.000	2	6.00	2026-02-03	2026-02-03 02:46:38.64699-03	2026-02-03 02:48:37.902474-03	f		1
1008	17143286-1e17-4e4f-957a-06313bbc146e	1	3000.000	2	4.00	2026-02-03	2026-02-03 02:48:14.310692-03	\N	t		1
1010	16885bfb-2530-408a-9824-0d0f7c84eb84	1	10000.000	2	1.00	2026-02-04	2026-02-04 17:50:32.087753-03	2026-02-04 17:50:47.857649-03	f		1
1005	16885bfb-2530-408a-9824-0d0f7c84eb84	1	200.000	2	2.00	2026-02-02	2026-02-02 23:37:13.553542-03	\N	t		1
1004	16885bfb-2530-408a-9824-0d0f7c84eb84	1	250.000	2	1.00	2026-02-02	2026-02-02 15:16:00.675665-03	\N	t		1
1011	16885bfb-2530-408a-9824-0d0f7c84eb84	1	2345.000	2	2.00	2026-02-04	2026-02-04 18:07:22.065601-03	2026-02-04 18:09:04.850665-03	f		1
1006	16885bfb-2530-408a-9824-0d0f7c84eb84	1	5000.000	2	5.00	2026-02-03	2026-02-03 02:44:24.292689-03	\N	t		1
1013	e2ac0af7-cd0a-4e84-84d1-35a6a0aa22a9	1	4001.000	2	1.89	2026-02-04	2026-02-05 02:05:52.816379-03	\N	t	muito leite barato	1
1015	e2ac0af7-cd0a-4e84-84d1-35a6a0aa22a9	1	4578.000	2	3.45	2025-12-09	2026-02-08 22:18:55.841629-03	\N	t	leite caroo	1
1016	17143286-1e17-4e4f-957a-06313bbc146e	1	4578.000	2	0.89	2025-12-09	2026-02-08 22:26:00.938611-03	\N	f	leito baratasso	1
1012	e2ac0af7-cd0a-4e84-84d1-35a6a0aa22a9	1	1234.001	2	1.20	2026-02-05	2026-02-05 00:28:22.072125-03	\N	t	qwer	1
\.


--
-- Data for Name: raw_material; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.raw_material (id, name, description, created_at, deleted_at) FROM stdin;
1	Leite	Leite Comum	2026-01-27 14:55:08.694757-03	\N
2	Coalhante	Coalhante para queijo	2026-01-27 23:33:20.255309-03	\N
3	Sal	Sal marinho comum	2026-01-27 23:35:16.766084-03	\N
\.


--
-- Data for Name: sale; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sale (id, client_id, created_at, deleted_at, confirmed, date) FROM stdin;
35	f467f142-e8a9-4536-bdca-b8178be17caa	2026-02-10 18:01:07.911997-03	\N	f	2026-02-10
36	daffb955-173f-4c74-9ac2-9fb63c335136	2026-02-10 19:05:55.039166-03	\N	f	2026-01-21
\.


--
-- Data for Name: sale_product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sale_product (id, product_id, quantity, sale_id, product_price_on_sale_date) FROM stdin;
46	1	1234.000	35	32.50
47	4	1234.000	35	18.50
48	3	1234.000	35	3.20
49	5	1234.000	35	32.00
50	6	321.000	36	8.20
51	7	321.000	36	14.00
52	5	321.000	36	37.00
\.


--
-- Data for Name: spent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spent (id, description, amount_paid, category_id, date, created_at, deleted_at, confirmed) FROM stdin;
1	conta de luz	1250.33	3	2026-01-05	2026-02-02 01:20:51.550825-03	\N	f
2	Conta de água	500.32	4	2026-01-05	2026-02-02 01:31:02.524889-03	\N	f
3	coisas	43.20	9	2026-02-02	2026-02-02 01:35:41.827185-03	\N	f
5		111.00	7	2026-02-02	2026-02-02 01:36:35.072514-03	\N	f
6	carro quebour	456.00	5	2026-02-02	2026-02-02 01:37:42.709125-03	\N	f
7	Gasolina	321.12	6	2026-02-02	2026-02-02 01:41:43.098623-03	\N	f
9	+++++++++++++	345.45	3	2026-02-02	2026-02-02 15:21:24.414882-03	\N	t
10	conta cara	4095.34	3	2026-02-05	2026-02-05 02:49:26.225302-03	\N	t
4	embalagems seladasssss	1200.00	8	2026-02-09	2026-02-02 01:36:05.961687-03	\N	f
8	CONTA x CONTA	300.00	5	2026-02-03	2026-02-02 15:18:18.135695-03	\N	f
11	mt dinheiro	35234539.10	3	2026-02-09	2026-02-09 02:08:02.822595-03	2026-02-09 23:30:14.051806-03	f
\.


--
-- Data for Name: spent_category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spent_category (id, name) FROM stdin;
1	Matéria-Prima
3	Energia
4	Àgua
5	Manutenção
6	Transporte
7	Imposto
8	Embalagem
9	Outros
2	Pagamento de funcionário
\.


--
-- Name: city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.city_id_seq', 759, true);


--
-- Name: employee_wage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employee_wage_id_seq', 18, true);


--
-- Name: measurement_unit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.measurement_unit_id_seq', 4, true);


--
-- Name: partner_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.partner_role_id_seq', 2, true);


--
-- Name: product_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_category_id_seq', 3, true);


--
-- Name: product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_id_seq', 7, true);


--
-- Name: product_price_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_price_id_seq', 10, true);


--
-- Name: production_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.production_id_seq', 15, true);


--
-- Name: purchase_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.purchase_id_seq', 1016, true);


--
-- Name: raw_material_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.raw_material_id_seq', 3, true);


--
-- Name: sale_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sale_id_seq', 36, true);


--
-- Name: sale_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sale_product_id_seq', 52, true);


--
-- Name: spent_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.spent_category_id_seq', 9, true);


--
-- Name: spent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.spent_id_seq', 11, true);


--
-- Name: city city_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (id);


--
-- Name: city city_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_unique UNIQUE (name);


--
-- Name: company_partner cnpj_format; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.company_partner
    ADD CONSTRAINT cnpj_format CHECK (((cnpj IS NULL) OR ((cnpj)::text ~ '^[0-9]{14}$'::text))) NOT VALID;


--
-- Name: company_partner company_partner_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company_partner
    ADD CONSTRAINT company_partner_pkey PRIMARY KEY (id);


--
-- Name: personal_partner cpf_format; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.personal_partner
    ADD CONSTRAINT cpf_format CHECK (((cpf IS NULL) OR ((cpf)::text ~ '^[0-9]{11}$'::text))) NOT VALID;


--
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (id);


--
-- Name: employee_payment employee_wage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_payment
    ADD CONSTRAINT employee_wage_pkey PRIMARY KEY (id);


--
-- Name: measurement_unit measurement_unit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measurement_unit
    ADD CONSTRAINT measurement_unit_pkey PRIMARY KEY (id);


--
-- Name: partner partner_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partner
    ADD CONSTRAINT partner_pkey PRIMARY KEY (id);


--
-- Name: partner_role partner_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partner_role
    ADD CONSTRAINT partner_role_pkey PRIMARY KEY (id);


--
-- Name: personal_partner personal_partner_cpf_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_partner
    ADD CONSTRAINT personal_partner_cpf_key UNIQUE (cpf);


--
-- Name: personal_partner personal_partner_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_partner
    ADD CONSTRAINT personal_partner_pkey PRIMARY KEY (id);


--
-- Name: product_category product_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_category
    ADD CONSTRAINT product_category_pkey PRIMARY KEY (id);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- Name: product_price product_price_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_price
    ADD CONSTRAINT product_price_pkey PRIMARY KEY (id);


--
-- Name: production production_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.production
    ADD CONSTRAINT production_pkey PRIMARY KEY (id);


--
-- Name: purchase purchase_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT purchase_pkey PRIMARY KEY (id);


--
-- Name: raw_material raw_material_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.raw_material
    ADD CONSTRAINT raw_material_pkey PRIMARY KEY (id);


--
-- Name: sale sale_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale
    ADD CONSTRAINT sale_pkey PRIMARY KEY (id);


--
-- Name: sale_product sale_production_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale_product
    ADD CONSTRAINT sale_production_pkey PRIMARY KEY (id);


--
-- Name: purchase spent_category_id_checker; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.purchase
    ADD CONSTRAINT spent_category_id_checker CHECK ((spent_category_id = 1)) NOT VALID;


--
-- Name: employee_payment spent_category_id_cheker; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.employee_payment
    ADD CONSTRAINT spent_category_id_cheker CHECK ((spent_category_id = 2)) NOT VALID;


--
-- Name: spent_category spent_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spent_category
    ADD CONSTRAINT spent_category_pkey PRIMARY KEY (id);


--
-- Name: spent spent_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spent
    ADD CONSTRAINT spent_pkey PRIMARY KEY (id);


--
-- Name: fki_category_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_category_fkey ON public.product USING btree (category_id);


--
-- Name: fki_city_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_city_fkey ON public.partner USING btree (city_id);


--
-- Name: fki_client_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_client_fkey ON public.sale USING btree (client_id);


--
-- Name: fki_employee_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_employee_fkey ON public.employee_payment USING btree (employee_id);


--
-- Name: fki_measurement_unit_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_measurement_unit_fkey ON public.purchase USING btree (measurement_unit_id);


--
-- Name: fki_partner_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_partner_fkey ON public.company_partner USING btree (id);


--
-- Name: fki_product_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_product_fkey ON public.sale_product USING btree (product_id);


--
-- Name: fki_raw_material_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_raw_material_fkey ON public.purchase USING btree (raw_material_id);


--
-- Name: fki_role_fkey; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_role_fkey ON public.partner USING btree (role_id);


--
-- Name: production_full _RETURN; Type: RULE; Schema: public; Owner: postgres
--

CREATE OR REPLACE VIEW public.production_full AS
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
    avg(pur.price_per_unit) AS avg_raw_material_unit_price,
    p.raw_material_purchase_date,
    p.quantity_used,
    p.date,
    p.created_at,
    p.deleted_at,
    p.confirmed
   FROM (((((public.production p
     JOIN public.product prod ON ((prod.id = p.product_id)))
     JOIN public.measurement_unit mu ON ((mu.id = p.gqp_measurement_unit_id)))
     JOIN public.measurement_unit muu ON ((muu.id = prod.measurement_unit_id)))
     LEFT JOIN LATERAL ( SELECT product_price.price
           FROM public.product_price
          WHERE (product_price.product_id = prod.id)
          ORDER BY product_price.price_change_date DESC
         LIMIT 1) pp ON (true))
     JOIN public.purchase pur ON ((pur.date = p.raw_material_purchase_date)))
  WHERE (p.deleted_at IS NULL)
  GROUP BY p.id, prod.name, prod.description, prod.quantity, pp.price, muu.symbol, p.quantity_produced, p.gross_quantity_produced, mu.unit, mu.name, mu.plural_name, mu.symbol, p.date, p.created_at, p.deleted_at, p.confirmed;


--
-- Name: sale_product trg_set_product_price_on_sale; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_set_product_price_on_sale BEFORE INSERT ON public.sale_product FOR EACH ROW EXECUTE FUNCTION public.set_product_price_on_sale();


--
-- Name: employee_payment category_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_payment
    ADD CONSTRAINT category_fkey FOREIGN KEY (spent_category_id) REFERENCES public.spent_category(id) NOT VALID;


--
-- Name: product category_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT category_fkey FOREIGN KEY (category_id) REFERENCES public.product_category(id) NOT VALID;


--
-- Name: purchase category_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT category_fkey FOREIGN KEY (spent_category_id) REFERENCES public.spent_category(id) NOT VALID;


--
-- Name: spent category_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spent
    ADD CONSTRAINT category_fkey FOREIGN KEY (category_id) REFERENCES public.spent_category(id) NOT VALID;


--
-- Name: partner city_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partner
    ADD CONSTRAINT city_fkey FOREIGN KEY (city_id) REFERENCES public.city(id) NOT VALID;


--
-- Name: sale client_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale
    ADD CONSTRAINT client_fkey FOREIGN KEY (client_id) REFERENCES public.partner(id) NOT VALID;


--
-- Name: employee_payment employee_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_payment
    ADD CONSTRAINT employee_fkey FOREIGN KEY (employee_id) REFERENCES public.employee(id) NOT VALID;


--
-- Name: product measurement_unit_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT measurement_unit_fkey FOREIGN KEY (measurement_unit_id) REFERENCES public.measurement_unit(id) NOT VALID;


--
-- Name: production measurement_unit_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.production
    ADD CONSTRAINT measurement_unit_fkey FOREIGN KEY (gqp_measurement_unit_id) REFERENCES public.measurement_unit(id) NOT VALID;


--
-- Name: purchase measurement_unit_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT measurement_unit_fkey FOREIGN KEY (measurement_unit_id) REFERENCES public.measurement_unit(id) NOT VALID;


--
-- Name: company_partner partner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company_partner
    ADD CONSTRAINT partner_fkey FOREIGN KEY (id) REFERENCES public.partner(id) NOT VALID;


--
-- Name: personal_partner partner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_partner
    ADD CONSTRAINT partner_fkey FOREIGN KEY (id) REFERENCES public.partner(id) NOT VALID;


--
-- Name: purchase partner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT partner_fkey FOREIGN KEY (partner_id) REFERENCES public.partner(id) NOT VALID;


--
-- Name: sale_product product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale_product
    ADD CONSTRAINT product_fkey FOREIGN KEY (product_id) REFERENCES public.product(id) NOT VALID;


--
-- Name: purchase raw_material_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT raw_material_fkey FOREIGN KEY (raw_material_id) REFERENCES public.raw_material(id) NOT VALID;


--
-- Name: partner role_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partner
    ADD CONSTRAINT role_fkey FOREIGN KEY (role_id) REFERENCES public.partner_role(id) NOT VALID;


--
-- PostgreSQL database dump complete
--

\unrestrict 24vdpRgw1Q67eHL9UWI9Df3kw6xagH4pIChIMiLRj6QDi0BE5sBnhOnahxkZPET

