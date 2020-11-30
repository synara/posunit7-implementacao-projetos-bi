******************************8DIMENSOES************************************

CREATE TABLE public.dim_contas
(
    contas_codcontas bigint NOT NULL DEFAULT nextval('dim_contas_contas_codcontas_seq'::regclass),
    contas_numcontas character varying(7) COLLATE pg_catalog."default",
    contas_tipo character varying(1) COLLATE pg_catalog."default",
    contas_a_pagar numeric(18,2),
    contas_pagas numeric(18,2),
    contas_a_receber numeric(18,2),
    contas_recebidas numeric(18,2),
    CONSTRAINT pk_dim_contas PRIMARY KEY (contas_codcontas)
)

CREATE TABLE public.dim_fonte_rec
(
    fonte_codrec bigint NOT NULL DEFAULT nextval('dim_fonte_rec_fonte_codrec_seq'::regclass),
    fonte_codfonte_rec character varying(5) COLLATE pg_catalog."default",
    fonte_namerec character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT pk_fonte_rec PRIMARY KEY (fonte_codrec)
)

CREATE TABLE public.dim_forma_pgto
(
    fp_codformpgto integer NOT NULL DEFAULT nextval('dim_forma_pgto_fp_codformpgto_seq'::regclass),
    cod_formpgto character varying(5) COLLATE pg_catalog."default",
    fp_qt_parcelas integer,
    descricao character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT dim_forma_pgto_pkey PRIMARY KEY (fp_codformpgto)
)

CREATE TABLE public.dim_loja
(
loja_codloja integer NOT NULL DEFAULT nextval('dim_loja_loja_codloja_seq'::regclass),
    loja_nome character varying(30) COLLATE pg_catalog."default",
    loja_codorigem character varying(5) COLLATE pg_catalog."default",
    loja_uf character varying(2) COLLATE pg_catalog."default",
    loja_endereco character varying(50) COLLATE pg_catalog."default",
    loja_bairro character varying(50) COLLATE pg_catalog."default",
    loja_cidade character varying(50) COLLATE pg_catalog."default",
    loja_numero character varying(5) COLLATE pg_catalog."default",
    loja_cep character varying(8) COLLATE pg_catalog."default",
    loja_cnpj character varying(19) COLLATE pg_catalog."default",
    loja_telefone character varying(12) COLLATE pg_catalog."default",
    CONSTRAINT dim_loja_pkey PRIMARY KEY (loja_codloja)
)
CREATE TABLE public.dim_nat_despesa
(
    natdesp_coddesp bigint NOT NULL DEFAULT nextval('dim_nat_despesa_natdesp_coddesp_seq'::regclass),
    natdesp_codorigem character varying(8) COLLATE pg_catalog."default" NOT NULL,
    natdesp_namedesp character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_dim_nat_despesa PRIMARY KEY (natdesp_coddesp)
)

CREATE TABLE public.dim_pessoa
(
    pes_codcliente bigint NOT NULL DEFAULT nextval('dim_pessoa_pes_codcliente_seq'::regclass),
    pes_codorigem character varying(5) COLLATE pg_catalog."default",
    pes_nome character varying(50) COLLATE pg_catalog."default",
    pes_cpf character varying(20) COLLATE pg_catalog."default",
    pes_cnpj character varying(20) COLLATE pg_catalog."default",
    pes_rua character varying(50) COLLATE pg_catalog."default",
    pes_bairro character varying(50) COLLATE pg_catalog."default",
    pes_cidade character varying(50) COLLATE pg_catalog."default",
    pes_uf character varying(8) COLLATE pg_catalog."default",
    pes_cep character varying(19) COLLATE pg_catalog."default",
    pes_sexo character varying(12) COLLATE pg_catalog."default",
    pes_tpcliente character varying(8) COLLATE pg_catalog."default",
    CONSTRAINT dim_pessoa_pkey PRIMARY KEY (pes_codcliente)
)

CREATE TABLE public.dim_tempo
(
    data_sk integer NOT NULL,
    ano_numero smallint,
    mes_numero smallint,
    dia_do_ano_numero smallint,
    dia_do_mes_numero smallint,
    dia_da_semana_numero smallint,
    semana_do_ano_numero smallint,
    dia_nome character varying(30) COLLATE pg_catalog."default",
    mes_nome character varying(30) COLLATE pg_catalog."default",
    trimestre_numero double precision,
    trimestre_nome character varying(2) COLLATE pg_catalog."default",
    ano_trimestre_nome character varying(32) COLLATE pg_catalog."default",
    fimdesemana_ind character varying(1) COLLATE pg_catalog."default",
    dias_no_mes_qtd smallint,
    dia_desc text COLLATE pg_catalog."default",
    semana_sk double precision,
    dia_data timestamp without time zone,
    semana_nome character varying(32) COLLATE pg_catalog."default",
    semana_do_mes_numero double precision,
    semana_do_mes_nome text COLLATE pg_catalog."default",
    ano_sk double precision,
    mes_sk double precision,
    trimestre_sk double precision,
    dia_da_semana_ordem_nome character varying(60) COLLATE pg_catalog."default",
    ano_ordem_numero character varying(4) COLLATE pg_catalog."default",
    CONSTRAINT dim_tempo_pkey PRIMARY KEY (data_sk)
)
************************FATO_FINANÇAS****************************************

CREATE TABLE public.fato_financas
(
    sk_codloja integer,
    sk_codcliente integer,
    sk_codvendedor integer,
    sk_data integer,
    sk_codcontas integer,
    sk_coddesp integer,
    sk_codrec integer,
    sk_codformpgto integer,
    contas_pag numeric(18,2),
    contas_rcb numeric(18,2),
    cod_situacao integer,
    contas_tipos varchar,

    CONSTRAINT fato_financas_sk_codcliente_fkey FOREIGN KEY (sk_codcliente)
        REFERENCES public.dim_pessoa (pes_codcliente) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fato_financas_sk_codcontas_fkey FOREIGN KEY (sk_codcontas)
        REFERENCES public.dim_contas (contas_codcontas) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fato_financas_sk_coddesp_fkey FOREIGN KEY (sk_coddesp)
        REFERENCES public.dim_nat_despesa (natdesp_coddesp) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fato_financas_sk_codformpgto_fkey FOREIGN KEY (sk_codformpgto)
        REFERENCES public.dim_forma_pgto (fp_codformpgto) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fato_financas_sk_codloja_fkey FOREIGN KEY (sk_codloja)
        REFERENCES public.dim_loja (loja_codloja) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fato_financas_sk_codrec_fkey FOREIGN KEY (sk_codrec)
        REFERENCES public.dim_fonte_rec (fonte_codrec) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fato_financas_sk_data_fkey FOREIGN KEY (sk_data)
        REFERENCES public.dim_tempo (data_sk) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)