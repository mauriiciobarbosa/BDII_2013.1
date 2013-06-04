-- 1. Nome do Fornecedor e o valor da cotação vencedora: com o
-- parâmetro de número da licitação e nome básico do item;

CREATE FUNCTION uf_fornecedor_valor_vencedor (@numLicitacao CHAR(13), @nomBasico VARCHAR(50)) RETURNS TABLE
AS
RETURN (
	SELECT f.nom_fornecedor, MIN(val_preco_unitario) AS val_preco_unitario
	FROM cotacoes_licitacao cl
	INNER JOIN fornecedor f ON cl.num_fornecedor = f.num_fornecedor
	INNER JOIN produto p ON cl.num_item = p.num_item
	WHERE cl.num_licitacao = @numLicitacao AND p.nom_basico = @nomBasico
)

-- select * from licitacao
-- select * from produtos_licitacao
-- select * from cotacoes_licitacao
-- select * from produto