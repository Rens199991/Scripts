@echo off
::agent version aan te passen aan installer
If EXIST C:\Program Files\SentinelOne\Sentinel Agent 21.7.5.1080\Tools GOTO EXITEXIT
GOTO INSTALL

:INSTALL
mkdir c:\temp
copy \\***DOMAIN VAN KLANT***\netlogon\SentinelInstaller-x64_windows_64bit_v21_7_5_1080.exe c:\temp
CALL c:\temp\SentinelInstaller-x64_windows_64bit_v21_7_5_1080.exe /SITE_TOKEN =eyJ1cmwiOiAiaHR0cHM6Ly9ldWNlMS0xMDIuc2VudGluZWxvbmUubmV0IiwgInNpdGVfa2V5IjogIjMyYzZmZTk4YmIwZGMzZWQifQ== /SILENT
GOTO EXIT

:EXITEXIT
EXIT