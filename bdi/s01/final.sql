--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5
-- Dumped by pg_dump version 10.5

-- Started on 2018-10-03 15:26:21

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12924)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2842 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 197 (class 1259 OID 16416)
-- Name: author; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.author (
    authorid integer NOT NULL,
    name character(255),
    email character(255),
    affiliation character(255)
);


ALTER TABLE public.author OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 16459)
-- Name: cites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cites (
    paperidfrom integer NOT NULL,
    paperidto integer NOT NULL
);


ALTER TABLE public.cites OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 16424)
-- Name: conference; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conference (
    confid integer NOT NULL,
    name character(255),
    ranking integer
);


ALTER TABLE public.conference OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 16408)
-- Name: paper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paper (
    paperid integer NOT NULL,
    title character(255),
    abstract text
);


ALTER TABLE public.paper OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 16444)
-- Name: submits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.submits (
    paperid integer NOT NULL,
    confid integer NOT NULL,
    isaccepted boolean,
    date date
);


ALTER TABLE public.submits OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 16429)
-- Name: writes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.writes (
    authorid integer NOT NULL,
    paperid integer NOT NULL
);


ALTER TABLE public.writes OWNER TO postgres;

--
-- TOC entry 2830 (class 0 OID 16416)
-- Dependencies: 197
-- Data for Name: author; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.author (authorid, name, email, affiliation) FROM stdin;
1	Bridie Brakus                                                                                                                                                                                                                                                  	Bart_Wintheiser@yahoo.com                                                                                                                                                                                                                                      	HEIA                                                                                                                                                                                                                                                           
2	Einar Erdman                                                                                                                                                                                                                                                   	Werner_Mraz33@gmail.com                                                                                                                                                                                                                                        	ETH                                                                                                                                                                                                                                                            
3	Alisha Kreiger                                                                                                                                                                                                                                                 	Tina.Reichel25@yahoo.com                                                                                                                                                                                                                                       	University of Bern                                                                                                                                                                                                                                             
4	Emilia Simonis                                                                                                                                                                                                                                                 	Nick.Fay80@hotmail.com                                                                                                                                                                                                                                         	ETH                                                                                                                                                                                                                                                            
5	Fabian Murray                                                                                                                                                                                                                                                  	Patricia.Ebert@yahoo.com                                                                                                                                                                                                                                       	EPFL                                                                                                                                                                                                                                                           
6	Jayda Turner                                                                                                                                                                                                                                                   	Carolanne36@gmail.com                                                                                                                                                                                                                                          	University of Neuchatel                                                                                                                                                                                                                                        
7	Rachael Kohler                                                                                                                                                                                                                                                 	Leonard_Medhurst@gmail.com                                                                                                                                                                                                                                     	University of Bern                                                                                                                                                                                                                                             
8	America Kunde                                                                                                                                                                                                                                                  	Garland.Frami12@hotmail.com                                                                                                                                                                                                                                    	University of Neuchatel                                                                                                                                                                                                                                        
9	Nathaniel Reilly                                                                                                                                                                                                                                               	Isaias39@hotmail.com                                                                                                                                                                                                                                           	University of Neuchatel                                                                                                                                                                                                                                        
10	Gabe Kilback                                                                                                                                                                                                                                                   	Wiley41@yahoo.com                                                                                                                                                                                                                                              	EPFL                                                                                                                                                                                                                                                           
11	Ulises Fadel                                                                                                                                                                                                                                                   	Alberto17@yahoo.com                                                                                                                                                                                                                                            	University of Neuchatel                                                                                                                                                                                                                                        
12	Cleo Bradtke                                                                                                                                                                                                                                                   	Hilbert_Reichel@yahoo.com                                                                                                                                                                                                                                      	University of Bern                                                                                                                                                                                                                                             
13	Gayle Quitzon                                                                                                                                                                                                                                                  	Nayeli60@hotmail.com                                                                                                                                                                                                                                           	ETH                                                                                                                                                                                                                                                            
14	Josh Goodwin                                                                                                                                                                                                                                                   	Nasir.Ortiz@gmail.com                                                                                                                                                                                                                                          	University of Neuchatel                                                                                                                                                                                                                                        
\.


--
-- TOC entry 2834 (class 0 OID 16459)
-- Dependencies: 201
-- Data for Name: cites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cites (paperidfrom, paperidto) FROM stdin;
13	21
9	9
12	8
33	35
15	1
4	38
9	28
15	17
1	8
4	14
4	1
15	10
38	36
24	7
12	4
12	11
1	33
1	18
33	1
20	32
28	21
29	20
32	39
9	5
19	38
39	12
14	23
20	23
25	20
7	12
36	36
28	25
22	7
39	30
36	4
10	31
6	26
19	15
19	17
\.


--
-- TOC entry 2831 (class 0 OID 16424)
-- Dependencies: 198
-- Data for Name: conference; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conference (confid, name, ranking) FROM stdin;
6	praesentium                                                                                                                                                                                                                                                    	8
7	sit                                                                                                                                                                                                                                                            	2
8	non                                                                                                                                                                                                                                                            	7
9	voluptas                                                                                                                                                                                                                                                       	6
10	reiciendis                                                                                                                                                                                                                                                     	0
11	omnis                                                                                                                                                                                                                                                          	6
12	hic                                                                                                                                                                                                                                                            	9
13	recusandae                                                                                                                                                                                                                                                     	8
14	excepturi                                                                                                                                                                                                                                                      	0
1	rerum                                                                                                                                                                                                                                                          	6
2	sed                                                                                                                                                                                                                                                            	1
3	sunt                                                                                                                                                                                                                                                           	5
4	tempore                                                                                                                                                                                                                                                        	3
5	animi                                                                                                                                                                                                                                                          	5
\.


--
-- TOC entry 2829 (class 0 OID 16408)
-- Dependencies: 196
-- Data for Name: paper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.paper (paperid, title, abstract) FROM stdin;
1	quisquam doloribus enim                                                                                                                                                                                                                                        	In rerum ex atque officiis quis voluptatum quia aut. Quidem voluptas quos ducimus saepe.
2	commodi recusandae in                                                                                                                                                                                                                                          	Enim qui est voluptatem. Officiis explicabo sequi.
3	quo omnis veritatis                                                                                                                                                                                                                                            	Sed error sed iste. Ut quis a pariatur qui quaerat amet quas. Ipsum accusantium sint natus facere et quod exercitationem eum. Veritatis et veniam unde ipsa.
4	quod excepturi qui                                                                                                                                                                                                                                             	Est asperiores rerum ea eum ut eligendi eaque soluta optio. Voluptatem vitae ut. Reiciendis repudiandae ea consequuntur deleniti animi ut. Qui sed numquam tempora omnis voluptates soluta.
5	quam in necessitatibus                                                                                                                                                                                                                                         	Maiores maxime et. Consequatur non repudiandae enim rerum. Veniam velit animi autem fuga eaque. Totam perferendis at omnis magnam exercitationem necessitatibus et soluta. Maxime quis aut voluptatem ad et. Ipsum exercitationem nisi quos.
6	ea officiis vero                                                                                                                                                                                                                                               	Asperiores iste omnis assumenda iste sed maxime. Cupiditate et repellat quidem necessitatibus sit. Optio tempore aut ea. Et consequatur laboriosam.
7	ea ut ex                                                                                                                                                                                                                                                       	Voluptas et magni delectus voluptas. Voluptatibus ipsum rerum. Saepe voluptatum debitis hic dolor tempora quia quia ex. Excepturi modi nobis nostrum ut minima exercitationem non iure dignissimos. Et numquam corrupti voluptates ipsum voluptatem aut.
8	error sint consectetur                                                                                                                                                                                                                                         	Non vel necessitatibus aspernatur debitis. Porro dolor delectus possimus iste et dolor minus non repellendus. Quia nesciunt aperiam dolor repellendus. Explicabo placeat eveniet. Blanditiis eos dolore quia rerum placeat eaque vel temporibus ut. Consequuntur architecto quam modi.
9	ipsum aut explicabo                                                                                                                                                                                                                                            	Illo ea dignissimos esse aut. Molestiae est porro dicta et et non asperiores quidem. Qui ut illum quia nisi. Consequatur pariatur qui. Doloremque temporibus sequi cupiditate similique voluptatibus incidunt et nesciunt.
10	architecto magni a                                                                                                                                                                                                                                             	Tempore sed quo ratione maiores dolor dolores. Enim quia modi aut. Maiores fuga delectus. Optio cumque et. Ullam aperiam at necessitatibus voluptate sed nesciunt sed quia accusantium. Ullam atque perspiciatis.
11	repudiandae veritatis numquam                                                                                                                                                                                                                                  	Nisi dolorem pariatur accusantium totam. Impedit quaerat doloremque incidunt delectus porro eos architecto sunt. Delectus laudantium incidunt cupiditate qui occaecati consectetur. Aperiam sint labore numquam.
12	velit vero perspiciatis                                                                                                                                                                                                                                        	Excepturi inventore et. Esse non ut ut consequatur iste perspiciatis sit. Veritatis et repellat dolor enim quas aliquam deleniti fugit quis. Est consequatur illo nemo.
13	architecto maiores fugiat                                                                                                                                                                                                                                      	Provident consectetur hic sed harum optio. Cupiditate quam saepe inventore cum inventore quis rerum. Numquam reprehenderit reprehenderit consequuntur nobis et laborum architecto nemo autem.
14	perspiciatis unde qui                                                                                                                                                                                                                                          	Voluptatem quo porro et ducimus maxime eveniet voluptas sint. Consequatur autem accusamus. Officiis eum ut maxime vero. Facere ut voluptatem earum unde.
15	aut dignissimos doloremque                                                                                                                                                                                                                                     	Molestiae eaque cum quia eum rerum in qui sint eius. Eum corporis dicta aut. Minus sit dolores fugiat pariatur animi tenetur id.
16	maxime quidem fuga                                                                                                                                                                                                                                             	Molestiae et molestias nam. Velit alias totam. Enim dolorem inventore. Sit velit aut impedit. Pariatur praesentium blanditiis voluptas iste vel sequi culpa aut officiis.
17	assumenda quia dignissimos                                                                                                                                                                                                                                     	Nostrum minima maxime. Quo rerum unde provident rerum accusamus. Voluptatem impedit et culpa qui blanditiis. Veritatis impedit qui beatae perspiciatis. Expedita iure occaecati pariatur repudiandae in aspernatur rerum.
18	cupiditate nostrum magni                                                                                                                                                                                                                                       	Consequatur modi qui accusantium laudantium. Et veritatis exercitationem.
19	ea qui quod                                                                                                                                                                                                                                                    	Eligendi delectus est omnis ullam dignissimos rem pariatur. Reprehenderit blanditiis porro eos labore vel sed occaecati eum a. Optio quibusdam eveniet dolor expedita. Quia recusandae quod ut autem non. Aperiam numquam quos voluptas. Facilis ducimus esse sit accusamus dolores sed.
20	ab officiis id                                                                                                                                                                                                                                                 	Exercitationem sit vero ea quaerat aspernatur officia. Doloribus ipsam expedita nobis laboriosam. Iusto iusto quia eum nostrum ad sequi mollitia.
21	quis atque delectus                                                                                                                                                                                                                                            	Maxime natus quo et voluptas et dolor maxime modi. Ea omnis qui ullam veniam earum consequatur debitis. Quis sint dolores natus provident. Provident eius omnis minus iure eius pariatur sunt aliquid natus. Excepturi qui ducimus dolor unde sunt.
22	repellat corporis voluptatem                                                                                                                                                                                                                                   	Eum at dolores illum. Minus omnis facilis repudiandae magnam. Consequatur ab et.
23	velit voluptatum debitis                                                                                                                                                                                                                                       	Placeat architecto quisquam culpa odio harum doloribus ipsa. Dolores ut sed commodi placeat dolorem perferendis voluptatem corrupti. Sed nulla magnam. Beatae voluptas rerum quasi assumenda qui facere. Qui unde temporibus nam ad. Delectus deserunt est quis.
24	similique aut velit                                                                                                                                                                                                                                            	Et adipisci nobis ullam quis eum sed cumque perferendis. Delectus soluta ratione est vitae totam. Qui sunt consequuntur laborum.
25	distinctio quia delectus                                                                                                                                                                                                                                       	Doloremque similique ut cum et. Possimus corrupti voluptatem nostrum. Nihil rerum aliquid id ullam aliquid cumque repudiandae. Quia sunt rerum libero nulla sunt cum sed totam. Labore officia aut ipsa impedit necessitatibus cum vel excepturi. Fugiat est neque tenetur dolore commodi.
26	ut id est                                                                                                                                                                                                                                                      	Minima consequatur ut laboriosam autem et dolor. Vitae dignissimos perspiciatis quae repellat ut exercitationem natus ullam. Possimus laudantium mollitia ipsum harum voluptates voluptas.
27	dolor sed est                                                                                                                                                                                                                                                  	Reprehenderit voluptatum dignissimos veniam dolorem. Voluptatum nihil est corrupti impedit.
28	non iusto velit                                                                                                                                                                                                                                                	Est omnis sit qui sunt provident similique eos quibusdam vero. Recusandae veritatis rerum velit quae voluptas. Provident cum ut unde deserunt occaecati.
29	inventore qui aperiam                                                                                                                                                                                                                                          	Veritatis quos fugit harum excepturi libero aperiam inventore omnis. Ut rerum est et enim quae. Enim est sed eum. Ut velit et et porro praesentium sit ut assumenda.
30	ratione aspernatur quo                                                                                                                                                                                                                                         	Accusamus nemo placeat ab pariatur aut accusantium est. Beatae quia corporis dolore velit ab soluta eius natus velit. Illo eum quibusdam voluptate aut minima voluptate. Quidem aut deleniti natus eum eum nobis.
31	non vel iste                                                                                                                                                                                                                                                   	Nemo sit quo nulla iusto quia non. Culpa sit ea quia quo pariatur et quia sed dicta. Earum voluptatem rerum dolor. Perferendis alias alias ad ut modi repellendus similique. Voluptas facere est explicabo perspiciatis omnis rerum ut.
32	reiciendis a nihil                                                                                                                                                                                                                                             	Qui unde excepturi qui dolorem repudiandae consequatur. Voluptatem mollitia enim quia voluptas voluptatem. Dolores eius officiis repudiandae voluptatem. Voluptas amet quae.
33	nostrum eius ex                                                                                                                                                                                                                                                	Tempore accusamus magni nihil qui. Enim nisi qui maxime voluptas assumenda qui nostrum. Maiores non maiores maiores aut reiciendis velit. Eius laudantium ipsa non.
34	quia distinctio deserunt                                                                                                                                                                                                                                       	Ab eum qui adipisci repellendus veritatis magnam debitis porro. Officiis voluptatem placeat ut. Cum exercitationem sed fugiat deserunt aut quis non et. Ut et dolorem ut nam ab sapiente et. Error nihil minus et reiciendis quis consequatur. Officiis ea eveniet sit dolores dicta consequuntur aliquam.
35	quos qui suscipit                                                                                                                                                                                                                                              	Alias minus tenetur id possimus consequuntur hic. Et aut similique voluptas. Ut quis est voluptate explicabo ut quae tenetur. Voluptas dicta voluptas quia placeat. Et est delectus nulla voluptas. Fugiat voluptas voluptatibus enim reiciendis iste voluptatem.
36	iure eaque dicta                                                                                                                                                                                                                                               	Officiis sit necessitatibus voluptatem in accusamus et earum et deleniti. Dolorem sed molestiae doloribus non. Provident minima maxime sit. Non sequi aspernatur vel fugiat eum molestiae et est.
37	maxime qui ratione                                                                                                                                                                                                                                             	Enim vitae quia ut ex ipsum quis ratione. Fuga sed assumenda unde soluta dolores cum iste. Pariatur nihil pariatur cum. Dolorem voluptatum eveniet qui aut omnis aut sunt quam sint. Dicta nobis eligendi animi ex ut eligendi qui rerum dicta. Est doloribus deserunt et.
38	aspernatur maiores accusantium                                                                                                                                                                                                                                 	Rerum soluta nemo illo mollitia est. Recusandae nobis in. Soluta id voluptatem quo qui unde velit ex. In quidem unde libero. Nihil sequi ducimus modi maiores ipsum beatae enim.
39	ducimus dolores molestias                                                                                                                                                                                                                                      	Dolores magnam autem occaecati. Autem dicta ea. Vel nihil voluptas sit mollitia a quia accusamus earum. Eius incidunt itaque suscipit et eligendi autem rerum porro odio. Modi natus est libero. Vero excepturi officiis earum autem ipsam.
\.


--
-- TOC entry 2833 (class 0 OID 16444)
-- Dependencies: 200
-- Data for Name: submits; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.submits (paperid, confid, isaccepted, date) FROM stdin;
18	12	f	2019-08-19
10	6	t	2019-07-07
20	3	t	2018-12-03
13	8	f	2018-10-16
15	9	t	2019-03-20
35	4	f	2019-07-14
2	1	t	2019-06-07
16	6	f	2019-02-06
9	3	t	2019-04-26
36	10	f	2018-12-29
22	11	f	2019-06-02
6	3	f	2019-05-14
27	1	f	2018-11-06
39	2	t	2019-05-28
23	2	t	2019-08-06
4	11	t	2019-04-05
10	12	f	2019-09-26
28	8	f	2019-01-07
5	9	f	2019-04-11
32	6	f	2018-12-24
28	13	f	2018-11-19
16	3	t	2018-10-10
1	11	t	2018-11-09
20	1	f	2019-06-12
9	2	t	2019-08-14
10	7	f	2019-04-02
8	10	f	2019-06-20
38	13	f	2019-01-24
35	11	t	2019-02-08
28	14	t	2019-01-17
34	11	f	2019-03-11
28	11	t	2018-12-11
33	2	f	2019-08-01
32	12	t	2018-10-09
23	10	f	2019-08-27
37	3	f	2019-04-12
5	7	t	2019-09-08
38	8	f	2019-04-01
21	3	f	2019-08-20
2	6	f	2019-05-07
9	10	t	2018-11-30
9	12	t	2018-10-19
20	7	t	2019-06-28
6	13	f	2018-12-23
37	12	f	2018-12-20
34	10	t	2018-12-12
19	9	t	2018-11-18
11	1	t	2018-12-26
12	3	t	2019-07-31
17	12	t	2018-11-02
32	2	f	2019-06-17
35	13	t	2019-03-07
20	10	f	2019-01-25
3	9	f	2019-02-01
11	7	f	2019-03-06
25	12	f	2018-12-21
38	11	t	2019-05-20
34	3	t	2019-06-03
24	12	t	2019-09-13
\.


--
-- TOC entry 2832 (class 0 OID 16429)
-- Dependencies: 199
-- Data for Name: writes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.writes (authorid, paperid) FROM stdin;
13	1
8	2
12	3
6	5
13	4
14	6
5	7
9	8
10	9
6	10
6	11
14	12
5	13
8	14
12	15
8	16
11	17
8	18
13	19
3	20
7	21
6	22
3	23
12	24
7	25
10	26
4	27
12	31
8	37
2	38
3	39
7	20
5	21
12	26
10	10
2	25
5	17
6	36
2	28
7	16
4	19
12	2
7	36
10	23
11	32
1	30
1	32
8	33
10	34
2	35
12	36
2	4
11	29
\.


--
-- TOC entry 2693 (class 2606 OID 16423)
-- Name: author author_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.author
    ADD CONSTRAINT author_pkey PRIMARY KEY (authorid);


--
-- TOC entry 2701 (class 2606 OID 16463)
-- Name: cites cites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cites
    ADD CONSTRAINT cites_pkey PRIMARY KEY (paperidfrom, paperidto);


--
-- TOC entry 2695 (class 2606 OID 16428)
-- Name: conference conference_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conference
    ADD CONSTRAINT conference_pkey PRIMARY KEY (confid);


--
-- TOC entry 2691 (class 2606 OID 16415)
-- Name: paper paper_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paper
    ADD CONSTRAINT paper_pkey PRIMARY KEY (paperid);


--
-- TOC entry 2699 (class 2606 OID 16448)
-- Name: submits submits_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submits
    ADD CONSTRAINT submits_pkey PRIMARY KEY (paperid, confid);


--
-- TOC entry 2697 (class 2606 OID 16433)
-- Name: writes writes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.writes
    ADD CONSTRAINT writes_pkey PRIMARY KEY (authorid, paperid);


--
-- TOC entry 2706 (class 2606 OID 16464)
-- Name: cites fk_cites_paperfrom; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cites
    ADD CONSTRAINT fk_cites_paperfrom FOREIGN KEY (paperidfrom) REFERENCES public.paper(paperid);


--
-- TOC entry 2707 (class 2606 OID 16469)
-- Name: cites fk_cites_paperto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cites
    ADD CONSTRAINT fk_cites_paperto FOREIGN KEY (paperidto) REFERENCES public.paper(paperid);


--
-- TOC entry 2704 (class 2606 OID 16449)
-- Name: submits fk_submits_conf; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submits
    ADD CONSTRAINT fk_submits_conf FOREIGN KEY (confid) REFERENCES public.conference(confid);


--
-- TOC entry 2705 (class 2606 OID 16454)
-- Name: submits fk_submits_paper; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submits
    ADD CONSTRAINT fk_submits_paper FOREIGN KEY (paperid) REFERENCES public.paper(paperid);


--
-- TOC entry 2702 (class 2606 OID 16434)
-- Name: writes fk_writes_author; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.writes
    ADD CONSTRAINT fk_writes_author FOREIGN KEY (authorid) REFERENCES public.author(authorid);


--
-- TOC entry 2703 (class 2606 OID 16439)
-- Name: writes fk_writes_paper; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.writes
    ADD CONSTRAINT fk_writes_paper FOREIGN KEY (paperid) REFERENCES public.paper(paperid);


-- Completed on 2018-10-03 15:26:21

--
-- PostgreSQL database dump complete
--

