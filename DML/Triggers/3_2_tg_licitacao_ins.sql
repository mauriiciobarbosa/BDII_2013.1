-- ii. Uma unidade só pode ter no máximo 2 licitações por mês;
CREATE TRIGGER tg_licitacao_ins ON licitacao FOR INSERT AS

DECLARE @numUnidade CHAR(3)
DECLARE @mes TINYINT

-- Seleciona o mês a partir do registro inserido
SELECT @numUnidade = num_unidade, @mes = DATEPART(M,dat_cadastro) FROM inserted

-- Verifica se há mais de duas licitacoes para a unidade/mês
IF (SELECT COUNT(*) FROM licitacao l INNER JOIN unidade u ON l.cod_secretaria = u.cod_secretaria AND l.num_unidade = u.num_unidade
WHERE l.num_unidade = @numUnidade AND DATEPART(M,l.dat_cadastro) = @mes) > 2
	RAISERROR ('A unidade não pode ter mais de 2 licitações por mês!', 10, 1)
	
	
-- Teste válido
/*

*/
-- Teste inválido