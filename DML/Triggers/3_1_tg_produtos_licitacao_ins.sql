-- CREATE TRIGGER tg_produtos_licitacao_ins ON produtos_licitacao FOR INSERT AS

DECLARE @numLicitacao CHAR(13)
DECLARE @numItem VARCHAR(11)
DECLARE @mes TINYINT

-- SELECT @numLicitacao = num_licitacao, @numItem = num_item FROM inserted

SET @numItem = '35271324516'
SET @numLicitacao = '123456781212'

SELECT @mes = DATEPART(M,dat_cadastro) FROM licitacao WHERE num_licitacao = @numLicitacao

IF (SELECT COUNT(*) FROM produtos_licitacao pl 
-- INNER JOIN produto p ON pl.num_item = p.num_item
INNER JOIN licitacao l ON pl.num_licitacao = l.num_licitacao
INNER JOIN unidade u ON l.cod_secretaria = u.cod_secretaria AND l.num_unidade = u.num_unidade
WHERE p.num_item = @numItem AND l.num_licitacao = @numLicitacao AND DATEPART(M,l.dat_cadastro) = @mes) > 1
	RAISERROR ('A licitacao a já tem o produto b associado no mês c de para a secretaria d', 10, 1)

-- Teste válido
-- EXEC up_cad_produtos_licitacao 1234567890123, 'xyz', 10

-- Teste inválido
-- EXEC up_cad_produtos_licitacao 1234567890123, 'xyz', 10

/*
SELECT * FROM produto
SELECT * FROM secretaria
SELECT * FROM licitacao
SELECT * FROM produtos_licitacao
*/
