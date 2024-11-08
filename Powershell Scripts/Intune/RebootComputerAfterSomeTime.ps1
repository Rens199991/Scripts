#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\RebootComputerAfterSomeTime"))
	{
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\RebootComputerAfterSomeTime"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\RebootComputerAfterSomeTime\RebootComputerAfterSomeTime.ps1.tag" -Value "Installed"
    }


#Wait for some Seconds and then Reboot Computer
Start-Sleep -Seconds 900
Restart-Computer -Force

