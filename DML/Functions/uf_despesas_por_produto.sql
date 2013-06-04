-- Retornos : Nome do produto, Quantidade adiquirida, preço unitário, valor total (por produto)
CREATE FUNCTION uf_despesas_por_produto( @num_licitacao CHAR(13) )
RETURNS @despesas_por_produtoTab TABLE
		(
			nom_basico 			VARCHAR(50) 	NOT NULL,
			qtd_item			INT				NOT NULL,
			val_preco_unitario	DECIMAL(12,2)	NOT NULL,
			val_total			DECIMAL(12,2)	NOT NULL
		)
BEGIN
	-- Criar uma tabela temporaria contendo somente as cotações vencedoras para determinada licitação
	/*
	CREATE TABLE #cotacoes_vencedoras
	(
		num_licitacao 		CHAR(13) 		NOT NULL,
		num_item 	 		CHAR(14) 		NOT NULL,
		val_preco_unitario	DECIMAL(12,2) NOT NULL
	)
	-- Preenche a tabela temporaria somente com as cotações vencedoras
	INSERT INTO #cotacoes_vencedoras (num_licitacao, num_item, val_preco_unitario)
	SELECT 	num_licitacao, num_item, MIN(val_preco_unitario) FROM dbo.cotacoes	
	WHERE num_licitacao = @num_licitacao
	GROUP BY num_licitacao, num_item
	*/

	SELECT 	num_licitacao, num_item, MIN(val_preco_unitario) 
	INTO #cotacoes_vencedoras	
	FROM dbo.cotacoes	
	WHERE num_licitacao = @num_licitacao
	GROUP BY num_licitacao, num_item	

	INSERT @despesas_por_produtoTab
	SELECT nom_basico AS PRODUTO, qtd_item AS QUANTIDADE, VAL_PRECO_UNITARIO AS 'PRECO UNITARIO',
			VAL_PRECO_UNITARIO * QTD_ITEM AS TOTAL
	FROM dbo.produto p 
	INNER JOIN dbo.produtos_licitacao pl ON p.num_item = pl.num_item
	INNER JOIN #cotacoes_vencedoras cl ON pl.num_licitacao = cl.num_licitacao AND pl.num_item = cl.num_item
	WHERE pl.num_licitacao = @num_licitacao 

	RETURN
END
