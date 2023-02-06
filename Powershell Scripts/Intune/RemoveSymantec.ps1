# Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\RemoveSymantec"))
	{
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\RemoveSymantec"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\RemoveSymantec\RemoveSymantec.ps1.tag" -Value "Installed"
    }

#Remove Symantec
Start-Process "msiexec.exe" -Argumentlist "/qn /norestart /x {CE2F0EC1-BF6B-42A6-993C-1D9655D0C9DF}" -wait -verbose
