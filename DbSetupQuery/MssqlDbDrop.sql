USE [master]

DECLARE @DbName varchar(30) = 'AdoNetSample1' --$(Pdbname)'

IF DB_ID(@DBName) IS NOT NULL
	EXECUTE('DROP DATABASE ' + @DBName)