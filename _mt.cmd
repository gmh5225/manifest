::@echo off
chcp 65001 1>nul 2>nul

call "bin\mt\10.0.19041.685\x86\mt.exe" %*

exit /b %ErrorLevel%
