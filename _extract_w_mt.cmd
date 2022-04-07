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

call "bin\mt\10.0.19041.685\x64\mt.exe" -nologo -inputresource:"%FILE_TARGET%";#1 -out:"%FILE_TARGET%.extracted.manifest"
set "EXIT_CODE=%ErrorLevel%"

if ["%EXIT_CODE%"] NEQ ["0"]         ( goto ERROR_EXTRACT                     )

echo [INFO] success. extracting manifest to "%FILE_TARGET%.extracted.manifest" . 1>&2
echo [INFO] note: mt.exe does some reading-and-parsing while ignoring errors whitespace and multiline structure, which results with a not accurate representation of the manifest resource!
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
  ::------------exit code is already not zero.
  echo [ERROR] there was a problem extracting the embedded manifest into the file "%FILE_TARGET%.extracted.manifest"
  goto END
  
:END
  echo [INFO] EXIT_CODE: %EXIT_CODE% 1>&2
  pause
  popd
  exit /b %EXIT_CODE%