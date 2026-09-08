USE [master]

DECLARE @DbName varchar(30) = 'AdoNetSample1'
DECLARE @Schema varchar(30) = 'dbo'
DECLARE @Table varchar(30) = 'shohins'
DECLARE @Sql NVARCHAR(MAX)
DECLARE @FullObjectName NVARCHAR(512)
DECLARE @Params NVARCHAR(MAX)
DECLARE @UniqueId NVARCHAR(36) = lower(convert(char(36), newid()))
DECLARE @UniqueId2 NVARCHAR(36) = lower(convert(char(36), newid()))
DECLARE @UniqueId3 NVARCHAR(36) = lower(convert(char(36), newid()))
DECLARE @UniqueId4 NVARCHAR(36) = lower(convert(char(36), newid()))
DECLARE @UniqueId5 NVARCHAR(36) = lower(convert(char(36), newid()))
DECLARE @UniqueId6 NVARCHAR(36) = lower(convert(char(36), newid()))

SET NOCOUNT ON --システムメッセージの削除
SET @FullObjectName = QUOTENAME(@DbName) + N'.' + QUOTENAME(@Schema) + N'.' + QUOTENAME(@Table)

BEGIN TRY
	BEGIN TRANSACTION
	SET @params = N'@Id NVARCHAR(36), @Code INT, @Name NVARCHAR(50), @Date DECIMAL(8,0), @Time DECIMAL(6,0), @Remarks NVARCHAR(255),
					@Id2 NVARCHAR(36), @Code2 INT, @Name2 NVARCHAR(50), @Date2 DECIMAL(8,0), @Time2 DECIMAL(6,0), @Remarks2 NVARCHAR(255),
					@Id3 NVARCHAR(36), @Code3 INT, @Name3 NVARCHAR(50), @Date3 DECIMAL(8,0), @Time3 DECIMAL(6,0), @Remarks3 NVARCHAR(255),
					@Id4 NVARCHAR(36), @Code4 INT, @Name4 NVARCHAR(50), @Date4 DECIMAL(8,0), @Time4 DECIMAL(6,0), @Remarks4 NVARCHAR(255),
					@Id5 NVARCHAR(36), @Code5 INT, @Name5 NVARCHAR(50), @Date5 DECIMAL(8,0), @Time5 DECIMAL(6,0), @Remarks5 NVARCHAR(255),
					@Id6 NVARCHAR(36), @Code6 INT, @Name6 NVARCHAR(50), @Date6 DECIMAL(8,0), @Time6 DECIMAL(6,0), @Remarks6 NVARCHAR(255)'
	
	SET @Sql = N'INSERT INTO ' + @FullObjectName +
				N'(unique_id, shohin_code, shohin_name, updated_on, updated_at, remarks) VALUES 
				(@Id, @Code, @Name, @Date, @Time, @Remarks),
				(@Id2, @Code2, @Name2, @Date2, @Time2, @Remarks2),
				(@Id3, @Code3, @Name3, @Date3, @Time3, @Remarks3),
				(@Id4, @Code4, @Name4, @Date4, @Time4, @Remarks4),
				(@Id5, @Code5, @Name5, @Date5, @Time5, @Remarks5),
				(@Id6, @Code6, @Name6, @Date6, @Time6, @Remarks6)'
	EXECUTE sp_executesql @stmt = @Sql, @params = @Params, 
			@Id = @UniqueId, @Code = 5600, @Name = N'セトウチレモン', @Date = 20211008, @Time = 203145, @Remarks = N'瀬戸内レモンです', 
			@Id2 = @UniqueId2, @Code2 = 6360, @Name2 = N'リンゴジュース', @Date2 = 20211206, @Time2 = 102533, @Remarks2 = N'果汁100%の炭酸飲料です',
			@Id3 = @UniqueId3, @Code3 = 2580, @Name3 = N'カフェオレ', @Date3 = 20220321, @Time3 = 91106, @Remarks3 = N'200ml増量中',
			@Id4 = @UniqueId4, @Code4 = 250, @Name4 = N'さけおにぎり', @Date4 = 20220416, @Time4 = 151615, @Remarks4 = N'北海道産さけ使用',
			@Id5 = @UniqueId5, @Code5 = 260, @Name5 = N'うめおにぎり', @Date5 = 20220513, @Time5 = 111506, @Remarks5 = N'none',
			@Id6 = @UniqueId6, @Code6 = 8300, @Name6 = N'カニクリームコロッケ', @Date6 = 20220529, @Time6 = 141521, @Remarks6 = N'３個入りです'
	COMMIT TRANSACTION
	PRINT('サンプル初期データを６件追加しました。')
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	PRINT (@Table + 'テーブルにデータを追加できませんでした。')
	PRINT (CAST(ERROR_MESSAGE() as varchar(200)))
END CATCH