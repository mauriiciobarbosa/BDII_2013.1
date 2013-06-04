USE bd_licitacao

CREATE TABLE secretaria
(
	cod_secretaria CHAR(2) NOT NULL,
	desc_secretaria VARCHAR(60) NOT NULL,
	
	CONSTRAINT pk_secretaria 
		PRIMARY KEY NONCLUSTERED (cod_secretaria) ON FGINDEX	
) ON FGDATA

CREATE TABLE unidade
(
	cod_secretaria CHAR(2) NOT NULL,
	num_unidade CHAR(3) NOT NULL,
	desc_unidade VARCHAR(80) NOT NULL,
	
	CONSTRAINT pk_unidade PRIMARY KEY NONCLUSTERED (cod_secretaria, num_unidade) ON FGINDEX,
	CONSTRAINT fk_unidade_secretaria 
		FOREIGN KEY (cod_secretaria) REFERENCES secretaria (cod_secretaria)
) ON FGDATA

CREATE TABLE licitacao
(
	num_licitacao CHAR(13) NOT NULL,
	cod_secretaria CHAR(2) NOT NULL,
	num_unidade CHAR(3) NOT NULL,
	dat_cadastro DATETIME,
	
	CONSTRAINT pk_licitacao PRIMARY KEY NONCLUSTERED (num_licitacao) ON FGINDEX,
	CONSTRAINT fk_licitacao_unidade 
		FOREIGN KEY (cod_secretaria, num_unidade) REFERENCES unidade (cod_secretaria, num_unidade)
) ON FGDATA


CREATE TABLE grupo
(
	cod_grupo CHAR(2) NOT NULL,
	desc_grupo VARCHAR(80) NOT NULL,
	
	CONSTRAINT pk_grupo PRIMARY KEY NONCLUSTERED (cod_grupo) ON FGINDEX
) ON FGDATA

CREATE TABLE familia
(
	cod_grupo CHAR(2) NOT NULL,
	num_familia CHAR(2) NOT NULL,
	desc_familia VARCHAR(60) NOT NULL,
	
	CONSTRAINT pk_familia PRIMARY KEY NONCLUSTERED (cod_grupo, num_familia) ON FGINDEX,
	CONSTRAINT fk_familia_grupo
		FOREIGN KEY (cod_grupo) REFERENCES grupo (cod_grupo)
) ON FGDATA

CREATE TABLE produto
(
	num_item CHAR(11) NOT NULL,
	nom_basico VARCHAR(50) NOT NULL,
	nom_detalhe VARCHAR(255) NOT NULL,
	cod_grupo CHAR(2) NOT NULL,
	num_familia CHAR(2) NOT NULL,
	
	CONSTRAINT pk_produto PRIMARY KEY NONCLUSTERED (num_item) ON FGINDEX,
	CONSTRAINT fk_produto_familia
		FOREIGN KEY (cod_grupo, num_familia) REFERENCES familia (cod_grupo, num_familia)
)

CREATE TABLE produtos_licitacao
(
	num_licitacao CHAR(13) NOT NULL,
	num_item CHAR(11) NOT NULL,
	qtd_item int,
	
	CONSTRAINT pk_produtos_licitacao PRIMARY KEY NONCLUSTERED (num_licitacao, num_item) ON FGINDEX,
	CONSTRAINT fk_produtos_licitacao__licitacao
		FOREIGN KEY (num_licitacao) REFERENCES licitacao (num_licitacao),
	CONSTRAINT fk_produtos_licitacao_produto
		FOREIGN KEY (num_item) REFERENCES produto (num_item)
		
) ON FGDATA

CREATE TABLE uf
(
	cod_uf CHAR(2) NOT NULL,
	nom_uf VARCHAR(20),
	
	CONSTRAINT pk_uf PRIMARY KEY NONCLUSTERED (cod_uf) ON FGINDEX
) ON FGDATA

CREATE TABLE fornecedor
(
	num_fornecedor CHAR(14) NOT NULL,
	nom_fornecedor VARCHAR(70) NOT NULL,
	cod_uf char(2) NOT NULL,
	
	CONSTRAINT pk_fornecedor PRIMARY KEY NONCLUSTERED (num_fornecedor) ON FGINDEX,
	CONSTRAINT fk_fornecedor_uf 
		FOREIGN KEY (cod_uf) REFERENCES uf (cod_uf)
) ON FGDATA

CREATE TABLE cotacoes_licitacao
(
	num_licitacao CHAR(13) NOT NULL,
	num_fornecedor CHAR(14) NOT NULL,
	num_item CHAR(11) NOT NULL,
	val_preco_unitario DECIMAL(12,2),
	
	CONSTRAINT pk_cotacoes_licitacao PRIMARY KEY NONCLUSTERED (num_licitacao, num_fornecedor, num_item) ON FGINDEX,
	CONSTRAINT fk_cotacoes_licitacao_produtos_licitacao
		FOREIGN KEY (num_licitacao, num_item) REFERENCES produtos_licitacao (num_licitacao, num_item),
	CONSTRAINT fk_cotacoes_licitacao_fornecedor
		FOREIGN KEY (num_fornecedor) REFERENCES fornecedor (num_fornecedor)
) ON FGDATA

ALTER TABLE dbo.produto
ADD CONSTRAINT un_nom_basico UNIQUE (nom_basico)

ALTER TABLE dbo.fornecedor
ADD CONSTRAINT un_nom_fornecedor UNIQUE (nom_fornecedor)

/*
DROP TABLE dbo.cotacoes_licitacao
DROP TABLE dbo.fornecedor
DROP TABLE dbo.uf
DROP TABLE dbo.produtos_licitacao
DROP TABLE dbo.familia
DROP TABLE dbo.grupo
DROP TABLE dbo.licitacao
DROP TABLE dbo.unidade
DROP TABLE dbo.secretaria
*/