@echo off
chcp 65001 1>nul 2>nul

set "EXIT_CODE=0"

pushd "%~dp0"

set "FILE_MANIFEST=%~1"
if ["%FILE_MANIFEST%"] EQU [""]      ( goto ERROR_MISSING_ARGUMENT_1_MANIFEST )
if not exist "%FILE_MANIFEST%"       ( goto ERROR_FILE_NOT_FOUND_MANIFEST     )
::for /f %%a in ("%FILE_MANIFEST%") do ( set "FILE_MANIFEST=%%~fa"              )

set "FILE_TARGET=%~2"
if ["%FILE_TARGET%"] EQU [""]        ( goto ERROR_MISSING_ARGUMENT_2_TARGET   )
if not exist "%FILE_TARGET%"         ( goto ERROR_FILE_NOT_FOUND_TARGET       )
if exist "%FILE_TARGET%\NUL"         ( goto ERROR_TARGET_IS_NOT_A_FILE        )
::for /f %%a in ("%FILE_TARGET%")   do ( set "FILE_TARGET=%%~fa"                )

call del /f /q "%FILE_TARGET%.manifest_bak"                            1>nul 2>nul
call copy /b /y "%FILE_TARGET%.manifest" "%FILE_TARGET%.manifest_bak"  1>nul 2>nul

call copy /b /y "%FILE_MANIFEST%" "%FILE_TARGET%.manifest"             1>nul 2>nul
set "EXIT_CODE=%ErrorLevel%"

if ["%EXIT_CODE%"] NEQ ["0"]          ( goto ERROR_COPY                        )


echo [INFO] success. "%FILE_MANIFEST%" was copied to "%FILE_TARGET%.manifest" . 1>&2
goto END

:ERROR_MISSING_ARGUMENT_1_MANIFEST
  set "EXIT_CODE=111"
  echo [ERROR] missing arguments, first one is manifest, second one is target-file.      1>&2
  goto END
  
:ERROR_FILE_NOT_FOUND_MANIFEST
  set "EXIT_CODE=222"
  echo [ERROR] first argument, manifest, does not exists in file-system. 1>&2
  goto END
  
:ERROR_MISSING_ARGUMENT_2_TARGET
  set "EXIT_CODE=333"
  echo [ERROR] missing second argument - target file. 1>&2
  goto END
  
:ERROR_FILE_NOT_FOUND_TARGET
  set "EXIT_CODE=444"
  echo [ERROR] second argument, target file, does not exists in file-system. 1>&2
  goto END
  
:ERROR_TARGET_IS_NOT_A_FILE
  set "EXIT_CODE=555"
  echo [ERROR] second argument, target file, seems to be a folder. you need to specify a file. 1>&2
  goto END

:ERROR_COPY
  ::------------exit code is already not zero from the second copy-action above.
  echo [ERROR] can not copy "%FILE_MANIFEST%" to "%FILE_TARGET%.manifest", maybe there is a file in that name already which can not be overwritten. 1>&2
  goto END
  
:END
  echo [INFO] EXIT_CODE: %EXIT_CODE% 1>&2
  ::pause
  popd
  exit /b %EXIT_CODE%