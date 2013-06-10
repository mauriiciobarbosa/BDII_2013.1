/*
	•
Implementação de regras de negócio através de triggers;
i. Em um determinado mês, um certo produto só pode estar associado a no
máximo uma licitação por secretaria;
ii. Uma unidade só pode ter no máximo 2 licitações por mês; - ok
iii. Uma licitação só pode ter no máximo 5 produtos de uma mesma família; - ok
iv. Em uma determinada licitação, um produto só pode ter no máximo 10
cotações de fornecedores do mesmo estado;
v. Em uma determinada licitação, um fornecedor só pode fazer cotações
para no máximo 2 produtos;
vi. Em uma determinada licitação, não pode existir 2 cotações com o mesmo
valor para um mesmo produto;
*/

CREATE TRIGGER tg_cotacoes_licitacao_ins_upd ON cotacoes_licitacao 
FOR INSERT, UPDATE
AS
-- iv. Em uma determinada licitação, um produto só pode ter no máximo 10 cotações de fornecedores do mesmo estado;
IF (SELECT COUNT(*) FROM inserted i INNER JOIN cotacoes_licitacao cl
	ON i.num_licitacao = cl.num_licitacao and i.num_item = cl.num_item
	INNER JOIN fornecedor f ON i.num_fornecedor = f.num_fornecedor
	GROUP BY i.num_licitacao, i.num_item, cod_uf
	HAVING COUNT(*) > 10) > 0
	BEGIN
		RAISERROR('Número limite de cotações produto/licitação atingido!',11,1)
		ROLLBACK
	END
-- v. Em uma determinada licitação, um fornecedor só pode fazer cotações para no máximo 2 produtos;
IF (SELECT COUNT(*) FROM inserted i INNER JOIN cotacoes_licitacao cl
    ON i.num_fornecedor = cl.num_fornecedor AND i.num_licitacao = cl.num_licitacao
	GROUP BY i.num_fornecedor, i.num_licitacao
	HAVING COUNT(*) > 1) > 0
	BEGIN
		RAISERROR('Número de cotações máxima fornecedor/licitacao atingido.',11,1)
		ROLLBACK
	END
-- vi. Em uma determinada licitação, não pode existir 2 cotações com o mesmo valor para um mesmo produto;
IF (SELECT COUNT(*) FROM inserted i INNER JOIN cotacoes_licitacao cl
	ON i.num_licitacao = cl.num_licitacao AND i.num_item = cl.num_item
	GROUP BY i.num_licitacao, i.num_item, i.val_preco_unitario
	HAVING COUNT(*) > 1) > 0
	BEGIN
		RAISERROR('Não pode existir duas cotações com o mesmo valor para o mesmo produto.',11,1)
		ROLLBACK
	END
