USE [AdoNetSample1]

CREATE TYPE dbo.UserTableType AS TABLE
(
    unique_id NVARCHAR(36),
    shohin_code INT,
	shohin_name NVARCHAR(50),
	update_on DECIMAL(8,0),
	update_at DECIMAL(6,0),
	remarks NVARCHAR(255)
);
GO

DECLARE @DataShohins dbo.UserTableType
DECLARE @UniqueId NVARCHAR(36) = lower(convert(char(36), newid()))
DECLARE @UniqueId2 NVARCHAR(36) = lower(convert(char(36), newid()))
DECLARE @UniqueId3 NVARCHAR(36) = lower(convert(char(36), newid()))
DECLARE @UniqueId4 NVARCHAR(36) = lower(convert(char(36), newid()))
DECLARE @UniqueId5 NVARCHAR(36) = lower(convert(char(36), newid()))
DECLARE @UniqueId6 NVARCHAR(36) = lower(convert(char(36), newid()))

INSERT INTO @DataShohins (unique_id, shohin_code, shohin_name, update_on, update_at, remarks)
	VALUES (@UniqueId, 5600, N'セトウチレモン', 20211008, 203145, N'瀬戸内レモンです'),
			(@UniqueId2, 6360, N'リンゴジュース', 20211206, 102533, N'果汁100%の炭酸飲料です'),
			(@UniqueId3, 2580, N'カフェオレ', 20220321, 91106, N'200ml増量中'),
			(@UniqueId4, 250, N'さけおにぎり', 20220416, 151615, N'北海道産さけ使用'),
			(@UniqueId5, 260, N'うめおにぎり', 20220513, 111506, N'none'),
			(@UniqueId6, 8300, N'カニクリームコロッケ', 20220529, 141521, N'３個入りです')

DECLARE @DbName varchar(30) = 'AdoNetSample1'
DECLARE @Schema varchar(30) = 'dbo'
DECLARE @Table varchar(30) = 'shohins'
DECLARE @Sql NVARCHAR(MAX)
DECLARE @FullObjectName NVARCHAR(512)
DECLARE @Params NVARCHAR(MAX)


SET NOCOUNT ON --システムメッセージの削除
SET @FullObjectName = QUOTENAME(@DbName) + N'.' + QUOTENAME(@Schema) + N'.' + QUOTENAME(@Table)

BEGIN TRY
	BEGIN TRANSACTION
	SET @Sql = N'INSERT INTO ' + @FullObjectName + 
			N'(unique_id, shohin_code, shohin_name, updated_on, updated_at, remarks) 
			SELECT unique_id, shohin_code, shohin_name, update_on, update_at, remarks FROM @ParamShohins'
	EXECUTE sp_executesql @stmt = @sql, @params = N'@ParamShohins dbo.UserTableType READONLY', @ParamShohins = @DataShohins
	COMMIT TRANSACTION
	PRINT('サンプル初期データを６件追加しました。')
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	PRINT (@Table + 'テーブルにデータを追加できませんでした。')
	PRINT (CAST(ERROR_MESSAGE() as varchar(200)))
END CATCH
GO

DROP TYPE dbo.UserTableType