@echo off
chcp 65001 1>nul 2>nul

::handle multiple drag and drop arguments.
::no error handling. will continue anyway.

pushd "%~dp0"

:LOOP
  if ["%~1"] EQU [""] ( goto END )
  call "_extract_w_resourcehacker.cmd" "%~1"
  call "timeout.exe" /T 1 /NOBREAK 1>nul 2>nul

:NEXT
  shift
  goto LOOP

:END
  popd
  exit /b 0
