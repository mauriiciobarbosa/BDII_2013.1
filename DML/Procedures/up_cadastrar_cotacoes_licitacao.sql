CREATE PROCEDURE up_cadastrar_cotacoes_licitacao
		(
			@nom_fornecedor VARCHAR(70),
			@num_licitacao CHAR(13),
			@nom_basico VARCHAR(50),
			@valor_cotacao DECIMAL(12,2)
		)
AS
BEGIN
	DECLARE @num_item CHAR(11);
	DECLARE @num_fornecedor CHAR(14);

	BEGIN TRY
		-- Verifica se o produto existe.
		SELECT @num_item = P.num_item
		FROM dbo.produto P
		WHERE P.nom_basico = @nom_basico
		
		IF @num_item IS NULL
		BEGIN
			RAISERROR('Não foi possível encontrar um produto com o nome básico informado.', 14, 1)
		END
		-- Verifica se o fornecedor existe.
		SELECT @num_fornecedor = num_fornecedor
		FROM dbo.fornecedor
		WHERE nom_fornecedor = @nom_fornecedor

		IF @num_fornecedor IS NULL
		BEGIN
			RAISERROR('Não foi possível encontrar um fornecedor com o nome informado.', 14, 1)
		END
		
		INSERT INTO dbo.cotacoes_licitacao
		VALUES (@num_licitacao, @num_fornecedor, @num_item, @valor_cotacao)
		
	END TRY
	BEGIN CATCH
		SELECT 'INSERT' AS ErrorType,
			   ERROR_LINE() AS ErrorLine, 
			   ERROR_MESSAGE() AS ErrorMessage,
			   ERROR_SEVERITY() AS ErrorSeverity, 
			   ERROR_STATE() AS ErrorState;
	END CATCH
END
