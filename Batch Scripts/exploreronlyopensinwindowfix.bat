@echo off

:: 64 bit only (32bit on 64 bit)
IF EXIST “%ProgramFiles(x86)%\Internet Explorer\ieproxy.dll” “%WinDir%\SysWOW64\regsvr32.exe” “%ProgramFiles(x86)%\Internet Explorer\ieproxy.dll”
IF EXIST “%WinDir%\SysWOW64\actxprxy.dll” “%WinDir%\SysWOW64\regsvr32.exe” “%WinDir%\SysWOW64\actxprxy.dll”