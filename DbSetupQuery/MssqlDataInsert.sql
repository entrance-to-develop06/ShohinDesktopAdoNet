USE [master]

DECLARE @DbName varchar(30) = 'AdoNetSample1'
DECLARE @Schema varchar(30) = 'dbo'
DECLARE @Table varchar(30) = 'shohins'

BEGIN TRY
	BEGIN TRANSACTION
	SET NOCOUNT ON --システムメッセージの削除
	EXECUTE('INSERT INTO [' + @DBName + '].[' + @Schema + '].[' + @Table + '] ' +
		'(unique_id, shohin_code, shohin_name, updated_on, updated_at, remarks) values ' +
		'(lower(convert(char(36), newid())), 5600,''せとうちレモン'',20211008,203145,''瀬戸内レモンです'')')
	EXECUTE('INSERT INTO [' + @DBName + '].[' + @Schema + '].[' + @Table + '] ' +
		'(unique_id, shohin_code, shohin_name, updated_on, updated_at, remarks) values' +
		'(lower(convert(char(36), newid())), 6360,''リンゴジュース'',20211206,102533,''果汁100%の炭酸飲料です'')')
	EXECUTE('INSERT INTO [' + @DBName + '].[' + @Schema + '].[' + @Table + '] ' +
		'(unique_id, shohin_code, shohin_name, updated_on, updated_at, remarks) values' +
		'(lower(convert(char(36), newid())), 2580,''カフェオレ'',20220321,91106,''200ml増量中'')')
	EXECUTE('INSERT INTO [' + @DBName + '].[' + @Schema + '].[' + @Table + '] ' +
		'(unique_id, shohin_code, shohin_name, updated_on, updated_at, remarks) values' +
		'(lower(convert(char(36), newid())), 250,''さけおにぎり'',20220416,151615,''北海道産さけ使用'')')
	EXECUTE('INSERT INTO [' + @DBName + '].[' + @Schema + '].[' + @Table + '] ' +
		'(unique_id, shohin_code, shohin_name, updated_on, updated_at, remarks) values' +
		'(lower(convert(char(36), newid())), 260,''うめおにぎり'',20220513,111506,''none'')')
	EXECUTE('INSERT INTO [' + @DBName + '].[' + @Schema + '].[' + @Table + '] ' +
		'(unique_id, shohin_code, shohin_name, updated_on, updated_at, remarks) values' +
		'(lower(convert(char(36), newid())), 8300,''カニクリームコロッケ'',20220529,141521,''３個入りです'')')
	COMMIT TRANSACTION
	PRINT('サンプル初期データを６件追加しました。')
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	PRINT (@Table + 'テーブルにデータが追加できませんでした。')
	PRINT (CAST(ERROR_MESSAGE() as varchar(200)))
END CATCH