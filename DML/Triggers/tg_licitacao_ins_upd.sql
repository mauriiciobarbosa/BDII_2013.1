CREATE TRIGGER tg_licitacao_ins_upd ON licitacao 
FOR INSERT, UPDATE
AS
	-- ii. Uma unidade só pode ter no máximo 2 licitações por mês;
IF (SELECT COUNT(*) FROM licitacao l INNER JOIN unidade un ON l.cod_secretaria = un.cod_secretaria 
	AND l.num_unidade = un.num_unidade GROUP BY un.cod_secretaria, un.num_unidade HAVING COUNT(*) > 1) > 1
	BEGIN
		RAISERROR('Uma unidade só pode ter no máximo duas licitações por mês',11,1)
		ROLLBACK
	END
