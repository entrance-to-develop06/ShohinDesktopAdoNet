USE [master]

DECLARE @DbName varchar(30) = 'AdoNetSample1'
DECLARE @Schema varchar(30) = 'dbo'
DECLARE @Table varchar(30) = 'shohins'

BEGIN TRY
	BEGIN TRANSACTION
	IF OBJECT_ID('[' + @DbName + '].[' + @Schema + '].[' + @Table + ']') IS NOT NULL
		EXECUTE('DROP TABLE [' + @DbName + '].[' + @Schema + '].[' + @Table + ']')
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	PRINT (@Table + 'テーブルの削除に失敗しました。')
	PRINT (CAST(ERROR_MESSAGE() as varchar(200)))
END CATCH