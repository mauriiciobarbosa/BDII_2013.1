CREATE DATABASE bd_licitacao
ON PRIMARY 
(
	NAME = bd_licitacao,
	FILENAME = 'D:\Faculdade\5º SEMESTRE\Banco de Dados II\1º Bimestre\Trabalho\DataBase\bd_licitacao.mdf',
	SIZE = 50,
	MAXSIZE = 200,
	FILEGROWTH = 50
),
FILEGROUP FGDATA
(
	NAME = bd_licitacao_1,
	FILENAME = 'D:\Faculdade\5º SEMESTRE\Banco de Dados II\1º Bimestre\Trabalho\DataBase\bd_licitacao_1.ndf',
	SIZE = 50,
	MAXSIZE = 100,
	FILEGROWTH = 25
),
(
	NAME = bd_licitacao_2,
	FILENAME = 'D:\Faculdade\5º SEMESTRE\Banco de Dados II\1º Bimestre\Trabalho\DataBase\bd_licitacao_2.ndf',
	SIZE = 50,
	MAXSIZE = 100,
	FILEGROWTH = 25
),
FILEGROUP FGINDEX
(
	NAME = bd_licitacao_3,
	FILENAME = 'D:\Faculdade\5º SEMESTRE\Banco de Dados II\1º Bimestre\Trabalho\DataBase\bd_licitacao_3.ndf',
	SIZE = 50,
	MAXSIZE = 100,
	FILEGROWTH = 25
)
LOG ON
(
	NAME = bd_licitacao_log,
	FILENAME = 'D:\Faculdade\5º SEMESTRE\Banco de Dados II\1º Bimestre\Trabalho\DataBase\bd_licitacao_log.ldf',
	SIZE = 200,
	MAXSIZE = 2GB,
	FILEGROWTH = 200
)
