CREATE TABLE dim_fatura
(
    fat_codfatura SERIAL,
    fat_numeronota character varying(8) COLLATE pg_catalog."default",
    fat_situacao character varying(15) COLLATE pg_catalog."default",
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
    pes_codcliente SERIAL,
    pes_codorigem character varying(5) COLLATE pg_catalog."default",
    pes_nome character varying(50) COLLATE pg_catalog."default",
    pes_cpf character varying(20) COLLATE pg_catalog."default",
    pes_cnpj character varying(20) COLLATE pg_catalog."default",
    pes_rua character varying(50) COLLATE pg_catalog."default",
    pes_bairro character varying(5) COLLATE pg_catalog."default",
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
    prod_grupo character varying(4) COLLATE pg_catalog."default",
    CONSTRAINT dim_produto_pkey PRIMARY KEY (prod_codproduto)
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
    valor_venda numeric(18,2),
    quantidade_vendida integer,
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
        ON DELETE NO ACTION
)
