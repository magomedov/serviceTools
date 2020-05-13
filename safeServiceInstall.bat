@echo off
:: Script authored by Bashir Magomedov (inspired from safeServiceDelete script by Hrusikesh Panda)

IF [%1]==[] GOTO usage
IF [%2]==[] GOTO usage
IF NOT "%3"=="" SET server=%3

GOTO InstallService

:InstallService
echo Installing the service...
echo SC %server% create %1 binPath=%2
SC %server% create %1 binPath=%2 > NUL
:InstallingServiceDelay
echo Waiting for %1 to get installed
ping -n 2 127.0.0.1 > NUL
:InstallingService
SC %server% query %1 >NUL
IF errorlevel 1060 GOTO InstallingServiceDelay

:InstalledService
echo %1 on %server% is installed
GOTO:eof

:usage
echo Will install a local/remote service.
echo This script will waiting for the service to enter the started state if necessary.
echo.
echo %0 [service name] [system name]
echo Example: %0 MyService C:\Services\MyService.exe server1
echo Example: %0 MyService C:\Services\MyService.exe (for local PC)
echo.

GOTO:eof