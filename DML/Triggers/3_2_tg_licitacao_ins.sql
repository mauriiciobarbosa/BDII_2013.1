-- ii. Uma unidade s� pode ter no m�ximo 2 licita��es por m�s;
CREATE TRIGGER tg_licitacao_ins ON licitacao FOR INSERT AS

DECLARE @numUnidade CHAR(3)
DECLARE @mes TINYINT

-- Seleciona o m�s a partir do registro inserido
SELECT @numUnidade = num_unidade, @mes = DATEPART(M,dat_cadastro) FROM inserted

-- Verifica se h� mais de duas licitacoes para a unidade/m�s
IF (SELECT COUNT(*) FROM licitacao l INNER JOIN unidade u ON l.cod_secretaria = u.cod_secretaria AND l.num_unidade = u.num_unidade
WHERE l.num_unidade = @numUnidade AND DATEPART(M,l.dat_cadastro) = @mes) > 2
	RAISERROR ('A unidade n�o pode ter mais de 2 licita��es por m�s!', 10, 1)
	
	
-- Teste v�lido
/*

*/
-- Teste inv�lido