@echo off
setlocal EnableDelayedExpansion

:: INSTRUCTIONS
:: Copy this 'template' file to the parent folder, of the wix4 repository.
:: Rename this file removing the .TEMPLATE
:: Launch this script once using an admin context, to configure a build, for which derivatives target the local system.

set _msbuild=%ProgramFiles(x86)%\MSBuild\14.0\Bin\msbuild.exe
if [_msbuild]==[] (
  goto :errMBS
)

if not exist "%_msbuild%" (
  goto :errMBS
)
net session >nul 2>&1
if errorlevel 1 goto :errAdmin

call "%_msbuild%" %~dp0wix4\tools\OneTimeWixBuildInitialization.proj /l:FileLogger,Microsoft.Build.Engine;logfile=wix4_init.log
if errorlevel 1 goto :errBuild

::success
pause
exit /b 0


:errBuild
@echo MSBuild returned an error.  Please review the log file.
pause
exit 3
:errMBS
@echo MSBuild was not located.  This script will exit.
pause
exit 2
:errAdmin
@echo Failed: Elevated Permissions are required!
pause
exit 1
::endlocal implied
