CREATE DATABASE bd_licitacao
ON PRIMARY 
(
	NAME = bd_licitacao,
	FILENAME = 'D:\Faculdade\5º SEMESTRE\Banco de Dados II\1º Bimestre\Trabalho\DataBase\bd_licitacao.mdf',
	SIZE = 5,
	MAXSIZE = 200,
	FILEGROWTH = 5
),
FILEGROUP FGDATA
(
	NAME = bd_licitacao_1,
	FILENAME = 'D:\Faculdade\5º SEMESTRE\Banco de Dados II\1º Bimestre\Trabalho\DataBase\bd_licitacao_1.mdf',
	SIZE = 5,
	MAXSIZE = 200,
	FILEGROWTH = 1
),
(
	NAME = bd_licitacao_2,
	FILENAME = 'D:\Faculdade\5º SEMESTRE\Banco de Dados II\1º Bimestre\Trabalho\DataBase\bd_licitacao_2.mdf',
	SIZE = 5,
	MAXSIZE = 200,
	FILEGROWTH = 1
),
FILEGROUP FGINDEX
(
	NAME = bd_licitacao_3,
	FILENAME = 'D:\Faculdade\5º SEMESTRE\Banco de Dados II\1º Bimestre\Trabalho\DataBase\bd_licitacao_3.mdf',
	SIZE = 5,
	MAXSIZE = 200,
	FILEGROWTH = 1
)
LOG ON
(
	NAME = bd_licitacao_log,
	FILENAME = 'D:\Faculdade\5º SEMESTRE\Banco de Dados II\1º Bimestre\Trabalho\DataBase\bd_licitacao_log.mdf',
	SIZE = 5,
	MAXSIZE = 2GB,
	FILEGROWTH = 10%
)