@echo off
title "Fix Microsoft® Windows®'s Installer"
endlocal & setlocal EnableDelayedExpansion

rem Script by <https://github.com/simdol>
rem Supports: Microsoft Windows 7/8/8.1

echo.
echo   ***************************************************************************
echo   *                                                                         *
echo   *                   Fix Microsoft® Windows®'s Installer                 *
echo   *                                                                         *
echo   ***************************************************************************
echo   *                                                                         *
echo   *                     WARNING WARNING WARNING                             *
echo   *             READ THE DOCUMENTATION BEFORE PROCEEDING!                    *
echo   *                                                                         *
echo   ***************************************************************************
echo

echo 1/2 - Running sfc /scannow..
sfc /scannow

echo 2/2 - Fixing Windows® Installer..
net start msiserver
cd %windir%/system32
msiexec /unregister
msiexec /regserver
net stop msiserver
net start msiserver

:end
  echo The script will exit after 60 seconds has been past. Press any keys to exit the script now.
  timeout /t 60>nul 2>&1
  endlocal & if %ExitOnComplete%==1 (exit)
echo on
