CREATE FUNCTION uf_retorna_cotacao_vencedora
		(
			@num_licitacao CHAR(13),
			@nom_basico VARCHAR(50)
		)
RETURNS TABLE
AS
		RETURN 
		(
			SELECT F.nom_fornecedor AS Fornecedor, 
				   CL.val_preco_unitario AS [Valor da cotação]  
			FROM dbo.cotacoes_licitacao CL
			INNER JOIN dbo.produtos_licitacao PL 
				ON (PL.num_licitacao = CL.num_licitacao AND PL.num_item = CL.num_item)
			INNER JOIN dbo.produto P 
				ON (P.num_item = PL.num_item)
			INNER JOIN dbo.fornecedor F
				ON (F.num_fornecedor = CL.num_fornecedor)
			WHERE CL.num_licitacao = @num_licitacao
			AND P.nom_basico = @nom_basico
			AND CL.val_preco_unitario = 
					(
						SELECT MIN(CL.val_preco_unitario) 
						FROM dbo.cotacoes_licitacao CL
						INNER JOIN dbo.produtos_licitacao PL 
							ON (PL.num_licitacao = CL.num_licitacao AND PL.num_item = CL.num_item)
						INNER JOIN dbo.produto P 
							ON (P.num_item = PL.num_item)
						INNER JOIN dbo.fornecedor F
							ON (F.num_fornecedor = CL.num_fornecedor)
						WHERE CL.num_licitacao = @num_licitacao
						AND P.nom_basico = @nom_basico
					)
		);
