USE [master]

DECLARE @Instance varchar(30) = 'SQLEXPRESS' --MSSQLSERVER
DECLARE @DbName varchar(30) = 'AdoNetSample1' --$(Pdbname)'
DECLARE @Sql NVARCHAR(MAX)
DECLARE @DefaultPath varchar(200)
DECLARE @Ver varchar(10) = '2025'

SET NOCOUNT ON --システムメッセージの削除

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
SET @DbName = QUOTENAME(@DbName)

BEGIN TRY
	IF DB_ID(@DbName) IS NOT NULL
	BEGIN
		SET @Sql = N'DROP DATABASE ' + @DbName
		EXECUTE sp_executesql @Sql
	END

	SET @Sql = N'CREATE DATABASE ' + @DbName + '
			ON
			(NAME=''' + @DBName + ''',FILENAME=''' + @DefaultPath + @DBName + '.mdf'',SIZE=8MB,FILEGROWTH=64MB)
			LOG ON
			(NAME=''' + @DBName + '_log'',FILENAME=''' + @DefaultPath + @DBName + '_log.ldf'',SIZE=8MB,FILEGROWTH=64MB)'
	EXECUTE sp_executesql @Sql

	SET @Sql = N'ALTER DATABASE ' + @DBName + ' SET AUTO_CLOSE OFF'
	EXECUTE sp_executesql @Sql
	PRINT(@DbName + 'データベースが作成されました。')
END TRY
BEGIN CATCH
	PRINT(@DbName + 'データベースを作成できませんでした。')
	PRINT('エラー番号：' + CAST(ERROR_NUMBER() AS VARCHAR(10)))
	PRINT('エラーメッセージ：' + ERROR_MESSAGE())
END CATCH
GO