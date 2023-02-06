if ((Test-Path -Path "C:\Program Files (x86)\Dell\CommandUpdate"))
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData))\CXN\Scripts\DellRunningCommandUpdateDRNeeded"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DellRunningCommandUpdateDRNeeded"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DellRunningCommandUpdateDRNeeded\DellRunningCommandUpdateDRNeeded.ps1.tag" -Value "Installed"
        }
        Write-Output "Remediation needed"
        exit 1  
    }
else 
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DellRunningCommandUpdateDRNOTMissingDependency"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DellRunningCommandUpdateDRNOTMissingDependency"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DellRunningCommandUpdateDRNOTMissingDependency\DellRunningCommandUpdateDRNOTMissingDependency.ps1.tag" -Value "Installed"
        } 
    Write-Output "No Remediation Needed"
    exit 0   
    }