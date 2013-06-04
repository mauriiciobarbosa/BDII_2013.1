USE bd_licitacao

---------------------------#### up_cadastro_unidade ####-----------------------------
-------------------------------------------------------------------------------------
	-- Teste com erro.
	up_cadastro_unidade 'Secretaria de Saúdess Pública', '117', 'Qualquer área' 

	-- Teste sem erro.
	up_cadastro_unidade 'Secretaria de Saúde Pública', '117', 'Qualquer área' 
	
	-- Teste sem erro - Comprovação
	SELECT U.cod_secretaria,
		   U.num_unidade,
		   U.desc_unidade
	FROM dbo.unidade U
	INNER JOIN dbo.secretaria S ON (S.cod_secretaria = U.cod_secretaria)
	WHERE S.desc_secretaria = 'Secretaria de Saúde Pública'
	AND num_unidade = '117'
	AND desc_unidade = 'Qualquer área'
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------


----------------------------#### up_cadastrar_item ####------------------------------
-------------------------------------------------------------------------------------
	-- Teste com erro em '@desc_grupo'.
	up_cadastrar_item 'Testando procedure', 'Detalhe de teste procedure', 
					  'Grupo BABA criado para teste do banco', 'Familia 12'
	
	-- Teste com erro em '@desc_grupo'.
	up_cadastrar_item 'Testando procedure', 'Detalhe de teste procedure', 
					  'Grupo TJ criado para teste do banco', 'Familiass 12'
					  
	-- Teste sem erro.
	up_cadastrar_item 'Testando procedure', 'Detalhe de teste procedure', 
					  'Grupo TJ criado para teste do banco', 'Familia 12'
					  
	-- Teste sem erro - Comprovação
	SELECT P.num_item,
		   P.nom_basico,
		   P.nom_detalhe,
		   P.cod_grupo,
		   P.num_familia
	FROM dbo.produto P
	INNER JOIN dbo.grupo G ON (G.cod_grupo = P.cod_grupo)
	INNER JOIN dbo.familia F ON (F.num_familia = P.num_familia)
	WHERE nom_basico = 'Testando procedure'
	AND nom_detalhe = 'Detalhe de teste procedure'
	AND G.desc_grupo = 'Grupo TJ criado para teste do banco'
	AND F.desc_familia = 'Familia 12'	
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------


---------------------#### up_cadastrar_produtos_licitacao ####-----------------------
-------------------------------------------------------------------------------------
	-- Teste com erro em '@num_licitacao'.
	up_cadastrar_produtos_licitacao '7834121256', 'Qualquer coisa 5.', 25
	
	-- Teste com erro em '@nom_basico'.
	up_cadastrar_produtos_licitacao '783412125612', 'Qualquer coisa que não exista.', 25
	
	-- Teste sem erro.
	up_cadastrar_produtos_licitacao '783412125612', 'Qualquer coisa 5.', 25
	
	-- Teste sem erro - Comprovação
	SELECT PL.num_licitacao,
		   PL.num_item,
		   PL.qtd_item
	FROM dbo.produtos_licitacao PL
	INNER JOIN dbo.produto P ON (P.num_item = PL.num_item)
	WHERE PL.num_licitacao = '783412125612'
	AND P.nom_basico = 'Qualquer coisa 5.'
	AND PL.qtd_item = 25	
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------


---------------------#### up_cadastrar_cotacoes_licitacao ####-----------------------
-------------------------------------------------------------------------------------
	-- Teste com erro em '@nom_fornecedor'.
	up_cadastrar_cotacoes_licitacao 'Compre Fácil SAAAA', '783412125612', 'Qualquer coisa 5.', 122.00
	
	-- Teste com erro em ''.
	up_cadastrar_cotacoes_licitacao 'Compre Fácil SA', '783412125612', 'Qualquer coisa 5aa.', 122.00
	
	-- Teste sem erro.
	up_cadastrar_cotacoes_licitacao 'Compre Fácil SA', '783412125612', 'Qualquer coisa 5.', 122.00
	
	-- Teste sem erro - Comprovação
	SELECT CL.num_licitacao,
		   CL.num_fornecedor,
		   CL.num_item,
		   CL.val_preco_unitario 
	FROM dbo.cotacoes_licitacao CL
	INNER JOIN dbo.fornecedor F ON (F.num_fornecedor = CL.num_fornecedor)
	INNER JOIN dbo.produto P ON (P.num_item = CL.num_item)
	INNER JOIN dbo.produtos_licitacao PL ON (PL.num_item = CL.num_item AND PL.num_licitacao = CL.num_licitacao)
	WHERE F.nom_fornecedor = 'Compre Fácil SA'
	AND CL.num_licitacao = '783412125612'
	AND P.nom_basico = 'Qualquer coisa 5.'
	AND CL.val_preco_unitario = 122.00
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------