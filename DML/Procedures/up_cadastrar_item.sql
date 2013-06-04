CREATE PROCEDURE up_cadastrar_item
		(
			@nom_basico VARCHAR(50),
			@nom_detalhe VARCHAR(255),
			@desc_grupo VARCHAR(80),
			@desc_familia VARCHAR(70)
		)
AS
BEGIN
	DECLARE @num_item CHAR(11);
	DECLARE @cod_grupo CHAR(2);
	DECLARE @num_familia CHAR(2);
	
	BEGIN TRY
	
		SELECT @num_item = (MAX(CONVERT(BIGINT, num_item)) + 1) 
		FROM dbo.produto
		
		SELECT @cod_grupo = cod_grupo 
		FROM dbo.grupo 
		WHERE desc_grupo = @desc_grupo
		
		IF @cod_grupo IS NULL
		BEGIN
			RAISERROR('Não foi possível encontrar um grupo com a descrição informada.', 11, 1)
		END
		
		SELECT @num_familia = num_familia 
		FROM dbo.familia 
		WHERE desc_familia = @desc_familia
		
		IF @num_familia IS NULL
		BEGIN
			RAISERROR('Não foi possível encontrar uma familia com a descrição informada.', 11, 1)
		END
		
		INSERT INTO dbo.produto
		VALUES (@num_item, @nom_basico, @nom_detalhe, @cod_grupo, @num_familia)
		
	END TRY
	BEGIN CATCH
		SELECT 'INSERT' AS ErrorType, 
			   ERROR_LINE() AS ErrorLine, 
			   ERROR_MESSAGE() AS ErrorMessage,
			   ERROR_SEVERITY() AS ErrorSeverity, 
			   ERROR_STATE() AS ErrorState;
	END CATCH
END