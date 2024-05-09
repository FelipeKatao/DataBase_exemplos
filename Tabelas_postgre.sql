-- Table: lojaroupa.Clientes

-- DROP TABLE IF EXISTS lojaroupa."Clientes";

CREATE TABLE IF NOT EXISTS lojaroupa."Clientes"
(
    "clientId" integer NOT NULL DEFAULT nextval('lojaroupa."Clientes_clientId_seq"'::regclass),
    nome character varying(90) COLLATE pg_catalog."default" NOT NULL,
    endereco_id integer NOT NULL,
    cpf character varying(11) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Clientes_pkey" PRIMARY KEY ("clientId"),
    CONSTRAINT "CPF_UNIQUE" UNIQUE (cpf),
    CONSTRAINT nome_cliente_unique UNIQUE (nome),
    CONSTRAINT fk_end_cliente FOREIGN KEY (endereco_id)
        REFERENCES lojaroupa.enderecos (enderecoid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS lojaroupa."Clientes"
    OWNER to postgres;

-- Table: lojaroupa.Funcionarios

-- DROP TABLE IF EXISTS lojaroupa."Funcionarios";

CREATE TABLE IF NOT EXISTS lojaroupa."Funcionarios"
(
    idpessoa integer NOT NULL DEFAULT nextval('lojaroupa."Funcionarios_idpessoa_seq"'::regclass),
    nome character varying(120) COLLATE pg_catalog."default" NOT NULL,
    departamento character varying(90) COLLATE pg_catalog."default" NOT NULL,
    funcao text COLLATE pg_catalog."default" NOT NULL,
    endereco_id integer NOT NULL,
    CONSTRAINT "Funcionarios_pkey" PRIMARY KEY (idpessoa),
    CONSTRAINT fk_nome_func UNIQUE (nome),
    CONSTRAINT fk_end_func FOREIGN KEY (endereco_id)
        REFERENCES lojaroupa.enderecos (enderecoid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT fk_func_dept FOREIGN KEY (departamento)
        REFERENCES lojaroupa.departamentos (departamento) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS lojaroupa."Funcionarios"
    OWNER to postgres;

-- Table: lojaroupa.Lojas

-- DROP TABLE IF EXISTS lojaroupa."Lojas";

CREATE TABLE IF NOT EXISTS lojaroupa."Lojas"
(
    idloja integer NOT NULL DEFAULT nextval('lojaroupa."Lojas_idloja_seq"'::regclass),
    nomeloja character varying(90) COLLATE pg_catalog."default" NOT NULL,
    localizacao integer NOT NULL,
    ativa boolean,
    CONSTRAINT "Lojas_pkey" PRIMARY KEY (idloja),
    CONSTRAINT fk_nome_unico UNIQUE (nomeloja),
    CONSTRAINT fk_end FOREIGN KEY (localizacao)
        REFERENCES lojaroupa.enderecos (enderecoid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS lojaroupa."Lojas"
    OWNER to postgres;

-- Table: lojaroupa.compras

-- DROP TABLE IF EXISTS lojaroupa.compras;

CREATE TABLE IF NOT EXISTS lojaroupa.compras
(
    compra_id integer NOT NULL DEFAULT nextval('lojaroupa.compras_compra_id_seq'::regclass),
    produto integer NOT NULL,
    client integer NOT NULL,
    quantidade integer NOT NULL,
    loja_id integer NOT NULL,
    CONSTRAINT compras_pkey PRIMARY KEY (compra_id),
    CONSTRAINT fk_cliente FOREIGN KEY (client)
        REFERENCES lojaroupa."Clientes" ("clientId") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_loja FOREIGN KEY (loja_id)
        REFERENCES lojaroupa."Lojas" (idloja) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT produto_fk FOREIGN KEY (produto)
        REFERENCES lojaroupa.produtos (id_produto) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS lojaroupa.compras
    OWNER to postgres;

-- Table: lojaroupa.departamentos

-- DROP TABLE IF EXISTS lojaroupa.departamentos;

CREATE TABLE IF NOT EXISTS lojaroupa.departamentos
(
    dept_id integer NOT NULL DEFAULT nextval('lojaroupa.departamentos_dept_id_seq'::regclass),
    departamento character varying(90) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT departamentos_pkey PRIMARY KEY (dept_id),
    CONSTRAINT fk_dept_uinique UNIQUE (departamento)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS lojaroupa.departamentos
    OWNER to postgres;

-- Table: lojaroupa.enderecos

-- DROP TABLE IF EXISTS lojaroupa.enderecos;

CREATE TABLE IF NOT EXISTS lojaroupa.enderecos
(
    enderecoid integer NOT NULL DEFAULT nextval('lojaroupa.enderecos_enderecoid_seq'::regclass),
    rua character varying(90) COLLATE pg_catalog."default" NOT NULL,
    numero integer NOT NULL,
    bairro character varying(90) COLLATE pg_catalog."default",
    estado character varying(40) COLLATE pg_catalog."default" NOT NULL,
    complemento text COLLATE pg_catalog."default",
    CONSTRAINT enderecos_pkey PRIMARY KEY (enderecoid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS lojaroupa.enderecos
    OWNER to postgres;

-- Table: lojaroupa.estoque_loja

-- DROP TABLE IF EXISTS lojaroupa.estoque_loja;

CREATE TABLE IF NOT EXISTS lojaroupa.estoque_loja
(
    "lojaId" integer NOT NULL,
    produtoid integer NOT NULL,
    quantidade integer NOT NULL,
    CONSTRAINT estoque_loja_pkey PRIMARY KEY ("lojaId"),
    CONSTRAINT fk_loja_est FOREIGN KEY ("lojaId")
        REFERENCES lojaroupa."Lojas" (idloja) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_produto_est FOREIGN KEY (produtoid)
        REFERENCES lojaroupa.produtos (id_produto) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS lojaroupa.estoque_loja
    OWNER to postgres;

-- Table: lojaroupa.produtos

-- DROP TABLE IF EXISTS lojaroupa.produtos;

CREATE TABLE IF NOT EXISTS lojaroupa.produtos
(
    id_produto integer NOT NULL DEFAULT nextval('lojaroupa.produtos_id_produto_seq'::regclass),
    nome_produto character varying(90) COLLATE pg_catalog."default" NOT NULL,
    preco numeric NOT NULL,
    lote integer NOT NULL,
    loja_id integer,
    CONSTRAINT produtos_pkey PRIMARY KEY (id_produto),
    CONSTRAINT fk_loja_id FOREIGN KEY (loja_id)
        REFERENCES lojaroupa."Lojas" (idloja) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS lojaroupa.produtos
    OWNER to postgres;
