SELECT * FROM dbo.uf
SELECT * FROM dbo.unidade
SELECT * FROM dbo.secretaria
SELECT * FROM dbo.grupo WHERE desc_grupo = 'Grupo TA criado para teste do banco'
SELECT * FROM dbo.familia WHERE desc_familia = 'Familia 12'
SELECT * FROM dbo.produto
SELECT * FROM dbo.produtos_licitacao
SELECT * FROM dbo.licitacaodbo.fornecedordbo.cotacoes_licitacao

SELECT * FROM dbo.uf_retorna_cotacao_vencedora('561712234812', 'Qualquer coisa 5.')
SELECT * FROM dbo.uf_qtd_cotacoes_por_estado_fornecedor('Grupo PT criado para teste do banco', 'Familia 15')
SELECT * FROM dbo.uf_qtd_licitacoes_por_unidade('Secretaria do Trabalho, Emprego, Renda e Esporte')
SELECT * FROM dbo.uf_despesas_por_produto('561712234812')

SELECT UF.nom_uf,
	   COUNT(*)
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
WHERE G.desc_grupo = 'Grupo PT criado para teste do banco'
AND F.desc_familia = 'Familia 15'
GROUP BY UF.nom_uf