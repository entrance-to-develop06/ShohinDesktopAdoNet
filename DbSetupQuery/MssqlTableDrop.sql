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
	IF OBJECT_ID(@FullObjectName) IS NOT NULL
	BEGIN
		SET @Sql = N'DROP TABLE ' + @FullObjectName
		EXECUTE sp_executesql @Sql
		PRINT(@Table + 'テーブルが削除されました。')
	END	
	ELSE BEGIN
		PRINT('テーブルが存在しませんでした。')
	END
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	PRINT (@Table + 'テーブルが削除にできませんでした。')
	PRINT (CAST(ERROR_MESSAGE() as varchar(200)))
END CATCH