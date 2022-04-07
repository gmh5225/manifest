@echo off

chcp 65001 1>nul 2>nul

pushd "%~sdp0"

::can work newer NodeJS in Windows 7 without warnings. https://nodejs.org/api/cli.html#cli_node_skip_platform_check_value
set "NODE_SKIP_PLATFORM_CHECK=1"

call "node.exe" "index.js" %*

pause
exit /b 0
