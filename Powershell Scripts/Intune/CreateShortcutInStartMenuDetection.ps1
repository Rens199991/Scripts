if ((Test-Path -Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Remote Desktop.lnk"))
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\CreateShortCutInStartMenuDRNOTMissingDependency"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\CreateShortCutInStartMenuDRNOTMissingDependency"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\CreateShortCutInStartMenuDRNOTMissingDependency\CreateShortCutInStartMenuDRNOTDRNOTMissingDependency.ps1.tag" -Value "Installed"
        }
        Write-Output "No Remediation Needed"
        exit 0  
    }
else 
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData))\CXN\Scripts\CreateShortCutInStartMenuDRNeeded"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\CreateShortCutInStartMenuDRNeeded"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\CreateShortCutInStartMenuDRNeeded\CreateShortCutInStartMenuDRNeeded.ps1.tag" -Value "Installed"
        } 
    Write-Output "Remediation Needed"
    exit 1   
    }



    


   