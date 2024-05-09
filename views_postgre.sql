-- View: lojaroupa.compras_cliente_vw

-- DROP VIEW lojaroupa.compras_cliente_vw;

CREATE OR REPLACE VIEW lojaroupa.compras_cliente_vw
 AS
 SELECT c."clientId",
    c.nome,
    c.cpf,
    p.nome_produto,
    cl.quantidade
   FROM lojaroupa.compras cl
     JOIN lojaroupa."Clientes" c ON cl.client = c."clientId"
     JOIN lojaroupa.produtos p ON p.id_produto = cl.produto;

ALTER TABLE lojaroupa.compras_cliente_vw
    OWNER TO postgres;

-- View: lojaroupa.estoque_vw

-- DROP VIEW lojaroupa.estoque_vw;

CREATE OR REPLACE VIEW lojaroupa.estoque_vw
 AS
 SELECT lj.idloja,
    lj.nomeloja,
    lj.localizacao,
    lj.ativa,
    pd.id_produto,
    pd.nome_produto,
    pd.preco,
    pd.lote,
    pd.loja_id,
    est."lojaId",
    est.produtoid,
    est.quantidade
   FROM lojaroupa."Lojas" lj
     JOIN lojaroupa.produtos pd ON pd.loja_id = lj.idloja
     JOIN lojaroupa.estoque_loja est ON est."lojaId" = lj.idloja;

ALTER TABLE lojaroupa.estoque_vw
    OWNER TO postgres;

