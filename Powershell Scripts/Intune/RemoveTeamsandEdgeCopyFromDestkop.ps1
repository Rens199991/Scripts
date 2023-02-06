#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\RemoveTeamsandEdgeCopyFromDestkop"))
	{
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\RemoveTeamsandEdgeCopyFromDestkop"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\RemoveTeamsandEdgeCopyFromDestkop\RemoveTeamsandEdgeCopyFromDestkop.ps1.tag" -Value "Installed"
    }

Remove-Item -path "%OneDriveCommercial%\Desktop\Microsoft Teams (copy)" 
Remove-Item -path "%OneDriveCommercial%\Desktop\Microsoft Teams (copy) (2)"   
Remove-Item -path "%OneDriveCommercial%\Desktop\Microsoft Teams (copy) (3)"   
Remove-Item -path "%OneDriveCommercial%\Desktop\Microsoft Edge (copy)"
Remove-Item -path "%OneDriveCommercial%\Desktop\Microsoft Edge (copy)"

