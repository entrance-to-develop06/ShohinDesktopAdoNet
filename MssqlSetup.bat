@echo off
rem バッチファイルでsqlcmdとクエリファイルを操作しデータベースを編集する。

:DB_CREATE
sqlcmd -S (local)\SQLEXPRESS -i ./MssqlDbCreate.sql -v Pver="2025"

@echo 終わりです。
endlocal
pause
exit