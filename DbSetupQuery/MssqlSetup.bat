@echo off
rem UTF-8に切り替える文字コード
chcp 65001 >nul
rem バッチファイルでsqlcmdとクエリファイルを操作しデータベースを編集する。

@echo 1:データベース、テーブル、サンプルデータを一括作成する
@echo 2:データベースだけ作成する
@echo 3:データベースごと削除する
@echo 4:テーブルだけ作成する
@echo 5:テーブルを削除する
@echo 6:サンプルデータの追加をする.
@echo 7:サンプルデータだけ削除する
@echo 0:何もせず終わる
@echo.

set /p INPUT1="どの作業を行いますか？対象の数字を入力して下さい。"

if "%INPUT1%"=="1" (
call :ALL_CREATE
) else if "%INPUT1%"=="2" (
call :DB_CREATE
) else if "%INPUT1%"=="3" (
call :DB_DROP
) else if "%INPUT1%"=="4" (
call :TABLE_CREATE
) else if "%INPUT1%"=="5" (
call :TABLE_DROP
) else if "%INPUT1%"=="6" (
call :DATA_INSERT
) else if "%INPUT1%"=="7" (
call :DATA_DELETE
) else (@echo キャンセルされました。)



@echo 終わりです。
endlocal
pause
exit


:ALL_CREATE
sqlcmd -S (local)\SQLEXPRESS -m 1 -i MssqlDbCreate.sql -v Pver="2025" -f 65001
sqlcmd -S (local)\SQLEXPRESS -m 1 -i MssqlTableCreate.sql -f 65001
sqlcmd -S (local)\SQLEXPRESS -m 1 -i MssqlDataInsert.sql -f 65001
exit /b

rem -m 1は、クエリファイル内のUSE [master]により出るメッセージを抑制するオプション
:DB_CREATE
sqlcmd -S (local)\SQLEXPRESS -m 1 -i MssqlDbCreate.sql -v Pver="2025" -f 65001
exit /b

:DB_DROP
sqlcmd -S (local)\SQLEXPRESS -m 1 -i MssqlDbDrop.sql -f 65001
exit /b

:TABLE_CREATE
sqlcmd -S (local)\SQLEXPRESS -m 1 -i MssqlTableCreate.sql -f 65001
exit /b

:TABLE_DROP
sqlcmd -S (local)\SQLEXPRESS -m 1 -i MssqlTableDrop.sql -f 65001
exit /b

:DATA_INSERT
sqlcmd -S (local)\SQLEXPRESS -m 1 -i MssqlDataInsert.sql -f 65001
exit /b

:DATA_DELETE
sqlcmd -S (local)\SQLEXPRESS -m 1 -i MssqlDataDelete.sql -f 65001
exit /b