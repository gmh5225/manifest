@echo off
chcp 65001 1>nul 2>nul

::handle multiple drag and drop arguments.
::no error handling. will continue anyway.

pushd "%~dp0"

:LOOP
  if ["%~1"] EQU [""] ( goto END )
  call "_remove_signature.cmd" "%~1"

:NEXT
  shift
  goto LOOP

:END
  popd
  exit /b 0
