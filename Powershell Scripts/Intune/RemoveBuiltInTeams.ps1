﻿#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\RemoveBuiltInTeams"))
	{
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\RemoveBuiltInTeams"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\RemoveBuiltInTeams\RemoveBuiltInTeams.ps1.tag" -Value "Installed"
    }

#Begin script
#Script removes the new Microsoft Teams consumer app on Windows 11.
#App is removed because this app can only be used with personal Microsoft accounts


Get-AppxPackage -Name MicrosoftTeams | Remove-AppxPackage


   

