@echo off

pushd "%~sdp0"

:LOOP

if ["%~1"] EQU [""] ( goto END;  )
if not exist %~s1   ( goto NEXT; )
if exist %~s1\NUL   ( goto NEXT; )

set "FILE_INPUT=%~1"
set "FILE_EXT=%~x1"
set "FILE_BCKUP=%~1.backup"


::                                                         generic exe uses "1" block. DLL always uses "2" block.
set RUN_CMD="mt.cmd" -nologo -manifest %FILE_MANIFEST% -outputresource:"%FILE_INPUT%";1

if /i ["%FILE_EXT%"] == [".dll"] (
  set RUN_CMD=%FILE_MT% -nologo -manifest %FILE_MANIFEST% -outputresource:"%FILE_INPUT%";2
)


::                                                         backup
call copy /b /y "%FILE_INPUT%" "%FILE_BCKUP%" 2>nul >nul


::                                                         modify
echo %RUN_CMD%
call %RUN_CMD%


::-------------------------------------------------------------------------------------------
::-------------------------------------------------------------------------------------------
:NEXT
shift
goto LOOP

:END
pause

