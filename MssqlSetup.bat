@echo off
rem UTF-8に切り替える文字コード
chcp 65001 >nul
rem バッチファイルでsqlcmdとクエリファイルを操作しデータベースを編集する。

:DB_CREATE
sqlcmd -S (local)\SQLEXPRESS -i MssqlDbCreate.sql -v Pver="2022"

@echo 終わりです。
endlocal
pause
exit