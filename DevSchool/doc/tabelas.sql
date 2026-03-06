--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

-- Started on 2026-03-06 11:39:02

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
-- TOC entry 218 (class 1259 OID 65550)
-- Name: leads; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.leads (
    id integer NOT NULL,
    nome character varying(150) NOT NULL,
    email character varying(150),
    telefone character varying(20),
    status character varying(50) DEFAULT 'Inscrito'::character varying,
    nivel_conhecimento character varying(50),
    interesse_curso character varying(100),
    score integer DEFAULT 50
);


--
-- TOC entry 217 (class 1259 OID 65549)
-- Name: leads_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.leads_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4839 (class 0 OID 0)
-- Dependencies: 217
-- Name: leads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.leads_id_seq OWNED BY public.leads.id;


--
-- TOC entry 220 (class 1259 OID 65561)
-- Name: produtos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.produtos (
    id integer NOT NULL,
    nome character varying(150) NOT NULL,
    descricao text,
    preco numeric(10,2) DEFAULT 0 NOT NULL,
    quantidade integer DEFAULT 0
);


--
-- TOC entry 219 (class 1259 OID 65560)
-- Name: produtos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.produtos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4840 (class 0 OID 0)
-- Dependencies: 219
-- Name: produtos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.produtos_id_seq OWNED BY public.produtos.id;


--
-- TOC entry 216 (class 1259 OID 65539)
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    nome character varying(150) NOT NULL,
    email character varying(150) NOT NULL,
    senha character varying(255) NOT NULL
);


--
-- TOC entry 215 (class 1259 OID 65538)
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
-- TOC entry 4841 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 224 (class 1259 OID 65586)
-- Name: venda_itens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.venda_itens (
    id integer NOT NULL,
    venda_id integer NOT NULL,
    produto_id integer NOT NULL,
    quantidade integer DEFAULT 1 NOT NULL,
    preco_unitario numeric(10,2) NOT NULL
);


--
-- TOC entry 223 (class 1259 OID 65585)
-- Name: venda_itens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.venda_itens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4842 (class 0 OID 0)
-- Dependencies: 223
-- Name: venda_itens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.venda_itens_id_seq OWNED BY public.venda_itens.id;


--
-- TOC entry 222 (class 1259 OID 65572)
-- Name: vendas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.vendas (
    id integer NOT NULL,
    lead_id integer NOT NULL,
    total numeric(10,2) DEFAULT 0,
    data_venda date DEFAULT CURRENT_DATE
);


--
-- TOC entry 221 (class 1259 OID 65571)
-- Name: vendas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.vendas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4843 (class 0 OID 0)
-- Dependencies: 221
-- Name: vendas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.vendas_id_seq OWNED BY public.vendas.id;


--
-- TOC entry 4655 (class 2604 OID 65553)
-- Name: leads id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leads ALTER COLUMN id SET DEFAULT nextval('public.leads_id_seq'::regclass);


--
-- TOC entry 4658 (class 2604 OID 65564)
-- Name: produtos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.produtos ALTER COLUMN id SET DEFAULT nextval('public.produtos_id_seq'::regclass);


--
-- TOC entry 4654 (class 2604 OID 65542)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4664 (class 2604 OID 65589)
-- Name: venda_itens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.venda_itens ALTER COLUMN id SET DEFAULT nextval('public.venda_itens_id_seq'::regclass);


--
-- TOC entry 4661 (class 2604 OID 65575)
-- Name: vendas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vendas ALTER COLUMN id SET DEFAULT nextval('public.vendas_id_seq'::regclass);


--
-- TOC entry 4827 (class 0 OID 65550)
-- Dependencies: 218
-- Data for Name: leads; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.leads (id, nome, email, telefone, status, nivel_conhecimento, interesse_curso, score) VALUES (1, 'João Silva', 'joao@gmail.com', '51999001122', 'Inscrito', 'Iniciante', 'Python', 100);
INSERT INTO public.leads (id, nome, email, telefone, status, nivel_conhecimento, interesse_curso, score) VALUES (2, 'Maria Souza', 'maria@gmail.com', '51988223344', 'Entrevista', 'Intermediario', 'Fullstack', 100);
INSERT INTO public.leads (id, nome, email, telefone, status, nivel_conhecimento, interesse_curso, score) VALUES (3, 'Carlos Lima', 'carlos@gmail.com', '', 'Matriculado', 'Avancado', 'Python', 50);


--
-- TOC entry 4829 (class 0 OID 65561)
-- Dependencies: 220
-- Data for Name: produtos; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (1, 'Facilis', 'Error molestiae tenetur.', 393.30, 84);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (2, 'Eligendi', 'Iste adipisci eius distinctio.', 497.40, 93);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (3, 'Repellendus', 'Reiciendis incidunt accusamus officiis blanditiis.', 487.00, 84);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (4, 'Quidem', 'Reprehenderit quaerat libero minus reprehenderit consequatur aliquam.', 101.35, 67);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (5, 'Iusto', 'Cum occaecati blanditiis rem quae ipsam voluptates voluptatum.', 277.99, 63);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (6, 'Minus', 'Molestiae nesciunt velit maxime.', 148.83, 20);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (7, 'Vitae', 'Qui porro omnis modi.', 328.28, 75);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (8, 'Unde', 'Explicabo fugiat ipsam sed sequi beatae.', 75.45, 12);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (9, 'Harum', 'Hic commodi sit aliquid.', 212.82, 42);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (10, 'Qui', 'Excepturi id expedita dolores optio nisi quos.', 110.61, 67);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (11, 'Doloremque', 'Atque itaque corporis vitae quidem minima.', 247.44, 53);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (12, 'Amet', 'Ab ipsum sunt.', 143.68, 97);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (13, 'Dolore', 'Quia numquam voluptatem magni pariatur ea.', 91.98, 29);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (14, 'Illo', 'Eius blanditiis facere exercitationem.', 354.70, 42);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (15, 'Quisquam', 'Cumque optio illo minus deleniti culpa doloremque illum.', 447.98, 43);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (16, 'Est', 'Provident quo necessitatibus.', 138.44, 52);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (17, 'Nemo', 'Repellat deserunt eveniet.', 137.74, 83);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (18, 'Ipsa', 'Amet provident explicabo velit eos recusandae vitae.', 449.29, 48);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (19, 'Veritatis', 'Necessitatibus nulla ducimus similique inventore.', 226.05, 47);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (20, 'Saepe', 'Libero at ut.', 458.92, 7);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (21, 'Sed', 'Delectus ipsam placeat quos earum eveniet possimus.', 477.74, 27);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (22, 'Id', 'Earum soluta asperiores quis tempore.', 212.21, 92);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (23, 'Quae', 'Totam at cumque temporibus.', 222.31, 2);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (24, 'Recusandae', 'Aliquid officia id.', 317.64, 26);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (25, 'Odit', 'Commodi consequatur inventore id.', 385.28, 63);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (26, 'Aspernatur', 'Sequi occaecati similique rerum.', 184.54, 73);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (27, 'Itaque', 'Ut possimus nostrum.', 335.88, 46);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (28, 'Illum', 'Illum velit distinctio nostrum.', 126.67, 31);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (29, 'Voluptas', 'Aut assumenda deleniti facere.', 363.53, 48);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (30, 'Quis', 'Commodi veniam totam quas officia repellendus numquam.', 339.98, 98);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (31, 'Ad', 'Tempora veniam saepe ea tenetur quo.', 416.64, 92);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (32, 'Adipisci', 'Ex assumenda esse fugiat ipsum reprehenderit.', 474.52, 99);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (33, 'Laudantium', 'Ipsum non aliquam eum.', 74.72, 33);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (34, 'At', 'Culpa optio numquam deserunt soluta placeat atque.', 389.61, 82);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (35, 'Quod', 'Quae dolor modi eius est excepturi.', 301.97, 75);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (36, 'Eveniet', 'Mollitia facilis suscipit distinctio eum similique.', 436.98, 85);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (37, 'Nobis', 'Eos similique accusantium iusto.', 369.03, 92);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (38, 'Facilis', 'Vero perferendis recusandae dolorum fuga animi.', 299.51, 12);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (39, 'In', 'Placeat aspernatur reprehenderit perferendis alias suscipit.', 242.28, 16);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (40, 'Quos', 'Recusandae repudiandae ab praesentium odio.', 165.01, 19);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (41, 'Officia', 'Dolorum veritatis repudiandae quis explicabo ullam.', 61.88, 11);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (42, 'Voluptatibus', 'Nemo non voluptates perferendis.', 447.73, 67);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (43, 'Deserunt', 'Corporis soluta numquam officia vero corrupti cum.', 113.11, 31);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (44, 'Nulla', 'Omnis unde eum.', 464.16, 33);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (45, 'At', 'Cum deserunt sapiente voluptatum.', 305.90, 86);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (46, 'Placeat', 'Odit distinctio delectus quasi delectus laborum.', 156.31, 88);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (47, 'Voluptatem', 'Nobis quibusdam placeat.', 62.41, 44);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (48, 'Architecto', 'Est consequatur velit blanditiis nesciunt.', 489.35, 93);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (49, 'Aut', 'Aperiam eaque provident officiis a aut dolorem.', 475.56, 17);
INSERT INTO public.produtos (id, nome, descricao, preco, quantidade) VALUES (50, 'Accusamus', 'Laboriosam asperiores beatae repellat libero omnis magni.', 179.85, 60);


--
-- TOC entry 4825 (class 0 OID 65539)
-- Dependencies: 216
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.users (id, nome, email, senha) VALUES (1, 'abc', 'a@gmail.com', 'blabla123');
INSERT INTO public.users (id, nome, email, senha) VALUES (2, 'matheus', 'matheus@gmail.com', '54321');
INSERT INTO public.users (id, nome, email, senha) VALUES (3, 'gades', 'gades@gmail.com', '12345');
INSERT INTO public.users (id, nome, email, senha) VALUES (4, '', '', '');


--
-- TOC entry 4833 (class 0 OID 65586)
-- Dependencies: 224
-- Data for Name: venda_itens; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (1, 1, 2, 1, 497.40);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (2, 2, 5, 2, 277.99);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (3, 3, 32, 5, 474.52);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (4, 4, 23, 1, 222.31);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (5, 4, 7, 1, 328.28);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (6, 4, 39, 2, 242.28);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (7, 5, 24, 2, 317.64);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (8, 5, 9, 2, 212.82);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (9, 6, 23, 2, 222.31);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (10, 6, 11, 1, 247.44);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (11, 6, 42, 1, 447.73);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (12, 7, 18, 2, 449.29);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (13, 7, 43, 1, 113.11);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (14, 8, 40, 1, 165.01);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (15, 9, 19, 2, 226.05);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (16, 9, 2, 2, 497.40);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (17, 10, 43, 1, 113.11);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (18, 10, 31, 1, 416.64);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (19, 11, 33, 1, 74.72);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (20, 12, 23, 1, 222.31);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (21, 13, 31, 2, 416.64);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (22, 13, 41, 2, 61.88);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (23, 14, 33, 1, 74.72);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (24, 15, 42, 1, 447.73);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (25, 16, 35, 2, 301.97);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (26, 16, 28, 2, 126.67);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (27, 16, 4, 2, 101.35);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (28, 17, 38, 2, 299.51);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (29, 17, 11, 2, 247.44);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (30, 17, 26, 2, 184.54);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (31, 18, 21, 1, 477.74);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (32, 18, 48, 1, 489.35);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (33, 18, 17, 2, 137.74);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (34, 19, 28, 2, 126.67);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (35, 19, 21, 2, 477.74);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (36, 20, 3, 1, 487.00);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (37, 21, 22, 2, 212.21);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (38, 22, 43, 1, 113.11);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (39, 22, 23, 1, 222.31);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (40, 23, 9, 1, 212.82);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (41, 23, 3, 2, 487.00);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (42, 24, 48, 2, 489.35);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (43, 25, 20, 2, 458.92);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (44, 26, 17, 1, 137.74);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (45, 26, 41, 2, 61.88);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (46, 26, 32, 1, 474.52);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (47, 27, 16, 1, 138.44);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (48, 28, 1, 2, 393.30);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (49, 28, 35, 2, 301.97);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (50, 28, 44, 2, 464.16);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (51, 29, 14, 1, 354.70);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (52, 29, 21, 2, 477.74);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (53, 29, 5, 1, 277.99);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (54, 30, 3, 2, 487.00);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (55, 30, 49, 1, 475.56);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (56, 31, 27, 1, 335.88);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (57, 31, 9, 2, 212.82);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (58, 31, 18, 2, 449.29);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (59, 32, 23, 1, 222.31);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (60, 33, 49, 1, 475.56);
INSERT INTO public.venda_itens (id, venda_id, produto_id, quantidade, preco_unitario) VALUES (61, 33, 23, 2, 222.31);


--
-- TOC entry 4831 (class 0 OID 65572)
-- Dependencies: 222
-- Data for Name: vendas; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (1, 1, 497.40, '2026-02-28');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (2, 3, 555.98, '2026-02-28');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (3, 2, 2372.60, '2026-02-28');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (4, 3, 1035.15, '2026-01-05');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (5, 2, 1060.92, '2026-01-16');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (6, 2, 1139.79, '2026-02-12');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (7, 2, 1011.69, '2026-01-12');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (8, 2, 165.01, '2026-01-11');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (9, 1, 1446.90, '2026-02-18');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (10, 1, 529.75, '2026-02-15');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (11, 2, 74.72, '2026-01-05');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (12, 2, 222.31, '2026-01-31');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (13, 1, 957.04, '2026-01-25');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (14, 3, 74.72, '2026-02-05');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (15, 1, 447.73, '2026-01-31');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (16, 1, 1059.98, '2026-01-15');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (17, 3, 1462.98, '2026-01-21');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (18, 3, 1242.57, '2026-01-02');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (19, 3, 1208.82, '2026-01-24');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (20, 3, 487.00, '2026-01-07');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (21, 2, 424.42, '2026-01-02');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (22, 3, 335.42, '2026-01-28');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (23, 2, 1186.82, '2026-02-26');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (24, 1, 978.70, '2026-01-06');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (25, 3, 917.84, '2026-01-24');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (26, 1, 736.02, '2026-01-27');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (27, 1, 138.44, '2026-01-14');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (28, 3, 2318.86, '2026-01-16');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (29, 1, 1588.17, '2026-02-02');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (30, 1, 1449.56, '2026-02-06');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (31, 2, 1660.10, '2026-02-04');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (32, 1, 222.31, '2026-02-24');
INSERT INTO public.vendas (id, lead_id, total, data_venda) VALUES (33, 3, 920.18, '2026-01-07');


--
-- TOC entry 4844 (class 0 OID 0)
-- Dependencies: 217
-- Name: leads_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.leads_id_seq', 4, true);


--
-- TOC entry 4845 (class 0 OID 0)
-- Dependencies: 219
-- Name: produtos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.produtos_id_seq', 50, true);


--
-- TOC entry 4846 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 4, true);


--
-- TOC entry 4847 (class 0 OID 0)
-- Dependencies: 223
-- Name: venda_itens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.venda_itens_id_seq', 61, true);


--
-- TOC entry 4848 (class 0 OID 0)
-- Dependencies: 221
-- Name: vendas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.vendas_id_seq', 33, true);


--
-- TOC entry 4671 (class 2606 OID 65559)
-- Name: leads leads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leads
    ADD CONSTRAINT leads_pkey PRIMARY KEY (id);


--
-- TOC entry 4673 (class 2606 OID 65570)
-- Name: produtos produtos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.produtos
    ADD CONSTRAINT produtos_pkey PRIMARY KEY (id);


--
-- TOC entry 4667 (class 2606 OID 65548)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4669 (class 2606 OID 65546)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4677 (class 2606 OID 65592)
-- Name: venda_itens venda_itens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.venda_itens
    ADD CONSTRAINT venda_itens_pkey PRIMARY KEY (id);


--
-- TOC entry 4675 (class 2606 OID 65579)
-- Name: vendas vendas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT vendas_pkey PRIMARY KEY (id);


--
-- TOC entry 4679 (class 2606 OID 65598)
-- Name: venda_itens venda_itens_produto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.venda_itens
    ADD CONSTRAINT venda_itens_produto_id_fkey FOREIGN KEY (produto_id) REFERENCES public.produtos(id) ON DELETE CASCADE;


--
-- TOC entry 4680 (class 2606 OID 65593)
-- Name: venda_itens venda_itens_venda_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.venda_itens
    ADD CONSTRAINT venda_itens_venda_id_fkey FOREIGN KEY (venda_id) REFERENCES public.vendas(id) ON DELETE CASCADE;


--
-- TOC entry 4678 (class 2606 OID 65580)
-- Name: vendas vendas_lead_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT vendas_lead_id_fkey FOREIGN KEY (lead_id) REFERENCES public.leads(id) ON DELETE CASCADE;


-- Completed on 2026-03-06 11:39:03

--
-- PostgreSQL database dump complete
--

