::@echo off
chcp 65001 1>nul 2>nul

call "bin\ResourceHacker\ResourceHacker.exe" %*

exit /b %ErrorLevel%
