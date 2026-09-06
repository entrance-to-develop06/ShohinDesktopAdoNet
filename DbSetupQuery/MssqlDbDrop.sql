USE [master]

DECLARE @DbName varchar(30) = 'AdoNetSample1' --$(Pdbname)'

SET NOCOUNT ON --システムメッセージの削除

IF DB_ID(@DbName) IS NOT NULL
BEGIN
	--シングルユーザーモードへの変更しDB接続の強制切断
	--現在使用中のデータベースを削除できない問題を解消
	EXECUTE('ALTER DATABASE [' + @DbName + '] SET SINGLE_USER WITH ROLLBACK IMMEDIATE')
	
	EXECUTE('DROP DATABASE ' + @DBName)
	PRINT(@DbName + 'データベースを削除しました。')
END
ELSE
BEGIN
	PRINT(@DbName + 'データベースが存在しませんでした。')
END