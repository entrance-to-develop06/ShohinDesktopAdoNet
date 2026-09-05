USE [master]

DECLARE @Instance varchar(30) = 'SQLEXPRESS' --MSSQLSERVER
DECLARE @DbName varchar(30) = 'AdoNetSample1' --$(Pdbname)'
DECLARE @DefaultPath varchar(200)
DECLARE @Ver varchar(10) = '2025'

IF '$(Pver)' <> ''
BEGIN
	SET @ver = '$(Pver)'
END

SET @DefaultPath = CASE @ver
	WHEN '2025' THEN 'MSSQL17.' 
	WHEN '2022' THEN 'MSSQL16.'
	WHEN '2019' THEN 'MSSQL15.'
	WHEN '2017' THEN 'MSSQL14.'
	ELSE 'MSSQL17.'
END
SET @DefaultPath = 'C:\Program Files\Microsoft SQL Server\' + @DefaultPath + @Instance + '\MSSQL\DATA\'

IF DB_ID(@DBName) IS NOT NULL
	EXECUTE('DROP DATABASE ' + @DBName)

EXECUTE('CREATE DATABASE ' + @DBName + '
ON
(NAME=''' + @DBName + ''',FILENAME=''' + @DefaultPath + @DBName + '.mdf'',SIZE=8MB,FILEGROWTH=64MB)
LOG ON
(NAME=''' + @DBName + '_log'',FILENAME=''' + @DefaultPath + @DBName + '_log.ldf'',SIZE=8MB,FILEGROWTH=64MB)')
	
EXECUTE('ALTER DATABASE ' + @DBName + ' SET AUTO_CLOSE OFF')
GO