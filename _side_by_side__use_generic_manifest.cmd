@echo off
chcp 65001 1>nul 2>nul

set "EXIT_CODE=0"

pushd "%~dp0"

call "_side_by_side.cmd" "example_manifests\generic.manifest" %*
set "EXIT_CODE=%ErrorLevel%"

popd
exit /b %EXIT_CODE%