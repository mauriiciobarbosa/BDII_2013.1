/*
		i. Em um determinado mês, um certo produto só pode estar associado a no
		máximo uma licitação por secretaria;
*/

CREATE TRIGGER tg_produtos_licitacao_ins_upd ON produtos_licitacao 
FOR INSERT, UPDATE
AS
TRY BEGIN
	DECLARE @dtc_licitacao DATETIME
	
	SELECT COUNT(*) FROM inserted 

	-- Recuperar data da licitação na tabela licitação
	-- Recuperar quantidade de licit 
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
