USE [master]

DECLARE @DbName varchar(30) = 'AdoNetSample1'
DECLARE @Schema varchar(30) = 'dbo'
DECLARE @Table varchar(30) = 'shohins'
DECLARE @Sql NVARCHAR(MAX)
DECLARE @FullObjectName NVARCHAR(512)

SET NOCOUNT ON --システムメッセージの削除
SET @FullObjectName = QUOTENAME(@DbName) + N'.' + QUOTENAME(@Schema) + N'.' + QUOTENAME(@Table)

BEGIN TRY
	BEGIN TRANSACTION
	SET @Sql = N'DELETE FROM ' + @FullObjectName
	EXECUTE sp_executesql @Sql
	COMMIT TRANSACTION
	PRINT(@Table + 'テーブル内のデータをすべて削除しました。')
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	PRINT (@Table + 'テーブルのデータが削除できませんでした。')
	PRINT (CAST(ERROR_MESSAGE() as varchar(200)))
END CATCH