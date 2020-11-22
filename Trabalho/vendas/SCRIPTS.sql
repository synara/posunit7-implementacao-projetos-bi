--SCRIPTS EM ORDEM DE CRIAÇAO DAS TABELAS

CREATE TABLE dim_fatura
(
    fat_codfatura SERIAL,
    fat_numeronota character varying(8) COLLATE pg_catalog."default",
    fat_situacaofatura character varying(10) COLLATE pg_catalog."default",
    fat_loja character varying(5) COLLATE pg_catalog."default",
    CONSTRAINT dim_fatura_pkey PRIMARY KEY (fat_codfatura)
)

CREATE TABLE dim_forma_pgto
(
    fp_codformpgto SERIAL,
    cod_formpgto character varying(5) COLLATE pg_catalog."default",
    fp_qt_parcelas integer,
    descricao character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT dim_forma_pgto_pkey PRIMARY KEY (fp_codformpgto)
)

CREATE TABLE dim_loja
(
    loja_codloja SERIAL,
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

CREATE TABLE dim_pessoa
(
    pes_codcliente integer SERIAL,
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

CREATE TABLE dim_produto
(
    prod_codproduto SERIAL,
    prod_codorigem character varying(10) COLLATE pg_catalog."default",
    prod_descprod character varying(100) COLLATE pg_catalog."default",
    prod_embalagem character varying(10) COLLATE pg_catalog."default",
    prod_qt_embalagem integer,
    prod_marca character varying(20) COLLATE pg_catalog."default",
    prod_grupo character varying(60) COLLATE pg_catalog."default",
    CONSTRAINT dim_produto_pkey PRIMARY KEY (prod_codproduto)
)

CREATE TABLE dim_tempo
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

CREATE TABLE dim_tipo_pagamento
(
    tp_codtppgto SERIAL,
    cod_tipopgto character varying(5) COLLATE pg_catalog."default",
    tp_descricao character varying(25) COLLATE pg_catalog."default",
    CONSTRAINT dim_tipo_pagamento_pkey PRIMARY KEY (tp_codtppgto)
)


CREATE TABLE fato_vendas
(
    sk_codloja integer,
    sk_codcliente integer,
    sk_codvendedor integer,
    sk_codproduto integer,
    sk_codfatura integer,
    sk_codtppgto integer,
    sk_codformpgto integer,
    sk_data integer,
    valor_venda numeric(18,2),
    quantidade_vendida integer,
    custo numeric(18,2),
    lucro numeric(18,2),
    CONSTRAINT fato_vendas_sk_codcliente_fkey FOREIGN KEY (sk_codcliente)
        REFERENCES public.dim_pessoa (pes_codcliente) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fato_vendas_sk_codfatura_fkey FOREIGN KEY (sk_codfatura)
        REFERENCES public.dim_fatura (fat_codfatura) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fato_vendas_sk_codformpgto_fkey FOREIGN KEY (sk_codformpgto)
        REFERENCES public.dim_forma_pgto (fp_codformpgto) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fato_vendas_sk_codloja_fkey FOREIGN KEY (sk_codloja)
        REFERENCES public.dim_loja (loja_codloja) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fato_vendas_sk_codproduto_fkey FOREIGN KEY (sk_codproduto)
        REFERENCES public.dim_produto (prod_codproduto) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fato_vendas_sk_codtppgto_fkey FOREIGN KEY (sk_codtppgto)
        REFERENCES public.dim_tipo_pagamento (tp_codtppgto) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fato_vendas_sk_codvendedor_fkey FOREIGN KEY (sk_codvendedor)
        REFERENCES public.dim_pessoa (pes_codcliente) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fato_vendas_sk_data_fkey FOREIGN KEY (sk_data)
        REFERENCES public.dim_tempo (data_sk) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)