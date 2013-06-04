CREATE PROCEDURE up_cadastro_unidade
		(
			@nom_secretaria VARCHAR(60),
			@num_unidade CHAR(3),
			@nome_unidade VARCHAR(80)
		)
AS
BEGIN	
	DECLARE @cod_secretaria CHAR(2);
	
	BEGIN TRY
	
		SELECT @cod_secretaria = cod_secretaria 
		FROM dbo.secretaria
		WHERE desc_secretaria = @nom_secretaria
		
		IF @cod_secretaria IS NULL
		BEGIN
			RAISERROR('Não foi possível encontrar uma secretaria com o nome informado.', 11, 1)
		END
	
		INSERT INTO dbo.unidade
		VALUES (@cod_secretaria, @num_unidade, @nome_unidade)
		
	END TRY
	BEGIN CATCH
		SELECT 'INSERT' AS ErrorType, 
			   ERROR_LINE() AS ErrorLine, 
			   ERROR_MESSAGE() AS ErrorMessage,
			   ERROR_SEVERITY() AS ErrorSeverity, 
			   ERROR_STATE() AS ErrorState;
	END CATCH
END	