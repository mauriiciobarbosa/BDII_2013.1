CREATE PROCEDURE up_cadastrar_produtos_licitacao
		(
			@num_licitacao CHAR(13),
			@nom_basico VARCHAR(50),
			@qtd_item int
		)
AS
BEGIN
	DECLARE @num_item CHAR(11);
	
	BEGIN TRANSACTION
	
	BEGIN TRY
	
		SELECT @num_item = num_item 
		FROM dbo.produto 
		WHERE nom_basico = @nom_basico
		
		IF @num_item IS NULL
		BEGIN
			RAISERROR('Não existe um produto com o nome informado.', 11, 1)
		END
		
		INSERT INTO dbo.produtos_licitacao
		VALUES (@num_licitacao, @num_item, @qtd_item)
		
		COMMIT
		
	END TRY
	BEGIN CATCH
		SELECT 'INSERT' AS ErrorType, 
			   ERROR_LINE() AS ErrorLine, 
			   ERROR_MESSAGE() AS ErrorMessage,
			   ERROR_SEVERITY() AS ErrorSeverity, 
			   ERROR_STATE() AS ErrorState;
			   
		ROLLBACK TRANSACTION
	END CATCH
END