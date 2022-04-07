::@echo off
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

call copy /b /y "%FILE_TARGET%" "%FILE_TARGET%.backup"                    1>nul 2>nul
set "EXIT_CODE=%ErrorLevel%"
if ["%EXIT_CODE%"] NEQ ["0"]          ( goto ERROR_COPY_BACKUP                   )


::                                                         generic exe uses "1" block. DLL always uses "2" block.
set RUN_CMD="_mt.cmd" -nologo -manifest %FILE_MANIFEST% -outputresource:"%FILE_TARGET%";1
set "FILE_EXT=%~x2"

if /i ["%FILE_EXT%"] EQU [".dll"] (
  set RUN_CMD="_mt.cmd" -nologo -manifest %FILE_MANIFEST% -outputresource:"%FILE_TARGET%";2
)


call %RUN_CMD%
set "EXIT_CODE=%ErrorLevel%"

if ["%EXIT_CODE%"] NEQ ["0"]          ( goto ERROR_EMBED_MANIFEST                    )


echo [INFO] success. "%FILE_MANIFEST%" was embedded into "%FILE_TARGET%", "%FILE_TARGET%" was backed-up to "%FILE_TARGET%.backup" before the change. 1>&2
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

:ERROR_COPY_BACKUP
  ::------------exit code is already not zero from the copy-action above.
  echo [ERROR] can not copy "%FILE_TARGET%" to "%FILE_TARGET%.backup". program done without any changes. 1>&2
  goto END
  
:ERROR_EMBED_MANIFEST
  ::------------exit code is already not zero from mt.exe action above.
  echo [ERROR] can not embed %FILE_MANIFEST% as a resource into "%FILE_TARGET%". program done without any changes. 1>&2
  goto END

:END
  echo [INFO] EXIT_CODE: %EXIT_CODE% 1>&2
  ::pause
  popd
  exit /b %EXIT_CODE%