#Script detects the new Microsoft Teams consumer app on Windows 11.
if ($null -eq (Get-AppxPackage -Name MicrosoftTeams)) 
    {
    #Create a tag file just so Intune knows this was installed
     If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\RemoveBuiltInTeamsDRNOT"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\RemoveBuiltInTeamsDRNOT"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\RemoveBuiltInTeamsDRNOT\RemoveBuiltInTeamsDRNOT.ps1.tag" -Value "Installed"
        }
	Write-Host "No Remediation Needed"
	exit 0
    } 
Else 
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\RemoveBuiltInTeamsDRNeeded"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\RemoveBuiltInTeamsDRNeeded"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\RemoveBuiltInTeamsDRNeeded\RemoveBuiltInTeamsDRNeeded.ps1.tag" -Value "Installed"
        }
	Write-Host "Remediation Needed"
	Exit 1
    }
   
