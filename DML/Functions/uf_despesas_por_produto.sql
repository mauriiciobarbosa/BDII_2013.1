CREATE FUNCTION uf_despesas_por_produto
		(
			@num_licitacao CHAR(13)
		)
RETURNS TABLE
AS
	RETURN
	(
		SELECT P.nom_basico AS Produto,
			   SUM(PL.qtd_item) AS Quantidade,
			   SUM(CL.val_preco_unitario) AS Valor,
			   SUM(PL.qtd_item) * SUM(CL.val_preco_unitario) AS Total
		FROM dbo.produtos_licitacao PL
		INNER JOIN dbo.cotacoes_licitacao CL
			ON (CL.num_licitacao = PL.num_licitacao AND CL.num_item = PL.num_item)
		INNER JOIN dbo.produto P
			ON (P.num_item = PL.num_item)
		WHERE PL.num_licitacao = @num_licitacao
		GROUP BY P.nom_basico
	);