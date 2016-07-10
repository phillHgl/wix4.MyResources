@echo off
setlocal
:set the window size
mode con: cols=210 lines=70

::see notes in Build.cmd
set _msbuild=%ProgramFiles(x86)%\MSBuild\14.0\Bin\msbuild.exe
if [_msbuild]==[] (
  goto :errMBS
)

if not exist "%_msbuild%" (
  goto :errMBS
)

call "%_msbuild%" ..\..\wix4\Wix.proj /t:Clean /v:diag /l:FileLogger,Microsoft.Build.Engine;logfile="%~dp0\wix4.log"
if errorlevel 1 goto :errBuild
@echo 


:errBuild
@echo MSBuild returned an error.  Please review the log file.
pause
exit 2
:errMBS
@echo MSBuild was not located.  This script will exit.
pause
exit 1

::endlocal implied
