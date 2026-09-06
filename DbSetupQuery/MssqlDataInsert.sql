USE [master]

DECLARE @DbName varchar(30) = 'AdoNetSample1'
DECLARE @Schema varchar(30) = 'dbo'
DECLARE @Table varchar(30) = 'shohins'

BEGIN TRY
	BEGIN TRANSACTION
	EXECUTE('INSERT INTO [' + @DBName + '].[' + @Schema + '].[' + @Table + '] ' +
		'(unique_id, shohin_code, shohin_name, updated_on, updated_at, remarks) values ' +
		'(lower(convert(char(36), newid())), 5600,''せとうちレモン'',20211008,203145,''瀬戸内レモンです'')')
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	PRINT (@Table + 'テーブルにデータが追加できませんでした。')
	PRINT (CAST(ERROR_MESSAGE() as varchar(200)))
END CATCH