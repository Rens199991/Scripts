If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\HPRunningImageAssistantR"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\HPRunningImageAssistantR"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\HPRunningImageAssistantR\HPRunningImageAssistantR.ps1.tag" -Value "Installed"
    }

#Begin script
Start-Process -FilePath "C:\hpia\HPImageAssistant.exe" -ArgumentList @("/Operation:Analyze","/Category:All","/Selection:All","/Action:Install","/Silent","/Action:Install","/Softpaqdownloadfolder:C:\HPIASoftpaqs") -Wait 


