CREATE FUNCTION uf_qtd_cotacoes_por_estado_fornecedor
		(
			@nom_grupo VARCHAR(80),
			@nom_familia VARCHAR(60)
		)
RETURNS TABLE
AS
	RETURN
	(
		SELECT UF.nom_uf AS [Fornecedor - UF],
			   COUNT(*) AS [Quantidade]
		FROM dbo.grupo G
		INNER JOIN dbo.familia F
			ON (F.cod_grupo = G.cod_grupo)
		INNER JOIN dbo.produto P
			ON (P.cod_grupo = F.cod_grupo AND P.num_familia = F.num_familia)
		INNER JOIN dbo.produtos_licitacao PL
			ON (PL.num_item = P.num_item)
		INNER JOIN dbo.cotacoes_licitacao CL
			ON (CL.num_licitacao = PL.num_licitacao AND CL.num_item = PL.num_item)
		INNER JOIN dbo.fornecedor FO
			ON (FO.num_fornecedor = CL.num_fornecedor)
		INNER JOIN dbo.uf UF
			ON (UF.cod_uf = FO.cod_uf)
		WHERE G.desc_grupo = @nom_grupo
		AND F.desc_familia = @nom_familia
		GROUP BY UF.nom_uf
	);