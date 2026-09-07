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
	END

	SET @Sql = N'CREATE TABLE ' + @FullObjectName + N'( 
				unique_id char(36) NOT NULL,		/*ユニークID*/
				shohin_code int NOT NULL,			/*商品番号*/
				shohin_name char(50),				/*商品名*/
				updated_on decimal(8,0) NOT NULL,   /*編集日付*/
				updated_at decimal(6,0) NOT NULL,   /*編集時刻*/
				remarks varchar(255),               /*備考*/
				primary key (unique_id))'
	EXECUTE sp_executesql @Sql
	COMMIT TRANSACTION
	PRINT(@Table + 'テーブルを作成しました。')
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	PRINT (@Table + 'テーブルが作成できませんでした。')
	PRINT (CAST(ERROR_MESSAGE() as varchar(200)))
END CATCH