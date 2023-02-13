if ((-not(Test-Path -Path "C:\hpia")))
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData))\CXN\Scripts\HPRunningImageAssistantDRNOTMissingDependency"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\HPRunningImageAssistantDRNOTMissingDependency"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\HPRunningImageAssistantDRNOTMissingDependency\HPRunningImageAssistantDRNOTMissingDependency.ps1.tag" -Value "Installed"
        }
        Write-Output "No Remediation needed"
        exit 0  
    }
else 
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\HPRunningImageAssistantDRNeeded"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\HPRunningImageAssistantDRNeeded"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\HPRunningImageAssistantDRNeeded\HPRunningImageAssistantDRNeeded.ps1.tag" -Value "Installed"
        } 
    Write-Output "Remediation Needed"
    exit 1   
    }



