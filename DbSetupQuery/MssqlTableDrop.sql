USE [master]

DECLARE @DbName varchar(30) = 'AdoNetSample1'
DECLARE @Schema varchar(30) = 'dbo'
DECLARE @Table varchar(30) = 'shohins'

SET NOCOUNT ON --システムメッセージの削除
BEGIN TRY
	BEGIN TRANSACTION
	IF OBJECT_ID('[' + @DbName + '].[' + @Schema + '].[' + @Table + ']') IS NOT NULL
		EXECUTE('DROP TABLE [' + @DbName + '].[' + @Schema + '].[' + @Table + ']')
	COMMIT TRANSACTION
	PRINT(@Table + 'テーブルが削除されました。')
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	PRINT (@Table + 'テーブルが削除にできませんでした。')
	PRINT (CAST(ERROR_MESSAGE() as varchar(200)))
END CATCH