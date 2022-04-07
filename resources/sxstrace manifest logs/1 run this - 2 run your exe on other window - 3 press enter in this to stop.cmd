::@echo off
chcp 65001 1>nul 2>nul
set "EXIT_CODE=0"

pushd "%~sdp0"

::-------------------------------------------- first thing, make sure the sxstrace.exe can be found in system PATH.
set "FILE_SXSTRACE_EXE="
for /f "tokens=*" %%a in ('where sxstrace.exe 2^>nul') do ( set "FILE_SXSTRACE_EXE=%%a"      )
set "EXIT_CODE=%ErrorLevel%"
if ["%EXIT_CODE%"] NEQ ["0"] ( 
  goto ERROR_SXSTRACE_EXE_CAN_NOT_BE_FOUND
) 
if not exist "%FILE_SXSTRACE_EXE%" ( 
  goto ERROR_SXSTRACE_EXE_CAN_NOT_BE_FOUND
) 
if ["%FILE_SXSTRACE_EXE%"] EQU [""] ( 
  goto ERROR_SXSTRACE_EXE_CAN_NOT_BE_FOUND
) 

::-------------------------------------------- file-name
set "FILE_LOG_BINARY=tracetest.log"
set "FILE_LOG_TEXT=tracetest.txt"

::-------------------------------------------- explicit path
set "FILE_LOG_BINARY=%~sdp0%FILE_LOG_BINARY%"
set "FILE_LOG_TEXT=%~sdp0%FILE_LOG_TEXT%"

::------------------------------------------- cleanup
del /f /q "%FILE_LOG_BINARY%" 1>nul 2>nul
del /f /q "%FILE_LOG_TEXT%"   1>nul 2>nul

call "sxstrace.exe" "Trace" "-logfile:%FILE_LOG_BINARY%"
set "EXIT_CODE=%ErrorLevel%"
if ["%EXIT_CODE%"] NEQ ["0"] ( 
  goto ERROR_TRACE_RECORDING
) 

if not exist "%FILE_LOG_BINARY%" ( 
  goto ERROR_LOG_NOT_EXIST
) 

call "sxstrace.exe" "Parse" "-logfile:%FILE_LOG_BINARY%" "-outfile:%FILE_LOG_TEXT%"
set "EXIT_CODE=%ErrorLevel%"
if ["%EXIT_CODE%"] NEQ ["0"] ( 
  goto ERROR_TRACE_PARSE_TO_TEXT
) 

if not exist "%FILE_LOG_TEXT%" ( 
  goto ERROR_LOG_TEXT_NOT_EXISTS
) 

del /f /q "%FILE_LOG_BINARY%" 1>nul 2>nul

echo [INFO] success - opening text-log in notepad.

call "notepad2.exe" "%FILE_LOG_TEXT%"

goto END

:ERROR_SXSTRACE_EXE_CAN_NOT_BE_FOUND
  ::exit code provided by 'where' command.
  set "EXIT_CODE=111"
  echo [ERROR] sxstrace.exe can not be found in system PATH. 1>&2
  goto END

:ERROR_TRACE_RECORDING
  ::exit code provided by sxstrace.
  echo [ERROR] recording %FILE_LOG_BINARY% failed. 1>&2
  goto END

:ERROR_LOG_NOT_EXIST
  set "EXIT_CODE=222"
  echo [ERROR] %FILE_LOG_TEXT% does not exists. 1>&2
  goto END

:ERROR_TRACE_PARSE_TO_TEXT
  ::exit code provided by sxstrace.
  echo [ERROR] parsing %FILE_LOG_BINARY%, for writing a readable content failed. 1>&2
  goto END

:ERROR_LOG_TEXT_NOT_EXISTS
  set "EXIT_CODE=333"
  echo [ERROR] %FILE_LOG_TEXT% does not exists. 1>&2
  goto END

:END
  echo [INFO] EXIT_CODE: %EXIT_CODE%.
  pause
  popd
  exit /b 0