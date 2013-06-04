CREATE FUNCTION uf_qtd_licitacoes_por_unidade
		(
			@nom_secretaria VARCHAR(60)
		)
RETURNS TABLE
AS
	RETURN
	(
		SELECT UN.desc_unidade AS [Unidade],
			   COUNT(*) AS [Quantidade]
		FROM dbo.licitacao L
		INNER JOIN dbo.unidade UN
			ON (UN.cod_secretaria = L.cod_secretaria AND Un.num_unidade = L.num_unidade)
		INNER JOIN dbo.secretaria S
			ON (S.cod_secretaria = UN.cod_secretaria)
		WHERE S.desc_secretaria = @nom_secretaria
		GROUP BY UN.desc_unidade		
	);
