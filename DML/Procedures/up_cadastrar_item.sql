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
	
	BEGIN TRANSACTION
	
	BEGIN TRY
	
		SELECT @num_item = (MAX(CONVERT(BIGINT, num_item)) + 1) 
		FROM dbo.produto
		
		SELECT @cod_grupo = f.cod_grupo, @num_familia = num_familia 
		FROM dbo.familia f INNER JOIN dbo.grupo g ON f.cod_grupo = g.cod_grupo
		WHERE desc_familia = @desc_familia AND desc_grupo = @desc_grupo
		
		IF @cod_grupo IS NULL
		BEGIN
			RAISERROR('Não foi possível encontrar a familia e o grupo ao qual o produto está associada.', 11, 1)
		END
		
		INSERT INTO dbo.produto
		VALUES (@num_item, @nom_basico, @nom_detalhe, @cod_grupo, @num_familia)
		
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
