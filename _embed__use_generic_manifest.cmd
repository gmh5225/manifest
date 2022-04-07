@echo off
chcp 65001 1>nul 2>nul

set "EXIT_CODE=0"

pushd "%~dp0"

call "_embed.cmd" "example_manifests\generic.manifest" %*
set "EXIT_CODE=%ErrorLevel%"

if ["%EXIT_CODE%"] NEQ ["0"] (
  pause
)

popd
exit /b %EXIT_CODE%