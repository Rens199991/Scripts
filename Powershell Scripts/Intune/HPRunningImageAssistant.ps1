# Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\HPRunningImageAssistant"))
	{
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\HPRunningImageAssistant"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\HPRunningImageAssistant\HPRunningImageAssistant.ps1.tag" -Value "Installed"
	}

#Begin script
Start-Process -FilePath "C:\hpia\HPImageAssistant.exe" -ArgumentList @("/Operation:Analyze","/Category:All","/Selection:All","/Action:Install","/Silent","/Action:Install","/Softpaqdownloadfolder:C:\HPIASoftpaqs") -Wait 


