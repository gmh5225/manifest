::@echo off
chcp 65001 1>nul 2>nul

set "EXIT_CODE=0"

pushd "%~dp0"

copy /b "%~1" "%~1.backup"
::call "bin\signtool\App Certification Kit\signtool.exe" remove /s /v %*
call "bin\signtool\App Certification Kit\signtool.exe" remove /s /q %*
set "EXIT_CODE=%ErrorLevel%"

::if ["%EXIT_CODE%"] NEQ ["0"] (
::  pause
::)

popd
exit /b %EXIT_CODE%