-- Em uma determinada licitação, um produto só pode ter no máximo 10 cotações de fornecedores do mesmo estado;
-- Em uma determinada licitação, um fornecedor só pode fazer cotações para no máximo 2 produtos;
-- Em uma determinada licitação, não pode existir 2 cotações com o mesmo valor para um mesmo produto;
CREATE TRIGGER tg_cotacoes_licitacao_ins_upd ON cotacoes_licitacao 
FOR INSERT, UPDATE
AS

CREATE TABLE #cotacoes_licitacao_temp
(
	num_licitacao 		CHAR(13) 		NOT NULL,
	num_fornecedor 		CHAR(14) 		NOT NULL,
	num_item 			CHAR(11) 		NOT NULL,
	val_preco_unitario 	DECIMAL(12,2) 	NULL
)


INSERT INTO #cotacoes_licitacao_temp (num_licitacao, num_fornecedor, num_item, val_preco_unitario)
			(SELECT num_licitacao, num_fornecedor, num_item, val_preco_unitario FROM inserted)

-- Declara as variáveis
DECLARE @num_licitacao 		CHAR(13)
DECLARE @num_fornecedor 	CHAR(14)
DECLARE @num_item 			CHAR(11)
DECLARE @cod_uf				CHAR(2)
DECLARE @val_preco_unitario DECIMAL(12,2)
--DECLARE @error				VARCHAR(500)

WHILE ((SELECT COUNT(*) FROM #cotacoes_licitacao_temp) > 0)
BEGIN
	-- Recupera numero e estado do fornecedor, o numero do produto e o numero da licitação.
	SELECT @num_licitacao = cl.num_licitacao, @num_item = cl.num_item, @cod_uf = f.cod_uf, 
	@num_fornecedor = f.num_fornecedor, @val_preco_unitario = cl.val_preco_unitario
	FROM #cotacoes_licitacao_temp cl INNER JOIN fornecedor f ON cl.num_fornecedor = f.num_fornecedor

	-- Recupera a quantidade de um determinado produto associado a uma determinada cotação realizada
	-- pelos fornecedores de um determinado estado.
	IF ((SELECT COUNT(*) FROM cotacoes_licitacao cl INNER JOIN fornecedor f ON cl.num_fornecedor = f.num_fornecedor
		 WHERE cl.num_licitacao = @num_licitacao AND cl.num_item = @num_item AND f.cod_uf = @cod_uf) > 10) 
		BEGIN
			RAISERROR('O limite de cotações desse produto para fornecedores desse estado atingiu o limite!',12,1)
			ROLLBACK
			-- SET @error = 'O limite de cotações desse produto para fornecedores desse estado atingiu o limite!'
		END
	-- Recupera a quantidade de cotações realizadas por um determinado fornecedor numa determinada licitação.
	IF ((SELECT COUNT(*) FROM cotacoes_licitacao WHERE num_licitacao = @num_licitacao AND num_fornecedor = @num_fornecedor) > 2)
		BEGIN
			RAISERROR ('O limite de cotações realizada por esta empresa nesta licitação foi atingido!', 10, 1)
			ROLLBACK
			-- SET @error = (SELECT (@error + 'O limite de cotações realizada por esta empresa nesta licitação foi atingido!\n'))
		END
	-- Verifica se existe mais de uma cotação com o mesmo valor.
	IF ((SELECT COUNT(*) FROM cotacoes_licitacao WHERE num_licitacao = @num_licitacao 
		 AND num_item = @num_item AND val_preco_unitario = @val_preco_unitario) > 1)
		BEGIN
			RAISERROR ('Já existe uma cotação com o mesmo preço informado!', 10, 1)
			ROLLBACK
			-- SET @error = (SELECT (@error + 'Já existe uma cotação com o mesmo preço informado!\n'))
		END

	DELETE FROM #cotacoes_licitacao_temp 
	WHERE num_licitacao = @num_licitacao AND num_item = @num_item AND num_fornecedor = @num_fornecedor
END

RETURN
