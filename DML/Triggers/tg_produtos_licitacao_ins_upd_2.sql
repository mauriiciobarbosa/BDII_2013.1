CREATE TRIGGER tg_produtos_licitacao_ins_upd ON produtos_licitacao 
FOR INSERT, UPDATE
AS

-- iii. Uma licitação só pode ter no máximo 5 produtos de uma mesma família;
-- Realizar um inner join com a tabela inserted, a fim de recuperar somente as licitações alteradas.
IF (SELECT COUNT(*) FROM inserted i INNER JOIN produtos_licitacao pl ON i.num_licitacao = pl.num_licitacao
	GROUP BY pl.num_licitacao, pl.num_item HAVING COUNT(*) > 5) > 0
	BEGIN
		RAISERROR('Uma licitação só pode ter no máximo 5 produtos de uma mesma família',11,1)
		ROLLBACK
	END
