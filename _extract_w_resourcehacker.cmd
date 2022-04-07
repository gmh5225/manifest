::@echo off
chcp 65001 1>nul 2>nul

set "EXIT_CODE=0"

pushd "%~dp0"

set "FILE_TARGET=%~1"
if ["%FILE_TARGET%"] EQU [""]        ( goto ERROR_MISSING_ARGUMENT_1_TARGET   )
if not exist "%FILE_TARGET%"         ( goto ERROR_FILE_NOT_FOUND_TARGET       )
if exist "%FILE_TARGET%\NUL"         ( goto ERROR_TARGET_IS_NOT_A_FILE        )
::for /f %%a in ("%FILE_TARGET%")   do ( set "FILE_TARGET=%%~fa"                )

call del /f /q  "%FILE_TARGET%.extracted.manifest.bak"                                     1>nul 2>nul
call copy /b /y "%FILE_TARGET%.extracted.manifest" "%FILE_TARGET%.extracted.manifest.bak"  1>nul 2>nul
call del /f /q  "%FILE_TARGET%.extracted.manifest"                                         1>nul 2>nul

call del /f /q  ".\manifests.rc"                                                           1>nul 2>nul
call del /f /q  ".\MANIFEST1*.txt"                                                         1>nul 2>nul

call "_ResourceHacker.cmd" -open "%FILE_TARGET%" -save ".\manifests.rc" -action extract -mask 24,, -log ".\resourcehacker.log"
set "EXIT_CODE=%ErrorLevel%"
if ["%EXIT_CODE%"] NEQ ["0"]         ( goto ERROR_EXTRACT                     )
if not exist "manifests.rc"          ( goto ERROR_EXTRACT_NO_RC               )
if not exist "MANIFEST1_1.txt"       ( goto ERROR_EXTRACT_NO_RESOURCE         )
call copy /b /y "MANIFEST1_1.txt" "%FILE_TARGET%.extracted.manifest"                       1>nul 2>nul
set "EXIT_CODE=%ErrorLevel%"
if ["%EXIT_CODE%"] NEQ ["0"]         ( goto ERROR_COPY_EXTRACTED_MANIFEST     )

if not exist "%FILE_TARGET%.extracted.manifest"       ( goto ERROR_EXTRACT_COPIED_MANIFEST_NOT_EXIST      )

echo [INFO] success. embedded manifest extracted - exactlly as it is, using ResourceHacker, into "%FILE_TARGET%.extracted.manifest". 1>&2

::----------- cleanup (may be commented out for debug-sake).
call del /f /q  ".\manifests.rc"                                                           1>nul 2>nul
call del /f /q  ".\MANIFEST1*.txt"                                                         1>nul 2>nul
call del /f /q  ".\resourcehacker.log"                                                     1>nul 2>nul

goto END

  
:ERROR_MISSING_ARGUMENT_1_TARGET
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

:ERROR_EXTRACT
  ::--------------------- this error will never be called since ResourceHacker always returns 0-exit-code, only the log is an indicator.
  set "EXIT_CODE=666"
  echo [ERROR] ResourceHacker ended with exit-code different than zero, meaning there was a problem while running the action, look for "resourcehacker.log" for the action-specifics. 1>&2
  goto END

:ERROR_EXTRACT_NO_RC
  set "EXIT_CODE=777"
  echo [ERROR] there was a problem extracting the embedded manifest using ResourceHacker, no "manifests.rc" file, look for "resourcehacker.log" for the action-specifics. 1>&2
  goto END
  
:ERROR_EXTRACT_NO_RC
  set "EXIT_CODE=888"
  echo [ERROR] there was a problem extracting the embedded manifest using ResourceHacker, "manifests.rc" file do exists, but actual resource in "MANIFEST1_1.txt" was not. look for "resourcehacker.log" for the action-specifics. 1>&2
  goto END
  
:ERROR_COPY_EXTRACTED_MANIFEST
  ::--------- already has non-zero exit code from the copy action.
  echo [ERROR] there was a problem copying "MANIFEST1_1.txt" to "%FILE_TARGET%.extracted.manifest".  1>&2
  goto END

:ERROR_EXTRACT_COPIED_MANIFEST_NOT_EXIST
  set "EXIT_CODE=999"
  echo [ERROR] "%FILE_TARGET%.extracted.manifest" does not exists.   1>&2
  goto END
  
:END
  echo [INFO] EXIT_CODE: %EXIT_CODE% 1>&2
  ::pause
  popd
  exit /b %EXIT_CODE%