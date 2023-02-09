if ((-not(Test-Path -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdates")))
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DeleteWindowsUpdatesRegKeysDRNOT"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DeleteWindowsUpdatesRegKeysDRNOT"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DeleteWindowsUpdatesRegKeysDRNOT\DeleteWindowsUpdatesRegKeysDRNOTDRNOT.ps1.tag" -Value "Installed"
        }
    Write-Output "No Remediation Needed"
    exit 0  
    }
else 
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData))\CXN\Scripts\DeleteWindowsUpdatesRegKeysDRNeeded"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DeleteWindowsUpdatesRegKeysDRNeeded"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DeleteWindowsUpdatesRegKeysDRNeeded\DeleteWindowsUpdatesRegKeysDRNeeded.ps1.tag" -Value "Installed"
        } 
    Write-Output "Remediation Needed"
    exit 1   
    }


