@echo off
chcp 65001 1>nul 2>nul

set "EXIT_CODE=0"

pushd "%~dp0"

call copy /b /y "%~1" "%~1.backup" 1>nul 2>nul

::call "App Certification Kit\signtool.exe" remove /s /v %*
call "App Certification Kit\signtool.exe" remove /s /q %*

popd
exit /b %EXIT_CODE%