@echo off
setlocal
:set the window size
mode con: cols=210 lines=70

::set PATH=%PATH%;%programfiles(x86)%\Microsoft Visual Studio 10.0\Common7\IDE
::%ProgramFiles(x86)%\MSBuild\12.0\Bin
::set _msbuild=%windir%\Microsoft.NET\Framework\v4.0.30319\msbuild.exe
::set _msbuild=%ProgramFiles(x86)%\MSBuild\12.0\Bin\msbuild.exe
:: When VS2015 is installed, must used MSBuild v14
set _msbuild=%ProgramFiles(x86)%\MSBuild\14.0\Bin\msbuild.exe
if [_msbuild]==[] (
  goto :errMBS
)

if not exist "%_msbuild%" (
  goto :errMBS
)

call "%_msbuild%" ..\..\wix4\Wix.proj /t:Rebuild /p:DebugSymbols=true /p:DebugType=full /p:Optimize=false /v:diag /l:FileLogger,Microsoft.Build.Engine;logfile="%~dp0\wix4.log"
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
