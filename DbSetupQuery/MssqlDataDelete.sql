USE [master]

DECLARE @DbName varchar(30) = 'AdoNetSample1'
DECLARE @Schema varchar(30) = 'dbo'
DECLARE @Table varchar(30) = 'shohins'

BEGIN TRY
	BEGIN TRANSACTION
	SET NOCOUNT ON --システムメッセージの削除
	EXECUTE('DELETE FROM [' + @DBName + '].[' + @Schema + '].[' + @Table + '] ')
	COMMIT TRANSACTION
	PRINT(@Table + 'テーブル内のデータをすべて削除しました。')
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	PRINT (@Table + 'テーブルのデータが削除できませんでした。')
	PRINT (CAST(ERROR_MESSAGE() as varchar(200)))
END CATCH