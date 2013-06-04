-- Uma licitação só pode ter no máximo 5 produtos de uma mesma família;
CREATE TRIGGER tg_produtos_licitacao_ins_upd ON produtos_licitacao 
FOR INSERT, UPDATE
AS

CREATE TABLE #produtos_licitacao_temp
(
	num_licitacao 	CHAR(13) NOT NULL,
	num_item 		CHAR(11) NOT NULL,
	qtd_item 		int
)

INSERT INTO #produtos_licitacao_temp (num_licitacao, num_item, qtd_item)
		(SELECT num_licitacao, num_item, qtd_item FROM inserted)

-- Declara as variáveis
DECLARE @num_licitacao CHAR(13)
DECLARE @num_item 	   CHAR(11)
DECLARE @num_familia   CHAR(2)

WHILE(SELECT COUNT(*) FROM #produtos_licitacao_temp)
BEGIN
	-- Recuperar o produto inserido ou atualizado,o numero da licitacao e o numero da familia do prodruto.
	SELECT @num_licitacao = pl.num_licitacao, @num_item = p.num_item, @num_familia = p.num_familia
	FROM inserted pl INNER JOIN produto p ON pl.num_item = p.num_item

	-- Recuperar a quantidade de produtos ja cadastrado nesta licitação que possui a mesma familia do novo produto.
	IF ((SELECT COUNT(*) FROM produtos_licitacao pl INNER JOIN produto p ON pl.num_item = p.num_item
		 WHERE pl.num_licitacao = @num_licitacao AND p.num_familia = @num_familia) >= 5)
		BEGIN
			RAISERROR('O limite de produtos de uma mesma familia registrados nessa licitação foi já foi atingido!',10,1)
			ROLLBACK
		END

	DELETE FROM #produtos_licitacao_temp WHERE num_licitacao = @num_licitacao AND num_item = @num_item
END

RETURN
