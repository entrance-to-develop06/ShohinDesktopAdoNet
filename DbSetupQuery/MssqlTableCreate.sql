USE [master]

DECLARE @DbName varchar(30) = 'AdoNetSample1'
DECLARE @Schema varchar(30) = 'dbo'
DECLARE @Table varchar(30) = 'shohins'

SET NOCOUNT ON --システムメッセージの削除
IF OBJECT_ID('[' + @DbName + '].[' + @Schema + '].[' + @Table + ']') IS NOT NULL
	EXECUTE('DROP TABLE [' + @DBName + '].[' + @Schema + '].[' + @Table + ']')

BEGIN TRY
	BEGIN TRANSACTION
	EXECUTE ('CREATE TABLE [' + @DbName + '].[' + @Schema + '].[' + @Table + '] (
		unique_id char(36) NOT NULL,		/*ユニークID*/
		shohin_code int NOT NULL,			/*商品番号*/
		shohin_name char(50),				/*商品名*/
		updated_on decimal(8,0) NOT NULL,   /*編集日付*/
		updated_at decimal(6,0) NOT NULL,   /*編集時刻*/
		remarks varchar(255),               /*備考*/
	primary key (unique_id))')
	COMMIT TRANSACTION
	PRINT(@Table + 'テーブルを作成しました。')
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	PRINT (@Table + 'テーブルが作成できませんでした。')
	PRINT (CAST(ERROR_MESSAGE() as varchar(200)))
END CATCH